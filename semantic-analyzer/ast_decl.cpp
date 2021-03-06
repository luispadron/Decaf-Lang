/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_stmt.h"
#include "errors.h"

#include <algorithm>
#include <vector>

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

void FnDecl::check_parameters(Identifier *fn_ident, List<Expr *> *actuals) const {
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

bool FnDecl::has_equal_signature(FnDecl *other) const {
    // check param sizes
    if (formals->size() != other->formals->size()) { return false; }

    // check return types
    if (!returnType->is_equal_to(other->returnType)) { return false; }

    // check parameters have same type
    for (int i = 0; i < formals->size(); ++i) {
        auto f1 = formals->get(i)->type_check();
        auto f2 = other->formals->get(i)->type_check();
        if (!f1->is_equal_to(f2)) { return false; }
    }

    return true;
}

void FnDecl::check() {
    Sym_tbl_t::shared().enter_scope(id->get_name());

    returnType->check();

    // push all formals into scope
    for (int i = 0; i < formals->size(); ++i) {
        auto formal = formals->get(i);
        try {
            Sym_tbl_t::shared().insert_declaration(formal->get_id()->get_name(), formal);
        } catch (Duplicate_symbol_exception &de) {
            ReportError::decl_conflict(formal, de.get_decl());
        }
    }

    formals->check_all();

    if (body) body->check();

    Sym_tbl_t::shared().leave_scope();
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
    type = new NamedType(n);
}

vector<FnDecl*> InterfaceDecl::get_fn_decls() {
    vector<FnDecl*> functions;
    for (int i = 0; i < members->size(); ++i) {
        auto fn = dynamic_cast<FnDecl*>(members->get(i));
        Assert(fn);
        functions.push_back(fn);
    }

    return functions;
}

void InterfaceDecl::check() {
    Sym_tbl_t::shared().enter_interface_scope(id->get_name());

    // insert all decls into interface scope

    for (int i = 0; i < members->size(); ++i) {
        auto decl = members->get(i);
        try {
            Sym_tbl_t::shared().insert_declaration(decl->get_id()->get_name(), decl);
        } catch (Duplicate_symbol_exception &de) {
            ReportError::decl_conflict(decl, de.get_decl());
        }
    }

    members->check_all();

    Sym_tbl_t::shared().leave_scope();
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

std::vector<FnDecl*> ClassDecl::get_fn_decls() const {
    // find functions in class
    vector<FnDecl*> functions;
    for (int i = 0; i < members->size(); ++i) {
        auto fn = dynamic_cast<FnDecl*>(members->get(i));
        if (fn) functions.push_back(fn);
    }
    return functions;
}

bool ClassDecl::verify_interface_conformance(InterfaceDecl *interface, NamedType *intf_type) {
    Assert(interface);

    bool is_valid = true;

    auto functions = get_fn_decls();

    // get functions in interface
    auto interface_functions = interface->get_fn_decls();

    int implemented_fns = 0;
    for (auto infn : interface_functions) {
        // if we find a function with same name as interface function, check its signature
        auto fn = find_if(functions.begin(), functions.end(), [infn](FnDecl *fn) {
           return infn->get_id()->is_equal_to(fn->get_id());
        });

        if (fn != functions.end()) {
            if (!(*fn)->has_equal_signature(infn)) {
                ReportError::override_mismatch(*fn);
                is_valid = false;
            } else {
                ++implemented_fns;
            }
        }
    }

    // if the class didn't implement all the interface functions we have an error
    if (implemented_fns != interface_functions.size()) {
        ReportError::interface_not_implemented(this, intf_type);
        is_valid = false;
    }

    return is_valid;
}

bool ClassDecl::verify_class_overrides(ClassDecl *base) {
    Assert(base);

    bool is_valid = true;

    // find functions in class
    auto functions = get_fn_decls();

    // find functions in base
    auto base_functions = base->get_fn_decls();

    for (auto base_fn : base_functions) {
        // find function in this class that shares name with a function in base class
        auto overriden = find_if(functions.begin(), functions.end(), [base_fn](FnDecl *fn) {
           return base_fn->get_id()->is_equal_to(fn->get_id());
        });

        if (overriden != functions.end()) {
            if (!(*overriden)->has_equal_signature(base_fn)) {
                ReportError::override_mismatch(*overriden);
                is_valid = false;
            }
        }
    }

    return is_valid;
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
                // verify overrides are correct
                if (verify_class_overrides(dynamic_cast<ClassDecl*>(decl))) {

                }
                // set super class
                Sym_tbl_t::shared().set_super_class(extends->get_id()->get_name());
            }
        }
    }

    // do checking for interfaces
    for (int i = 0; i < implements->size(); ++i) {
        auto imp = implements->get(i);
        if (!imp->get_id()->is_defined()) {
            ReportError::identifier_not_found(imp->get_id(), Reason_e::LookingForInterface);
        } else {
            auto decl = Sym_tbl_t::shared().get_declaration(imp->get_id()->get_name());
            if (decl->get_decl_type() != DeclType::Interface) {
                // decl needs to be of type interface, otherwise error
                ReportError::identifier_not_found(imp->get_id(), Reason_e::LookingForInterface);
            } else {
                if (verify_interface_conformance(dynamic_cast<InterfaceDecl*>(decl), imp)) {
                    Sym_tbl_t::shared().set_interface(imp->get_id()->get_name());
                }
            }
        }
    }

    // insert all decls into class scope

    for (int i = 0; i < members->size(); ++i) {
        auto decl = members->get(i);
        try {
            Sym_tbl_t::shared().insert_declaration(decl->get_id()->get_name(), decl);
        } catch (Duplicate_symbol_exception &de) {
            ReportError::decl_conflict(decl, de.get_decl());
        }
    }

    members->check_all();

    Sym_tbl_t::shared().leave_scope();
}
