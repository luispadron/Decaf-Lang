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

class Decl : public Node {
protected:
    Identifier *id;
  
public:
    explicit Decl(Identifier *name);
    friend std::ostream& operator<<(std::ostream& out, Decl *d) { return out << d->id; }
};

class VarDecl : public Decl {
protected:
    Identifier *ident;
    Type *type;
    
public:
    VarDecl(Identifier *name, Type *type);

    Type * get_type() { return type; }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

class ClassDecl : public Decl {
protected:
    Identifier* name;
    List<Decl*> *members;
    NamedType *extends;
    List<NamedType*> *implements;

public:
    ClassDecl(Identifier *name, NamedType *extends, 
              List<NamedType*> *implements, List<Decl*> *members);

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

class InterfaceDecl : public Decl {
protected:
    List<Decl*> *members;
    
public:
    InterfaceDecl(Identifier *name, List<Decl*> *members);

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

class FnDecl : public Decl {
protected:
    Identifier *ident;
    List<VarDecl*> *formals;
    Type *returnType;
    Stmt *body;
    
public:
    FnDecl(Identifier *name, Type *returnType, List<VarDecl*> *formals);

    void set_function_body(Stmt *b);

    const char * get_name() const noexcept { return ident->get_name(); }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

#endif
