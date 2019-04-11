//
// Created by Luis on 2019-04-11.
//

#include "ast_program.h"
#include "ast_decl.h"
#include "codegen.h"
#include "errors.h"

Program::Program(List<Decl*> *d) {
    Assert(d != NULL);
    (decls=d)->SetParentAll(this);
}

void Program::Check() {
    nodeScope = new Scope();
    decls->DeclareAll(nodeScope);
    decls->CheckAll();
}
void Program::Emit() {
    bool found = false;

    for (int i=0; i < decls->NumElements(); i++) {
        Decl *d = decls->Nth(i);
        if (!strcmp(d->GetName(), "main") && d->IsFnDecl()) {
            found = true;
            break;
        }
    }

    if (!found) {
        ReportError::NoMainFound();
        return;
    }

    auto cg = new CodeGenerator();

    decls->EmitAll(cg);

    if (ReportError::NumErrors() == 0) {
        cg->DoFinalCodeGen();
    }
}