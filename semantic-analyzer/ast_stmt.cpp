/* File: ast_stmt.cc
 * -----------------
 * Implementation of statement node classes.
 */
#include "ast_stmt.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "ast_expr.h"
#include "Symbol_table.h"
#include "errors.h"

StmtBlock::StmtBlock(List<VarDecl*> *d, List<Stmt*> *s) {
    Assert(d != nullptr && s != nullptr);
    (decls = d)->set_parent_all(this);
    (stmts = s)->set_parent_all(this);
}

bool StmtBlock::check() {

}


ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) { 
    Assert(t != nullptr && b != nullptr);
    (test = t)->set_parent(this);
    (body = b)->set_parent(this);
}

bool ConditionalStmt::check() {

}


bool LoopStmt::check() {

}


ForStmt::ForStmt(Expr *i, Expr *t, Expr *s, Stmt *b): LoopStmt(t, b) { 
    Assert(i != nullptr && t != nullptr && s != nullptr && b != nullptr);
    (init = i)->set_parent(this);
    (step = s)->set_parent(this);
}

bool ForStmt::check() {

}


bool WhileStmt::check() {

}


IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) { 
    Assert(t != nullptr && tb != nullptr); // else can be nullptr
    elseBody = eb;
    if (elseBody) elseBody->set_parent(this);
}

bool IfStmt::check() {

}


bool BreakStmt::check() {

}


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) { 
    Assert(e != nullptr);
    (expr = e)->set_parent(this);
}

bool ReturnStmt::check() {

}


PrintStmt::PrintStmt(List<Expr*> *a) {    
    Assert(a != nullptr);
    (args = a)->set_parent_all(this);
}

bool PrintStmt::check() {

}
