/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_stmt.h"
#include "errors.h"

using namespace std;
        
         
Decl::Decl(Identifier *n) : Node(*n->get_location()), type(Type::errorType) {
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
    Sym_tbl_t::shared().enter_class_scope(id->get_name());

    // verify that superclass exists
    if (extends) {
        if (!extends->get_id()->is_defined()) {
            ReportError::identifier_not_found(extends->get_id(), Reason_e::LookingForClass);
        } else {
            auto decl = Sym_tbl_t::shared().get_declaration(extends->get_id()->get_name());
            if (decl->get_decl_type() != DeclType::Class) {
                // decl needs to be of type class, otherwise error
                ReportError::identifier_not_found(extends->get_id(), Reason_e::LookingForClass);
            } else {
                // set super class
                Sym_tbl_t::shared().set_super_class(extends->get_id()->get_name());
            }
        }
    }

    // verify interfaces exist
    for (int i = 0; i < implements->size(); ++i) {
        auto imp = implements->get(i);
        if (!imp->get_id()->is_defined()) {
            ReportError::identifier_not_found(imp->get_id(), Reason_e::LookingForInterface);
        } else {
            auto decl = Sym_tbl_t::shared().get_declaration(imp->get_id()->get_name());
            if (decl->get_decl_type() != DeclType::Interface) {
                // decl needs to be of type interface, otherwise error
                ReportError::identifier_not_found(imp->get_id(), Reason_e::LookingForInterface);
            }
        }
    }

    // insert all decls into class scope

    for (int i = 0; i < members->size(); ++i) {
        auto decl = members->get(i);
        Sym_tbl_t::shared().insert_declaration(decl->get_id()->get_name(), decl);
    }

    members->check_all();

    Sym_tbl_t::shared().leave_scope();
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
    type = new NamedType(n);
}

void InterfaceDecl::check() {
    Sym_tbl_t::shared().enter_scope(id->get_name());

    members->check_all();

    Sym_tbl_t::shared().leave_scope();
}

	
FnDecl::FnDecl(Identifier *n, Type *r, List<VarDecl*> *d) : Decl(n) {
    Assert(n != nullptr && r != nullptr && d != nullptr);
    (returnType = r)->set_parent(this);
    (formals = d)->set_parent_all(this);
    body = nullptr;
    type = returnType;
}

void FnDecl::set_function_body(Stmt *b) {
    (body = b)->set_parent(this);
}

void FnDecl::check_parameters(Identifier *fn_ident, List<Expr *> *actuals) {
    // if sizes dont match, error
    if (formals->size() != actuals->size()) {
        ReportError::num_args_mismatch(fn_ident, formals->size(), actuals->size());
        return;
    }

    // check that actuals match formals
    for (int i = 0; i < formals->size(); ++i) {
        auto formal = formals->get(i);
        auto actual = actuals->get(i);
        auto ftype = formal->type_check();
        auto atype = actual->type_check();

        if (!ftype->is_equal_to(atype)) {
            ReportError::arg_mismatch(actual, i + 1, atype, ftype);
        }
    }
}

void FnDecl::check() {
    Sym_tbl_t::shared().enter_scope(id->get_name());

    returnType->check();

    // push all formals into scope
    for (int i = 0; i < formals->size(); ++i) {
        auto formal = formals->get(i);
        Sym_tbl_t::shared().insert_declaration(formal->get_id()->get_name(), formal);
    }

    formals->check_all();

    if (body) body->check();

    Sym_tbl_t::shared().leave_scope();
}



