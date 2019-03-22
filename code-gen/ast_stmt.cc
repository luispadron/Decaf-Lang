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


int StmtBlock::current_block_id = 0;

StmtBlock::StmtBlock(List<VarDecl*> *d, List<Stmt*> *s) : block_id(StmtBlock::current_block_id++) {
    Assert(d != nullptr && s != nullptr);
    (decls = d)->set_parent_all(this);
    (stmts = s)->set_parent_all(this);
}

string StmtBlock::get_mangled_name(const std::string &func_name) const {
    return func_name + "_block" + to_string(block_id);
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

void StmtBlock::check(Scope *func_scope) {
    Assert(func_scope);
    auto scope = Sym_tbl_t::shared().create_scope(get_mangled_name(func_scope->name()), ScopeType::Block);

    // add declarations to scope
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        scope->insert_decl(decl->get_id()->get_name(), decl);
    }

    for (int i = 0; i < stmts->size(); ++i) {
        auto block = dynamic_cast<StmtBlock*>(stmts->get(i));
        if (block) block->check(func_scope);
    }

    Sym_tbl_t::shared().leave_scope();
}

Location * StmtBlock::emit(Scope *func_scope) const {
    Assert(func_scope);
    auto scope = Sym_tbl_t::shared().enter_scope(get_mangled_name(func_scope->name()));

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
        stmts->get(i)->emit(func_scope);
    }

    Sym_tbl_t::shared().leave_scope();
    return nullptr;
}


ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) {
    Assert(t != nullptr && b != nullptr);
    (test = t)->set_parent(this);
    (body = b)->set_parent(this);
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


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) {
    Assert(e != nullptr);
    (expr = e)->set_parent(this);
}


PrintStmt::PrintStmt(List<Expr*> *a) {
    Assert(a != nullptr);
    (args = a)->set_parent_all(this);
}