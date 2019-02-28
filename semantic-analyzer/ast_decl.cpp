/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_type.h"
#include "ast_stmt.h"

#include <iostream>

using namespace std;
        
         
Decl::Decl(Identifier *n) : Node(*n->GetLocation()) {
    Assert(n != nullptr);
    (id=n)->SetParent(this); 
}


VarDecl::VarDecl(Identifier *n, Type *t) : Decl(n) {
    Assert(n != nullptr && t != nullptr);
    ident = n;
    (type=t)->SetParent(this);
}

void VarDecl::Check(Symbol_table<std::string, Node *> &sym_table) {
    sym_table.insert_symbol(ident->GetName(), this);
}
  

ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be NULL, impl & mem may be empty lists but cannot be NULL
    Assert(n != nullptr && imp != nullptr && m != nullptr);
    name = n;
    extends = ex;
    if (extends) extends->SetParent(this);
    (implements=imp)->SetParentAll(this);
    (members=m)->SetParentAll(this);
}

void ClassDecl::Check(Symbol_table<std::string, Node *> &sym_table) {
    sym_table.insert_symbol(name->GetName(), this);
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members=m)->SetParentAll(this);
}

void InterfaceDecl::Check(Symbol_table<std::string, Node *> &sym_table) {

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

void FnDecl::Check(Symbol_table<std::string, Node *> &sym_table) {
    // push scope and call Check for children
    sym_table.push_scope();
    formals->CheckAll(sym_table);
    body->Check(sym_table);
}



