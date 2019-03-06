/* File: ast_expr.h
 * ----------------
 * The Expr class and its subclasses are used to represent
 * expressions in the parse tree.  For each expression in the
 * language (add, call, New, etc.) there is a corresponding
 * node class for that construct. 
 *
 * pp3: You will need to extend the Expr classes to implement 
 * semantic analysis for rules pertaining to expressions.
 */


#ifndef _H_ast_expr
#define _H_ast_expr

#include "ast.h"
#include "ast_decl.h"
#include "ast_stmt.h"
#include "ast_type.h"
#include "list.h"


class Expr : public Stmt {
public:
    explicit Expr(yyltype loc) : Stmt(loc) {}
    Expr() : Stmt() {}

    /// returns the identifier associated with the given expression
    virtual Identifier * get_id() const { return nullptr; }

    /// returns the type of the result of performing some expression
    virtual Type * get_result_type() { return nullptr; };
};


/* This node type is used for those places where an expression is optional.
 * We could use a NULL pointer, but then it adds a lot of checking for
 * NULL. By using a valid, but no-op, node, we save that trouble */
class EmptyExpr : public Expr {
public:
    bool check() override { return true; }

    Type * get_result_type() override { return Type::voidType; }
};


class IntConstant : public Expr {
protected:
    int value;
  
public:
    IntConstant(yyltype loc, int val);

    Type * get_result_type() override { return Type::intType; }

    bool check() override;
};


class DoubleConstant : public Expr {
protected:
    double value;
    
public:
    DoubleConstant(yyltype loc, double val);

    Type * get_result_type() override { return Type::doubleType; }

    bool check() override;
};


class BoolConstant : public Expr {
protected:
    bool value;
    
public:
    BoolConstant(yyltype loc, bool val);

    Type * get_result_type() override { return Type::boolType; }

    bool check() override;
};


class StringConstant : public Expr {
protected:
    char *value;
    
public:
    StringConstant(yyltype loc, const char *val);

    Type * get_result_type() override { return Type::stringType; }

    bool check() override;
};


class NullConstant: public Expr {
public:
    explicit NullConstant(yyltype loc) : Expr(loc) {}

    Type * get_result_type() override { return Type::nullType; }

    bool check() override;
};


class Operator : public Node {
protected:
    char tokenString[4];
    
public:
    Operator(yyltype loc, const char *tok);

    friend std::ostream& operator<<(std::ostream& out, Operator *o) { return out << o->tokenString; }

    bool check() override;
 };


class CompoundExpr : public Expr {
protected:
    Operator *op;
    Expr *left, *right; // left will be NULL if unary
    
public:
    CompoundExpr(Expr *lhs, Operator *op, Expr *rhs);  // for binary
    CompoundExpr(Operator *op, Expr *rhs);             // for unary

    /// returns the type of the lhs by looking for matching declaration in symbol table
    Type* get_lhs_type();

    /// returns the type of the rhs by looking for matching declaration in symbol table
    Type* get_rhs_type();

    bool check() override;
};


class ArithmeticExpr : public CompoundExpr {
public:
    ArithmeticExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    ArithmeticExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}

    Type * get_result_type() override { return right->get_result_type(); }

    bool check() override;
};


class RelationalExpr : public CompoundExpr {
public:
    RelationalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    Type * get_result_type() override { return Type::boolType; }

    bool check() override;
};


class EqualityExpr : public CompoundExpr {
public:
    EqualityExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    const char *GetPrintNameForNode() { return "EqualityExpr"; }

    Type * get_result_type() override { return Type::boolType; }

    bool check() override;
};


class LogicalExpr : public CompoundExpr {
public:
    LogicalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    LogicalExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}

    const char *GetPrintNameForNode() { return "LogicalExpr"; }

    Type * get_result_type() override { return Type::boolType; }

    bool check() override;
};


class AssignExpr : public CompoundExpr {
public:
    AssignExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    const char *GetPrintNameForNode() { return "AssignExpr"; }

    Type * get_result_type() override { return right->get_result_type(); }

    bool check() override;
};


class LValue : public Expr {
public:
    explicit LValue(yyltype loc) : Expr(loc) {}
};


class This : public Expr {
public:
    explicit This(yyltype loc) : Expr(loc) {}

    bool check() override;
};


class ArrayAccess : public LValue {
protected:
    Expr *base, *subscript;
    
public:
    ArrayAccess(yyltype loc, Expr *base, Expr *subscript);

    Type * get_result_type() override { return base->get_result_type(); }

    bool check() override;
};


/* Note that field access is used both for qualified names
 * base.field and just field without qualification. We don't
 * know for sure whether there is an implicit "this." in
 * front until later on, so we use one node type for either
 * and sort it out later. */
class FieldAccess : public LValue {
protected:
    Expr *base;	// will be NULL if no explicit base
    Identifier *field;

public:
    FieldAccess(Expr *base, Identifier *field); //ok to pass NULL base

    Identifier * get_id() const override { return field; }

    Type * get_result_type() override;

    bool check() override;
};


/* Like field access, call is used both for qualified base.field()
 * and unqualified field().  We won't figure out until later
 * whether we need implicit "this." so we use one node type for either
 * and sort it out later. */
class Call : public Expr {
protected:
    Expr *base;	// will be NULL if no explicit base
    Identifier *field;
    List<Expr*> *actuals;
    
public:
    Call(yyltype loc, Expr *base, Identifier *field, List<Expr*> *args);

    Identifier * get_id() const override { return field; }

    Type * get_result_type() override;

    bool check() override;
};


class NewExpr : public Expr {
protected:
    NamedType *cType;
    
public:
    NewExpr(yyltype loc, NamedType *clsType);

    bool check() override;

    Type * get_result_type() override { return cType; }

    Identifier * get_id() const override { return cType->get_id(); }
};


class NewArrayExpr : public Expr {
protected:
    Expr *size;
    Type *elemType;
    
public:
    NewArrayExpr(yyltype loc, Expr *sizeExpr, Type *elemType);

    Type * get_result_type() override { return new ArrayType(*get_location(), elemType); }

    bool check() override;
};


class ReadIntegerExpr : public Expr {
public:
    explicit ReadIntegerExpr(yyltype loc) : Expr(loc) {}

    Type * get_result_type() override { return Type::intType; }

    bool check() override;
};


class ReadLineExpr : public Expr {
public:
    explicit ReadLineExpr(yyltype loc) : Expr (loc) {}

    Type * get_result_type() override { return Type::stringType; }

    bool check() override;
};

    
#endif
