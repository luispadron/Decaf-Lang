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

    if (!validate()) {
        if (left) {
            ReportError::incompatible_operands(op, left->type_check(), right->type_check());
        } else {
            ReportError::incompatible_operand(op, right->type_check());
        }
    }
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


void This::check() {
    if (type_check() == Type::errorType) {
        ReportError::this_outside_class_scope(this);
    }
}

Type* This::type_check() {
    // if not in class scope, error
    if (!Sym_tbl_t::shared().is_class_scope()) {
        return Type::errorType;
    }

    // find name of class, then look up the symbol and return its type
    auto class_name = Sym_tbl_t::shared().get_class_scope_name();

    if (!Sym_tbl_t::shared().is_declared(class_name)) {
        return Type::errorType;
    }

    auto decl = Sym_tbl_t::shared().get_declaration(class_name);
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

void ArrayAccess::check() {
    base->check();

    if (!base->type_check()->is_array_type()) {
        ReportError::brackets_on_non_array(base);
    }

    subscript->check();

    if (!subscript->type_check()->can_perform_array_access()) {
        ReportError::subscript_not_integer(subscript);
    }
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

void FieldAccess::check() {
    if (base) {
        base->check();
        auto btype = base->type_check();
        if (btype == Type::errorType) { return; }

        // field is not found in the scope of the base, error
        if (!Sym_tbl_t::shared().is_declared_in_scope(btype->get_type_name(), field->get_name())) {
            ReportError::field_not_found_in_base(field, btype);
            return;
        }

        auto decl = Sym_tbl_t::shared().get_declaration_in_scope(btype->get_type_name(), field->get_name());
        // variables only accessible within class scope, unless using "this" or in same class
        if (decl->get_decl_type() == DeclType::Variable &&
            !base->is_this_expr() &&
            !Sym_tbl_t::shared().is_scope_named(btype->get_type_name())) {
            ReportError::inaccessible_field(field, btype);
            return;
        }
    } else if (!Sym_tbl_t::shared().is_declared(field->get_name())) {
        // didn't find the field at all
        ReportError::identifier_not_found(field, Reason_e::LookingForVariable);
    } else {
        // found field, but declaration of field needs to be a variable
        auto decl = Sym_tbl_t::shared().get_declaration(field->get_name());
        if (decl->get_decl_type() != DeclType::Variable) {
            ReportError::identifier_not_found(field, Reason_e::LookingForVariable);
        }
    }
}

Type* FieldAccess::type_check() {
    if (base) {
        auto btype = base->type_check();
        // only named types can use . syntax
        if (!btype->is_named_type()) { return Type::errorType; }
        // perform another type check on the named type, since we need to make sure name is defined
        if (btype->type_check() == Type::errorType) { return Type::errorType; }

        // not found, thus this field doesnt exist in class
        if (!Sym_tbl_t::shared().is_declared_in_scope(btype->get_type_name(), field->get_name())) { return Type::errorType; }
        // found in sym table, simply return the type of the decl, if its a var decl
        auto decl = Sym_tbl_t::shared().get_declaration_in_scope(btype->get_type_name(), field->get_name());
        // if not a var decl, this is an error
        if (decl->get_decl_type() != DeclType::Variable) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
    } else {
        // field not found in current scope, error
        if (!field->is_defined()) { return Type::errorType; }
        // found in sym table, simply return the type of the decl, if its a var decl
        auto decl = Sym_tbl_t::shared().get_declaration(field->get_name());
        // if not a var decl, this is an error
        if (decl->get_decl_type() != DeclType::Variable) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
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
    FnDecl *fn_decl = nullptr;

    if (base) {
        // handle special case for length function of array types
        if (strcmp(field->get_name(), "length") == 0) {
            if (base->type_check()->is_array_type() && actuals->size() == 0) {
                return;
            }
        }

        base->check();
        auto btype = base->type_check();
        // dont check further if type is error
        if (btype == Type::errorType) { return; }
        if (btype->is_named_type() && btype->type_check() == Type::errorType) { return; }

        // field is not found in the scope of the base, error
        if (!Sym_tbl_t::shared().is_declared_in_scope(btype->get_type_name(), field->get_name())) {
            ReportError::field_not_found_in_base(field, btype);
            actuals->check_all();
            return;
        }

        auto decl = Sym_tbl_t::shared().get_declaration_in_scope(btype->get_type_name(), field->get_name());
        if (decl->get_decl_type() != DeclType::Function) {
            ReportError::field_not_found_in_base(field, btype);
            actuals->check_all();
            return;
        }
        // good to go, now just need to verify signature is correct
        fn_decl = dynamic_cast<FnDecl*>(decl);
    } else if (!Sym_tbl_t::shared().is_declared(field->get_name())) {
        // didn't find the field at all
        ReportError::identifier_not_found(field, Reason_e::LookingForFunction);
        actuals->check_all();
        return;
    } else {
        // found field, but declaration of field needs to be a function
        auto decl = Sym_tbl_t::shared().get_declaration(field->get_name());
        if (decl->get_decl_type() != DeclType::Function) {
            ReportError::identifier_not_found(field, Reason_e::LookingForFunction);
            actuals->check_all();
            return;
        }
        // good to go, now just need to verify signature is correct
        fn_decl = dynamic_cast<FnDecl*>(decl);
    }

    Assert(fn_decl);

    actuals->check_all();
    fn_decl->check_parameters(field, actuals);
}

Type* Call::type_check() {
    if (base) {
        auto btype = base->type_check();
        // only named types can use . syntax
        if (!btype->is_named_type()) { return Type::errorType; }
        // not found, thus this field doesnt exist in class
        if (!Sym_tbl_t::shared().is_declared_in_scope(btype->get_type_name(), field->get_name())) { return Type::errorType; }
        // found in sym table, simply return the type of the decl, if its a function decl
        auto decl = Sym_tbl_t::shared().get_declaration_in_scope(btype->get_type_name(), field->get_name());
        // if not a function decl, this is an error
        if (decl->get_decl_type() != DeclType::Function) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
    } else {
        // field not found in current scope, error
        if (!field->is_defined()) { return Type::errorType; }
        // found in sym table, simply return the type of the decl, if its a function decl
        auto decl = Sym_tbl_t::shared().get_declaration(field->get_name());
        // if not a function decl, this is an error
        if (decl->get_decl_type() != DeclType::Function) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
    }
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

    auto decl = Sym_tbl_t::shared().get_declaration(cType->get_id()->get_name());
    if (decl->get_decl_type() != DeclType::Class) {
        return false;
    }

    return true;
}

void NewExpr::check() {
    if (!validate()) {
        ReportError::identifier_not_found(cType->get_id(), Reason_e::LookingForClass);
    }
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

void NewArrayExpr::check() {
    if (size->type_check() != Type::intType) {
        ReportError::new_array_size_not_integer(size);
    }

    elemType->check();
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
