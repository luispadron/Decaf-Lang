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
#include "cfg.h"

#include <algorithm>
#include <cstring>
#include <iostream>
#include <string>
#include <stack>

using namespace std;
  
CodeGenerator::CodeGenerator()
{
  code = new List<Instruction*>();
  curGlobalOffset = 0;
}

char *CodeGenerator::NewLabel()
{
  static int nextLabelNum = 0;
  char temp[10];
  sprintf(temp, "_L%d", nextLabelNum++);
  return strdup(temp);
}


Location *CodeGenerator::GenTempVariable()
{
  static int nextTempNum;
  char temp[10];
  Location *result = NULL;
  sprintf(temp, "_tmp%d", nextTempNum++);
  return GenLocalVariable(temp);
}

  
Location *CodeGenerator::GenLocalVariable(const char *varName)
{            
    curStackOffset -= VarSize;
    Location *loc = new Location(fpRelative, curStackOffset+4, varName);
    return loc;
}

Location *CodeGenerator::GenGlobalVariable(const char *varName)
{
    curGlobalOffset += VarSize;
    Location *loc = new Location(gpRelative, curGlobalOffset-4, varName);
    return loc;
}

Location *CodeGenerator::GenParameter(int index, const char *varName)
{
    Location *loc = new Location(fpRelative, OffsetToFirstParam+index*VarSize, varName);
    return loc;
}

Location *CodeGenerator::GenIndirect(Location* base, int offset)
{
    Location *loc = new Location(base, offset);
    return loc;
}


Location *CodeGenerator::GenLoadConstant(int value)
{
  Location *result = GenTempVariable();
  code->Append(new LoadConstant(result, value));
  return result;
}

Location *CodeGenerator::GenLoadConstant(const char *s)
{
  Location *result = GenTempVariable();
  code->Append(new LoadStringConstant(result, s));
  return result;
} 

Location *CodeGenerator::GenLoadLabel(const char *label)
{
  Location *result = GenTempVariable();
  code->Append(new LoadLabel(result, label));
  return result;
} 


void CodeGenerator::GenAssign(Location *dst, Location *src)
{
  code->Append(new Assign(dst, src));
}


Location *CodeGenerator::GenLoad(Location *ref, int offset)
{
  Location *result = GenTempVariable();
  code->Append(new Load(result, ref, offset));
  return result;
}

void CodeGenerator::GenStore(Location *dst,Location *src, int offset)
{
  code->Append(new Store(dst, src, offset));
}


Location *CodeGenerator::GenBinaryOp(const char *opName, Location *op1,
						     Location *op2)
{
  Location *result = GenTempVariable();
  code->Append(new BinaryOp(BinaryOp::OpCodeForName(opName), result, op1, op2));
  return result;
}


void CodeGenerator::GenLabel(const char *label)
{
  code->Append(new Label(label));
}

void CodeGenerator::GenIfZ(Location *test, const char *label)
{
  code->Append(new IfZ(test, label));
}

void CodeGenerator::GenGoto(const char *label)
{
  code->Append(new Goto(label));
}

void CodeGenerator::GenReturn(Location *val)
{
  code->Append(new Return(val));
}


BeginFunc *CodeGenerator::GenBeginFunc()
{
  BeginFunc *result = new BeginFunc;
  code->Append(result);
  insideFn = code->NumElements() - 1;
  curStackOffset = OffsetToFirstLocal;
  return result;
}

void CodeGenerator::GenEndFunc()
{
  code->Append(new EndFunc());
  BeginFunc *beginFunc = dynamic_cast<BeginFunc*>(code->Nth(insideFn));
  Assert(beginFunc != NULL);
  beginFunc->SetFrameSize(OffsetToFirstLocal-curStackOffset);
}

void CodeGenerator::GenPushParam(Location *param)
{
  code->Append(new PushParam(param));
}

void CodeGenerator::GenPopParams(int numBytesOfParams)
{
  Assert(numBytesOfParams >= 0 && numBytesOfParams % VarSize == 0); // sanity check
  if (numBytesOfParams > 0)
    code->Append(new PopParams(numBytesOfParams));
}

Location *CodeGenerator::GenLCall(const char *label, bool fnHasReturnValue)
{
  Location *result = fnHasReturnValue ? GenTempVariable() : NULL;
  code->Append(new LCall(label, result));
  return result;
}
  
Location *CodeGenerator::GenFunctionCall(const char *fnLabel, List<Location*> *args, bool hasReturnValue)
{
  for (int i = args->NumElements()-1; i >= 0; i--) // push params right to left
    GenPushParam(args->Nth(i));
  Location *result = GenLCall(fnLabel, hasReturnValue);
  GenPopParams(args->NumElements()*VarSize);
  return result;
}

Location *CodeGenerator::GenACall(Location *fnAddr, bool fnHasReturnValue)
{
  Location *result = fnHasReturnValue ? GenTempVariable() : NULL;
  code->Append(new ACall(fnAddr, result));
  return result;
}
  
Location *CodeGenerator::GenMethodCall(Location *rcvr,
			     Location *meth, List<Location*> *args, bool fnHasReturnValue)
{
  for (int i = args->NumElements()-1; i >= 0; i--)
    GenPushParam(args->Nth(i));
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

Location *CodeGenerator::GenBuiltInCall(BuiltIn bn,Location *arg1, Location *arg2)
{
  Assert(bn >= 0 && bn < NumBuiltIns);
  struct _builtin *b = &builtins[bn];
  Location *result = NULL;

  if (b->hasReturn) result = GenTempVariable();
                // verify appropriate number of non-NULL arguments given
  Assert((b->numArgs == 0 && !arg1 && !arg2)
	|| (b->numArgs == 1 && arg1 && !arg2)
	|| (b->numArgs == 2 && arg1 && arg2));
  if (arg2) code->Append(new PushParam(arg2));
  if (arg1) code->Append(new PushParam(arg1));
  code->Append(new LCall(b->label, result));
  GenPopParams(VarSize*b->numArgs);
  return result;
}


void CodeGenerator::GenVTable(const char *className, List<const char *> *methodLabels)
{
  code->Append(new VTable(className, methodLabels));
}


void CodeGenerator::DoFinalCodeGen() {

    if (IsDebugOn("opt")) { // prints out code names
        for (int i = 0; i < code->NumElements(); i++) {
            cout << typeid(*code->Nth(i)).name() << endl;
        }
    } else if (IsDebugOn("tac")) { // if debug don't translate to mips, just print Tac
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

void CodeGenerator::DoOptimization() {
    auto successor_tree = GenSuccessorTree();
}

CFInstruction * CodeGenerator::GenSuccessorTree() {
    vector<CFInstruction *> instructions(code->NumElements());
    for (int i = 0; i < instructions.size(); ++i) {
        instructions[i] = new CFInstruction;
        instructions[i]->instruction = code->Nth(i);
    }

    auto tree = GenSuccessorTreeImpl(0, instructions);

    CFInstruction::traverse(tree, [](CFInstruction *curr) {
        curr->print();
    });

    DoLiveAnalyses(tree);

    for (auto &instr : instructions) {
        instr->print();
    }

    return tree;
}

CFInstruction * CodeGenerator::GenSuccessorTreeImpl(int pos, const vector<CFInstruction *> &instructions,
                                                    CFInstruction *predecessor) {
    if (pos >= code->NumElements()) return nullptr;

    auto cfi = instructions[pos];

    if (predecessor) {
        if (!cfi->predecessors.first && cfi->predecessors.second != predecessor) {
            cfi->predecessors.first = predecessor;
        } else if (!cfi->predecessors.second && cfi->predecessors.first != predecessor) {
            cfi->predecessors.second = predecessor;
        }

        if (!predecessor->successors.first && predecessor->successors.second != cfi) {
            predecessor->successors.first = cfi;
        } else if (!predecessor->successors.second && predecessor->successors.first != cfi) {
            predecessor->successors.second = cfi;
        }
    }

    auto ifz = dynamic_cast<IfZ*>(cfi->instruction);
    auto goTo = dynamic_cast<Goto*>(cfi->instruction);

    if (ifz) {
        GenSuccessorTreeImpl(pos + 1, instructions, cfi);
        GenSuccessorTreeImpl(GetPosOfLabel(ifz->GetLabel()), instructions, cfi);
    } else if (goTo) {
        GenSuccessorTreeImpl(GetPosOfLabel(goTo->GetLabel()), instructions, cfi);
    } else {
        GenSuccessorTreeImpl(pos + 1, instructions, cfi);
    }

    return cfi;
}

int CodeGenerator::GetPosOfLabel(const char *label) const {
    for (int i = 0; i < code->NumElements(); ++i) {
        auto ilabel = dynamic_cast<Label*>(code->Nth(i));
        if (ilabel && strcmp(ilabel->GetLabel(), label) == 0) {
            return i;
        }
    }

    Assert(false);
    return -1;
}

void CodeGenerator::DoLiveAnalyses(CFInstruction *tree) {
    bool changed = true;

    while (changed) {
        changed = false;

        // for each TAC
        CFInstruction::traverse(tree, [&](CFInstruction *curr) {
            vector<Location *> succ;

            if (curr->successors.first) {
                succ.insert(succ.end(), curr->successors.first->in.begin(), curr->successors.first->in.end());
            }

            if (curr->successors.second) {
                succ.insert(succ.end(), curr->successors.second->in.begin(), curr->successors.second->in.end());
            }

            curr->out = succ;

            auto kill = curr->instruction->GetKillSet();
            auto gen = curr->instruction->GetGenSet();

            // erase anything in the succ set that is in the kill set
            auto ebegin = remove_if(succ.begin(), succ.end(), [&](Location *loc) {
               return find_if(kill.begin(), kill.end(), bind(mem_fn(&Location::IsEqualTo), loc, placeholders::_1)) != kill.end();
            });
            succ.erase(ebegin, succ.end());

            // add anything in the gen set into the succ set, if its not already added
            for (auto *loc : gen) {
                auto found = find_if(
                        succ.begin(),
                        succ.end(),
                        bind(mem_fn(&Location::IsEqualTo), loc, placeholders::_1)) != succ.end();

                if (!found) {
                    succ.push_back(loc);
                }
            }

            // if succ and curr->in set are not equal, set succ equal to curr->in and set changed to true
            if (succ != curr->in) {
                changed = true;
                curr->in = succ;
            }
        });
    }
}
