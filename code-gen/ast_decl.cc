/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_type.h"
#include "ast_stmt.h"

#include <iostream>
#include <cmath>

using namespace std;

         
Decl::Decl(Identifier *n) : Node(*n->GetLocation()) {
    Assert(n != nullptr);
    (id=n)->SetParent(this); 
}


VarDecl::VarDecl(Identifier *n, Type *t) : Decl(n) {
    Assert(n != nullptr && t != nullptr);
    (type=t)->SetParent(this);
}

void VarDecl::set_location(Segment segment, int offset) {
    delete location;
    location = new Location(segment, offset, id->get_name());
}

void VarDecl::Emit() {
    // some debug printing
#if DEBUG==1
    const char *seg = location->GetSegment() == Segment::gpRelative ? "gp" : "fp";
    cout << location->GetName() << ": (" << location->GetOffset() << ", " <<  seg << ")" << endl;
#endif


}
  

ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be nullptr, impl & mem may be empty lists but cannot be nullptr
    Assert(n != nullptr && imp != nullptr && m != nullptr);     
    extends = ex;
    if (extends) extends->SetParent(this);
    (implements=imp)->SetParentAll(this);
    (members=m)->SetParentAll(this);
}

void ClassDecl::Emit() {
    // add new scope, push all declarations into scope
    auto scope = SymTbl::shared().enter_scope(id->get_name(), ScopeType::Class);
    for (int i = 0; i < members->Size(); ++i) {
        scope->insert_decl(members->Get(i)->get_id()->get_name(), members->Get(i));
    }

    members->EmitAll();

    // do more stuff

    SymTbl::shared().leave_scope();
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members=m)->SetParentAll(this);
}

void InterfaceDecl::Emit() {
    // add new scope, push all declarations into scope
    auto scope = SymTbl::shared().enter_scope(id->get_name(), ScopeType::Interface);
    for (int i = 0; i < members->Size(); ++i) {
        scope->insert_decl(members->Get(i)->get_id()->get_name(), members->Get(i));
    }

    SymTbl::shared().leave_scope();
}

	
FnDecl::FnDecl(Identifier *n, Type *r, List<VarDecl*> *d) : Decl(n) {
    Assert(n != nullptr && r!= nullptr && d != nullptr);
    (returnType=r)->SetParent(this);
    (formals=d)->SetParentAll(this);
    body = nullptr;
}

void FnDecl::SetFunctionBody(Stmt *b) { 
    (body=b)->SetParent(this);
}

void FnDecl::Emit() {
    // add new scope, push all parameters declarations into scope
    auto scope = SymTbl::shared().enter_scope(id->get_name(), ScopeType::Function);
    for (int i = 0; i < formals->Size(); ++i) {
        scope->insert_decl(formals->Get(i)->get_id()->get_name(), formals->Get(i));
    }

    // set locations for parameters
    int paramOffset = SetLocations(
            formals,
            Segment::fpRelative,
            CodeGenerator::OffsetToFirstParam + (scope->is_class_scope() ? 4 : 0) // needed if function is a method
            );

    // set locations for body variables
    int bodyOffset = body->set_locations(
            Segment::fpRelative,
            CodeGenerator::OffsetToFirstLocal
            );

    // generate function code
    auto fnCode = g_codeGen->GenBeginFunc();
    fnCode->SetFrameSize(abs(bodyOffset) == 0 ? 0 : abs(bodyOffset) - 4);

    // call child emit functions
    returnType->Emit();
    formals->EmitAll();
    body->Emit();

    SymTbl::shared().leave_scope();
    g_codeGen->GenEndFunc();
}