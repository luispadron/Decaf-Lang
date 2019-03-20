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
 * This is the entry point for the semantic analyzer.
 * In this project we wont perform "as much" semantic analyses.
 * So the main goal of this check function is to setup the symbol table.
 *
 * It will traverse the AST and setup scoping as needed.
 */
void Program::check() {

    // push root scope
    auto g_scope = Sym_tbl_t::shared().create_scope("global", ScopeType::Global);

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


/**
 * This is the entry point for the code generator.
 * In this function we need to do:
 *
 * 1. Verify that the "main" function is defined
 * 2. Emit code for loading globals and setting offsets
 * 3. Setup any other thing the child nodes of the AST will need
 * 4. Call "emit" on any declarations within the program.
 */
void Program::emit() {

}