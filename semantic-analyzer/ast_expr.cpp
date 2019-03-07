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

bool IntConstant::check() {

}


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

bool DoubleConstant::check() {

}


BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
}

bool BoolConstant::check() {

}


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != nullptr);
    value = strdup(val);
}

bool NullConstant::check() {

}

bool StringConstant::check() {

}


Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok != nullptr);
    strncpy(tokenString, tok, sizeof(tokenString));
}

bool Operator::check() {

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

Type* CompoundExpr::get_lhs_type() {
    if (!left) return nullptr;
    return left->get_result_type();
}

Type* CompoundExpr::get_rhs_type() {
    if (!right) return nullptr;
    return right->get_result_type();
}

bool CompoundExpr::check() {

}


bool ArithmeticExpr::check() {

}


bool RelationalExpr::check() {

}


bool EqualityExpr::check() {

}


bool LogicalExpr::check() {

}


bool AssignExpr::check() {

}


bool This::check() {

}

  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base = b)->set_parent(this);
    (subscript = s)->set_parent(this);
}

bool ArrayAccess::check() {

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
        auto decl = dynamic_cast<VarDecl*>(Sym_table_t::shared().get_symbol_in_class(base->get_id()->get_name(),
                                                                                     field->get_name()));
        if (decl) return decl->get_type();
    } else if (Sym_table_t::shared().is_symbol(field->get_name())) {
        auto decl = dynamic_cast<VarDecl*>(Sym_table_t::shared().get_symbol(field->get_name()));
        if (decl) return decl->get_type();
    }

    return nullptr;
}

bool FieldAccess::check() {

}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != nullptr && a != nullptr); // b can be be nullptr (just means no explicit base)
    base = b;
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
    (actuals = a)->set_parent_all(this);
}

Type* Call::get_result_type() {
    if (Sym_table_t::shared().is_symbol(field->get_name())) {
        auto fn_decl = dynamic_cast<FnDecl*>(Sym_table_t::shared().get_symbol(field->get_name()));
        if (fn_decl) return fn_decl->get_return_type();
    }

    return nullptr;
}

bool Call::check() {

}


NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c != nullptr);
    (cType = c)->set_parent(this);
}

bool NewExpr::check() {

}


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz != nullptr && et != nullptr);
    (size = sz)->set_parent(this);
    (elemType = et)->set_parent(this);
}

bool NewArrayExpr::check() {

}


bool ReadIntegerExpr::check() {

}


bool ReadLineExpr::check() {

}
