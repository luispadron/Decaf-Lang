/* File: ast_expr.h
 * ----------------
 * The Expr class and its subclasses are used to represent
 * expressions in the parse tree.  For each expression in the
 * language (add, call, New, etc.) there is a corresponding
 * node class for that construct. 
 */


#ifndef _H_ast_expr
#define _H_ast_expr

#include "ast.h"
#include "ast_stmt.h"
#include "list.h"

class NamedType; // for new
class Type; // for NewArray
class ClassDecl; // for This
class Location;


class Expr : public Stmt {
public:
    explicit Expr(yyltype loc) : Stmt(loc) { result = nullptr; }
    Expr() : Stmt() { result = nullptr; }
    void Check() override { CheckAndComputeResultType(); }
    virtual Type* CheckAndComputeResultType() = 0;
    Location *result;
    Location *GetResult() { return result; }
};

/* This node type is used for those places where an expression is optional.
 * We could use a NULL pointer, but then it adds a lot of checking for
 * NULL. By using a valid, but no-op, node, we save that trouble */
class EmptyExpr : public Expr {
public:
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override { result = nullptr; }
};

class IntConstant : public Expr {
protected:
    int value;
  
public:
    IntConstant(yyltype loc, int val);
    Type *CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class DoubleConstant : public Expr {
protected:
    double value;
    
public:
    DoubleConstant(yyltype loc, double val);
    Type *CheckAndComputeResultType() override;
};

class BoolConstant : public Expr {
protected:
    bool value;
    
public:
    BoolConstant(yyltype loc, bool val);
    Type *CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class StringConstant : public Expr {
protected:
    char *value;
    
public:
    StringConstant(yyltype loc, const char *val);
    Type *CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class NullConstant: public Expr {
public:
    explicit NullConstant(yyltype loc) : Expr(loc) {}
    Type *CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class Operator : public Node {
protected:
    char tokenString[4];
    
public:
    Operator(yyltype loc, const char *tok);
    friend std::ostream& operator<<(std::ostream& out, Operator *o) { return out << o->tokenString; }
    const char *str() { return tokenString; }
 };
 
class CompoundExpr : public Expr {
protected:
    Operator *op;
    Expr *left, *right; // left will be NULL if unary
    
public:
    CompoundExpr(Expr *lhs, Operator *op, Expr *rhs); // for binary
    CompoundExpr(Operator *op, Expr *rhs);             // for unary
    void ReportErrorForIncompatibleOperands(Type *lhs, Type *rhs);
    bool CanDoArithmetic(Type *lhs, Type *rhs);
    void Emit(CodeGenerator *cg) override;
};

class ArithmeticExpr : public CompoundExpr {
public:
    ArithmeticExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    ArithmeticExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class RelationalExpr : public CompoundExpr {
public:
    RelationalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class EqualityExpr : public CompoundExpr {
public:
    EqualityExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class LogicalExpr : public CompoundExpr {
public:
    LogicalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    LogicalExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class AssignExpr : public CompoundExpr {
public:
    AssignExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class LValue : public Expr {
public:
    explicit LValue(yyltype loc) : Expr(loc) {}
    void Emit(CodeGenerator *cg) override;
    virtual void EmitWithoutDereference(CodeGenerator *cg){}
};

class This : public Expr {
protected:
    ClassDecl *enclosingClass;
    
public:
    explicit This(yyltype loc) : Expr(loc), enclosingClass(nullptr)  {}
    Type* CheckAndComputeResultType() override;
     void Emit(CodeGenerator *cg) override;
};

class ArrayAccess : public LValue {
protected:
    Expr *base, *subscript;
    
public:
    ArrayAccess(yyltype loc, Expr *base, Expr *subscript);
    Type *CheckAndComputeResultType() override;
    void EmitWithoutDereference(CodeGenerator *cg) override;
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
    Type* CheckAndComputeResultType() override;
     void EmitWithoutDereference(CodeGenerator *cg) override;
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
    Type *CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class NewExpr : public Expr {
protected:
    NamedType *cType;
    
public:
    NewExpr(yyltype loc, NamedType *clsType);
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class NewArrayExpr : public Expr {
protected:
    Expr *size;
    Type *elemType;
    
public:
    NewArrayExpr(yyltype loc, Expr *sizeExpr, Type *elemType);
    Type* CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class ReadIntegerExpr : public Expr {
public:
    explicit ReadIntegerExpr(yyltype loc) : Expr(loc) {}
    Type *CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

class ReadLineExpr : public Expr {
public:
    explicit ReadLineExpr(yyltype loc) : Expr (loc) {}
    Type *CheckAndComputeResultType() override;
    void Emit(CodeGenerator *cg) override;
};

    
#endif
