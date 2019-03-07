/* File: ast_stmt.h
 * ----------------
 * The Stmt class and its subclasses are used to represent
 * statements in the parse tree.  For each statment in the
 * language (for, if, return, etc.) there is a corresponding
 * node class for that construct. 
 *
 * pp3: You will need to extend the Stmt classes to implement
 * semantic analysis for rules pertaining to statements.
 */


#ifndef _H_ast_stmt
#define _H_ast_stmt

#include "list.h"
#include "ast.h"

class Decl;
class VarDecl;
class Expr;


class Stmt : public Node {
public:
    Stmt() : Node() {}
    explicit Stmt(yyltype loc) : Node(loc) {}
};


class StmtBlock : public Stmt {
protected:
    List<VarDecl*> *decls;
    List<Stmt*> *stmts;
    
public:
    StmtBlock(List<VarDecl*> *variableDeclarations, List<Stmt*> *statements);

    void check() override;
};

  
class ConditionalStmt : public Stmt {
protected:
    Expr *test;
    Stmt *body;
  
public:
    ConditionalStmt(Expr *testExpr, Stmt *body);

    void check() override;
};


class LoopStmt : public ConditionalStmt {
public:
    LoopStmt(Expr *testExpr, Stmt *body) : ConditionalStmt(testExpr, body) {}

    void check() override;
};


class ForStmt : public LoopStmt {
protected:
    Expr *init;
    Expr *step;
  
public:
    ForStmt(Expr *init, Expr *test, Expr *step, Stmt *body);

    void check() override;
};


class WhileStmt : public LoopStmt {
public:
    WhileStmt(Expr *test, Stmt *body) : LoopStmt(test, body) {}

    void check() override;
};


class IfStmt : public ConditionalStmt {
protected:
    Stmt *elseBody;
  
public:
    IfStmt(Expr *test, Stmt *thenBody, Stmt *elseBody);

    void check() override;
};


class BreakStmt : public Stmt {
public:
    explicit BreakStmt(yyltype loc) : Stmt(loc) {}

    void check() override;
};


class ReturnStmt : public Stmt {
protected:
    Expr *expr;
  
public:
    ReturnStmt(yyltype loc, Expr *expr);

    void check() override;
};


class PrintStmt : public Stmt {
protected:
    List<Expr*> *args;
    
public:
    explicit PrintStmt(List<Expr*> *arguments);

    void check() override;
};


#endif
