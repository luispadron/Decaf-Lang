/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_stmt.h"
#include "errors.h"

#include <iostream>

using namespace std;
        
         
Decl::Decl(Identifier *n) : Node(*n->get_location()) {
    Assert(n != nullptr);
    (id = n)->set_parent(this);
}


VarDecl::VarDecl(Identifier *n, Type *t) : Decl(n) {
    Assert(n != nullptr && t != nullptr);
    (type = t)->set_parent(this);
}

void VarDecl::check() {

}
  

ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be NULL, impl & mem may be empty lists but cannot be NULL
    Assert(n != nullptr && imp != nullptr && m != nullptr);
    extends = ex;
    if (extends) extends->set_parent(this);
    (implements = imp)->set_parent_all(this);
    (members = m)->set_parent_all(this);
}

void ClassDecl::check() {

}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
}

void InterfaceDecl::check() {

}

	
FnDecl::FnDecl(Identifier *n, Type *r, List<VarDecl*> *d) : Decl(n) {
    Assert(n != nullptr && r!= nullptr && d != nullptr);
    (returnType = r)->set_parent(this);
    (formals = d)->set_parent_all(this);
    body = nullptr;
}

void FnDecl::set_function_body(Stmt *b) {
    (body = b)->set_parent(this);
}

void FnDecl::check() {

}



