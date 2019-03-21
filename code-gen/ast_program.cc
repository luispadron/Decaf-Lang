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

    Sym_tbl_t::shared().leave_scope();
}


/**
 * This is the entry point for the code generator.
 * In this function we need to do:
 *
 * 1. Emit code for loading globals and setting offsets
 * 2. Setup any other thing the child nodes of the AST will need
 * 3. Call "emit" on any declarations within the program.
 */
void Program::emit() {
    Sym_tbl_t::shared().enter_scope("global");

    // set location for globals
    int goffset = CodeGenerator::offset_first_global;
    for (int i = 0; i < decls->size(); ++i) {
        auto gvar = dynamic_cast<VarDecl*>(decls->get(i));
        if (gvar) {
            auto var_loc = new Location(Segment::gp_relative, goffset, gvar->get_id()->get_name().c_str());
            gvar->set_location(var_loc);
            goffset += gvar->get_bytes();
        }
    }

    // emit code for other decls that are not variables
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        if (!dynamic_cast<VarDecl*>(decl)) {
            decl->emit(nullptr, nullptr);
        }
    }

    // perform final code generation
    CodeGenerator::shared().do_final_code_gen();

    Sym_tbl_t::shared().leave_scope();
}