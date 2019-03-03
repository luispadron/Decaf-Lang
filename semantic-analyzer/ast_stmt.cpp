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
    // push scope and call children check method
    Sym_table_t::shared().push_scope("block");
    decls->check_all();
    stmts->check_all();
    Sym_table_t::shared().pop_scope();

    return true;
}


ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) { 
    Assert(t != nullptr && b != nullptr);
    (test = t)->set_parent(this);
    (body = b)->set_parent(this);
}

bool ConditionalStmt::check() {
    return test->check() && body->check();
}


bool LoopStmt::check() {
    return ConditionalStmt::check();
}


ForStmt::ForStmt(Expr *i, Expr *t, Expr *s, Stmt *b): LoopStmt(t, b) { 
    Assert(i != nullptr && t != nullptr && s != nullptr && b != nullptr);
    (init = i)->set_parent(this);
    (step = s)->set_parent(this);
}

bool ForStmt::check() {
    return init->check() && test->check() &&
           step->check() && body->check();
}


bool WhileStmt::check() {
    return LoopStmt::check();
}


IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) { 
    Assert(t != nullptr && tb != nullptr); // else can be nullptr
    elseBody = eb;
    if (elseBody) elseBody->set_parent(this);
}

bool IfStmt::check() {
    bool ret = ConditionalStmt::check();
    ret = ret && elseBody ? elseBody->check() : true;
    return ret;
}


bool BreakStmt::check() {
    // check that the break stmt is within a loop stmt
    auto loop_stmt = find_if([](Node *node) {
       return dynamic_cast<LoopStmt*>(node) != nullptr;
    });

    if (!loop_stmt) {
        ReportError::break_outside_loop(this);
        return false;
    }

    return true;
}


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) { 
    Assert(e != nullptr);
    (expr = e)->set_parent(this);
}

bool ReturnStmt::check() {
    // verify return statement is within function and expr type is equal to return type
    auto fn_decl = dynamic_cast<FnDecl*>(find_if([](Node *node) {
       return dynamic_cast<FnDecl*>(node) != nullptr;
    }));

    Assert(fn_decl);

    if (!expr->get_result_type()->is_equal_to(fn_decl->get_return_type())) {
        ReportError::return_mismatch(this, expr->get_result_type(), fn_decl->get_return_type());
        return false;
    }

    return expr->check();
}


PrintStmt::PrintStmt(List<Expr*> *a) {    
    Assert(a != nullptr);
    (args = a)->set_parent_all(this);
}

bool PrintStmt::check() {
    // check all types in the print function are printable
    for (int i = 0; i < args->size(); ++i) {
        auto arg = args->get(i);
        auto res_type = arg->get_result_type();
        Assert(res_type != nullptr);

        if (!res_type->is_printable()) {
            ReportError::print_arg_mismatch(arg, i + 1, res_type);
            return false;
        }
    }

    return true;
}
