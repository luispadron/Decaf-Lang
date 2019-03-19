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

void StmtBlock::check(Scope *function_scope) {
    Assert(function_scope);
    auto scope = Sym_tbl_t::shared().enter_scope(get_mangled_name(function_scope->name()), ScopeType::Block);

    for (int i = 0; i < decls->size(); ++i) {

    }

    // add declarations to scope
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        scope->insert_decl(decl->get_id()->get_name(), decl);
    }

    for (int i = 0; i < stmts->size(); ++i) {
        auto block = dynamic_cast<StmtBlock*>(stmts->get(i));
        if (block) block->check(function_scope);
    }

    Sym_tbl_t::shared().leave_scope();
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