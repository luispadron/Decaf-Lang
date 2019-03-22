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

Location * IntConstant::emit() const {
    return Cgen_t::shared().gen_load_constant(value);
}


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

Type* DoubleConstant::type_check() {
    return Type::doubleType;
}

Location * DoubleConstant::emit() const {
    // doubles are not implemented in this project
    Assert(false);
    return nullptr;
}


BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
}

Type* BoolConstant::type_check() {
    return Type::boolType;
}

Location * BoolConstant::emit() const {
    return Cgen_t::shared().gen_load_constant(value);
}


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != nullptr);
    value = strdup(val);
}

Type* StringConstant::type_check() {
    return Type::stringType;
}

Location * StringConstant::emit() const {
    return Cgen_t::shared().gen_load_constant(value);
}


Type* NullConstant::type_check() {
    return Type::nullType;
}

Location * NullConstant::emit() const {
    return Cgen_t::shared().gen_load_constant(0);
}


Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok != nullptr);
    strncpy(tokenString, tok, sizeof(tokenString));
}

Operator::Type Operator::get_op_type() const {
    if (strcmp(tokenString, "<") == 0) return Type::less_than;
    if (strcmp(tokenString, ">") == 0) return Type::greater_than;
    if (strcmp(tokenString, "<=") == 0) return Type::less_than_eql;
    if (strcmp(tokenString, ">=") == 0) return Type::greater_than_eql;
    if (strcmp(tokenString, "=") == 0) return Type::assign;
    if (strcmp(tokenString, "==") == 0) return Type::equal;
    if (strcmp(tokenString, "!=") == 0) return Type::not_equal;
    if (strcmp(tokenString, "!") == 0) return Type::notOp;
    if (strcmp(tokenString, "||") == 0) return Type::orOp;
    if (strcmp(tokenString, "&&") == 0) return Type::andOp;
    if (strcmp(tokenString, "+") == 0) return Type::plus;
    if (strcmp(tokenString, "-") == 0) return Type::minus;
    if (strcmp(tokenString, "/") == 0) return Type::divide;
    if (strcmp(tokenString, "*") == 0) return Type::multiply;
    if (strcmp(tokenString, "%") == 0) return Type::mod;

    Assert(false);
    return Type::multiply; // shouldn't ever happen, but silences compiler warning
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

int ArithmeticExpr::get_bytes() const {
    if (left) {
        return left->get_bytes() + right->get_bytes() + Cgen_t::word_size;
    } else {
        // for unary, (-) negative
        // we will still generate a lhs, the value of the lhs temp will be zero
        // ex: -3 -> 0 - 3
        return right->get_bytes() + 2 * Cgen_t::word_size;
    }
}

Location * ArithmeticExpr::emit() const {
    Location *lhs = [&]() {
        if (left) return left->emit();
        return Cgen_t::shared().gen_load_constant(0);
    }();

    Location *rhs = right->emit();

    return Cgen_t::shared().gen_binary_op(op->get_op_token(), lhs, rhs);
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

int RelationalExpr::get_bytes() const {
    switch (op->get_op_type()) {
        case Operator::Type::less_than:
        case Operator::Type::greater_than:
            return left->get_bytes() + right->get_bytes() + Cgen_t::word_size;

        // for these operations we actually generate 3 temporaries
        // example: x <= 3
        // 1: x < 3
        // 2: x == 3
        // 3: 1 || 2
        case Operator::Type::less_than_eql:
        case Operator::Type::greater_than_eql:
            return left->get_bytes() + right->get_bytes() + 3 * Cgen_t::word_size;

        default:
            Assert(false);
            return -1;
    }
}

Location * RelationalExpr::emit() const {
    auto lhs = left->emit();
    auto rhs = right->emit();

    switch (op->get_op_type()) {
        case Operator::Type::less_than:
            return Cgen_t::shared().gen_binary_op("<", lhs, rhs);

        case Operator::Type::greater_than:
            return Cgen_t::shared().gen_binary_op(">", lhs, rhs);

        case Operator::Type::less_than_eql: {
            auto lt_temp = Cgen_t::shared().gen_binary_op("<", lhs, rhs);
            auto eq_temp = Cgen_t::shared().gen_binary_op("==", lhs, rhs);
            return Cgen_t::shared().gen_binary_op("||", lt_temp, eq_temp);
        }

        case Operator::Type::greater_than_eql: {
            auto gt_temp = Cgen_t::shared().gen_binary_op(">", lhs, rhs);
            auto eq_temp = Cgen_t::shared().gen_binary_op("==", lhs, rhs);
            return Cgen_t::shared().gen_binary_op("||", gt_temp, eq_temp);
        }

        default:
            Assert(false);
            return nullptr;
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

int EqualityExpr::get_bytes() const {
    switch (op->get_op_type()) {
        case Operator::Type::equal:
            return left->get_bytes() + right->get_bytes() + Cgen_t::word_size;

        // != example:
        // x != 3
        // 1: tmp0 = 3
        // 2: tmp1 = x == tmp0
        // 3: tmp2 = 0
        // 4: tmp3 = tmp1 == tmp2
        case Operator::Type::not_equal:
            return left->get_bytes() + right->get_bytes() + 3 * Cgen_t::word_size;

        default:
            Assert(false);
            return -1;
    }
}

Location * EqualityExpr::emit() const {
    auto lhs = left->emit();
    auto rhs = right->emit();

    switch (op->get_op_type()) {
        case Operator::Type::equal:
            if (left->type_check()->is_equal_to(Type::stringType)) {
                return Cgen_t::shared().gen_built_in_call(StringEqual, lhs, rhs);
            } else {
                return Cgen_t::shared().gen_binary_op("==", lhs, rhs);
            }

        case Operator::Type::not_equal: {
            auto eql_tmp = [&]() {
                if (left->type_check()->is_equal_to(Type::stringType)) {
                    return Cgen_t::shared().gen_built_in_call(StringEqual, lhs, rhs);
                } else {
                    return Cgen_t::shared().gen_binary_op("==", lhs, rhs);
                }
            }();
            auto zero_tmp = Cgen_t::shared().gen_load_constant(0);
            return Cgen_t::shared().gen_binary_op("==", eql_tmp, zero_tmp);
        }

        default:
            Assert(false);
            return nullptr;
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

Location * LogicalExpr::emit() const {
    return nullptr;
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

int AssignExpr::get_bytes() const {
    return right->get_bytes();
}

Location * AssignExpr::emit() const {
    Assert(left && right);

    auto lhs = left->emit();
    auto rhs = right->emit();
    Cgen_t::shared().gen_assign(lhs, rhs);

    return lhs;
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

int ArrayAccess::get_bytes() const {
    return base->get_bytes() + subscript->get_bytes();
}


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->get_location(), f->get_location()) : *f->get_location()) {
    Assert(f != nullptr); // b can be be nullptr (just means no explicit base)
    base = b; 
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
}


Type* FieldAccess::type_check() {
    // not implemented for this project
    return Type::errorType;
}

Location * FieldAccess::emit() const {
    auto scope = Sym_tbl_t::shared().get_scope();

    if (base) {
        // TODO: add this when classes are finished
        Assert(false);
        return nullptr;
    } else {
        auto var = dynamic_cast<VarDecl*>(scope->get_decl(field->get_name()).first);
        Assert(var);
        return var->get_location();
    }
}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != nullptr && a != nullptr); // b can be be nullptr (just means no explicit base)
    base = b;
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
    (actuals = a)->set_parent_all(this);
}

Type* Call::type_check() {
    // not implemented for this project
    return Type::errorType;
}

int Call::get_bytes() const {
    auto scope = Sym_tbl_t::shared().get_scope();

    // byte size for the parameters
    int actual_bytes = 0;
    for (int i = 0; i < actuals->size(); ++i) {
        actual_bytes += actuals->get(i)->get_bytes();
    }

    if (base) {
        // TODO: add this when class and stuff is done
        Assert(false);
        return 0;
    } else {
        auto fn = dynamic_cast<FnDecl*>(scope->get_decl(field->get_name()).first);
        Assert(fn);
        if (fn->has_return()) {
            return actual_bytes + Cgen_t::word_size;
        } else {
            return actual_bytes;
        }
    }
}

Location * Call::emit() const {
    auto scope = Sym_tbl_t::shared().get_scope();

    if (base) {
        // TODO: add this when class stuff is done
        Assert(false);
        return nullptr;
    } else {
        auto fn = dynamic_cast<FnDecl*>(scope->get_decl(field->get_name()).first);
        Assert(fn);

        // generate parameter pushing
        for (int i = 0; i < actuals->size(); ++i) {
            Cgen_t::shared().gen_push_param(actuals->get(i)->emit());
        }

        // generate call code
        auto call_code = Cgen_t::shared().gen_l_call(fn->get_mangled_name("").c_str(), fn->has_return());

        // generate pop params
        Cgen_t::shared().gen_pop_params(actuals->size() * Cgen_t::word_size);

        return call_code;
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

int NewArrayExpr::get_bytes() const {
    // Example:
    //  - NewArray(10, int);
    // tmp0 = 10
    // tmp1 = 1
    // tmp2 = tmp0 < tmp1 (checks size is greater than 0)
    // tmp3 = "Decaf runtime error: Array size is <= 0\n" (constant string for dynamic error)
    return size->get_bytes() + 3 * Cgen_t::word_size;
}

Location* NewArrayExpr::emit() const {
    // generates the variables to prepare for array making and checking
    auto size_tmp = size->emit();
    auto one_tmp = Cgen_t::shared().gen_load_constant(1);
    auto lt_1_tmp = Cgen_t::shared().gen_binary_op("<", size_tmp, one_tmp);

    auto size_pass_lbl = Cgen_t::shared().new_label();

    // start if
    Cgen_t::shared().gen_ifz(lt_1_tmp, size_pass_lbl);

    // if the check fails (that is, given a size <= 0) the code below will be executed:
    auto fail_msg = Cgen_t::shared().gen_load_constant("Decaf runtime error: Array size is <= 0\\n");
    Cgen_t::shared().gen_built_in_call(PrintString, fail_msg, nullptr);
    Cgen_t::shared().gen_built_in_call(Halt, nullptr, nullptr);

    // if the check doesnt fail, this code will be executed:
    Cgen_t::shared().gen_label(size_pass_lbl);
    auto one_tmp2 = Cgen_t::shared().gen_load_constant(1);
    auto final_size_tmp = Cgen_t::shared().gen_binary_op("+", one_tmp2, size_tmp); // this adds 1 to the size
    auto word_size_tmp = Cgen_t::shared().gen_load_constant(4); // used to multiply by a word size for memory offsets
    auto arr_word_size = Cgen_t::shared().gen_binary_op("*", final_size_tmp, word_size_tmp); // calculates the memory size
    auto alloc_call_res = Cgen_t::shared().gen_built_in_call(Alloc, arr_word_size);
    Cgen_t::shared().gen_store(alloc_call_res, size_tmp); // store size of array in first slot of array

    // this sets the array offset to be the correct offset (that is the first true element)
    // this is because, if we have an array [10, 20, 30], the real array looks like: [3, 10, 20, 30]
    // where 3 is the size of the array, thus we need to return a pointer to the 1st index, thus offset the
    // array by 4 bytes and return that new location
    return Cgen_t::shared().gen_binary_op("+", alloc_call_res, word_size_tmp);
}


Type* ReadIntegerExpr::type_check() {
    return Type::intType;
}


Type* ReadLineExpr::type_check() {
    return Type::stringType;
}
