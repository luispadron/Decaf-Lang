/* File: ast_type.h
 * ----------------
 * In our parse tree, Type nodes are used to represent and
 * store type information. The base Type class is used
 * for built-in types, the NamedType for classes and interfaces,
 * and the ArrayType for arrays of other types.  
 */
 
#ifndef _H_ast_type
#define _H_ast_type

#include "ast.h"
#include "list.h"
#include <iostream>


class Type : public Node {
protected:
    char *typeName = nullptr;

public :
    static Type *intType, *doubleType, *boolType, *voidType,
                *nullType, *stringType, *errorType;

    explicit Type(yyltype loc) : Node(loc) {}
    explicit Type(const char *str);
    
    virtual void PrintToStream(std::ostream& out) { out << typeName; }
    friend std::ostream& operator<<(std::ostream& out, Type *t) { t->PrintToStream(out); return out; }
    virtual bool IsEquivalentTo(Type *other) { return this == other; }
    virtual bool IsArrayType() { return false; }
    virtual bool IsNamedType() { return false; }
    virtual bool IsCompatibleWith(Type *other);
    virtual bool IsNumeric() { return this == Type::intType || this == Type::doubleType; }
    virtual bool IsError() { return false;}
    virtual Type *LesserType(Type *other);
	 
     void Emit(CodeGenerator *cg) override {}
};

class NamedType : public Type {
protected:
    Identifier *id;
    Decl *declForType; // either class or inteface
    bool isError;
    
public:
    explicit NamedType(Identifier *i);
    
    void PrintToStream(std::ostream& out) override { out << id; }
    Decl *GetDeclForType();
    void SetDeclForType(Decl *decl);
    bool IsInterface();
    bool IsClass();
    Identifier *GetId() { return id; }
    bool IsEquivalentTo(Type *other) override;
    bool IsNamedType() override { return true; }
    bool IsCompatibleWith(Type *other) override;
    bool IsError() override { return isError;}

    void Check() override;
};

class ArrayType : public Type {
protected:
    Type *elemType;

public:
    ArrayType(yyltype loc, Type *elemType);
    
    void PrintToStream(std::ostream& out) override { out << elemType << "[]"; }
    bool IsEquivalentTo(Type *other) override;
    bool IsArrayType() override { return true; }
    bool IsError() override { return elemType->IsError(); }
    Type *GetArrayElemType() { return elemType; }

    void Check() override;
};

 
#endif
