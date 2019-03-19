/* File: ast_expr.cc
 * -----------------
 * Implementation of expression node classes.
 */
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "errors.h"

#include <cstring>

using namespace std;


IntConstant::IntConstant(yyltype loc, int val) : Expr(loc) {
    value = val;
}

Type* IntConstant::type_check() {
    return Type::intType;
}


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

Type* DoubleConstant::type_check() {
    return Type::doubleType;
}


BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
}

Type* BoolConstant::type_check() {
    return Type::boolType;
}


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != nullptr);
    value = strdup(val);
}

Type* StringConstant::type_check() {
    return Type::stringType;
}


Type* NullConstant::type_check() {
    return Type::nullType;
}


Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok != nullptr);
    strncpy(tokenString, tok, sizeof(tokenString));
}


CompoundExpr::CompoundExpr(Expr *l, Operator *o, Expr *r) 
  : Expr(Join(l->get_location(), r->get_location())) {
    Assert(l != nullptr && o != nullptr && r != nullptr);
    (op = o)->set_parent(this);
    (left = l)->set_parent(this);
    (right = r)->set_parent(this);
}

CompoundExpr::CompoundExpr(Operator *o, Expr *r) 
  : Expr(Join(o->get_location(), r->get_location())) {
    Assert(o != nullptr && r != nullptr);
    left = nullptr;
    (op = o)->set_parent(this);
    (right = r)->set_parent(this);
}


bool ArithmeticExpr::validate() {
    if (left) return left->type_check()->can_perform_arithmetic_with(right->type_check());
    return right->type_check()->can_perform_arithmetic();
}

Type* ArithmeticExpr::type_check() {
    if (!validate()) {
        return Type::errorType;
    } else {
        return right->type_check();
    }
}


bool RelationalExpr::validate() {
    return left->type_check()->can_perform_relational_with(right->type_check());
}


Type* RelationalExpr::type_check() {
    if (!validate()) {
        return Type::errorType;
    } else {
        return Type::boolType;
    }
}


bool EqualityExpr::validate() {
    return left->type_check()->can_perform_equality_with(right->type_check());
}

Type* EqualityExpr::type_check() {
    if (!validate()) {
        return Type::errorType;
    } else {
        return Type::boolType;
    }
}


bool LogicalExpr::validate() {
    if (left) return left->type_check()->can_perform_logical_with(right->type_check());
    return right->type_check()->can_perform_logical();
}

Type* LogicalExpr::type_check() {
    if (!validate()) {
        return Type::errorType;
    } else {
        return Type::boolType;
    }
}


bool AssignExpr::validate() {
    return left->type_check()->can_perform_assignment_with(right->type_check());
}

Type * AssignExpr::type_check() {
    if (!validate()) {
        return Type::errorType;
    } else {
        return right->type_check();
    }
}


Type* This::type_check() {
    auto scope = Sym_tbl_t::shared().get_scope();
    // if not in class scope, error
    if (!scope->is_class_scope()) {
        return Type::errorType;
    }

    // find name of class, then look up the symbol and return its type
    const auto &class_name = scope->name();

    if (!scope->get_decl(class_name).second) {
        return Type::errorType;
    }

    auto decl = scope->get_decl(class_name).first;
    // if the decl isn't a class this is invalid
    if (decl->get_decl_type() != DeclType::Class) {
        return Type::errorType;
    } else {
        return decl->type_check();
    }
}

  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base = b)->set_parent(this);
    (subscript = s)->set_parent(this);
}

Type * ArrayAccess::type_check() {
    if (!base->type_check()->is_array_type() || !subscript->type_check()->can_perform_array_access()) {
        return Type::errorType;
    } else {
        auto type = base->type_check();
        if (type->is_array_type()) {
            return type->type_check();
        } else {
            return type;
        }
    }
}


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->get_location(), f->get_location()) : *f->get_location()) {
    Assert(f != nullptr); // b can be be nullptr (just means no explicit base)
    base = b; 
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
}


Type* FieldAccess::type_check() {
//    if (base) {
//        auto btype = base->type_check();
//        // only named types can use . syntax
//        if (!btype->is_named_type()) { return Type::errorType; }
//        // perform another type check on the named type, since we need to make sure name is defined
//        if (btype->type_check() == Type::errorType) { return Type::errorType; }
//
//        // not found, thus this field doesnt exist in class
//        if (!Sym_tbl_t::shared().is_declared_in_scope(btype->get_type_name(), field->get_name())) { return Type::errorType; }
//        // found in sym table, simply return the type of the decl, if its a var decl
//        auto decl = Sym_tbl_t::shared().get_declaration_in_scope(btype->get_type_name(), field->get_name());
//        // if not a var decl, this is an error
//        if (decl->get_decl_type() != DeclType::Variable) { return Type::errorType; }
//        // everything is good, return type of decl
//        return decl->type_check();
//    } else {
//        // field not found in current scope, error
//        if (!field->is_defined()) { return Type::errorType; }
//        // found in sym table, simply return the type of the decl, if its a var decl
//        auto decl = Sym_tbl_t::shared().get_declaration(field->get_name());
//        // if not a var decl, this is an error
//        if (decl->get_decl_type() != DeclType::Variable) { return Type::errorType; }
//        // everything is good, return type of decl
//        return decl->type_check();
//    }
    return Type::errorType;
}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != nullptr && a != nullptr); // b can be be nullptr (just means no explicit base)
    base = b;
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
    (actuals = a)->set_parent_all(this);
}

Type* Call::type_check() {
//    if (base) {
//        auto btype = base->type_check();
//        // only named types can use . syntax
//        if (!btype->is_named_type()) { return Type::errorType; }
//        // not found, thus this field doesnt exist in class
//        if (!Sym_tbl_t::shared().is_declared_in_scope(btype->get_type_name(), field->get_name())) { return Type::errorType; }
//        // found in sym table, simply return the type of the decl, if its a function decl
//        auto decl = Sym_tbl_t::shared().get_declaration_in_scope(btype->get_type_name(), field->get_name());
//        // if not a function decl, this is an error
//        if (decl->get_decl_type() != DeclType::Function) { return Type::errorType; }
//        // everything is good, return type of decl
//        return decl->type_check();
//    } else {
//        // field not found in current scope, error
//        if (!field->is_defined()) { return Type::errorType; }
//        // found in sym table, simply return the type of the decl, if its a function decl
//        auto decl = Sym_tbl_t::shared().get_declaration(field->get_name());
//        // if not a function decl, this is an error
//        if (decl->get_decl_type() != DeclType::Function) { return Type::errorType; }
//        // everything is good, return type of decl
//        return decl->type_check();
//    }
    return Type::errorType;
}


NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c != nullptr);
    (cType = c)->set_parent(this);
}

bool NewExpr::validate() {
    // check that the named type is in the symbol table, and its decl type is class type
    if (!cType->get_id()->is_defined()) {
        return false;
    }

    auto decl = Sym_tbl_t::shared().get_scope()->get_decl(cType->get_id()->get_name()).first;
    return !(decl->get_decl_type() != DeclType::Class);
}


Type* NewExpr::type_check() {
    if (!validate()) {
        return Type::errorType;
    } else {
        return cType;
    }
}


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz != nullptr && et != nullptr);
    (size = sz)->set_parent(this);
    (elemType = et)->set_parent(this);
    arrayType = new ArrayType(loc, et);
}

Type* NewArrayExpr::type_check() {
    if (size->type_check() != Type::intType || elemType->type_check() == Type::errorType) {
        return Type::errorType;
    } else {
        return arrayType;
    }
}


Type* ReadIntegerExpr::type_check() {
    return Type::intType;
}


Type* ReadLineExpr::type_check() {
    return Type::stringType;
}
