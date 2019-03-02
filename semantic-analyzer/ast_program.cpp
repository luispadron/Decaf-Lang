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
    auto sym_table = Sym_table_t::shared();

    // TODO: remove this
    sym_table.DEBUG_PRINT = true;

    try {
        // push root scope
        sym_table.push_scope("root");


        // first we push all function names into global scope
        for (int i = 0; i < decls->size(); ++i) {
            auto decl = decls->get(i);
            auto fdecl = dynamic_cast<FnDecl *>(decl);

            if (fdecl) {
                sym_table.insert_symbol(fdecl->get_name(), fdecl);
            }
        }

        // now we can traverse the AST
        for (int i = 0; i < decls->size(); ++i) {
            auto decl = decls->get(i);
            decl->check();

            // TODO: remove this
            cout << endl;
            sym_table.debug_print();
            cout << endl;
        }
    } catch (const Symbol_table_exception &e) {
        cout << e.what() << endl;
    } catch (const std::exception &e) {
        cout << e.what() << endl;
    }

    return true;
}