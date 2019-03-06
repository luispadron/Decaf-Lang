/* File: ast_type.cc
 * -----------------
 * Implementation of type node classes.
 */
#include "ast_type.h"
#include "ast_decl.h"
#include "errors.h"

#include <cstring>
 
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

bool Type::is_printable() const {
    return this == intType || this == boolType || this == stringType;
}

bool Type::is_equal_to(const Type *other) const {
    return this == other;
}

bool Type::can_perform_arithmetic() const {
    return this == intType || this == doubleType;
}

bool Type::can_perform_arithmetic_with(const Type *other) const {
    return can_perform_arithmetic() && is_equal_to(other);
}

bool Type::can_perform_relational_with(const Type *other) const {
    return (this == intType || this == doubleType) && is_equal_to(other);
}

bool Type::can_perform_equality_with(const Type *other) const {
    return is_equal_to(other);
}

bool Type::can_perform_logical() const {
    return this == boolType;
}

bool Type::can_perform_logical_with(const Type *other) const {
    return this == boolType && other == boolType;
}

bool Type::can_perform_assignment_with(const Type *other) const {
    return is_equal_to(other);
}

bool Type::check() {
    return true; // since all fundamental types are defined
}


NamedType::NamedType(Identifier *i) : Type(*i->get_location()) {
    Assert(i != nullptr);
    (id = i)->set_parent(this);
}

bool NamedType::is_equal_to(const Type *other) const {
    auto named_other = dynamic_cast<const NamedType*>(other);
    if (!named_other) { return false; }
    return std::strcmp(id->get_str(), named_other->id->get_str()) == 0;
}

bool NamedType::can_perform_equality_with(const Type *other) const {
    return other == nullType || is_equal_to(other); // types must be same or comparing to null
}

bool NamedType::check() {
    return Sym_table_t::shared().is_symbol(id->get_str());
}


ArrayType::ArrayType(yyltype loc, Type *et) : Type(loc) {
    Assert(et != nullptr);
    (elemType = et)->set_parent(this);
}

bool ArrayType::is_equal_to(const Type *other) const {
    auto array_other = dynamic_cast<const ArrayType*>(other);
    if (!array_other) { return false; }
    return elemType->is_equal_to(array_other->elemType);
}

bool ArrayType::can_perform_assignment_with(const Type *other) const {
    // the element type and rhs type must be equal
    auto array_type = dynamic_cast<const ArrayType*>(other);
    if (array_type) {
        return elemType->is_equal_to(array_type->elemType);
    } else {
        return elemType->is_equal_to(other);
    }
}

bool ArrayType::check() {
    return elemType->check();
}


