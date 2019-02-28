/* File: ast_stmt.cc
 * -----------------
 * Implementation of statement node classes.
 */
#include "ast_stmt.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "ast_expr.h"
#include "Symbol_table.h"

#include <iostream>
#include <exception>

using namespace std;


Program::Program(List<Decl*> *d) {
    Assert(d != NULL);
    (decls=d)->SetParentAll(this);
}

/**
 * This is the main entry point for the parser.
 * This function should set off all the children to have them verify the semantics are valid.
 */
void Program::Check(Symbol_table<std::string, Node *> &sym_table) {
    try {
        for (int i = 0; i < decls->NumElements(); ++i) {
            Decl* decl = decls->Nth(i);
            decl->Check(sym_table);
        }

        sym_table.debug_print();
    } catch (const Symbol_table_exception &e) {
        cout << e.what() << endl;
    } catch (const std::exception &e) {
        cout << e.what() << endl;
    }
}


StmtBlock::StmtBlock(List<VarDecl*> *d, List<Stmt*> *s) {
    Assert(d != NULL && s != NULL);
    (decls=d)->SetParentAll(this);
    (stmts=s)->SetParentAll(this);
}

void StmtBlock::Check(Symbol_table<std::string, Node *> &sym_table) {
    // push scope and call children check method
    sym_table.push_scope();
    decls->CheckAll(sym_table);
    stmts->CheckAll(sym_table);
}


ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) { 
    Assert(t != NULL && b != NULL);
    (test=t)->SetParent(this); 
    (body=b)->SetParent(this);
}

void ConditionalStmt::Check(Symbol_table<std::string, Node *> &sym_table) {

}


ForStmt::ForStmt(Expr *i, Expr *t, Expr *s, Stmt *b): LoopStmt(t, b) { 
    Assert(i != NULL && t != NULL && s != NULL && b != NULL);
    (init=i)->SetParent(this);
    (step=s)->SetParent(this);
}

void ForStmt::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void WhileStmt::Check(Symbol_table<std::string, Node *> &sym_table) {

}


IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) { 
    Assert(t != NULL && tb != NULL); // else can be NULL
    elseBody = eb;
    if (elseBody) elseBody->SetParent(this);
}

void IfStmt::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void BreakStmt::Check(Symbol_table<std::string, Node *> &sym_table) {

}


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) { 
    Assert(e != NULL);
    (expr=e)->SetParent(this);
}

void ReturnStmt::Check(Symbol_table<std::string, Node *> &sym_table) {

}


PrintStmt::PrintStmt(List<Expr*> *a) {    
    Assert(a != NULL);
    (args=a)->SetParentAll(this);
}

void PrintStmt::Check(Symbol_table<std::string, Node *> &sym_table) {

}
