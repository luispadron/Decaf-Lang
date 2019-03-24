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

#include <string>

class Decl;
class FnDecl;
class VarDecl;
class Expr;


class Stmt : public Node {
public:
    Stmt() : Node() {}
    explicit Stmt(yyltype loc) : Node(loc) {}

    virtual void check() { }

    virtual Location *emit() { return nullptr; }

    virtual int get_bytes() const { return 0; }
};


class StmtBlock : public Stmt {
private:
    static int next_block_id;

protected:
    List<VarDecl*> *decls;
    List<Stmt*> *stmts;
    const int block_id;
    
public:
    StmtBlock(List<VarDecl*> *variableDeclarations, List<Stmt*> *statements);

    /// returns the mangled name of the block, for example:
    /// if "_block1", where 1 is a unique id
    std::string get_mangled_name() const;

    int get_bytes() const override;

    void check() override;

    Location *emit() override;
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
protected:
    char * done_label = nullptr;

public:

    LoopStmt(Expr *testExpr, Stmt *body) : ConditionalStmt(testExpr, body) {}

    const char * get_done_label() const { return done_label; }
};


class ForStmt : public LoopStmt {
protected:
    Expr *init;
    Expr *step;
  
public:
    ForStmt(Expr *init, Expr *test, Expr *step, Stmt *body);

    int get_bytes() const override;

    Location * emit() override;
};


class WhileStmt : public LoopStmt {
public:
    WhileStmt(Expr *test, Stmt *body) : LoopStmt(test, body) {}

    int get_bytes() const override;

    Location * emit() override;
};


class IfStmt : public ConditionalStmt {
protected:
    Stmt *elseBody;
  
public:
    IfStmt(Expr *test, Stmt *thenBody, Stmt *elseBody);

    void check() override;

    int get_bytes() const override;

    Location * emit() override;
};


class BreakStmt : public Stmt {
public:
    explicit BreakStmt(yyltype loc) : Stmt(loc) {}

    Location * emit() override;
};


class ReturnStmt : public Stmt {
protected:
    Expr *expr;
  
public:
    ReturnStmt(yyltype loc, Expr *expr);

    int get_bytes() const override;

    Location * emit()  override;
};


class PrintStmt : public Stmt {
protected:
    List<Expr*> *args;
    
public:
    explicit PrintStmt(List<Expr*> *arguments);

    int get_bytes() const override;

    Location * emit() override;
};

#endif
