/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_type.h"
#include "ast_stmt.h"

#include <iostream>

using namespace std;
        
         
Decl::Decl(Identifier *n) : Node(*n->get_location()) {
    Assert(n != nullptr);
    (id = n)->set_parent(this);
}


VarDecl::VarDecl(Identifier *n, Type *t) : Decl(n) {
    Assert(n != nullptr && t != nullptr);
    ident = n;
    (type = t)->set_parent(this);
}

void VarDecl::check(Symbol_table<std::string, Node *> &sym_table) {
    sym_table.insert_symbol(ident->get_name(), this);
}
  

ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be NULL, impl & mem may be empty lists but cannot be NULL
    Assert(n != nullptr && imp != nullptr && m != nullptr);
    name = n;
    extends = ex;
    if (extends) extends->set_parent(this);
    (implements = imp)->set_parent_all(this);
    (members = m)->set_parent_all(this);
}

void ClassDecl::check(Symbol_table<std::string, Node *> &sym_table) {
    sym_table.insert_symbol(name->get_name(), this);
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
}

void InterfaceDecl::check(Symbol_table<std::string, Node *> &sym_table) {

}

	
FnDecl::FnDecl(Identifier *n, Type *r, List<VarDecl*> *d) : Decl(n) {
    Assert(n != nullptr && r!= nullptr && d != nullptr);
    ident = n;
    (returnType = r)->set_parent(this);
    (formals = d)->set_parent_all(this);
    body = nullptr;
}

void FnDecl::set_function_body(Stmt *b) {
    (body = b)->set_parent(this);
}

void FnDecl::check(Symbol_table<std::string, Node *> &sym_table) {
    // push scope and call check for children
    sym_table.push_scope(ident->get_name());
    formals->check_all(sym_table);
    body->check(sym_table);
    sym_table.pop_scope();
}



