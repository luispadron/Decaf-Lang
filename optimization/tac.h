/* File: tac.h
 * -----------
 * This module contains the Instruction class (and its various
 * subclasses) that represent Tac instructions and the Location
 * class used for operands to those instructions.
 *
 * Each instruction is mostly just a little struct with a
 * few fields, but each responds polymorphically to the methods
 * Print and Emit, the first is used to print out the TAC form of
 * the instruction (helpful when debugging) and the second to
 * convert to the appropriate MIPS assembly.
 *
 * The operands to each instruction are of Location class.
 * A Location object is a simple representation of where a variable
 * exists at runtime, i.e. whether it is on the stack or global
 * segment and at what offset relative to the current fp or gp.
 *
 * You may need to make changes/extensions to these classes
 * if you are working on IR optimization.

 */

#ifndef _H_tac
#define _H_tac

#include "list.h" // for VTable
#include "mips.h"

#include <set>
#include <utility>


    // A Location object is used to identify the operands to the
    // various TAC instructions. A Location is either fp or gp
    // relative (depending on whether in stack or global segemnt)
    // and has an offset relative to the base of that segment.
    // For example, a declaration for integer num as the first local
    // variable in a function would be assigned a Location object
    // with name "num", segment fpRelative, and offset -8. 
 
typedef enum {fpRelative, gpRelative} Segment;

class Location {
protected:
    const char *variableName = "";
    Segment segment;
    int offset;
    Location *reference = nullptr;
    int refOffset;

    // The register allocated to this location.
    // A "zero" indicates that no register has been allocated.
    Mips::Register reg = Mips::Register::zero;

public:
    Location(Segment seg, int offset, const char *name);

    Location(Location *base, int refOff) :
        variableName(base->variableName), segment(base->segment),
        offset(base->offset), reference(base), refOffset(refOff) {}

    bool IsEqualTo(const Location *other) const;

    const char *GetName() const { return variableName; }
    Segment GetSegment() const { return segment; }
    int GetOffset() const { return offset; }
    void SetRegister(Mips::Register r)    { reg = r; }
    Mips::Register GetRegister()          { return reg; }
    bool IsReference()              { return reference != nullptr; }
    Location *GetReference()        { return reference; }
    int GetRefOffset()              { return refOffset; }
};



  // base class from which all Tac instructions derived
  // has the interface for the 2 polymorphic messages: Print & Emit
  
class Instruction {
protected:
    char printed[128];
	  
public:
    std::set<Location *> inSet;
    std::set<Location *> outSet;
    std::set<Instruction *> successors;
    std::set<Instruction *> predecessors;

	virtual void Print();
	virtual void EmitSpecific(Mips *mips) = 0;
	virtual void Emit(Mips *mips);
    void SetOutSet(std::set<Location *> out) { outSet = std::move(out); }
    virtual std::set<Location *> GetKillSet() const;
    virtual std::set<Location *> GetGenSet() const;
    virtual void GenSuccSet(int pos, const std::vector<Instruction *> &instructions);
    static int GetPosOfLabel(const char *label, const std::vector<Instruction *> &instructions);
};

  
  
  // for convenience, the instruction classes are listed here.
  // the interfaces for the classes follows below
  
  class LoadConstant;
  class LoadStringConstant;
  class LoadLabel;
  class Assign;
  class Load;
  class Store;
  class BinaryOp;
  class Label;
  class Goto;
  class IfZ;
  class BeginFunc;
  class EndFunc;
  class Return;
  class PushParam;
  class RemoveParams;
  class LCall;
  class ACall;
  class VTable;




class LoadConstant: public Instruction {
    Location *dst;
    int val;

public:
    LoadConstant(Location *dst, int val);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
};

class LoadStringConstant: public Instruction {
    Location *dst;
    char *str;

public:
    LoadStringConstant(Location *dst, const char *s);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
};
    
class LoadLabel: public Instruction {
    Location *dst;
    const char *label;

public:
    LoadLabel(Location *dst, const char *label);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
};

class Assign: public Instruction {
    Location *dst, *src;

public:
    Assign(Location *dst, Location *src);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
    std::set<Location *> GetGenSet() const override;
};

class Load: public Instruction {
    Location *dst, *src;
    int offset;

public:
    Load(Location *dst, Location *src, int offset = 0);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
    std::set<Location *> GetGenSet() const override;
};

class Store: public Instruction {
    Location *dst, *src;
    int offset;

public:
    Store(Location *d, Location *s, int offset = 0);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetGenSet() const override;
};

class BinaryOp: public Instruction {

public:
    static const char * const opName[Mips::NumOps];
    static Mips::OpCode OpCodeForName(const char *name);

    BinaryOp(Mips::OpCode c, Location *dst, Location *op1, Location *op2);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
    std::set<Location *> GetGenSet() const override;

protected:
    Mips::OpCode code;
    Location *dst, *op1, *op2;
};

class Label: public Instruction {
    const char *label;

public:
    explicit Label(const char *label);
    void Print() override;
    void EmitSpecific(Mips *mips) override;
    const char *GetLabel() { return label; }
};

class Goto: public Instruction {
    const char *label;

public:
    explicit Goto(const char *label);
    void EmitSpecific(Mips *mips) override;
    void GenSuccSet(int pos, const std::vector<Instruction *> &instructions) override;
};

class IfZ: public Instruction {
    Location *test;
    const char *label;

public:
    IfZ(Location *test, const char *label);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetGenSet() const override;
    void GenSuccSet(int pos, const std::vector<Instruction *> &instructions) override;
};

class BeginFunc: public Instruction {
    int frameSize;

public:
    BeginFunc();
    // used to backpatch the instruction with frame size once known
    void SetFrameSize(int numBytesForAllLocalsAndTemps);
    void EmitSpecific(Mips *mips) override;
};

class EndFunc: public Instruction {
public:
    EndFunc();
    void EmitSpecific(Mips *mips) override;
    void GenSuccSet(int pos, const std::vector<Instruction *> &instructions) override;
};

class Return: public Instruction {
    Location *val = nullptr;

public:
    explicit Return(Location *val);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetGenSet() const override;
    std::set<Location *> GetKillSet() const override;
    void GenSuccSet(int pos, const std::vector<Instruction *> &instructions) override;
};   

class PushParam: public Instruction {
    Location *param = nullptr;

public:
    explicit PushParam(Location *param);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetGenSet() const override;
}; 

class PopParams: public Instruction {
    int numBytes;

public:
    explicit PopParams(int numBytesOfParamsToRemove);
    void EmitSpecific(Mips *mips) override;
}; 

class LCall: public Instruction {
    const char *label;
    Location *dst;

public:
    LCall(const char *label, Location *result);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
};

class ACall: public Instruction {
    Location *dst, *methodAddr;

public:
    ACall(Location *meth, Location *result);
    void EmitSpecific(Mips *mips) override;
    std::set<Location *> GetKillSet() const override;
    std::set<Location *> GetGenSet() const override;
};

class VTable: public Instruction {
    List<const char *> *methodLabels;
    const char *label;

public:
    VTable(const char *labelForTable, List<const char *> *methodLabels);
    void Print() override;
    void EmitSpecific(Mips *mips) override;
};


#endif
