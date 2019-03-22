/* File: codegen.h
 * ---------------
 * The CodeGenerator class defines an object that will build Tac
 * instructions (using the Tac class and its subclasses) and store the
 * instructions in a sequential list, ready for further processing or
 * translation to MIPS as part of final code generation.
 *
 *    pp4:  The class as given supports the basic Tac instructions,
 *          you will need to extend it to handle the more complex
 *          operations (accessing instance variables, dynamic method
 *          dispatch, array length(), etc.)
 */

#ifndef _H_codegen
#define _H_codegen

#include <stdlib.h>
#include "list.h"
#include "tac.h"

// These codes are used to identify the built-in functions
typedef enum { Alloc, ReadLine, ReadInteger, StringEqual,
    PrintInt, PrintString, PrintBool, Halt, NumBuiltIns } BuiltIn;

enum class OffsetType {
    Global,
    Local,
    Param
};

class CodeGenerator {
public:

    /// Here are some class constants to remind you of the offsets
    /// used for globals, locals, and parameters. You will be
    /// responsible for using these when assigning Locations.
    /// In a MIPS stack frame, first local is at fp-8, subsequent locals
    /// are at fp-12, fp-16, and so on. The first param is at fp+4,
    /// subsequent ones as fp+8, fp+12, etc. (Because methods have secret
    /// "this" passed in first param slot at fp+4, all normal params
    /// are shifted up by 4.)  First global is at offset 0 from global
    /// pointer, all subsequent at +4, +8, etc.
    /// Conveniently, all vars are 4 bytes in size for code generation
    static const int offset_first_local = -8;
    static const int offset_first_param = 4;
    static const int offset_first_global = 0;
    static const int word_size = 4;

    /// the name of the main function, which is required in all programs
    static constexpr const char * const main_func_name = "main";


                    /******** API ********/

    /**
     * @return a singleton instance of the CodeGenerator class
     */
    static CodeGenerator & shared() {
        static CodeGenerator gen;
        return gen;
    }

    /**
     * Prepares the code generator for next code generation steps.
     */
    void reset_offsets();

    /**
     * Assigns a new unique label name and returns it. Does not
     * generate any Tac instructions (see GenLabel below if needed)
     */
    char * new_label();

    /**
     * Creates and returns a Location for a new uniquely named
     * temp variable. Does not generate any Tac instructions
     */
    Location * gen_temp_var();

    /**
     * Creates and returns a Location for a new local variable.
     * Calling this function modifies the local offset of the current code generator.
     */
     Location * gen_local_var(const char *name, int bytes);

    /**
    * Generates Tac instructions to load a constant value. Creates
    * a new temp var to hold the result. The constant
    * value is passed as an integer, it can be 0 for integer zero,
    * false for bool, NULL for null object, etc. All are just 4-byte
    * zero in the code generation world.
    * The second overloaded version is used for string constants.
    * The LoadLabel method loads a label into a temporary.
    * Each of the methods returns a Location for the temp var
    * where the constant was loaded.
    */
    Location *gen_load_constant(int value);
    Location *gen_load_constant(const char *str);
    Location *gen_load_label(const char *label);


    // Generates Tac instructions to copy value from one location to another
    void gen_assign(Location *dst, Location *src);

    // Generates Tac instructions to dereference addr and store value
    // into that memory location. addr should hold a valid memory address
    // (most likely computed from an array or field offset calculation).
    // The optional offset argument can be used to offset the addr by a
    // positive/negative number of bytes. If not given, 0 is assumed.
    void gen_store(Location *addr, Location *val, int offset = 0);

    // Generates Tac instructions to dereference addr and load contents
    // from a memory location into a new temp var. addr should hold a
    // valid memory address (most likely computed from an array or
    // field offset calculation). Returns the Location for the new
    // temporary variable where the result was stored. The optional
    // offset argument can be used to offset the addr by a positive or
    // negative number of bytes. If not given, 0 is assumed.
    Location * gen_load(Location *addr, int offset = 0);


    // Generates Tac instructions to perform one of the binary ops
    // identified by string name, such as "+" or "==".  Returns a
    // Location object for the new temporary where the result
    // was stored.
    Location * gen_binary_op(const char *opName, Location *op1, Location *op2);


    // Generates the Tac instruction for pushing a single
    // parameter. Used to set up for ACall and LCall instructions.
    // The Decaf convention is that parameters are pushed right
    // to left (so the first argument is pushed last)
    void gen_push_param(Location *param);

    // Generates the Tac instruction for popping parameters to
    // clean up after an ACall or LCall instruction. All parameters
    // are removed with one adjustment of the stack pointer.
    void gen_pop_params(int num_bytes);

    // Generates the Tac instructions for a LCall, a jump to
    // a compile-time label. The params to the target routine
    // should already have been pushed. If hasReturnValue is
    // true,  a new temp var is created, the fn result is stored
    // there and that Location is returned. If false, no temp is
    // created and NULL is returned
    Location * gen_l_call(const char *label, bool fn_has_return_val);

    // Generates the Tac instructions for ACall, a jump to an
    // address computed at runtime. Works similarly to LCall,
    // described above, in terms of return type.
    // The fnAddr Location is expected to hold the address of
    // the code to jump to (typically it was read from the vtable)
    Location * gen_a_call(Location *fn_addr, bool fn_has_return_val);

    // Generates the Tac instructions to call one of
    // the built-in functions (Read, Print, Alloc, etc.) Although
    // you could just make a call to GenLCall above, this cover
    // is a little more convenient to use.  The arguments to the
    // builtin should be given as arg1 and arg2, NULL is used if
    // fewer than 2 args to pass. The method returns a Location
    // for the new temp var holding the result.  For those
    // built-ins with no return value (Print/Halt), no temporary
    // is created and NULL is returned.
    Location * gen_built_in_call(BuiltIn bn, Location *arg1 = nullptr, Location *arg2 = nullptr);


    // These methods generate the Tac instructions for various
    // control flow (branches, jumps, returns, labels)
    // One minor detail to mention is that you can pass NULL
    // (or omit arg) to GenReturn for a return that does not
    // return a value
    void gen_ifz(Location *test, const char *label);
    void gen_go_to(const char *label);
    void gen_return(Location *val = nullptr);
    void gen_label(const char *label);


    // These methods generate the Tac instructions that mark the start
    // and end of a function/method definition.
    BeginFunc * gen_begin_func();
    void gen_end_func(BeginFunc *func);


    // Generates the Tac instructions for defining vtable for a
    // The methods parameter is expected to contain the vtable
    // methods in the order they should be laid out.  The vtable
    // is tagged with a label of the class name, so when you later
    // need access to the vtable, you use LoadLabel of class name.
    void gen_vtable(const char *className, List<const char *> *methodLabels);


    // Emits the final "object code" for the program by
    // translating the sequence of Tac instructions into their mips
    // equivalent and printing them out to stdout. If the debug
    // flag tac is on (-d tac), it will not translate to MIPS,
    // but instead just print the untranslated Tac. It may be
    // useful in debugging to first make sure your Tac is correct.
    void do_final_code_gen();

private:
    List<Instruction*> *code;
    bool is_main_defined;
    int next_local_offset;
    int curr_func_frame_size;

    /// creates a new code generator, private to disallow creation unless using "shared"
    CodeGenerator();
};

#endif
