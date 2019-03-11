#include "ast_program.h"
#include "ast_decl.h"
#include "errors.h"

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

    // add declaration for global nullptr symbol
    Sym_tbl_t::shared().insert_declaration("null", new VarDecl(new Identifier(yyltype(), "null"), Type::nullType));

    // go through each decl and push it's identifier into root scope
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        try {
            Sym_tbl_t::shared().insert_declaration(decl->get_id()->get_name(), decl);
        } catch (Duplicate_symbol_exception &de) {
            ReportError::decl_conflict(decl, de.get_decl());
        }
    }

    // check all declarations
    decls->check_all();
}