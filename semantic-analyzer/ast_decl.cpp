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

Type* Decl::type_check() {
    return type;
}


VarDecl::VarDecl(Identifier *n, Type *t) : Decl(n) {
    Assert(n != nullptr && t != nullptr);
    (type = t)->set_parent(this);
}

void VarDecl::check() {
    // check type
    type->check();

    // push id into symbol table
    Sym_tbl_t::shared().insert_symbol(id->get_name(), type);
}


ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be NULL, impl & mem may be empty lists but cannot be NULL
    Assert(n != nullptr && imp != nullptr && m != nullptr);
    type = new NamedType(n);
    extends = ex;
    if (extends) extends->set_parent(this);
    (implements = imp)->set_parent_all(this);
    (members = m)->set_parent_all(this);
}

void ClassDecl::check() {
    // push id into symbol table
    Sym_tbl_t::shared().insert_symbol(id->get_name(), type);

    // verify that superclass exists
    if (extends && !extends->get_id()->is_defined()) {
        ReportError::identifier_not_found(extends->get_id(), Reason_e::LookingForClass);
    }

    // verify interfaces exist
    for (int i = 0; i < implements->size(); ++i) {
        auto imp = implements->get(i);
        if (!imp->get_id()->is_defined()) {
            ReportError::identifier_not_found(imp->get_id(), Reason_e::LookingForInterface);
        }
    }

    Sym_tbl_t::shared().enter_scope(id->get_name());

    members->check_all();

    Sym_tbl_t::shared().leave_scope();
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
    type = new NamedType(n);
}

void InterfaceDecl::check() {
    Sym_tbl_t::shared().insert_symbol(id->get_name(), type);
    Sym_tbl_t::shared().enter_scope(id->get_name());

    members->check_all();

    Sym_tbl_t::shared().leave_scope();
}

	
FnDecl::FnDecl(Identifier *n, Type *r, List<VarDecl*> *d) : Decl(n) {
    Assert(n != nullptr && r != nullptr && d != nullptr);
    type = returnType;
    (returnType = r)->set_parent(this);
    (formals = d)->set_parent_all(this);
    body = nullptr;
}

void FnDecl::set_function_body(Stmt *b) {
    (body = b)->set_parent(this);
}

void FnDecl::check() {
    Sym_tbl_t::shared().insert_symbol(id->get_name(), type);
    Sym_tbl_t::shared().enter_scope(id->get_name());

    returnType->check();
    formals->check_all();
    if (body) body->check();

    Sym_tbl_t::shared().leave_scope();
}



