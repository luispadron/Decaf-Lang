/* File: ast_expr.cc
 * -----------------
 * Implementation of expression node classes.
 */
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_decl.h"
#include <string.h>


IntConstant::IntConstant(yyltype loc, int val) : Expr(loc) {
    value = val;
}

Location* IntConstant::emit_with_location() {
    return g_codeGen->GenLoadConstant(value);
}


DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
}

Location* DoubleConstant::emit_with_location() {
    Assert(false); // code gen not implemented for doubles
    exit(1);
}


BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
}

Location* BoolConstant::emit_with_location() {
    return g_codeGen->GenLoadConstant(value);
}


StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val);
    value = strdup(val);
}

Location* StringConstant::emit_with_location() {
    return g_codeGen->GenLoadConstant(value);
}


Location* NullConstant::emit_with_location() {
    return g_codeGen->GenLoadConstant(nullptr);
}


Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok);
    strncpy(tokenString, tok, sizeof(tokenString));
}


CompoundExpr::CompoundExpr(Expr *l, Operator *o, Expr *r) 
  : Expr(Join(l->GetLocation(), r->GetLocation())) {
    Assert(l && o && r);
    (op=o)->SetParent(this);
    (left=l)->SetParent(this); 
    (right=r)->SetParent(this);
}

CompoundExpr::CompoundExpr(Operator *o, Expr *r) : Expr(Join(o->GetLocation(), r->GetLocation())) {
    Assert(o && r);
    left = nullptr;
    (op=o)->SetParent(this);
    (right=r)->SetParent(this);
}


Location* ArithmeticExpr::emit_with_location() {
    auto l = left->emit_with_location();
    auto r = right->emit_with_location();
    Assert(l && r);

    return g_codeGen->GenBinaryOp(op->get_op_token(), l, r);
}

void ArithmeticExpr::Emit() {
    emit_with_location();
}
   
  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base=b)->SetParent(this); 
    (subscript=s)->SetParent(this);
}
     
FieldAccess::FieldAccess(Expr *b, Identifier *f)
    : LValue(b? Join(b->GetLocation(), f->GetLocation()) : *f->GetLocation()) {
    Assert(f); // b can be be NULL (just means no explicit base)
    base = b; 
    if (base) base->SetParent(this); 
    (field=f)->SetParent(this);
}


Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f && a); // b can be be NULL (just means no explicit base)
    base = b;
    if (base) base->SetParent(this);
    (field=f)->SetParent(this);
    (actuals=a)->SetParentAll(this);
}
 

NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c);
  (cType=c)->SetParent(this);
}


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz && et);
    (size=sz)->SetParent(this); 
    (elemType=et)->SetParent(this);
}

       
