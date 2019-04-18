/* File: codegen.cc
 * ----------------
 * Implementation for the CodeGenerator class. The methods don't do anything
 * too fancy, mostly just create objects of the various Tac instruction
 * classes and append them to the list.
 */

#include "codegen.h"
#include "tac.h"
#include "mips.h"
#include "ast_decl.h"
#include "errors.h"

#include <algorithm>
#include <functional>
#include <cstring>
#include <iostream>
#include <string>
#include <stack>
#include <iterator>

using namespace std;
  
CodeGenerator::CodeGenerator() {
    code = new List<Instruction*>();
    curGlobalOffset = 0;
}

void CodeGenerator::BeginLiveRange() {
    liveRange.clear();
}

void CodeGenerator::AddInstruction(Instruction *line) {
    code->Append(line);
    liveRange.push_back(line);
}

char *CodeGenerator::NewLabel() {
    static int nextLabelNum = 0;
    char temp[10];
    sprintf(temp, "_L%d", nextLabelNum++);
    return strdup(temp);
}

Location *CodeGenerator::GenTempVariable() {
  static int nextTempNum;
  char temp[10];
  Location *result = NULL;
  sprintf(temp, "_tmp%d", nextTempNum++);
  return GenLocalVariable(temp);
}

Location *CodeGenerator::GenLocalVariable(const char *varName) {
    curStackOffset -= VarSize;
    auto *loc = new Location(fpRelative, curStackOffset+4, varName);
    return loc;
}

Location *CodeGenerator::GenGlobalVariable(const char *varName) {
    curGlobalOffset += VarSize;
    auto *loc = new Location(gpRelative, curGlobalOffset-4, varName);
    return loc;
}

Location *CodeGenerator::GenParameter(int index, const char *varName) {
    auto *loc = new Location(fpRelative, OffsetToFirstParam+index*VarSize, varName);
    return loc;
}

Location *CodeGenerator::GenIndirect(Location* base, int offset) {
    auto *loc = new Location(base, offset);
    return loc;
}

Location *CodeGenerator::GenLoadConstant(int value) {
    auto *result = GenTempVariable();
    AddInstruction(new LoadConstant(result, value));
    return result;
}

Location *CodeGenerator::GenLoadConstant(const char *s) {
    Location *result = GenTempVariable();
    AddInstruction(new LoadStringConstant(result, s));
    return result;
} 

Location *CodeGenerator::GenLoadLabel(const char *label) {
    Location *result = GenTempVariable();
    AddInstruction(new LoadLabel(result, label));
    return result;
} 

void CodeGenerator::GenAssign(Location *dst, Location *src) {
    AddInstruction(new Assign(dst, src));
}

Location *CodeGenerator::GenLoad(Location *ref, int offset) {
    Location *result = GenTempVariable();
    AddInstruction(new Load(result, ref, offset));
    return result;
}

void CodeGenerator::GenStore(Location *dst,Location *src, int offset) {
    AddInstruction(new Store(dst, src, offset));
}

Location *CodeGenerator::GenBinaryOp(const char *opName, Location *op1, Location *op2) {
    Location *result = GenTempVariable();
    AddInstruction(new BinaryOp(BinaryOp::OpCodeForName(opName), result, op1, op2));
    return result;
}

void CodeGenerator::GenLabel(const char *label) {
    AddInstruction(new Label(label));
}

void CodeGenerator::GenIfZ(Location *test, const char *label) {
    AddInstruction(new IfZ(test, label));
}

void CodeGenerator::GenGoto(const char *label) {
    AddInstruction(new Goto(label));
}

void CodeGenerator::GenReturn(Location *val) {
  AddInstruction(new Return(val));
}

BeginFunc *CodeGenerator::GenBeginFunc() {
  auto *result = new BeginFunc;
  AddInstruction(result);
  insideFn = code->NumElements() - 1;
  curStackOffset = OffsetToFirstLocal;
  return result;
}

void CodeGenerator::GenEndFunc() {
    AddInstruction(new EndFunc());
    auto *beginFunc = dynamic_cast<BeginFunc*>(code->Nth(insideFn));
    Assert(beginFunc != nullptr);
    beginFunc->SetFrameSize(OffsetToFirstLocal-curStackOffset);
}

void CodeGenerator::GenPushParam(Location *param) {
    AddInstruction(new PushParam(param));
}

void CodeGenerator::GenPopParams(int numBytesOfParams) {
    Assert(numBytesOfParams >= 0 && numBytesOfParams % VarSize == 0); // sanity check
    if (numBytesOfParams > 0)
        AddInstruction(new PopParams(numBytesOfParams));
}

Location *CodeGenerator::GenLCall(const char *label, bool fnHasReturnValue) {
    Location *result = fnHasReturnValue ? GenTempVariable() : nullptr;
    AddInstruction(new LCall(label, result));
    return result;
}
  
Location *CodeGenerator::GenFunctionCall(const char *fnLabel, List<Location*> *args, bool hasReturnValue) {
    for (int i = args->NumElements()-1; i >= 0; i--) { // push params right to left
        GenPushParam(args->Nth(i));
    }

    auto *result = GenLCall(fnLabel, hasReturnValue);
    GenPopParams(args->NumElements() * VarSize);
    return result;
}

Location *CodeGenerator::GenACall(Location *fnAddr, bool fnHasReturnValue) {
    Location *result = fnHasReturnValue ? GenTempVariable() : nullptr;
    AddInstruction(new ACall(fnAddr, result));
    return result;
}
  
Location *CodeGenerator::GenMethodCall(Location *rcvr,
			     Location *meth, List<Location*> *args, bool fnHasReturnValue) {
  for (int i = args->NumElements()-1; i >= 0; i--) {
      GenPushParam(args->Nth(i));
  }

  GenPushParam(rcvr);	// hidden "this" parameter
  Location *result= GenACall(meth, fnHasReturnValue);
  GenPopParams((args->NumElements()+1)*VarSize);
  return result;
}
 
 
static struct _builtin {
  const char *label;
  int numArgs;
  bool hasReturn;
} builtins[] =
 {{"_Alloc", 1, true},
  {"_ReadLine", 0, true},
  {"_ReadInteger", 0, true},
  {"_StringEqual", 2, true},
  {"_PrintInt", 1, false},
  {"_PrintString", 1, false},
  {"_PrintBool", 1, false},
  {"_Halt", 0, false}};

Location *CodeGenerator::GenBuiltInCall(BuiltIn bn, Location *arg1, Location *arg2) {
    Assert(bn >= 0 && bn < NumBuiltIns);
    struct _builtin *b = &builtins[bn];
    Location *result = nullptr;

    if (b->hasReturn) result = GenTempVariable();

    // verify appropriate number of non-NULL arguments given
    Assert((b->numArgs == 0 && !arg1 && !arg2) || (b->numArgs == 1 && arg1 && !arg2) || (b->numArgs == 2 && arg1 && arg2));
    if (arg2) AddInstruction(new PushParam(arg2));
    if (arg1) AddInstruction(new PushParam(arg1));

    AddInstruction(new LCall(b->label, result));

    GenPopParams(VarSize * b->numArgs);

    return result;
}


void CodeGenerator::GenVTable(const char *className, List<const char *> *methodLabels)
{
  AddInstruction(new VTable(className, methodLabels));
}


void CodeGenerator::DoFinalCodeGen() {
    if (IsDebugOn("tac")) { // if debug don't translate to mips, just print Tac
        for (int i = 0; i < code->NumElements(); i++) {
            code->Nth(i)->Print();
        }
    } else {
        Mips mips;
        mips.EmitPreamble();

        for (int i = 0; i < code->NumElements(); i++) {
            code->Nth(i)->Emit(&mips);
        }
    }
}



Location *CodeGenerator::GenArrayLen(Location *array)
{
  return GenLoad(array, -4);
}

Location *CodeGenerator::GenNew(const char *vTableLabel, int instanceSize)
{
  Location *size = GenLoadConstant(instanceSize);
  Location *result = GenBuiltInCall(Alloc, size);
  Location *vt = GenLoadLabel(vTableLabel);
  GenStore(result, vt);
  return result;
}


Location *CodeGenerator::GenDynamicDispatch(Location *rcvr, int vtableOffset, List<Location*> *args, bool hasReturnValue)
{
  Location *vptr = GenLoad(rcvr); // load vptr
  Assert(vtableOffset >= 0);
  Location *m = GenLoad(vptr, vtableOffset*4);
  return GenMethodCall(rcvr, m, args, hasReturnValue);
}

// all variables (ints, bools, ptrs, arrays) are 4 bytes in for code generation
// so this simplifies the math for offsets
Location *CodeGenerator::GenSubscript(Location *array, Location *index)
{
  Location *zero = GenLoadConstant(0);
  Location *isNegative = GenBinaryOp("<", index, zero);
  Location *count = GenLoad(array, -4);
  Location *isWithinRange = GenBinaryOp("<", index, count);
  Location *pastEnd = GenBinaryOp("==", isWithinRange, zero);
  Location *outOfRange = GenBinaryOp("||", isNegative, pastEnd);
  const char *pastError = NewLabel();
  GenIfZ(outOfRange, pastError);
  GenHaltWithMessage(err_arr_out_of_bounds);
  GenLabel(pastError);
  Location *four = GenLoadConstant(VarSize);
  Location *offset = GenBinaryOp("*", four, index);
  Location *elem = GenBinaryOp("+", array, offset);
  return GenIndirect(elem, 0); 
}



Location *CodeGenerator::GenNewArray(Location *numElems)
{
  Location *one = GenLoadConstant(1);
  Location *isNonpositive = GenBinaryOp("<", numElems, one);
  const char *pastError = NewLabel();
  GenIfZ(isNonpositive, pastError);
  GenHaltWithMessage(err_arr_bad_size);
  GenLabel(pastError);

  // need (numElems+1)*VarSize total bytes (extra 1 is for length)
  Location *arraySize = GenLoadConstant(1);
  Location *num = GenBinaryOp("+", arraySize, numElems);
  Location *four = GenLoadConstant(VarSize);
  Location *bytes = GenBinaryOp("*", num, four);
  Location *result = GenBuiltInCall(Alloc, bytes);
  GenStore(result, numElems);
  return GenBinaryOp("+", result, four);
}

void CodeGenerator::GenHaltWithMessage(const char *message)
{
   Location *msg = GenLoadConstant(message);
   GenBuiltInCall(PrintString, msg);
   GenBuiltInCall(Halt, nullptr);
}

void CodeGenerator::DoOptimizationOnLiveRange() {
    DoOptimizationSetup();
    DoRegisterAllocation();
}

void CodeGenerator::DoOptimizationSetup() {
    // sets up the successor/predecessors for instructions
    for (int i = 0; i < liveRange.size(); ++i) {
        auto curr = liveRange[i];
        curr->GenSuccSet(i, liveRange);

        for (auto *succ : curr->successors) {
            succ->predecessors.insert(curr);
        }
    }
}

/// performs live analysis algorithm from spec
void CodeGenerator::DoRegisterAllocation() {
    // init IN[tac] = {}
    for_each(liveRange.begin(), liveRange.end(), [](Instruction *i) { i->inSet.clear(); });

    // loop until there is no change in the outSet of an instruction
    bool changed = true;
    while (changed) {
        changed = false;

        for (auto it = liveRange.rbegin(); it != liveRange.rend(); ++it) {
            auto *tac = *it;

            set<Location *> out_tac; // OUT[tac]
            // for every successor set OUT[tac] = UNION(IN[succ])
            for (auto *succ : tac->successors) {
                set_union(out_tac.begin(), out_tac.end(),
                        succ->inSet.begin(), succ->inSet.end(),
                        inserter(out_tac, out_tac.begin()));
            }

            tac->outSet = out_tac;

            // calculate IN'[tac]
            set<Location *> new_in;

            auto kill = tac->GetKillSet();
            auto gen = tac->GetGenSet();

            // this is OUT[tac] - KILL(tac)
            set_difference(out_tac.begin(), out_tac.end(),
                    kill.begin(), kill.end(),
                    inserter(new_in, new_in.begin()));

            // this IN'[tac] = OUT[tac] - KILL(tac) + GEN(tac)
            set_union(new_in.begin(), new_in.end(),
                    gen.begin(), gen.end(),
                    inserter(new_in, new_in.begin()));

            if (new_in != tac->inSet) {
                changed = true;
                tac->inSet = new_in;
            }
        }
    }

    // now that we have all the in & out sets, lets create the adjacency list

    AdjacencyList<Location *> list;

    // create list by adding every known location as a node
    set<Location *> locations;
    for (auto *instr : liveRange) {
        auto locs = instr->GetLocations();
        set_union(locations.begin(), locations.end(),
                locs.begin(), locs.end(),
                inserter(locations, locations.begin()));
    }

    for (auto *loc : locations) {
        list.add(loc);
    }

    // add edge for every KILL(instr) in OUT(instr)
    for (auto *instr : liveRange) {
        for (auto *k : instr->GetKillSet()) {
            for (auto *o : instr->outSet) {
                if (k != o) {
                    list.add_edge(k, o);
                }
            }
        }
    }

    PerformRegisterAllocOpt(list, list);
}

void CodeGenerator::PerformRegisterAllocOpt(AdjacencyList<Location *> list, AdjacencyList<Location *> graph) {
    using Edges = AdjacencyList<Location *>::Edges;
    constexpr int k = Mips::NumGeneralPurposeRegs; // for k-coloring
    bool has_less_k = true;
    stack<Location *> removed;

    // remove nodes with degree < k until there a no such nodes to remove
    while (has_less_k) {
        has_less_k = false;

        for (auto it = list.begin(); it != list.end();) {
            if (list.get_degrees(it->first) < k) {
                has_less_k = true;
                removed.push(it->first);
                it = list.erase(it);
            } else {
                ++it;
            }
        }
    }

    // if all nodes had degrees < k, then we can perform a k graph coloring
    // otherwise we need to find a node to remove and leave it out of the grap
    // and rerun this algorithm

    if (list.empty()) { // perform coloring
        while (!removed.empty()) {
            auto *vertex = removed.top();
            removed.pop();
            if (vertex->GetSegment() == gpRelative) {
                graph.set_color(vertex, 0);
            } else {
                auto color = GetValidColor(vertex, graph, k);
                graph.set_color(vertex, color);
            }
        }

        // assign registers based on color
        for (auto it = graph.begin(); it != graph.end(); ++it) {
            auto reg = graph.get_color(it->first);
            if (reg == 0) continue;
            it->first->SetRegister(Mips::GetGenPurposeReg(reg));
        }
    } else { // find location to spill, and rerun this algorithm
        // for this case we will simply remove the node with highest degree
        auto max_vertex = list.begin();
        for (auto it = list.begin(); it != list.end(); ++it) {
            if (list.get_degrees(max_vertex->first) < list.get_degrees(it->first)) {
                max_vertex = it;
            }
        }

        list.erase(max_vertex);
        PerformRegisterAllocOpt(list, graph);
    }
}

int CodeGenerator::GetValidColor(Location *vertex, const AdjacencyList<Location *> &list, int colors) {
    set<int> assigned_colors;
    for (const auto &edge : list.get_edges(vertex)) {
        auto color = list.get_color(edge);
        if (color != 0) {
            assigned_colors.insert(color);
        }
    }

    auto max_color = max_element(assigned_colors.begin(), assigned_colors.end());
    if (max_color == assigned_colors.end()) {
        return 1;
    } else {
        return *max_color + 1;
    }
}