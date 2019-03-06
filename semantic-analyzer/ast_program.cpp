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
bool Program::check() {
    #if DEBUG==1
        Sym_table_t::shared().DEBUG_PRINT = false;
    #endif

    try {
        // push root scope
        Sym_table_t::shared().push_scope("root");


        // first we push all declarations into global scope
        for (int i = 0; i < decls->size(); ++i) {
            auto decl = decls->get(i);
            Sym_table_t::shared().insert_symbol(decl->get_id()->get_str(), decl);
        }

        // now we can traverse the AST
        for (int i = 0; i < decls->size(); ++i) {
            auto decl = decls->get(i);
            decl->check();
        }
    } catch (const Symbol_table_exception &e) {
        cout << e.what() << endl;
    } catch (const std::exception &e) {
        cout << e.what() << endl;
    }

    return true;
}