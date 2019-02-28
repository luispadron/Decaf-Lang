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

    virtual bool is_equal_to(Type *other) { return this == other; }

    /// returns whether type is either int or double, since these are the only
    /// types that can perform arithmetic operations
    bool is_arithmetic() const { return this == intType || this == doubleType; }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};


class NamedType : public Type {
protected:
    Identifier *id;
    
public:
    explicit NamedType(Identifier *i);
    
    void print_to(std::ostream &out) override { out << id; }

    bool is_equal_to(Type *other) override {
        auto named_other = dynamic_cast<NamedType*>(other);
        if (!named_other) { return false; }
        return id == named_other->id;
    }

    const char * get_name() const { return id->get_name(); }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

class ArrayType : public Type {
protected:
    Type *elemType;

public:
    ArrayType(yyltype loc, Type *elemType);
    
    void print_to(std::ostream &out) override { out << elemType << "[]"; }

    bool is_equal_to(Type *other) override {
        auto array_other = dynamic_cast<ArrayType*>(other);
        if (!array_other) { return false; }
        return elemType->is_equal_to(array_other->elemType);
    }

    void check(Symbol_table<std::string, Node *> &sym_table) override;
};

 
#endif
