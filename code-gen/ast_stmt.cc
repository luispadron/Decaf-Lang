/* File: ast_stmt.cc
 * -----------------
 * Implementation of statement node classes.
 */
#include "ast_stmt.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "ast_expr.h"
#include "errors.h"

using namespace std;

int StmtBlock::next_block_id = 0;

StmtBlock::StmtBlock(List<VarDecl*> *d, List<Stmt*> *s): block_id(next_block_id++) {
    Assert(d != nullptr && s != nullptr);
    (decls = d)->set_parent_all(this);
    (stmts = s)->set_parent_all(this);
}

string StmtBlock::get_mangled_name() const {
    return "_block" + to_string(block_id);
}

int StmtBlock::get_bytes() const {
    // collect bytes from children
    int bytes = 0;

    for (int i = 0; i < decls->size(); ++i) {
        bytes += decls->get(i)->get_bytes();
    }

    for (int i = 0; i < stmts->size(); ++i) {
        bytes += stmts->get(i)->get_bytes();
    }

    return bytes;
}

void StmtBlock::check() {
    auto scope = Sym_tbl_t::shared().create_scope(get_mangled_name(), ScopeType::Block);

    // add declarations to scope
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        scope->insert_decl(decl->get_id()->get_name(), decl);
    }

    for (int i = 0; i < stmts->size(); ++i) {
        stmts->get(i)->check();
    }

    Sym_tbl_t::shared().leave_scope();
}

Location * StmtBlock::emit() const {
    auto scope = Sym_tbl_t::shared().enter_scope(get_mangled_name());

    // set locations for local variables, the offset is tracked by code generator as there
    // can be multiple stmt blocks inside each other and thus must be done and tracked recursively
    for (int i = 0; i < decls->size(); ++i) {
        auto var = dynamic_cast<VarDecl*>(decls->get(i));
        if (var) {
            auto loc = Cgen_t::shared().gen_local_var(var->get_id()->get_name().c_str(), var->get_bytes());
            var->set_location(loc);
        }
    }

    for (int i = 0; i < stmts->size(); ++i) {
        stmts->get(i)->emit();
    }

    Sym_tbl_t::shared().leave_scope();
    return nullptr;
}


ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) {
    Assert(t != nullptr && b != nullptr);
    (test = t)->set_parent(this);
    (body = b)->set_parent(this);
}

void ConditionalStmt::check() {
    body->check();
}


ForStmt::ForStmt(Expr *i, Expr *t, Expr *s, Stmt *b): LoopStmt(t, b) {
    Assert(i != nullptr && t != nullptr && s != nullptr && b != nullptr);
    (init = i)->set_parent(this);
    (step = s)->set_parent(this);
}


IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) {
    Assert(t != nullptr && tb != nullptr); // else can be nullptr
    elseBody = eb;
    if (elseBody) elseBody->set_parent(this);
}

void IfStmt::check() {
    body->check();
    if (elseBody) elseBody->check();
}

int IfStmt::get_bytes() const {
    return body->get_bytes() + (elseBody ? elseBody->get_bytes() : 0) + Cgen_t::word_size;
}

Location* IfStmt::emit() const {
    auto else_lbl = Cgen_t::shared().new_label();
    auto end_lbl = Cgen_t::shared().new_label();
    auto test_loc = test->emit();

    Cgen_t::shared().gen_ifz(test_loc, else_lbl);

    // anything under here will be executed if the if statement passes
    body->emit();
    Cgen_t::shared().gen_go_to(end_lbl); // skip over else body

    Cgen_t::shared().gen_label(else_lbl);
    // anything here will be executed if the if statement fails
    if (elseBody) elseBody->emit();

    // end of if statement
    Cgen_t::shared().gen_label(end_lbl);

    return nullptr;
}



ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) {
    Assert(e != nullptr);
    (expr = e)->set_parent(this);
}


PrintStmt::PrintStmt(List<Expr*> *a) {
    Assert(a != nullptr);
    (args = a)->set_parent_all(this);
}

int PrintStmt::get_bytes() const {
    return args->size() * Cgen_t::word_size;
}

Location* PrintStmt::emit() const {
    for (int i = 0; i < args->size(); ++i) {
        auto arg = args->get(i);
        auto arg_type = arg->type_check();
        auto arg_tmp = arg->emit();

        if (arg_type->is_equal_to(Type::stringType)) {
            Cgen_t::shared().gen_built_in_call(PrintString, arg_tmp);
        } else if (arg_type->is_equal_to(Type::boolType)){
            Cgen_t::shared().gen_built_in_call(PrintBool, arg_tmp);
        } else if (arg_type->is_equal_to(Type::intType)) {
            Cgen_t::shared().gen_built_in_call(PrintInt, arg_tmp);
        } else {
            Assert(false);
            return nullptr;
        }
    }

    return nullptr;
}