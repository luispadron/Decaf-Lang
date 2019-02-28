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
    Assert(d != nullptr);
    (decls = d)->set_parent_all(this);
}

/**
 * This is the main entry point for the parser.
 * This function should set off all the children to have them verify the semantics are valid.
 */
void Program::check(Symbol_table<std::string, Node *> &sym_table) {
    try {
        for (int i = 0; i < decls->size(); ++i) {
            Decl* decl = decls->get(i);
            decl->check(sym_table);
        }

        sym_table.debug_print();
    } catch (const Symbol_table_exception &e) {
        cout << e.what() << endl;
    } catch (const std::exception &e) {
        cout << e.what() << endl;
    }
}


StmtBlock::StmtBlock(List<VarDecl*> *d, List<Stmt*> *s) {
    Assert(d != nullptr && s != nullptr);
    (decls = d)->set_parent_all(this);
    (stmts = s)->set_parent_all(this);
}

void StmtBlock::check(Symbol_table<std::string, Node *> &sym_table) {
    // push scope and call children check method
    sym_table.push_scope();
    decls->check_all(sym_table);
    stmts->check_all(sym_table);
}


ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) { 
    Assert(t != nullptr && b != nullptr);
    (test = t)->set_parent(this);
    (body = b)->set_parent(this);
}

void ConditionalStmt::check(Symbol_table<std::string, Node *> &sym_table) {

}


ForStmt::ForStmt(Expr *i, Expr *t, Expr *s, Stmt *b): LoopStmt(t, b) { 
    Assert(i != nullptr && t != nullptr && s != nullptr && b != nullptr);
    (init = i)->set_parent(this);
    (step = s)->set_parent(this);
}

void ForStmt::check(Symbol_table<std::string, Node *> &sym_table) {

}


void WhileStmt::check(Symbol_table<std::string, Node *> &sym_table) {

}


IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) { 
    Assert(t != nullptr && tb != nullptr); // else can be nullptr
    elseBody = eb;
    if (elseBody) elseBody->set_parent(this);
}

void IfStmt::check(Symbol_table<std::string, Node *> &sym_table) {

}


void BreakStmt::check(Symbol_table<std::string, Node *> &sym_table) {

}


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) { 
    Assert(e != nullptr);
    (expr = e)->set_parent(this);
}

void ReturnStmt::check(Symbol_table<std::string, Node *> &sym_table) {

}


PrintStmt::PrintStmt(List<Expr*> *a) {    
    Assert(a != nullptr);
    (args = a)->set_parent_all(this);
}

void PrintStmt::check(Symbol_table<std::string, Node *> &sym_table) {

}
