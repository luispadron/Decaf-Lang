/* File: ast_expr.cc
 * -----------------
 * Implementation of expression node classes.
 */
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "errors.h"

#include <string.h>


IntConstant::IntConstant(yyltype loc, int val) : Expr(loc) {
    value = val;
}

bool IntConstant::check() { return true; }


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

bool DoubleConstant::check() { return true; }


BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
}

bool BoolConstant::check() { return true; }


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != nullptr);
    value = strdup(val);
}

bool NullConstant::check() { return true; }

bool StringConstant::check() { return true; }


Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok != nullptr);
    strncpy(tokenString, tok, sizeof(tokenString));
}

bool Operator::check() { return true; }


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

Type* CompoundExpr::get_lhs_type() {
    if (!left) return nullptr;
    return dynamic_cast<VarDecl*>(Sym_table_t::shared().get_symbol(left->get_id()->get_name()))->get_type();
}

Type* CompoundExpr::get_rhs_type() {
    if (!right) return nullptr;
    return dynamic_cast<VarDecl*>(Sym_table_t::shared().get_symbol(right->get_id()->get_name()))->get_type();
}

bool CompoundExpr::check() {
    // simply checks that symbols are in table
    if (left) return left->check() && right->check();
    return right->check();
}


bool ArithmeticExpr::check() {
    // checks typing for arithmetic expression, i.e types must be of int/double and must be the same types
    CompoundExpr::check();

    auto rhs_type = get_rhs_type();
    if (left) {
        auto lhs_type = get_lhs_type();
        if (!lhs_type->can_perform_arithmetic_with(rhs_type)) {
            ReportError::incompatible_operands(op, lhs_type, rhs_type);
            return false;
        }
    } else if (!rhs_type->can_perform_arithmetic()) {
        ReportError::incompatible_operand(op, rhs_type);
        return false;
    }

    return true;
}


bool RelationalExpr::check() {
    // checks typing for relational expression, i.e. types must be of int/double and must be the same types
    CompoundExpr::check();

    auto lhs_type = get_lhs_type();
    auto rhs_type = get_rhs_type();
    if (!lhs_type->can_perform_relational_with(rhs_type)) {
        ReportError::incompatible_operands(op, lhs_type, rhs_type);
        return false;
    }

    return true;
}


bool EqualityExpr::check() {
    // checks typing for equality expression, types must be the same or if comparing objects one or both may be null
    CompoundExpr::check();

    auto lhs_type = get_lhs_type();
    auto rhs_type = get_rhs_type();
    if (!lhs_type->can_perform_equality_with(rhs_type)) {
        ReportError::incompatible_operands(op, lhs_type, rhs_type);
        return false;
    }

    return true;
}


bool LogicalExpr::check() {
    // checks typing for logical expression, only bools may be used
    CompoundExpr::check();

    auto rhs_type = get_rhs_type();
    if (left) {
        auto lhs_type = get_lhs_type();
        if (!lhs_type->can_perform_logical_with(rhs_type)) {
            ReportError::incompatible_operands(op, lhs_type, rhs_type);
            return false;
        }
    } else if (!rhs_type->can_perform_logical()) {
        ReportError::incompatible_operand(op, rhs_type);
        return false;
    }

    return true;
}


bool AssignExpr::check() {
    return left->check() && right->check();
}


bool This::check() {
    // simply checks that usage of "this" is within class scope

    if (!Sym_table_t::shared().is_class_scope()) {
        ReportError::this_outside_class_scope(this);
        return false;
    }

    return true;
}

  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base = b)->set_parent(this);
    (subscript = s)->set_parent(this);
}

bool ArrayAccess::check() { return false; }


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->get_location(), f->get_location()) : *f->get_location()) {
    Assert(f != nullptr); // b can be be nullptr (just means no explicit base)
    base = b; 
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
}

Type* FieldAccess::get_result_type() {
    // need to find the type of this field in the symbol table
    // TODO: add checking for class scope
    if (Sym_table_t::shared().is_symbol(field->get_name())) {
        auto decl = dynamic_cast<VarDecl*>(Sym_table_t::shared().get_symbol(field->get_name()));
        if (decl) return decl->get_type();
    }

    return nullptr;
}

bool FieldAccess::check() {
    /// TODO: add check for this/super, etc
    return field->check();
}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != nullptr && a != nullptr); // b can be be nullptr (just means no explicit base)
    base = b;
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
    (actuals = a)->set_parent_all(this);
}

Type* Call::get_result_type() {
    // find function and get its return type
    if (Sym_table_t::shared().is_symbol(field->get_name())) {
        auto fn_decl = dynamic_cast<FnDecl*>(Sym_table_t::shared().get_symbol(field->get_name()));
        if (fn_decl) return fn_decl->get_return_type();
    }

    return nullptr;
}

bool Call::check() {
    // verify function name is in scope
    if (!Sym_table_t::shared().is_symbol(field->get_name())) {
        ReportError::identifier_not_found(field, Reason_e::LookingForFunction);
        return false;
    }

    actuals->check_all();
    return true;
}


NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c != nullptr);
    (cType = c)->set_parent(this);
}

bool NewExpr::check() {
    return false;
}


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz != nullptr && et != nullptr);
    (size = sz)->set_parent(this);
    (elemType = et)->set_parent(this);
}

bool NewArrayExpr::check() {
    return false;
}


bool ReadIntegerExpr::check() {
    return false;
}


bool ReadLineExpr::check() {
    return false;
}
