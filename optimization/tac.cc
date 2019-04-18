/* File: tac.cc
 * ------------
 * Implementation of Location class and Instruction class/subclasses.
 */
  
#include "tac.h"
#include "mips.h"


#include <algorithm>
#include <functional>
#include <string>
#include <cstring>
#include <deque>

using namespace std;

bool Location::LocSortFunc::operator()(const Location *lhs, const Location *rhs) const {
    if (lhs->segment > rhs->segment) return false;

    if (lhs->offset <= 0) {
        if (rhs->offset <= 0)
            return lhs->offset > rhs->offset;
        else
            return false;
    } else {
        if (rhs->offset <= 0) {
            return true;
        } else {
            return lhs->offset < rhs->offset;
        }
    }

}

Location::Location(Segment s, int o, const char *name) :
    variableName(strdup(name)), segment(s), offset(o), reg(Mips::zero) {}

bool Location::IsEqualTo(const Location *other) const {
    return (this == other ||
            (other
             && !strcmp(GetName(), other->GetName())
             && GetSegment() == other->GetSegment()
             && GetOffset() == other->GetOffset()));
}
 
void Instruction::Print() {
    printf("\t%s ;", printed);
    printf("\t# live-out = {");

    set<Location *, Location::LocSortFunc> out_set;
    for (auto *loc : outSet) {
        out_set.insert(loc);
    }

    for (auto it = out_set.begin(); it != out_set.end(); ++it) {
        auto *loc = *it;
        if (it != out_set.begin()) printf(",");
        printf("%s", loc->GetName());
    }
    printf("}");
    printf("\n");
}

void Instruction::Emit(Mips *mips) {
    if (*printed) {
        mips->Emit("# %s", printed);   // emit TAC as comment into assembly
    }

    EmitSpecific(mips);
}


std::set<Location *> Instruction::GetKillSet() const {
    return set<Location *>();
}

std::set<Location *> Instruction::GetGenSet() const {
    return set<Location *>();
}

set<Location *> Instruction::GetLocations() const {
    return set<Location *>();
}

void Instruction::GenSuccSet(int pos, const vector<Instruction *> &instructions) {
    if (pos + 1 < instructions.size()) {
        successors.insert(instructions[pos + 1]);
    }
}

int Instruction::GetPosOfLabel(const char *label, const std::vector<Instruction *> &instructions) {
    for (int i = 0; i < instructions.size(); ++i) {
        auto lblInstruction = dynamic_cast<Label*>(instructions[i]);
        if (lblInstruction && strcmp(lblInstruction->GetLabel(), label) == 0) {
            return i;
        }
    }

    Assert(false);
    return -1;
}


LoadConstant::LoadConstant(Location *d, int v) : dst(d), val(v) {
    Assert(dst != nullptr);
    sprintf(printed, "%s = %d", dst->GetName(), val);
}

void LoadConstant::EmitSpecific(Mips *mips) {
    mips->EmitLoadConstant(dst, val);
}

std::set<Location *> LoadConstant::GetKillSet() const {
    return set<Location *>{dst};
}

set<Location *> LoadConstant::GetLocations() const {
    return set<Location *>{dst};
}


LoadStringConstant::LoadStringConstant(Location *d, const char *s) : dst(d) {
    Assert(dst != nullptr && s != nullptr);
    const char *quote = (*s == '"') ? "" : "\"";
    str = new char[strlen(s) + 2*strlen(quote) + 1];
    sprintf(str, "%s%s%s", quote, s, quote);
    quote = (strlen(str) > 50) ? "...\"" : "";
    sprintf(printed, "%s = %.50s%s", dst->GetName(), str, quote);
}

void LoadStringConstant::EmitSpecific(Mips *mips) {
    mips->EmitLoadStringConstant(dst, str);
}

std::set<Location *> LoadStringConstant::GetKillSet() const {
    return set<Location *>{dst};
}

std::set<Location *> LoadStringConstant::GetLocations() const {
    return set<Location *>{dst};
}
     

LoadLabel::LoadLabel(Location *d, const char *l) : dst(d), label(strdup(l)) {
    Assert(dst != nullptr && label != nullptr);
    sprintf(printed, "%s = %s", dst->GetName(), label);
}

void LoadLabel::EmitSpecific(Mips *mips) {
    mips->EmitLoadLabel(dst, label);
}

std::set<Location *> LoadLabel::GetKillSet() const {
    return set<Location *>{dst};
}

std::set<Location *> LoadLabel::GetLocations() const {
    return set<Location *>{dst};
}


Assign::Assign(Location *d, Location *s) : dst(d), src(s) {
    Assert(dst != nullptr && src != nullptr);
    sprintf(printed, "%s = %s", dst->GetName(), src->GetName());
}

void Assign::EmitSpecific(Mips *mips) {
    mips->EmitCopy(dst, src);
}

std::set<Location *> Assign::GetKillSet() const {
    return set<Location *>{dst};
}

std::set<Location *> Assign::GetGenSet() const {
    return set<Location *>{src};
}

std::set<Location *> Assign::GetLocations() const {
    return set<Location *>{dst, src};
}


Load::Load(Location *d, Location *s, int off) : dst(d), src(s), offset(off) {
    Assert(dst != nullptr && src != nullptr);
    if (offset)
        sprintf(printed, "%s = *(%s + %d)", dst->GetName(), src->GetName(), offset);
    else
        sprintf(printed, "%s = *(%s)", dst->GetName(), src->GetName());
}

void Load::EmitSpecific(Mips *mips) {
    mips->EmitLoad(dst, src, offset);
}

std::set<Location *> Load::GetKillSet() const {
    return set<Location *>{dst};
}

std::set<Location *> Load::GetGenSet() const {
    return set<Location *>{src};
}

std::set<Location *> Load::GetLocations() const {
    return set<Location *>{dst, src};
}


Store::Store(Location *d, Location *s, int off) : dst(d), src(s), offset(off) {
    Assert(dst != nullptr && src != nullptr);
    if (offset)
        sprintf(printed, "*(%s + %d) = %s", dst->GetName(), offset, src->GetName());
    else
        sprintf(printed, "*(%s) = %s", dst->GetName(), src->GetName());
}

void Store::EmitSpecific(Mips *mips) {
    mips->EmitStore(dst, src, offset);
}


std::set<Location *> Store::GetGenSet() const {
    return set<Location *>{dst, src};
}

std::set<Location *> Store::GetLocations() const {
    return set<Location *>{dst, src};
}


const char * const BinaryOp::opName[Mips::NumOps]  = {"+", "-", "*", "/", "%", "==", "<", "&&", "||"};;

Mips::OpCode BinaryOp::OpCodeForName(const char *name) {
    for (int i = 0; i < Mips::NumOps; i++) {
        if (opName[i] && !strcmp(opName[i], name)) {
            return (Mips::OpCode) i;
        }
    }

    Failure("Unrecognized Tac operator: '%s'\n", name);
    return Mips::Add; // can't get here, but compiler doesn't know that
}

BinaryOp::BinaryOp(Mips::OpCode c, Location *d, Location *o1, Location *o2) : code(c), dst(d), op1(o1), op2(o2) {
    Assert(dst && op1 && op2);
    Assert(code >= 0 && code < Mips::NumOps);
    sprintf(printed, "%s = %s %s %s", dst->GetName(), op1->GetName(), opName[code], op2->GetName());
}

std::set<Location *> BinaryOp::GetLocations() const {
    return set<Location *>{dst, op1, op2};
}

void BinaryOp::EmitSpecific(Mips *mips) {
    mips->EmitBinaryOp(code, dst, op1, op2);
}

std::set<Location *> BinaryOp::GetKillSet() const {
    return set<Location *>{dst};
}

std::set<Location *> BinaryOp::GetGenSet() const {
    return set<Location *>{op1, op2};
}


Label::Label(const char *l) : label(strdup(l)) {
    Assert(label != nullptr);
    *printed = '\0';
}

void Label::Print() {
    printf("%s:\n", label);
}

void Label::EmitSpecific(Mips *mips) {
    mips->EmitLabel(label);
}

 
Goto::Goto(const char *l) : label(strdup(l)) {
    Assert(label != nullptr);
    sprintf(printed, "Goto %s", label);
}

void Goto::EmitSpecific(Mips *mips) {
    mips->EmitGoto(label);
}

void Goto::GenSuccSet(int pos, const vector<Instruction *> &instructions) {
    auto lbl_pos = Instruction::GetPosOfLabel(label, instructions);
    Assert(lbl_pos >= 0 && lbl_pos < instructions.size());
    successors.insert(instructions[lbl_pos]);
}

IfZ::IfZ(Location *te, const char *l) : test(te), label(strdup(l)) {
    Assert(test != nullptr && label != nullptr);
    sprintf(printed, "IfZ %s Goto %s", test->GetName(), label);
}

void IfZ::EmitSpecific(Mips *mips) {
    mips->EmitIfZ(test, label);
}

std::set<Location *> IfZ::GetGenSet() const {
    return set<Location *>{test};
}

std::set<Location *> IfZ::GetLocations() const {
    return set<Location *>{test};
}

void IfZ::GenSuccSet(int pos, const vector<Instruction *> &instructions) {
    auto lbl_pos = Instruction::GetPosOfLabel(label, instructions);

    Assert(pos + 1 < instructions.size());
    Assert(lbl_pos >= 0 && lbl_pos < instructions.size());

    successors.insert(instructions[pos + 1]);
    successors.insert(instructions[lbl_pos]);
}


BeginFunc::BeginFunc() {
  sprintf(printed,"BeginFunc (unassigned)");
  frameSize = -555; // used as sentinel to recognized unassigned value
}

void BeginFunc::SetFrameSize(int numBytesForAllLocalsAndTemps) {
  frameSize = numBytesForAllLocalsAndTemps; 
  sprintf(printed,"BeginFunc %d", frameSize);
}

void BeginFunc::EmitSpecific(Mips *mips) {
    mips->EmitBeginFunction(frameSize);
    // pp5: need to load all parameters to the allocated registers.
    set<Location *, Location::LocSortFunc> fills;
    set_union(fills.begin(), fills.end(),
            outSet.begin(), outSet.end(),
            inserter(fills, fills.begin()));

    for (auto *f : fills) {
        auto reg = f->GetRegister();
        mips->FillRegister(f, reg);
    }
}


EndFunc::EndFunc() : Instruction() {
    sprintf(printed, "EndFunc");
}

void EndFunc::EmitSpecific(Mips *mips) {
  mips->EmitEndFunction();
}

void EndFunc::GenSuccSet(int pos, const std::vector<Instruction *> &instructions) {
    Assert(successors.empty());
}

 
Return::Return(Location *v) : val(v) {
    sprintf(printed, "Return %s", val? val->GetName() : "");
}

void Return::EmitSpecific(Mips *mips) {
    mips->EmitReturn(val);
}

std::set<Location *> Return::GetGenSet() const {
    return val ? set<Location *>{val} : set<Location *>{};
}


std::set<Location *> Return::GetLocations() const {
    return val ? set<Location *>{val} : set<Location *>{};
}

void Return::GenSuccSet(int pos, const std::vector<Instruction *> &instructions) {
    Assert(successors.empty());
}


PushParam::PushParam(Location *p) :  param(p) {
    Assert(param != nullptr);
    sprintf(printed, "PushParam %s", param->GetName());
}

void PushParam::EmitSpecific(Mips *mips) {
    mips->EmitParam(param);
}

std::set<Location *> PushParam::GetGenSet() const {
    return set<Location *>{param};
}


std::set<Location *> PushParam::GetLocations() const {
    return set<Location *>{param};
}


PopParams::PopParams(int nb) : numBytes(nb) {
    sprintf(printed, "PopParams %d", numBytes);
}

void PopParams::EmitSpecific(Mips *mips) {
    mips->EmitPopParams(numBytes);
}


LCall::LCall(const char *l, Location *d) : label(strdup(l)), dst(d) {
    sprintf(printed, "%s%sLCall %s", dst? dst->GetName(): "", dst?" = ":"", label);
}

void LCall::EmitSpecific(Mips *mips) {
    // pp5: fill/spill parameters that are needed

    // spill any registers alive after call
    for (auto *i : inSet) {
        for (auto *o : outSet) {
            if (i == o && i->GetSegment() == fpRelative) {
                mips->SpillRegister(i, i->GetRegister());
            }
        }
    }

    mips->EmitLCall(dst, label);

    // fill any registers alive after call
    for (auto *i : inSet) {
        for (auto *o : outSet) {
            if (i == o && i->GetSegment() == fpRelative) {
                mips->FillRegister(i, i->GetRegister());
            }
        }
    }
}

std::set<Location *> LCall::GetKillSet() const {
    return dst ? set<Location *>{dst} : set<Location *>();
}

std::set<Location *> LCall::GetLocations() const {
    return dst ? set<Location *>{dst} : set<Location *>();
}


ACall::ACall(Location *ma, Location *d) : dst(d), methodAddr(ma) {
    Assert(methodAddr != nullptr);
    sprintf(printed, "%s%sACall %s", dst? dst->GetName(): "", dst?" = ":"", methodAddr->GetName());
}

void ACall::EmitSpecific(Mips *mips) {
    // pp5: need to spill and restore registers after function call
    for (auto *i : inSet) {
        for (auto *o : outSet) {
            if (i == o && i->GetSegment() == fpRelative) {
                mips->SpillRegister(i, i->GetRegister());
            }
        }
    }
    mips->EmitACall(dst, methodAddr);

    for (auto *i : inSet) {
        for (auto *o : outSet) {
            if (i == o && i->GetSegment() == fpRelative) {
                mips->FillRegister(i, i->GetRegister());
            }
        }
    }
}

std::set<Location *> ACall::GetKillSet() const {
    return dst ? set<Location *>{dst} : set<Location *>{};
}

std::set<Location *> ACall::GetGenSet() const {
    return set<Location *>{methodAddr};
}

std::set<Location *> ACall::GetLocations() const {
    return dst ? set<Location *>{dst, methodAddr} : set<Location *>{methodAddr};
}


VTable::VTable(const char *l, List<const char *> *m) : methodLabels(m), label(strdup(l)) {
    Assert(methodLabels != nullptr && label != nullptr);
    sprintf(printed, "VTable for class %s", l);
}

void VTable::Print() {
    printf("VTable %s =\n", label);

    for (int i = 0; i < methodLabels->NumElements(); i++) {
        printf("\t%s,\n", methodLabels->Nth(i));
    }

    printf("; \n");
}

void VTable::EmitSpecific(Mips *mips) {
    mips->EmitVTable(label, methodLabels);
}


