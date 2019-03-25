/** File: ast_expr.h
 * ----------------
 * The Expr class and its subclasses are used to represent
 * expressions in the parse tree.  For each expression in the
 * language (add, call, New, etc.) there is a corresponding
 * node class for that construct.
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
};


/**
 * This node type is used for those places where an expression is optional.
 * We could use a NULL pointer, but then it adds a lot of checking for
 * NULL. By using a valid, but no-op, node, we save that trouble
 */
class EmptyExpr : public Expr {
public:
    Type * type_check() override { return Type::voidType; }
};


class IntConstant : public Expr {
protected:
    int value;
  
public:
    IntConstant(yyltype loc, int val);

    Type * type_check() override;

    int get_bytes() const override { return CodeGenerator::word_size; }

    Location *emit() override;
};


class DoubleConstant : public Expr {
protected:
    double value;
    
public:
    DoubleConstant(yyltype loc, double val);

    Type * type_check() override;

    int get_bytes() const override { return CodeGenerator::word_size; }

    Location *emit() override;
};


class BoolConstant : public Expr {
protected:
    bool value;
    
public:
    BoolConstant(yyltype loc, bool val);

    Type * type_check() override;

    int get_bytes() const override { return CodeGenerator::word_size; }

    Location *emit() override;
};


class StringConstant : public Expr {
protected:
    char *value;
    
public:
    StringConstant(yyltype loc, const char *val);

    Type * type_check() override;

    int get_bytes() const override { return CodeGenerator::word_size; }

    Location *emit() override;
};


class NullConstant: public Expr {
public:
    explicit NullConstant(yyltype loc) : Expr(loc) { }

    Type * type_check() override;

    int get_bytes() const override { return CodeGenerator::word_size; }

    Location *emit() override;
};


class Operator : public Node {
protected:
    char tokenString[4];
    
public:

    enum class Type {
        less_than,
        greater_than,
        less_than_eql,
        greater_than_eql,
        assign,
        equal,
        not_equal,
        notOp,
        orOp,
        andOp,
        plus,
        minus,
        divide,
        multiply,
        mod
    };

    Operator(yyltype loc, const char *tok);

    friend std::ostream& operator<<(std::ostream& out, Operator *o) { return out << o->tokenString; }

    const char * get_op_token() const { return tokenString; }

    Type get_op_type() const;
};


class CompoundExpr : public Expr {
protected:
    Operator *op;
    Expr *left, *right; // left will be NULL if unary

    virtual bool validate() { return false; }

public:
    CompoundExpr(Expr *lhs, Operator *op, Expr *rhs);  // for binary
    CompoundExpr(Operator *op, Expr *rhs);             // for unary
};


class ArithmeticExpr : public CompoundExpr {
protected:
    bool validate() override;

public:
    ArithmeticExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    ArithmeticExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}

    Type * type_check() override;

    int get_bytes() const override;

    Location *emit() override;
};


class RelationalExpr : public CompoundExpr {
protected:
    bool validate() override;

public:
    RelationalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    Type * type_check() override;

    int get_bytes() const override;

    Location *emit() override;
};


class EqualityExpr : public CompoundExpr {
protected:
    bool validate() override;

public:
    EqualityExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    Type * type_check() override;

    int get_bytes() const override;

    Location *emit() override;
};


class LogicalExpr : public CompoundExpr {
protected:
    bool validate() override;

public:
    LogicalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    LogicalExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}

    Type * type_check() override;

    int get_bytes() const override;

    Location *emit() override;
};


class AssignExpr : public CompoundExpr {
protected:
    bool validate() override;

public:
    AssignExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}

    Type * type_check() override;

    int get_bytes() const override;

    Location *emit() override;
};


class LValue : public Expr {
public:
    explicit LValue(yyltype loc) : Expr(loc) {}
};


class This : public Expr {
public:
    explicit This(yyltype loc) : Expr(loc) {}

    Type * type_check() override;
};


class ArrayAccess : public LValue {
private:

    void emit_check(Location *base, Location *subscript) const;

protected:
    Expr *base, *subscript;
    
public:
    ArrayAccess(yyltype loc, Expr *base, Expr *subscript);

    Type * type_check() override;

    int get_bytes() const override;

    int get_bytes_store() const;

    Location * emit()  override;

    Location * emit_store() const;
};


/**
 * Note that field access is used both for qualified names
 * base.field and just field without qualification. We don't
 * know for sure whether there is an implicit "this." in
 * front until later on, so we use one node type for either
 * and sort it out later.
 */
class FieldAccess : public LValue {
protected:
    Expr *base;	// will be NULL if no explicit base
    Identifier *field;

public:
    FieldAccess(Expr *base, Identifier *field); //ok to pass NULL base

    Type * type_check() override;

    Location *emit() override;
};


/**
 * Like field access, call is used both for qualified base.field()
 * and unqualified field().  We won't figure out until later
 * whether we need implicit "this." so we use one node type for either
 * and sort it out later.
 */
class Call : public Expr {
private:
    /// emits length of an array (.length() call)
    Location * emit_length_call();

    void push_params() const;

protected:
    Expr *base;	// will be NULL if no explicit base
    Identifier *field;
    List<Expr*> *actuals;
    
public:
    Call(yyltype loc, Expr *base, Identifier *field, List<Expr*> *args);

    Type * type_check() override;

    int get_bytes() const override;

    Location *emit() override;
};


class NewExpr : public Expr {
private:
    bool validate();

protected:
    NamedType *cType;
    
public:
    NewExpr(yyltype loc, NamedType *clsType);

    Type * type_check() override;

    int get_bytes() const override;

    Location * emit() override;
};


class NewArrayExpr : public Expr {
protected:
    Expr *size;
    Type *elemType;
    ArrayType *arrayType;
    
public:
    NewArrayExpr(yyltype loc, Expr *sizeExpr, Type *elemType);

    Type * type_check() override;

    int get_bytes() const override;

    Location * emit()  override;
};


class ReadIntegerExpr : public Expr {
public:
    explicit ReadIntegerExpr(yyltype loc) : Expr(loc) {}

    Type * type_check() override;

    int get_bytes() const override;

    Location * emit()  override;
};


class ReadLineExpr : public Expr {
public:
    explicit ReadLineExpr(yyltype loc) : Expr (loc) {}

    Type * type_check() override;

    int get_bytes() const override;

    Location * emit()  override;
};

    
#endif
