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
#include "Vtable.h"

class Identifier;
class Stmt;
class Expr;
class Call;
class FnDecl;

/// Declares the different types of decls
enum class DeclType { Variable, Class, Function, Interface };

class Decl : public Node {
protected:
    Type *type;
    Identifier *id;
  
public:

    explicit Decl(Identifier *name);
    friend std::ostream& operator<<(std::ostream& out, Decl *d) { return out << d->id; }

    /// returns the id of a decl
    Identifier * get_id() { return id; }

    /// returns the type of a decl
    virtual DeclType get_decl_type() const = 0;

    /// returns the byte size of a decl
    virtual int get_bytes() const { return 0; }

    /// returns the type of a decl
    Type* type_check() override;

    /// runs semantic checking on a decl
    virtual void check(Scope *class_or_interface_scope) = 0;

    /// generates code for a decl
    virtual void emit(Scope *class_or_interface_scope, FnDecl *curr_func) { }
};


class VarDecl : public Decl {
private:
    Location *location = nullptr;
    bool is_member = false;

public:
    VarDecl(Identifier *name, Type *type);

    DeclType get_decl_type() const override { return DeclType::Variable; }

    int get_bytes() const override { return Cgen_t::word_size; }

    /// returns the memory location of this variable
    Location * get_location() const { return location; }

    /// sets the memory location of this variable
    void set_location(Location *new_loc) { location = new_loc; }

    void set_is_member(bool member) { is_member = member; }

    bool is_member_var() const { return is_member; }

    void check(Scope *class_or_interface_scope) override;
};


class FnDecl : public Decl {
protected:
    List<VarDecl*> *formals;
    Type *returnType;
    Stmt *body;

    bool is_method = false;

public:
    FnDecl(Identifier *name, Type *returnType, List<VarDecl*> *formals);

    void set_function_body(Stmt *b);

    DeclType get_decl_type() const override { return DeclType::Function; }

    bool has_return() const { return !returnType->is_equal_to(Type::voidType); }

    /// returns the mangled function name
    /// if in class/interface: _Class/Interface.FunctionName
    /// if global: _FunctionName
    std::string get_mangled_name(const std::string &class_or_interface_name) const;

    void check(Scope *class_or_interface_scope) override;

    void emit(Scope *class_or_interface_scope, FnDecl *curr_func) override;

    void set_is_method(bool method) { is_method = method; }

    bool is_method_func() const { return is_method; }
};


class InterfaceDecl : public Decl {
protected:
    List<Decl*> *members;
    
public:
    InterfaceDecl(Identifier *name, List<Decl*> *members);

    DeclType get_decl_type() const override { return DeclType::Interface; }

    void check(Scope *class_or_interface_scope) override;
};

class ClassDecl : public Decl {
protected:
    int bytes;
    int parent_bytes = 0;
    List<Decl*> *members;
    NamedType *extends;
    List<NamedType*> *implements;
    Vtable vtable;

public:

    friend class Vtable;

    ClassDecl(Identifier *name, NamedType *extends,
              List<NamedType*> *implements, List<Decl*> *members);

    DeclType get_decl_type() const override { return DeclType::Class; }

    int get_bytes() const override {
        return bytes + parent_bytes;
    }

    NamedType * get_extends() const { return extends; }

    int get_method_offset(const std::string &name) const;

    int get_member_offset(const std::string &name) const;

    void check(Scope *class_or_interface_scope) override;

    void prepare_for_emit();

    void emit(Scope *class_or_interface_scope, FnDecl *curr_func) override;
};

#endif
