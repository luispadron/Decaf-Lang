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

    // first check that main is defined
    bool is_main_defined = false;
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        if (decl->get_decl_type() == DeclType::Function && decl->get_id()->get_name() == Cgen_t::main_func_name) {
            is_main_defined = true;
        }
    }

    if (!is_main_defined) {
        ReportError::NoMainFound();
        return;
    }

    // set location for globals
    int offset = Cgen_t::offset_first_global;
    for (int i = 0; i < decls->size(); ++i) {
        auto var = dynamic_cast<VarDecl*>(decls->get(i));
        if (var) {
            auto loc = new Location(Segment::gp_relative, offset, var->get_id()->get_name().c_str());
            var->set_location(loc);
            offset += var->get_bytes();
        }
    }

    // perform virtual table generation and setting up of class hierarachy
    for (int i = 0; i < decls->size(); ++i) {
        auto class_decl = dynamic_cast<ClassDecl*>(decls->get(i));
        if (class_decl) {
            class_decl->prepare_for_emit();

            // setup super scope
            if (class_decl->get_extends()) {
                auto class_scope = Sym_tbl_t::shared().get_scope(class_decl->get_id()->get_name()).first;
                auto super_scope = Sym_tbl_t::shared().get_scope(class_decl->get_extends()->get_id()->get_name()).first;
                Assert(class_scope && super_scope);
                class_scope->set_super_scope(super_scope);
            }
        }
    }

    // emit code declarations
    for (int i = 0; i < decls->size(); ++i) {
        decls->get(i)->emit(nullptr, nullptr);
    }

    // perform final code generation
    Cgen_t::shared().do_final_code_gen();

    Sym_tbl_t::shared().leave_scope();
}