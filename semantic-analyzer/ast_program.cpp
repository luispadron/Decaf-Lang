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


        // first we push all function/class names into global scope
        for (int i = 0; i < decls->size(); ++i) {
            auto decl = decls->get(i);

            auto fdecl = dynamic_cast<FnDecl*>(decl);
            auto cdecl = dynamic_cast<ClassDecl*>(decl);
            if (fdecl) {
                Sym_table_t::shared().insert_symbol(fdecl->get_name(), fdecl);
            } else if (cdecl) {
                Sym_table_t::shared().insert_symbol(cdecl->get_id()->get_name(), cdecl);
            }
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