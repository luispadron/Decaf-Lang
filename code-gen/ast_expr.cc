/* File: ast_expr.cc
 * -----------------
 * Implementation of expression node classes.
 */
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "errors.h"

#include <cstring>
#include <vector>

using namespace std;


IntConstant::IntConstant(yyltype loc, int val) : Expr(loc) {
    value = val;
}

Type* IntConstant::type_check() {
    return Type::intType;
}

Location * IntConstant::emit() {
    return Cgen_t::shared().gen_load_constant(value);
}


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

Type* DoubleConstant::type_check() {
    return Type::doubleType;
}

Location * DoubleConstant::emit() {
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

Location * BoolConstant::emit() {
    return Cgen_t::shared().gen_load_constant(value);
}


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != nullptr);
    value = strdup(val);
}

Type* StringConstant::type_check() {
    return Type::stringType;
}

Location * StringConstant::emit() {
    return Cgen_t::shared().gen_load_constant(value);
}


Type* NullConstant::type_check() {
    return Type::nullType;
}

Location * NullConstant::emit() {
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

Location * ArithmeticExpr::emit() {
    Location *lhs;
    Location *rhs;

    if (!left) {
        rhs = right->emit();
        lhs = Cgen_t::shared().gen_load_constant(0);
    } else {
        lhs = left->emit();
        rhs = right->emit();
    }

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

Location * RelationalExpr::emit() {
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

Location * EqualityExpr::emit() {
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

int LogicalExpr::get_bytes() const {
    if (left) return left->get_bytes() + right->get_bytes() + Cgen_t::word_size;
    else return right->get_bytes() + 2 * Cgen_t::word_size;
}

Location * LogicalExpr::emit() {
    if (!left) {
        // do unary not (!) operation
        auto rhs = right->emit();
        auto zero_tmp = Cgen_t::shared().gen_load_constant(0);
        return Cgen_t::shared().gen_binary_op("==", rhs, zero_tmp);
    } else {
        auto lhs = left->emit();
        auto rhs = right->emit();
        return Cgen_t::shared().gen_binary_op(op->get_op_token(), lhs, rhs);
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

int AssignExpr::get_bytes() const {
    auto arr = dynamic_cast<ArrayAccess*>(left);
    if (arr) {
        return arr->get_bytes_store() + right->get_bytes();
    } else {
        return right->get_bytes();
    }
}

Location * AssignExpr::emit() {
    Assert(left && right);

    auto arr = dynamic_cast<ArrayAccess*>(left);

    if (arr) { // array assign is really a store and not a load
        auto lhs = arr->emit_store();
        auto rhs = right->emit();
        Cgen_t::shared().gen_store(lhs, rhs);
        return lhs;
    }else {
        auto lhs = left->emit();
        auto rhs = right->emit();
        Cgen_t::shared().gen_assign(lhs, rhs);
        return lhs;
    }
}


Type* This::type_check() {
    auto scope = Sym_tbl_t::shared().get_scope();
    // if not in class scope, error
    if (!scope->is_class_scope()) {
        return Type::errorType;
    }

    // find name of class, then look up the symbol and return its type
    const auto &class_name = scope->get_class_scope_name();
    auto decl = Sym_tbl_t::shared().get_scope("global").first->get_decl(class_name).first;

    // if the decl isn't a class this is invalid
    if (decl->get_decl_type() != DeclType::Class) {
        return Type::errorType;
    } else {
        return decl->type_check();
    }
}

Location* This::emit() {
    static auto *this_loc = new Location(Segment::fp_relative, 4, "this");
    return this_loc;
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

int ArrayAccess::get_bytes_store() const {
    return base->get_bytes() + subscript->get_bytes() + 10 * Cgen_t::word_size; // 10 temporaries are used
}

int ArrayAccess::get_bytes() const {
    return base->get_bytes() + subscript->get_bytes() + 11 * Cgen_t::word_size; // 11 temporaries are used
}

void ArrayAccess::emit_check(Location *base, Location *subscript) const {
    auto zero_tmp = Cgen_t::shared().gen_load_constant(0); // 0, for out of bounds check
    auto lt_zero = Cgen_t::shared().gen_binary_op("<", subscript, zero_tmp); // check for less than 0

    auto arr_size_tmp = Cgen_t::shared().gen_load(base, -4); // remember, array size is at first element (0th)
    auto lt_size = Cgen_t::shared().gen_binary_op("<", subscript, arr_size_tmp); // checks that subscript is less than size
    auto eql_size = Cgen_t::shared().gen_binary_op("==", lt_size, zero_tmp); // bool check since if 0 == 0, then were ok (in bounds)
    auto check = Cgen_t::shared().gen_binary_op("||", lt_zero, eql_size); // final or, to make sure > 0 and < size

    auto size_pass_lbl = Cgen_t::shared().new_label();
    Cgen_t::shared().gen_ifz(check, size_pass_lbl); // generate if check for "check"

    // any code here will be executed if the size check fails
    auto fail_msg = Cgen_t::shared().gen_load_constant("Decaf runtime error: Array subscript out of bounds\n");
    Cgen_t::shared().gen_built_in_call(PrintString, fail_msg);
    Cgen_t::shared().gen_built_in_call(Halt);

    // any code here will be executed if the size check passed
    Cgen_t::shared().gen_label(size_pass_lbl);
}

Location* ArrayAccess::emit_store() const {
    auto base_tmp = base->emit();
    auto subs_tmp = subscript->emit(); // subscript temp

    emit_check(base_tmp, subs_tmp);

    auto word_sz_tmp = Cgen_t::shared().gen_load_constant(Cgen_t::word_size);
    auto index_addr = Cgen_t::shared().gen_binary_op("*", word_sz_tmp, subs_tmp); // get address of element at index

    return Cgen_t::shared().gen_binary_op("+", base_tmp, index_addr); // get pointer to element
}

Location* ArrayAccess::emit() {
    auto base_tmp = base->emit();
    auto subs_tmp = subscript->emit(); // subscript temp

    emit_check(base_tmp, subs_tmp);

    auto word_sz_tmp = Cgen_t::shared().gen_load_constant(Cgen_t::word_size);
    auto index_addr = Cgen_t::shared().gen_binary_op("*", word_sz_tmp, subs_tmp); // get address of element at index
    auto elem_pointer = Cgen_t::shared().gen_binary_op("+", base_tmp, index_addr); // get pointer to element

    return Cgen_t::shared().gen_load(elem_pointer); // dereference pointer at element
}


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->get_location(), f->get_location()) : *f->get_location()) {
    Assert(f != nullptr); // b can be be nullptr (just means no explicit base)
    base = b; 
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
}


Type* FieldAccess::type_check() {
    auto scope = Sym_tbl_t::shared().get_scope();

    if (base) {
        auto btype = base->type_check();
        // only named types can use . syntax
        if (!btype->is_named_type()) { return Type::errorType; }
        // perform another type check on the named type, since we need to make sure name is defined
        if (btype->type_check() == Type::errorType) { return Type::errorType; }

        auto base_scope = Sym_tbl_t::shared().get_scope(btype->get_type_name());
        auto decl_pair = base_scope.first->get_decl(field->get_name());

        // found in sym table, simply return the type of the decl, if its a var decl
        auto decl = decl_pair.first;
        Assert(decl);

        // if not a var decl, this is an error
        if (decl->get_decl_type() != DeclType::Variable) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
    } else {
        // field not found in current scope, error
        if (!field->is_defined()) { return Type::errorType; }
        // found in sym table, simply return the type of the decl, if its a var decl
        auto decl = scope->get_decl(field->get_name()).first;
        Assert(decl);

        // if not a var decl, this is an error
        if (decl->get_decl_type() != DeclType::Variable) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
    }
}

Location* FieldAccess::emit_member_access() {
    auto scope = Sym_tbl_t::shared().get_scope();
    auto gscope = Sym_tbl_t::shared().get_scope("global").first;
    Assert(gscope);
    auto class_decl = dynamic_cast<ClassDecl*>(gscope->get_decl(scope->get_class_scope_name()).first);
    Assert(class_decl);

    int offset = class_decl->get_member_offset(field->get_name());
    return Cgen_t::shared().gen_load_this_ptr(offset);
}

Location * FieldAccess::emit() {
    auto scope = Sym_tbl_t::shared().get_scope();
    auto is_local = scope->get_decl(field->get_name(), false).second;

    if (base) {
        emit_member_access();
    } else if (!is_local) {
        emit_member_access();
    } else {
        // normal local/global variable access
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
    auto scope = Sym_tbl_t::shared().get_scope();

    if (base) {
        auto btype = base->type_check();

        if (btype->is_array_type() && field->get_name() == "length") { return Type::intType; }

        // only named types can use . syntax
        if (!btype->is_named_type()) { return Type::errorType; }

        auto base_scope = Sym_tbl_t::shared().get_scope(btype->get_type_name());
        auto decl_pair = base_scope.first->get_decl(field->get_name());

        // found in sym table, simply return the type of the decl, if its a function decl
        auto decl = decl_pair.first;
        Assert(decl);

        // if not a function decl, this is an error
        if (decl->get_decl_type() != DeclType::Function) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
    } else {
        // field not found in current scope, error
        if (!field->is_defined()) { return Type::errorType; }
        // found in sym table, simply return the type of the decl, if its a function decl
        auto decl = scope->get_decl(field->get_name()).first;
        Assert(decl);

        // if not a function decl, this is an error
        if (decl->get_decl_type() != DeclType::Function) { return Type::errorType; }
        // everything is good, return type of decl
        return decl->type_check();
    }
}

int Call::get_bytes() const {
    auto scope = Sym_tbl_t::shared().get_scope();

    // byte size for the parameters
    int actual_bytes = 0;
    for (int i = 0; i < actuals->size(); ++i) {
        actual_bytes += actuals->get(i)->get_bytes();
    }

    if (base) {
        if (base->type_check()->is_array_type() && field->get_name() == "length") { // handle built in length call
            return base->get_bytes() + Cgen_t::word_size;
        }

        auto class_name = base->type_check()->get_type_name();
        auto gscope = Sym_tbl_t::shared().get_scope("global").first;
        Assert(gscope);
        auto class_decl = dynamic_cast<ClassDecl *>(gscope->get_decl(class_name).first);
        Assert(class_decl);
        auto class_scope = Sym_tbl_t::shared().get_scope(class_decl->get_id()->get_name()).first;
        Assert(class_scope);
        auto fn = dynamic_cast<FnDecl *>(class_scope->get_decl(field->get_name()).first);
        Assert(fn);

        if (fn->has_return()) {
            return actual_bytes + (3 * Cgen_t::word_size);
        } else {
            return actual_bytes + (2 * Cgen_t::word_size);
        }

    }

    // handle the rest of two cases, either calling using implicit "this" or just a global function call
    auto is_local = scope->get_decl(field->get_name(), false).second;
    auto fn = dynamic_cast<FnDecl *>(scope->get_decl(field->get_name()).first);
    Assert(fn);

    if (!is_local) {
        if (fn->has_return()) {
            return actual_bytes + (3 * Cgen_t::word_size);
        } else {
            return actual_bytes + (2 * Cgen_t::word_size);
        }
    } else {
        if (fn->has_return()) {
            return actual_bytes + Cgen_t::word_size;
        } else {
            return actual_bytes;
        }
    }
}

Location* Call::emit_length_call() {
    auto base_tmp = base->emit();
    return Cgen_t::shared().gen_load(base_tmp, -4);
}

Location* Call::emit_explicit_method_call() {
    auto class_name = base->type_check()->get_type_name();
    auto gscope = Sym_tbl_t::shared().get_scope("global").first;
    Assert(gscope);
    auto class_decl = dynamic_cast<ClassDecl *>(gscope->get_decl(class_name).first);
    Assert(class_decl);
    auto class_scope = Sym_tbl_t::shared().get_scope(class_decl->get_id()->get_name()).first;
    Assert(class_scope);
    auto fn = dynamic_cast<FnDecl *>(class_scope->get_decl(field->get_name()).first);
    Assert(fn);

    auto object_loc = base->emit();
    auto vtable = Cgen_t::shared().gen_load(object_loc); // get vtable, remember vtable is at first 4 bytes of object
    int method_offset = class_decl->get_method_offset(field->get_name()); // get offset of method in vtable
    auto method_addr = Cgen_t::shared().gen_load(vtable, method_offset); // get actual method address

    push_params(object_loc);

    auto call_ret = Cgen_t::shared().gen_a_call(method_addr, fn->has_return());
    Cgen_t::shared().gen_pop_params((actuals->size() * Cgen_t::word_size) + Cgen_t::word_size);
    return call_ret;
}

Location* Call::emit_implicit_method_call() {
    auto gscope = Sym_tbl_t::shared().get_scope("global").first;
    auto scope = Sym_tbl_t::shared().get_scope();

    // get class decl
    auto class_decl = dynamic_cast<ClassDecl*>(gscope->get_decl(scope->get_class_scope_name()).first);
    Assert(class_decl);

    // get function decl
    auto fn = dynamic_cast<FnDecl*>(scope->get_decl(field->get_name()).first);
    Assert(fn);

    // find offset of method in object
    auto fn_offset = class_decl->get_method_offset(fn->get_id()->get_name());

    // get this pointer location with offset of function
    auto this_loc = Cgen_t::shared().gen_load_this_ptr();
    auto method_addr = Cgen_t::shared().gen_load(this_loc, fn_offset);
    push_params(this_loc);

    auto ret = Cgen_t::shared().gen_a_call(method_addr, fn->has_return());
    Cgen_t::shared().gen_pop_params((actuals->size() * Cgen_t::word_size) + Cgen_t::word_size);
    return ret;
}

void Call::push_params(Location *this_ptr) const {
    // generate locations for parameters
    vector<Location *> params;
    params.reserve(static_cast<size_t>(actuals->size()));
    for (int i = 0; i < actuals->size(); ++i) {
        params.push_back(actuals->get(i)->emit());
    }

    // generate parameter pushing, this is done from last to first
    for (auto param_it = params.rbegin(); param_it != params.rend(); ++param_it) {
        Cgen_t::shared().gen_push_param(*param_it);
    }

    if (this_ptr) {
        Cgen_t::shared().gen_push_param(this_ptr);
    }
}

Location * Call::emit() {
    auto scope = Sym_tbl_t::shared().get_scope();
    auto is_local = scope->get_decl(field->get_name(), false).second;

    if (base) {
        if (base->type_check()->is_array_type() && field->get_name() == "length") { // handle built in length call
            return emit_length_call();
        } else {
            return emit_explicit_method_call();
        }
    } else if (!is_local){
        return emit_implicit_method_call();
    } else {
        // emit normal call
        auto fn = dynamic_cast<FnDecl*>(scope->get_decl(field->get_name()).first);
        Assert(fn);

        push_params();
        auto ret = Cgen_t::shared().gen_l_call(fn->get_id()->get_name().c_str(), fn->has_return());
        Cgen_t::shared().gen_pop_params(actuals->size() * Cgen_t::word_size);
        return ret;
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

int NewExpr::get_bytes() const {
    return 3 * Cgen_t::word_size;
}

Location* NewExpr::emit() {
    // find class decl
    auto gscope = Sym_tbl_t::shared().get_scope("global").first;
    Assert(gscope);
    auto class_decl = dynamic_cast<ClassDecl*>(gscope->get_decl(cType->get_id()->get_name()).first);
    Assert(class_decl);

    auto size_tmp = Cgen_t::shared().gen_load_constant(class_decl->get_bytes()); // size of class
    auto result = Cgen_t::shared().gen_built_in_call(Alloc, size_tmp); // allocate space for object
    auto vtable_tmp = Cgen_t::shared().gen_load_label(class_decl->get_id()->get_name().c_str());
    Cgen_t::shared().gen_store(result, vtable_tmp); // assign vtable address to start of object memory
    return result;
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
    return size->get_bytes() + 9 * Cgen_t::word_size;
}

Location* NewArrayExpr::emit() {
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
    auto word_size_tmp = Cgen_t::shared().gen_load_constant(Cgen_t::word_size); // used to multiply by a word size for memory offsets
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

int ReadIntegerExpr::get_bytes() const {
    return Cgen_t::word_size;
}

Location* ReadIntegerExpr::emit() {
    return Cgen_t::shared().gen_built_in_call(ReadInteger);
}


Type* ReadLineExpr::type_check() {
    return Type::stringType;
}

int ReadLineExpr::get_bytes() const {
    return Cgen_t::word_size;
}

Location* ReadLineExpr::emit() {
    return Cgen_t::shared().gen_built_in_call(ReadLine);
}