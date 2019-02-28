/* File: ast_expr.cc
 * -----------------
 * Implementation of expression node classes.
 */
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_decl.h"
#include <string.h>
#include "errors.h"


IntConstant::IntConstant(yyltype loc, int val) : Expr(loc) {
    value = val;
}

void IntConstant::check(Symbol_table<std::string, Node *> &sym_table) {}


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

void DoubleConstant::check(Symbol_table<std::string, Node *> &sym_table) {}


BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
}

void BoolConstant::check(Symbol_table<std::string, Node *> &sym_table) {}


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != nullptr);
    value = strdup(val);
}

void NullConstant::check(Symbol_table<std::string, Node *> &sym_table) {

}

void StringConstant::check(Symbol_table<std::string, Node *> &sym_table) {}


Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok != nullptr);
    strncpy(tokenString, tok, sizeof(tokenString));
}

void Operator::check(Symbol_table<std::string, Node *> &sym_table) {

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

void CompoundExpr::check(Symbol_table<std::string, Node *> &sym_table) {

}


void ArithmeticExpr::check(Symbol_table<std::string, Node *> &sym_table) {

}


void RelationalExpr::check(Symbol_table<std::string, Node *> &sym_table) {

}


void EqualityExpr::check(Symbol_table<std::string, Node *> &sym_table) {

}


void LogicalExpr::check(Symbol_table<std::string, Node *> &sym_table) {

}


void AssignExpr::check(Symbol_table<std::string, Node *> &sym_table) {
    left->check(sym_table);
    right->check(sym_table);
}


void This::check(Symbol_table<std::string, Node *> &sym_table) {

}

  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base = b)->set_parent(this);
    (subscript = s)->set_parent(this);
}

void ArrayAccess::check(Symbol_table<std::string, Node *> &sym_table) { }


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->get_location(), f->get_location()) : *f->get_location()) {
    Assert(f != nullptr); // b can be be nullptr (just means no explicit base)
    base = b; 
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
}

void FieldAccess::check(Symbol_table<std::string, Node *> &sym_table) {
    /// TODO: add check for this/super, etc
    field->check(sym_table);
}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != nullptr && a != nullptr); // b can be be nullptr (just means no explicit base)
    base = b;
    if (base) base->set_parent(this);
    (field = f)->set_parent(this);
    (actuals = a)->set_parent_all(this);
}

void Call::check(Symbol_table<std::string, Node *> &sym_table) {}


NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c != nullptr);
    (cType = c)->set_parent(this);
}

void NewExpr::check(Symbol_table<std::string, Node *> &sym_table) { }


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz != nullptr && et != nullptr);
    (size = sz)->set_parent(this);
    (elemType = et)->set_parent(this);
}

void NewArrayExpr::check(Symbol_table<std::string, Node *> &sym_table) { }


void ReadIntegerExpr::check(Symbol_table<std::string, Node *> &sym_table) {

}


void ReadLineExpr::check(Symbol_table<std::string, Node *> &sym_table) {

}
