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

bool VarDecl::check() {
    if (!type->check()) {
        auto named_type = dynamic_cast<NamedType*>(type);
        if (!named_type) { return false; }

        ReportError::identifier_not_found(named_type->get_id(), Reason_e::LookingForType);
        return false;
    }

    return true;
}
  

ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be NULL, impl & mem may be empty lists but cannot be NULL
    Assert(n != nullptr && imp != nullptr && m != nullptr);
    extends = ex;
    if (extends) extends->set_parent(this);
    (implements = imp)->set_parent_all(this);
    (members = m)->set_parent_all(this);
}

bool ClassDecl::check() {
    // push class scope and call check on children
    // TODO: add handling for inheritance
    Sym_table_t::shared().push_class_scope(id->get_str(), id->get_str());

    // insert all function members into class scope
    for (int i = 0; i < members->size(); ++i) {
        auto decl = members->get(i);
        Sym_table_t::shared().insert_symbol(decl->get_id()->get_str(), decl);
    }

    // check all members
    members->check_all();

    Sym_table_t::shared().pop_scope();
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
    (returnType = r)->set_parent(this);
    (formals = d)->set_parent_all(this);
    body = nullptr;
}

void FnDecl::set_function_body(Stmt *b) {
    (body = b)->set_parent(this);
}

bool FnDecl::check_params_match(Identifier *call_id, List<Expr *> *params) const {
    if (formals->size() != params->size()) {
        ReportError::num_args_mismatch(call_id, formals->size(), params->size());
        return false;
    }

    for (int i = 0; i < formals->size(); ++i) {
        auto ftype = formals->get(i)->get_type();
        auto ptype = params->get(i)->get_result_type();

        if (!ftype->is_equal_to(ptype)) {
            ReportError::arg_mismatch(params->get(i), i + 1, ptype, ftype);
            return false;
        }
    }

    return true;
}

bool FnDecl::check() {
    // push scope and call check for children
    Sym_table_t::shared().push_scope(id->get_str());
    formals->check_all();
    body->check();
    Sym_table_t::shared().pop_scope();
    return true;
}



