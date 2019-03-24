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
    Sym_tbl_t::shared().enter_scope(get_mangled_name());

    // collect bytes from children
    int bytes = 0;

    for (int i = 0; i < decls->size(); ++i) {
        bytes += decls->get(i)->get_bytes();
    }

    for (int i = 0; i < stmts->size(); ++i) {
        bytes += stmts->get(i)->get_bytes();
    }

    Sym_tbl_t::shared().leave_scope();
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

Location * StmtBlock::emit() {
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

int ForStmt::get_bytes() const {
    return init->get_bytes() + test->get_bytes() + step->get_bytes() + body->get_bytes();
}

Location* ForStmt::emit() {
    init->emit();

    auto start_lbl = Cgen_t::shared().new_label();
    done_label = Cgen_t::shared().new_label();

    // start of the for loop, anything under here will be executed during every iteration
    Cgen_t::shared().gen_label(start_lbl);
    auto test_tmp = test->emit();
    Cgen_t::shared().gen_ifz(test_tmp, done_label); // does the for loop check, if it fails goto's the end of the loop
    body->emit(); // perform body operation
    step->emit(); // perform step if it has it
    Cgen_t::shared().gen_go_to(start_lbl); // go back to start of loop

    Cgen_t::shared().gen_label(done_label); // the end of the loop, jumps here if ifz fails above

    return nullptr;
}


int WhileStmt::get_bytes() const {
    return test->get_bytes() + body->get_bytes();
}

Location* WhileStmt::emit() {
    auto start_lbl = Cgen_t::shared().new_label();
    done_label = Cgen_t::shared().new_label();

    // start of for loop
    Cgen_t::shared().gen_label(start_lbl);
    auto test_tmp = test->emit();
    Cgen_t::shared().gen_ifz(test_tmp, done_label);
    body->emit();
    Cgen_t::shared().gen_go_to(start_lbl); // go back to start

    // end of loop
    Cgen_t::shared().gen_label(done_label);

    return nullptr;
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
    return test->get_bytes() + body->get_bytes() + (elseBody ? elseBody->get_bytes() : 0);
}

Location* IfStmt::emit() {
    if (elseBody) {
        auto else_lbl = Cgen_t::shared().new_label();
        auto end_lbl = Cgen_t::shared().new_label();
        auto test_loc = test->emit();

        Cgen_t::shared().gen_ifz(test_loc, else_lbl);

        // anything under here will be executed if the if statement passes
        body->emit();

        Cgen_t::shared().gen_go_to(end_lbl); // skip over else body
        Cgen_t::shared().gen_label(else_lbl);
        elseBody->emit();

        // end of if statement
        Cgen_t::shared().gen_label(end_lbl);
    } else {
        auto end_lbl = Cgen_t::shared().new_label();
        auto test_loc = test->emit();

        Cgen_t::shared().gen_ifz(test_loc, end_lbl);

        // anything under here will be executed if the if statement passes
        body->emit();

        // end of if statement
        Cgen_t::shared().gen_label(end_lbl);
    }

    return nullptr;
}


Location * BreakStmt::emit() {
    // find the parent loop stmt, get the done label and generate goto
    LoopStmt *loop = nullptr;
    for (auto p = parent; p; p = p->get_parent()) {
        loop = dynamic_cast<LoopStmt*>(p);
        if (loop) break;
    }

    Assert(loop);

    Cgen_t::shared().gen_go_to(loop->get_done_label());

    return nullptr;
}


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) {
    Assert(e != nullptr);
    (expr = e)->set_parent(this);
}

int ReturnStmt::get_bytes() const {
    return expr->get_bytes();
}

Location* ReturnStmt::emit() {
    auto ret_val = expr->emit();
    Cgen_t::shared().gen_return(ret_val);
    return nullptr;
}


PrintStmt::PrintStmt(List<Expr*> *a) {
    Assert(a != nullptr);
    (args = a)->set_parent_all(this);
}

int PrintStmt::get_bytes() const {
    int bytes = 0;
    for (int i = 0; i < args->size(); ++i) {
        bytes += args->get(i)->get_bytes();
    }
    return bytes;
}

Location* PrintStmt::emit() {
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