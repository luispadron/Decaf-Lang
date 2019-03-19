/* File: ast_stmt.cc
 * -----------------
 * Implementation of statement node classes.
 */
#include "ast_stmt.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "ast_expr.h"

#include <cstring>

using namespace std;


Program::Program(List<Decl*> *d) {
    Assert(d != nullptr);
    (decls=d)->SetParentAll(this);
}

void Program::Check() {
    /* You can use your pp3 semantic analysis or leave it out if
     * you want to avoid the clutter.  We won't test pp4 against 
     * semantically-invalid programs.
     */
}
void Program::Emit() {
    // enter global scope
    auto g_scope = SymTbl::shared().enter_scope("global", ScopeType::Global);

    // push all global declarations to global scope
    for (int i = 0; i < decls->Size(); ++i) {
        g_scope->insert_decl(decls->Get(i)->get_id()->get_name(), decls->Get(i));
    }

    // set location for global variables
    int global_offset = SetLocations(decls, Segment::gpRelative, CodeGenerator::OffsetToFirstGlobal);

    // first find the main function, and verify it exists
    bool found_main = false;
    for (int i = 0; i < decls->Size(); ++i) {
        auto decl = decls->Get(i);
        if (decl->get_decl_type() == DeclType::Function &&
            strcmp(decl->get_id()->get_name(), "main") == 0) {
            found_main = true;
        }
    }

    if (!found_main) {
        ReportError::NoMainFound();
        return;
    }

    decls->EmitAll();

    SymTbl::shared().debug_print();

    SymTbl::shared().leave_scope();

    g_codeGen->DoFinalCodeGen();
}

StmtBlock::StmtBlock(List<VarDecl*> *d, List<Stmt*> *s) {
    Assert(d != nullptr && s != nullptr);
    (decls=d)->SetParentAll(this);
    (stmts=s)->SetParentAll(this);
}

void StmtBlock::Emit() {
    auto scope = SymTbl::shared().enter_scope("block", ScopeType::Block);
    for (int i = 0; i < decls->Size(); ++i) {
        scope->insert_decl(decls->Get(i)->get_id()->get_name(), decls->Get(i));
    }

    decls->EmitAll();
    stmts->EmitAll();

    SymTbl::shared().leave_scope();
}

int StmtBlock::set_locations(Segment segment, int startOffset) {
    // TODO: probably add nested block handling here?
    return SetLocations(decls, segment, startOffset);
}


ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) { 
    Assert(t != nullptr && b != nullptr);
    (test=t)->SetParent(this); 
    (body=b)->SetParent(this);
}

ForStmt::ForStmt(Expr *i, Expr *t, Expr *s, Stmt *b): LoopStmt(t, b) { 
    Assert(i != nullptr && t != nullptr && s != nullptr && b != nullptr);
    (init=i)->SetParent(this);
    (step=s)->SetParent(this);
}

IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) { 
    Assert(t != nullptr && tb != nullptr); // else can be nullptr
    elseBody = eb;
    if (elseBody) elseBody->SetParent(this);
}


ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) { 
    Assert(e != nullptr);
    (expr=e)->SetParent(this);
}
  
PrintStmt::PrintStmt(List<Expr*> *a) {    
    Assert(a != nullptr);
    (args=a)->SetParentAll(this);
}


