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

void IntConstant::Check(Symbol_table<std::string, Node *> &sym_table) {}


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

void DoubleConstant::Check(Symbol_table<std::string, Node *> &sym_table) {}


BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
}

void BoolConstant::Check(Symbol_table<std::string, Node *> &sym_table) {}


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != NULL);
    value = strdup(val);
}

void NullConstant::Check(Symbol_table<std::string, Node *> &sym_table) {

}

void StringConstant::Check(Symbol_table<std::string, Node *> &sym_table) {}


Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok != NULL);
    strncpy(tokenString, tok, sizeof(tokenString));
}

void Operator::Check(Symbol_table<std::string, Node *> &sym_table) {

}


CompoundExpr::CompoundExpr(Expr *l, Operator *o, Expr *r) 
  : Expr(Join(l->GetLocation(), r->GetLocation())) {
    Assert(l != NULL && o != NULL && r != NULL);
    (op=o)->SetParent(this);
    (left=l)->SetParent(this); 
    (right=r)->SetParent(this);
}

CompoundExpr::CompoundExpr(Operator *o, Expr *r) 
  : Expr(Join(o->GetLocation(), r->GetLocation())) {
    Assert(o != NULL && r != NULL);
    left = NULL; 
    (op=o)->SetParent(this);
    (right=r)->SetParent(this);
}

void CompoundExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void ArithmeticExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void RelationalExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void EqualityExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void LogicalExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void AssignExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void LValue::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void This::Check(Symbol_table<std::string, Node *> &sym_table) {

}

  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base=b)->SetParent(this); 
    (subscript=s)->SetParent(this);
}

void ArrayAccess::Check(Symbol_table<std::string, Node *> &sym_table) { }


FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->GetLocation(), f->GetLocation()) : *f->GetLocation()) {
    Assert(f != NULL); // b can be be NULL (just means no explicit base)
    base = b; 
    if (base) base->SetParent(this); 
    (field=f)->SetParent(this);
}

void FieldAccess::Check(Symbol_table<std::string, Node *> &sym_table) {}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != NULL && a != NULL); // b can be be NULL (just means no explicit base)
    base = b;
    if (base) base->SetParent(this);
    (field=f)->SetParent(this);
    (actuals=a)->SetParentAll(this);
}

void Call::Check(Symbol_table<std::string, Node *> &sym_table) {}


NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c != NULL);
  (cType=c)->SetParent(this);
}

void NewExpr::Check(Symbol_table<std::string, Node *> &sym_table) { }


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz != NULL && et != NULL);
    (size=sz)->SetParent(this); 
    (elemType=et)->SetParent(this);
}

void NewArrayExpr::Check(Symbol_table<std::string, Node *> &sym_table) { }


void ReadIntegerExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}


void ReadLineExpr::Check(Symbol_table<std::string, Node *> &sym_table) {

}
