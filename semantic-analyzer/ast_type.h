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
    std::string typeName;

public:
    static Type *intType, *doubleType, *boolType, *voidType,
                *nullType, *stringType, *errorType;

    explicit Type(yyltype loc) : Node(loc) {}
    explicit Type(const char *str);

    friend std::ostream& operator<<(std::ostream& out, Type *t) { t->print_to(out); return out; }

    virtual void print_to(std::ostream &out) { out << typeName; }

    /// returns whether this type is equal to another type
    virtual bool is_equal_to(const Type *other) const {
        return this == other;
    }

    /// returns whether this type can perform arithmetic
    virtual bool can_perform_arithmetic() const {
        return this == intType || this == doubleType;
    }

    /// returns whether this type can perform arithmetic with other type
    virtual bool can_perform_arithmetic_with(const Type *other) const {
        return can_perform_arithmetic() && is_equal_to(other);
    }

    /// returns whether this type can perform relational operations with another type (<, > <=, >=)
    virtual bool can_perform_relational_with(const Type *other) const {
        return (this == intType || this == doubleType) && is_equal_to(other);
    }

    /// returns whether this type can perform an equality operation with another type (==, !=)
    virtual bool can_perform_equality_with(const Type *other) const {
        return is_equal_to(other);
    }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};


class NamedType : public Type {
protected:
    Identifier *id;
    
public:
    explicit NamedType(Identifier *i);
    
    void print_to(std::ostream &out) override { out << id; }

    const char * get_name() const { return id->get_name(); }

    /// returns whether two named types are equal to each other (same identifier)
    bool is_equal_to(const Type *other) const override {
        auto named_other = dynamic_cast<const NamedType*>(other);
        if (!named_other) { return false; }
        return id == named_other->id;
    }

    bool can_perform_equality_with(const Type *other) const override {
        return other == nullType || is_equal_to(other); // types must be same or comparing to null
    }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

class ArrayType : public Type {
protected:
    Type *elemType;

public:
    ArrayType(yyltype loc, Type *elemType);
    
    void print_to(std::ostream &out) override { out << elemType << "[]"; }

    bool is_equal_to(const Type *other) const override {
        auto array_other = dynamic_cast<const ArrayType*>(other);
        if (!array_other) { return false; }
        return elemType->is_equal_to(array_other->elemType);
    }

    bool can_perform_equality_with(const Type *other) const override {
        return is_equal_to(other); // array types must match
    }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

 
#endif
