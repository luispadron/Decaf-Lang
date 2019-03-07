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
    return left->get_result_type();
}

Type* CompoundExpr::get_rhs_type() {
    if (!right) return nullptr;
    return right->get_result_type();
}

bool CompoundExpr::check() {
    // simply checks that symbols are in table
    bool lcheck, rcheck;
    lcheck = left ? left->check() : true;
    rcheck = right->check();
    return lcheck && rcheck;
}


bool ArithmeticExpr::check() {
    // checks typing for arithmetic expression, i.e types must be of int/double and must be the same types
    if (!CompoundExpr::check()) return false;

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
    if (!CompoundExpr::check()) return false;

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
    if (!CompoundExpr::check()) return false;

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
    if (!CompoundExpr::check()) return false;

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
    if (!CompoundExpr::check()) return false;

    auto lhs_type = get_lhs_type();
    auto rhs_type = get_rhs_type();
    if (!lhs_type->can_perform_assignment_with(rhs_type)) {
        ReportError::incompatible_operands(op, lhs_type, rhs_type);
        return false;
    }

    return true;
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

bool ArrayAccess::check() {
    auto base_type = base->get_result_type();

    if (!dynamic_cast<ArrayType*>(base_type)) {
        ReportError::brackets_on_non_array(base);
        return false;
    }

    if (subscript->get_result_type() != Type::intType) {
        ReportError::subscript_not_integer(subscript);
        return false;
    }

    return true;
}


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->get_location(), f->get_location()) : *f->get_location()) {
    Assert(f != nullptr); // b can be be nullptr (just means no explicit base)
    base = b; 
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
}

Type* FieldAccess::get_result_type() {
    // find the type of this field in the symbol table
    if (base) {
        auto decl = dynamic_cast<VarDecl*>(Sym_table_t::shared().get_symbol_in_class(base->get_id()->get_str(), field->get_str()));
        if (decl) return decl->get_type();
    } else if (Sym_table_t::shared().is_symbol(field->get_str())) {
        auto decl = dynamic_cast<VarDecl*>(Sym_table_t::shared().get_symbol(field->get_str()));
        if (decl) return decl->get_type();
    }

    return nullptr;
}

bool FieldAccess::check() {
    auto named_base = base ? dynamic_cast<NamedType*>(base->get_result_type()) : nullptr;
    if (named_base) {
        if (!Sym_table_t::shared().is_symbol_in_class(named_base->get_id()->get_str(), field->get_str())) {
            ReportError::field_not_found_in_base(field, base->get_result_type());
            return false;
        } else if (!Sym_table_t::shared().is_class_scope()) {
            ReportError::inaccessible_field(field, base->get_result_type());
            return false;
        }
    } else if (base) { // not a class type yet using . syntax, this is invalid
        ReportError::field_not_found_in_base(field, base->get_result_type());
        return false;
    } else if (!field->check()) { // check that field is declared
        ReportError::identifier_not_found(field, Reason_e::LookingForVariable);
        return false;
    }

    return true;
}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != nullptr && a != nullptr); // b can be be nullptr (just means no explicit base)
    base = b;
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
    (actuals = a)->set_parent_all(this);
}

Type* Call::get_result_type() {
    if (Sym_table_t::shared().is_symbol(field->get_str())) {
        auto fn_decl = dynamic_cast<FnDecl*>(Sym_table_t::shared().get_symbol(field->get_str()));
        if (fn_decl) return fn_decl->get_return_type();
    }

    return nullptr;
}

bool Call::check() {
    auto named_base = base ? dynamic_cast<NamedType*>(base->get_result_type()) : nullptr;
    FnDecl *fn = nullptr;
    bool param_check = true;

    // we first need to verify that the given function is in scope, either in a class or global
    // once that's verified, we need to check whether this call parameters are equal to the declaration parameters
    if (named_base) {
        if (!Sym_table_t::shared().is_symbol_in_class(named_base->get_id()->get_str(), field->get_str())) {
            ReportError::field_not_found_in_base(field, named_base);
            param_check = false;
        } else {
            fn = dynamic_cast<FnDecl*>(Sym_table_t::shared().get_symbol_in_class(named_base->get_id()->get_str(),
                                                                                 field->get_str()));
            Assert(fn);
            // check params match
            if (!fn->check_params_match(field, actuals)) {
                param_check = false;
            }
        }
    } else {
        if (!Sym_table_t::shared().is_symbol(field->get_str())) {
            ReportError::identifier_not_found(field, Reason_e::LookingForFunction);
            param_check = false;
        } else {
            fn = dynamic_cast<FnDecl*>(Sym_table_t::shared().get_symbol(field->get_str()));
            Assert(fn);
            // check params match
            if (!fn->check_params_match(field, actuals)) {
                param_check = false;
            }
        }
    }

    bool acheck = actuals->check_all();

    return param_check && acheck;
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
    // size type must be integer
    if (size->get_result_type() != Type::intType) {
        ReportError::new_array_size_not_integer(size);
        return false;
    }

    return true;
}


bool ReadIntegerExpr::check() {
    return false;
}


bool ReadLineExpr::check() {
    return false;
}
