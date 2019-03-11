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

void StmtBlock::check() {
    Sym_tbl_t::shared().enter_scope("block");

    decls->check_all();

    // add declarations to scope
    for (int i = 0; i < decls->size(); ++i) {
        auto decl = decls->get(i);
        try {
            Sym_tbl_t::shared().insert_declaration(decl->get_id()->get_name(), decl);
        } catch (Duplicate_symbol_exception &de) {
            ReportError::decl_conflict(decl, de.get_decl());
        }
    }

    stmts->check_all();

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

void ForStmt::check() {
    init->check();

    test->check();
    if (!test->type_check()->is_equal_to(Type::boolType)) {
        ReportError::test_not_boolean(test);
    }

    step->check();
    body->check();
}


void WhileStmt::check() {
    test->check();
    if (!test->type_check()->is_equal_to(Type::boolType)) {
        ReportError::test_not_boolean(test);
    }

    body->check();
}


IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) { 
    Assert(t != nullptr && tb != nullptr); // else can be nullptr
    elseBody = eb;
    if (elseBody) elseBody->set_parent(this);
}

void IfStmt::check() {
    test->check();
    if (!test->type_check()->is_equal_to(Type::boolType)) {
        ReportError::test_not_boolean(test);
    }

    body->check();

    if (elseBody) {
        elseBody->check();
    }
}


void BreakStmt::check() {
    // check that we're in a loop stmt, which means to traverse up the AST
    // until we find a node that's a loop statement
    bool is_in_loop = false;
    for (auto p = parent; p; p = p->get_parent()) {
        if (dynamic_cast<LoopStmt*>(p)) {
            is_in_loop = true;
            break; // lol
        }
    }

    if (!is_in_loop) {
        ReportError::break_outside_loop(this);
    }
}


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) { 
    Assert(e != nullptr);
    (expr = e)->set_parent(this);
}

void ReturnStmt::check() {
    expr->check();

    // find function decl
    FnDecl *fn = nullptr;
    for (auto p = parent; p; p = p->get_parent()) {
        fn = dynamic_cast<FnDecl*>(p);
        if (fn) { break; }
    }

    // return always need to be in a function or else stuff went wrong?
    Assert(fn);

    // check return types match
    if (!fn->type_check()->is_equal_to(expr->type_check())) {
        ReportError::return_mismatch(this, expr->type_check(), fn->type_check());
    }
}


PrintStmt::PrintStmt(List<Expr*> *a) {    
    Assert(a != nullptr);
    (args = a)->set_parent_all(this);
}

void PrintStmt::check() {
    // check all args are printable
    for (int i = 0; i < args->size(); ++i) {
        auto arg = args->get(i);
        arg->check();
        if (!arg->type_check()->is_printable()) {
            ReportError::print_arg_mismatch(arg, i + 1, arg->type_check());
        }
    }
}
