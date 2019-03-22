/* File: codegen.cc
 * ----------------
 * Implementation for the CodeGenerator class. The methods don't do anything
 * too fancy, mostly just create objects of the various Tac instruction
 * classes and append them to the list.
 */

#include "codegen.h"
#include "errors.h"
#include "tac.h"
#include "mips.h"

#include <cstring>

using namespace std;

CodeGenerator::CodeGenerator() :
    code(new List<Instruction*>),
    is_main_defined(false),
    next_local_offset(CodeGenerator::offset_first_local) { }

void CodeGenerator::reset_offsets() {
    // reset offsets
    next_local_offset = CodeGenerator::offset_first_local;
}

char *CodeGenerator::new_label() {
    static int nextLabelNum = 0;
    char temp[10];
    sprintf(temp, "_L%d", nextLabelNum++);
    return strdup(temp);
}


Location *CodeGenerator::gen_temp_var() {
    static int nextTempNum;
    char temp[10];
    sprintf(temp, "_tmp%d", nextTempNum++);
    auto *result = new Location(Segment::fp_relative, next_local_offset, temp);
    next_local_offset -= word_size;

    Assert(result);
    return result;
}

Location* CodeGenerator::gen_local_var(const char *name, int bytes) {
    auto loc = new Location(Segment::fp_relative, next_local_offset, name);
    next_local_offset -= bytes;
    return loc;
}

Location *CodeGenerator::gen_load_constant(int value) {
    Location *result = gen_temp_var();
    code->append(new LoadConstant(result, value));
    return result;
}

Location *CodeGenerator::gen_load_constant(const char *str) {
    Location *result = gen_temp_var();
    code->append(new LoadStringConstant(result, str));
    return result;
}

Location *CodeGenerator::gen_load_label(const char *label) {
    Location *result = gen_temp_var();
    code->append(new LoadLabel(result, label));
    return result;
}


void CodeGenerator::gen_assign(Location *dst, Location *src)
{
    code->append(new Assign(dst, src));
}


Location *CodeGenerator::gen_load(Location *addr, int offset)
{
    Location *result = gen_temp_var();
    code->append(new Load(result, addr, offset));
    return result;
}

void CodeGenerator::gen_store(Location *addr, Location *val, int offset)
{
    code->append(new Store(addr, val, offset));
}


Location *CodeGenerator::gen_binary_op(const char *opName, Location *op1, Location *op2) {
    Location *result = gen_temp_var();
    code->append(new BinaryOp(BinaryOp::OpCodeForName(opName), result, op1, op2));
    return result;
}


void CodeGenerator::gen_label(const char *label) {
    code->append(new Label(label));
    // check to see if the label is the "main" label
    is_main_defined = is_main_defined || strcmp(label, CodeGenerator::main_func_name) == 0;
}

void CodeGenerator::gen_ifz(Location *test, const char *label)
{
    code->append(new IfZ(test, label));
}

void CodeGenerator::gen_go_to(const char *label)
{
    code->append(new Goto(label));
}

void CodeGenerator::gen_return(Location *val)
{
    code->append(new Return(val));
}


BeginFunc *CodeGenerator::gen_begin_func() {
    auto result = new BeginFunc;
    code->append(result);
    return result;
}

void CodeGenerator::gen_end_func() {
    code->append(new EndFunc());
}

void CodeGenerator::gen_push_param(Location *param)
{
    code->append(new PushParam(param));
}

void CodeGenerator::gen_pop_params(int num_bytes)
{
    Assert(num_bytes >= 0 && num_bytes % word_size == 0); // sanity check
    if (num_bytes > 0)
        code->append(new PopParams(num_bytes));
}

Location *CodeGenerator::gen_l_call(const char *label, bool fn_has_return_val)
{
    Location *result = fn_has_return_val ? gen_temp_var() : nullptr;
    code->append(new LCall(label, result));
    return result;
}

Location *CodeGenerator::gen_a_call(Location *fn_addr, bool fn_has_return_val)
{
    Location *result = fn_has_return_val ? gen_temp_var() : nullptr;
    code->append(new ACall(fn_addr, result));
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

Location *CodeGenerator::gen_built_in_call(BuiltIn bn, Location *arg1, Location *arg2) {
    Assert(bn >= 0 && bn < NumBuiltIns);
    struct _builtin *b = &builtins[bn];
    Location *result = nullptr;

    if (b->hasReturn) result = gen_temp_var();
    // verify appropriate number of non-nullptr arguments given
    Assert((b->numArgs == 0 && !arg1 && !arg2)
           || (b->numArgs == 1 && arg1 && !arg2)
           || (b->numArgs == 2 && arg1 && arg2));
    if (arg2) code->append(new PushParam(arg2));
    if (arg1) code->append(new PushParam(arg1));
    code->append(new LCall(b->label, result));
    gen_pop_params(word_size * b->numArgs);
    return result;
}


void CodeGenerator::gen_vtable(const char *className, List<const char *> *methodLabels)
{
    code->append(new VTable(className, methodLabels));
}


void CodeGenerator::do_final_code_gen() {
    // if main was not defined we need to throw a linker error
    if (!is_main_defined) {
        ReportError::NoMainFound();
        return;
    }

    if (is_debug_on("tac")) { // if debug don't translate to mips, just print Tac
        for (int i = 0; i < code->size(); i++)
            code->get(i)->Print();
    }  else {
        Mips mips;
        mips.EmitPreamble();
        for (int i = 0; i < code->size(); i++)
            code->get(i)->Emit(&mips);
    }
}


