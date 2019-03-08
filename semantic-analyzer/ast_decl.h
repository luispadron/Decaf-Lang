/* File: ast_decl.h
 * ----------------
 * In our parse tree, Decl nodes are used to represent and
 * manage declarations. There are 4 subclasses of the base class,
 * specialized for declarations of variables, functions, classes,
 * and interfaces.
 *
 * pp3: You will need to extend the Decl classes to implement 
 * semantic processing including detection of declaration conflicts 
 * and managing scoping issues.
 */

#ifndef _H_ast_decl
#define _H_ast_decl

#include "ast.h"
#include "ast_type.h"
#include "list.h"

class Identifier;
class Stmt;
class Expr;
class Call;

/// Declares the different types of decls
enum class DeclType { Variable, Class, Function, Interface };

class Decl : public Node {
protected:
    Type *type;
    Identifier *id;
  
public:

    explicit Decl(Identifier *name);
    friend std::ostream& operator<<(std::ostream& out, Decl *d) { return out << d->id; }

    Identifier * get_id() { return id; }

    virtual DeclType get_decl_type() const = 0;

    Type* type_check() override;
};


class VarDecl : public Decl {
public:
    VarDecl(Identifier *name, Type *type);

    DeclType get_decl_type() const override { return DeclType::Variable; }

    void check() override;
};


class ClassDecl : public Decl {
protected:
    List<Decl*> *members;
    NamedType *extends;
    List<NamedType*> *implements;

public:
    ClassDecl(Identifier *name, NamedType *extends, 
              List<NamedType*> *implements, List<Decl*> *members);

    DeclType get_decl_type() const override { return DeclType::Class; }

    void check() override;
};


class InterfaceDecl : public Decl {
protected:
    List<Decl*> *members;
    
public:
    InterfaceDecl(Identifier *name, List<Decl*> *members);

    DeclType get_decl_type() const override { return DeclType::Interface; }

    void check() override;
};


class FnDecl : public Decl {
protected:
    List<VarDecl*> *formals;
    Type *returnType;
    Stmt *body;
    
public:
    FnDecl(Identifier *name, Type *returnType, List<VarDecl*> *formals);

    void set_function_body(Stmt *b);

    void check_parameters(Call *expr, Identifier *fn_ident, List<Expr*> *actuals);

    DeclType get_decl_type() const override { return DeclType::Function; }

    void check() override;
};

#endif
