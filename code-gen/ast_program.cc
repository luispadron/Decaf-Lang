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

/// In this project we wont perform semantic analysis, all the check function will do is
/// generate the symbol table and call check on its children so they can insert symbols as well.
void Program::check() {

    // push root scope
    auto g_scope = Sym_tbl_t::shared().enter_scope("global", ScopeType::Global);

    // add declaration for global nullptr symbol
    g_scope->insert_decl("null", new VarDecl(new Identifier(yyltype(), "null"), Type::nullType));

    // go through each decl and push it's identifier into root scope
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        g_scope->insert_decl(decl->get_id()->get_name(), decl);
    }

    // tell each decl to check its privilege
    for (int i = 0; i < decls->size(); ++i) {
        decls->get(i)->check(nullptr);
    }

    Sym_tbl_t::shared().debug_print();
}

void Program::emit() {

}