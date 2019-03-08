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

void CompoundExpr::check() {
    if (left) left->check();
    right->check();
}


bool ArithmeticExpr::validate() {
    auto rtype = right->type_check();
    if (left) return left->type_check()->can_perform_arithmetic_with(rtype);
    return rtype->can_perform_arithmetic();
}

void ArithmeticExpr::check() {
    CompoundExpr::check();

    // if we arent a valid arithmetic expression, only print error if both left/right are NOT errorType
    // this is because we dont want to continue printing errors if either of the operands is in error.
    if (!validate()) {
        if (left && left->type_check() != Type::errorType && right->type_check() != Type::errorType) {
            ReportError::incompatible_operands(op, left->type_check(), right->type_check());
        } else if (right->type_check() != Type::errorType) {
            ReportError::incompatible_operand(op, right->type_check());
        }
    }
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

void RelationalExpr::check() {
    CompoundExpr::check();

    Type *ltype = left->type_check(), *rtype = right->type_check();

    if (!validate() && ltype != Type::errorType && rtype != Type::errorType) {
        ReportError::incompatible_operands(op, ltype, rtype);
    }
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

void EqualityExpr::check() {
    CompoundExpr::check();

    Type *ltype = left->type_check(), *rtype = right->type_check();

    if (!validate() && ltype != Type::errorType && rtype != Type::errorType) {
        ReportError::incompatible_operands(op, ltype, rtype);
    }
}

Type* EqualityExpr::type_check() {
    if (!validate()) {
        return Type::errorType;
    } else {
        return Type::boolType;
    }
}


void LogicalExpr::check() {

}


void AssignExpr::check() {

}


void This::check() {

}

  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base = b)->set_parent(this);
    (subscript = s)->set_parent(this);
}

void ArrayAccess::check() {

}


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->get_location(), f->get_location()) : *f->get_location()) {
    Assert(f != nullptr); // b can be be nullptr (just means no explicit base)
    base = b; 
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
}

void FieldAccess::check() {
    // TODO: add class lookup
    if (!field->is_defined()) {
        ReportError::identifier_not_found(field, Reason_e::LookingForVariable);
    }
}

Type* FieldAccess::type_check() {
    // TODO: add class lookup
    if (field->is_defined()) {
        return Sym_tbl_t::shared().get_symbol(field->get_name());
    } else {
        return Type::errorType;
    }
}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != nullptr && a != nullptr); // b can be be nullptr (just means no explicit base)
    base = b;
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
    (actuals = a)->set_parent_all(this);
}


void Call::check() {

}


NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c != nullptr);
    (cType = c)->set_parent(this);
}

void NewExpr::check() {

}


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz != nullptr && et != nullptr);
    (size = sz)->set_parent(this);
    (elemType = et)->set_parent(this);
}

void NewArrayExpr::check() {

}


void ReadIntegerExpr::check() {

}


void ReadLineExpr::check() {

}
