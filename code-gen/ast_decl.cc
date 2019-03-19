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
    location = new Location(segment, offset, id->get_name().c_str());
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
    auto scope = SymTbl::shared().enter_scope(get_mips_label(), ScopeType::Class);
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
    auto scope = SymTbl::shared().enter_scope(get_mips_label(), ScopeType::Interface);
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

string FnDecl::get_mips_label() const {
    string label;
    // traverse up the AST getting the correct label
    for (auto p = parent; p; p = p->GetParent()) {
        auto decl = dynamic_cast<Decl*>(p);
        if (decl) {
            label = decl->get_label_prefix() + label;
        }
    }

    label.append(id->get_name());

    return label;
}

void FnDecl::Emit() {
    // add new scope, push all parameters declarations into scope
    auto scope = SymTbl::shared().enter_scope(get_mips_label(), ScopeType::Function);
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
    g_codeGen->GenLabel(get_mips_label().c_str());
    auto fnCode = g_codeGen->GenBeginFunc();
    fnCode->SetFrameSize(abs(bodyOffset) - 8);

    // call child emit functions
    returnType->Emit();
    formals->EmitAll();
    body->Emit();

    SymTbl::shared().leave_scope();
    g_codeGen->GenEndFunc();
}