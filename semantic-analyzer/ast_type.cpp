/* File: ast_type.cc
 * -----------------
 * Implementation of type node classes.
 */
#include "ast_type.h"
#include "ast_decl.h"
#include <string.h>
 
/* Class constants
 * ---------------
 * These are public constants for the built-in base types (int, double, etc.)
 * They can be accessed with the syntax Type::intType. This allows you to
 * directly access them and share the built-in types where needed rather that
 * creates lots of copies.
 */

Type *Type::intType    = new Type("int");
Type *Type::doubleType = new Type("double");
Type *Type::voidType   = new Type("void");
Type *Type::boolType   = new Type("bool");
Type *Type::nullType   = new Type("null");
Type *Type::stringType = new Type("string");
Type *Type::errorType  = new Type("error"); 

Type::Type(const char *n) {
    Assert(n);
    typeName = strdup(n);
}

void Type::check(Symbol_table<std::string, Node *> &sym_table) {

}


NamedType::NamedType(Identifier *i) : Type(*i->get_location()) {
    Assert(i != nullptr);
    (id = i)->set_parent(this);
}

void NamedType::check(Symbol_table<std::string, Node *> &sym_table) {

}


ArrayType::ArrayType(yyltype loc, Type *et) : Type(loc) {
    Assert(et != nullptr);
    (elemType = et)->set_parent(this);
}

void ArrayType::check(Symbol_table<std::string, Node *> &sym_table) {

}


