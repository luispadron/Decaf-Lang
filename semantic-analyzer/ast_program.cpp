#include "ast_program.h"
#include "ast_decl.h"

#include <iostream>
#include <exception>

using namespace std;


Program::Program(List<Decl*> *d) {
    Assert(d != nullptr);
    (decls = d)->set_parent_all(this);
}

/**
 * This is the main entry point for the parser.
 * This function should set off all the children to have them verify the semantics are valid.
 */
void Program::check() {
    #if DEBUG==1
        Sym_tbl_t::shared().DEBUG_PRINT = true;
    #endif

    // push root scope
    Sym_tbl_t::shared().enter_scope("root");

    // check all declarations
    decls->check_all();
}