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

void VarDecl::check(Scope *class_or_interface_scope) { }


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

string FnDecl::get_mangled_name(const std::string &class_or_interface_name) const {
    if (id->get_name() == "main") { return "main"; }
    if (class_or_interface_name.empty()) {
        return "_" + id->get_name();
    } else {
        return "_" + class_or_interface_name + "." + id->get_name();
    }
}

void FnDecl::check(Scope *class_or_interface_scope) {
    Scope *scope = Sym_tbl_t::shared()
            .enter_scope(
                    get_mangled_name(class_or_interface_scope ? class_or_interface_scope->name() : ""),
                    ScopeType::Function
                    );

    // push all formals into scope
    for (int i = 0; i < formals->size(); ++i) {
        auto formal = formals->get(i);
        scope->insert_decl(formal->get_id()->get_name(), formal);
    }

    auto block = dynamic_cast<StmtBlock*>(body);
    if (block) { block->check(scope); }

    Sym_tbl_t::shared().leave_scope();
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
    type = new NamedType(n);
}

void InterfaceDecl::check(Scope *class_or_interface_scope) {
    auto scope = Sym_tbl_t::shared().enter_scope(id->get_name(), ScopeType::Interface);

    // insert all decls into class scope
    for (int i = 0; i < members->size(); ++i) {
        auto decl = members->get(i);
        scope->insert_decl(decl->get_id()->get_name(), decl);
    }

    for (int i = 0; i < members->size(); ++i) {
        members->get(i)->check(scope);
    }

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

void ClassDecl::check(Scope *class_or_interface_scope) {
    auto scope = Sym_tbl_t::shared().enter_scope(id->get_name(), ScopeType::Class);

    // insert all decls into class scope
    for (int i = 0; i < members->size(); ++i) {
        auto decl = members->get(i);
        scope->insert_decl(decl->get_id()->get_name(), decl);
    }

    for (int i = 0; i < members->size(); ++i) {
        members->get(i)->check(scope);
    }

    Sym_tbl_t::shared().leave_scope();
}
