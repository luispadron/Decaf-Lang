/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
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
    ident = n;
    (type = t)->set_parent(this);
}

bool VarDecl::check() {
    if (!type->check()) {
        auto named_type = dynamic_cast<NamedType*>(type);
        if (!named_type) { return false; }

        ReportError::identifier_not_found(named_type->get_id(), Reason_e::LookingForType);
        return false;
    }

    Sym_table_t::shared().insert_symbol(ident->get_name(), this);
    return true;
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

bool ClassDecl::check() {
    Sym_table_t::shared().insert_symbol(name->get_name(), this);
    return true;
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
}

bool InterfaceDecl::check() {
    return true;
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

bool FnDecl::check() {
    // push scope and call check for children
    Sym_table_t::shared().push_scope(ident->get_name());
    formals->check_all();
    body->check();
    Sym_table_t::shared().pop_scope();
    return true;
}



