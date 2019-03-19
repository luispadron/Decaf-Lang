/* File: ast_decl.h
 * ----------------
 * In our parse tree, Decl nodes are used to represent and
 * manage declarations. There are 4 subclasses of the base class,
 * specialized for declarations of variables, functions, classes,
 * and interfaces.
 *
 * pp4: You will need to extend the Decl classes to implement 
 * code generation for declarations.
 */

#ifndef _H_ast_decl
#define _H_ast_decl

#include "ast.h"
#include "ast_type.h"
#include "list.h"

class Identifier;
class Stmt;

enum class DeclType {
    Variable,
    Function,
    Interface,
    Class
};

class Decl : public Node {

protected:
    Identifier *id;
  
public:
    explicit Decl(Identifier *name);
    friend std::ostream& operator<<(std::ostream& out, Decl *d) { return out << d->id; }

    virtual Identifier * get_id() const { return id; }

    /// returns type of the decl, either class, function, interface or variable
    virtual DeclType get_decl_type() const = 0;

    /// returns the prefix for the label, that is, the prefix used for MIPS label
    virtual std::string get_label_prefix() const { return ""; }

    virtual std::string get_mips_label() const { return "_" + id->get_name(); }
};

class VarDecl : public Decl {
protected:
    Location *location = nullptr;
    Type *type;
    
public:
    VarDecl(Identifier *name, Type *type);

    void set_location(Segment segment, int offset);

    Location * get_location() const { return location; }

    DeclType get_decl_type() const override { return DeclType::Variable; }

    std::string get_mips_label() const override { return g_codeGen->NewLabel(); }

    void Emit() override;
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

    std::string get_label_prefix() const override { return "_" + id->get_name() + "."; }

    std::string get_mips_label() const override { return id->get_name(); }

    void Emit() override;
};


class InterfaceDecl : public Decl {
protected:
    List<Decl*> *members;
    
public:
    InterfaceDecl(Identifier *name, List<Decl*> *members);

    DeclType get_decl_type() const override { return DeclType::Interface; }

    std::string get_label_prefix() const override { return "_" + id->get_name() + "."; }

    void Emit() override;
};


class FnDecl : public Decl {
protected:
    List<VarDecl*> *formals;
    Type *returnType;
    Stmt *body;
    
public:
    FnDecl(Identifier *name, Type *returnType, List<VarDecl*> *formals);

    void SetFunctionBody(Stmt *b);

    DeclType get_decl_type() const override { return DeclType::Function; }

    std::string get_label_prefix() const override {
        if (id->get_name() == "main") return "";
        else return "_";
    }

    std::string get_mips_label() const override;

    void Emit() override;
};

#endif
