/* File: ast_type.h
 * ----------------
 * In our parse tree, Type nodes are used to represent and
 * store type information. The base Type class is used
 * for built-in types, the NamedType for classes and interfaces,
 * and the ArrayType for arrays of other types.  
 *
 * pp3: You will need to extend the Type classes to implement
 * the type system and rules for type equivalency and compatibility.
 */
 
#ifndef _H_ast_type
#define _H_ast_type

#include "ast.h"
#include "list.h"

#include <iostream>
#include <string>


class Type : public Node {
protected:
    char *typeName;

public:
    static Type *intType, *doubleType, *boolType, *voidType,
                *nullType, *stringType, *errorType;

    explicit Type(yyltype loc) : Node(loc) {}
    explicit Type(const char *str);

    friend std::ostream& operator<<(std::ostream& out, Type *t) { t->print_to(out); return out; }

    virtual void print_to(std::ostream &out) { out << typeName; }

    /// returns whether given type is printable or not
    bool is_printable() const;

    /// returns whether this type is equal to another type
    virtual bool is_equal_to(const Type *other) const;

    /// returns whether this type can perform arithmetic
    bool can_perform_arithmetic() const;

    /// returns whether this type can perform arithmetic with other type
    bool can_perform_arithmetic_with(const Type *other) const;

    /// returns whether this type can perform relational operations with another type (<, > <=, >=)
    bool can_perform_relational_with(const Type *other) const;

    /// returns whether this type can perform an equality operation with another type (==, !=)
    virtual bool can_perform_equality_with(const Type *other) const;

    /// returns whether this type can perform logic operations (||, !, &&)
    bool can_perform_logical() const;

    /// returns whether this type can perform logic operations with another type (||, !, &&)
    bool can_perform_logical_with(const Type *other) const;

    /// returns whether this type can get the other type assigned to it
    virtual bool can_perform_assignment_with(const Type *other) const;

    Type* type_check() override;
};


class NamedType : public Type {
protected:
    Identifier *id;
    
public:
    explicit NamedType(Identifier *i);
    
    void print_to(std::ostream &out) override { out << id; }

    Identifier * get_id() { return id; }

    /// returns whether two named types are equal to each other (same identifier)
    bool is_equal_to(const Type *other) const override;

    /// returns whether two named types can perform equality, i.e must be same type or one or both must be null
    bool can_perform_equality_with(const Type *other) const override;

    void check() override;

    Type* type_check() override;
};

class ArrayType : public Type {
protected:
    Type *elemType;

public:
    ArrayType(yyltype loc, Type *elemType);
    
    void print_to(std::ostream &out) override { out << elemType << "[]"; }

    bool is_equal_to(const Type *other) const override;

    void check() override;

    Type* type_check() override;
};

 
#endif
