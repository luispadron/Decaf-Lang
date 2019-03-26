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
            .create_scope(
                    get_mangled_name(class_or_interface_scope ? class_or_interface_scope->name() : ""),
                    ScopeType::Function
            );

    // push all formals into scope
    for (int i = 0; i < formals->size(); ++i) {
        auto formal = formals->get(i);
        scope->insert_decl(formal->get_id()->get_name(), formal);
    }

    auto block = dynamic_cast<StmtBlock*>(body);
    if (block) { block->check(); }

    Sym_tbl_t::shared().leave_scope();
}

void FnDecl::emit(Scope *class_or_interface_scope, FnDecl *curr_func) {
    // enter scope
    auto scope = Sym_tbl_t::shared()
            .enter_scope(get_mangled_name(class_or_interface_scope ? class_or_interface_scope->name() : ""));

    // prepare generator
    Cgen_t::shared().reset_offsets();

    // generate function label and begin function code
    const auto &label = get_mangled_name(class_or_interface_scope ? class_or_interface_scope->name() : "");
    Cgen_t::shared().gen_label(label.c_str());
    auto func_code = Cgen_t::shared().gen_begin_func();

    // generate locations for parameters
    int param_offset = Cgen_t::offset_first_param;
    for (int i = 0; i < formals->size(); ++i) {
        auto var = formals->get(i);
        auto loc = new Location(Segment::fp_relative, param_offset, var->get_id()->get_name().c_str());
        var->set_location(loc);
        param_offset += var->get_bytes();
    }

    auto block = dynamic_cast<StmtBlock*>(body);
    if (block) {
        block->emit();
        func_code->SetFrameSize(block->get_bytes());
    }

    // end function code and pop scope
    Sym_tbl_t::shared().leave_scope();
    Cgen_t::shared().gen_end_func();
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != nullptr && m != nullptr);
    (members = m)->set_parent_all(this);
    type = new NamedType(n);
}

void InterfaceDecl::check(Scope *class_or_interface_scope) {
    auto scope = Sym_tbl_t::shared().create_scope(id->get_name(), ScopeType::Interface);

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

int ClassDecl::get_method_offset(const std::string &name) const {
    int offset = 0;
    for (int i = 0; i < members->size(); ++i) {
        auto member = members->get(i);
        if (member->get_decl_type() == DeclType::Function) {
            if (member->get_id()->get_name() == name) { return offset; }
            offset += 4;
        }
    }

    Assert(false);
    return -1;
}

int ClassDecl::get_member_offset(const string &name) const {
    int offset = 4;
    for (int i = 0; i < members->size(); ++i) {
        auto member = members->get(i);
        if (member->get_decl_type() == DeclType::Variable) {
            if (member->get_id()->get_name() == name) { return offset; }
            offset += 4;
        }
    }

    Assert(false);
    return -1;
}

void ClassDecl::check(Scope *class_or_interface_scope) {
    auto scope = Sym_tbl_t::shared().create_scope(id->get_name(), ScopeType::Class);

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

void ClassDecl::emit(Scope *class_or_interface_scope, FnDecl *curr_func) {
    auto scope = Sym_tbl_t::shared().enter_scope(id->get_name());

    // generate variable locations
    int offset = 4;
    for (int i = 0; i < members->size(); ++i) {
        auto var = dynamic_cast<VarDecl*>(members->get(i));
        if (var) {
            var->set_location(new Location(Segment::fp_relative, offset, "this"));
            offset += var->get_bytes();
        }
    }

    // call emit on members
    for (int i = 0; i < members->size(); ++i) {
        auto member = members->get(i);
        member->emit(scope, nullptr);

        if (member->get_decl_type() == DeclType::Function) {
            auto method = dynamic_cast<FnDecl*>(member);
            Assert(method);

            mangled_method_names.push_back(method->get_mangled_name(scope->name()));
        } else if (member->get_decl_type() == DeclType::Variable) {
            bytes += Cgen_t::word_size; // increase size of class
        }
    }

    // generate v table
    List<const char*> methods;
    for (const auto &m : mangled_method_names) {
        methods.append(m.c_str());
    }
    Cgen_t::shared().gen_vtable(id->get_name().c_str(), methods);

    Sym_tbl_t::shared().leave_scope();
}
