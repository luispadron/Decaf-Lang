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
    return this == intType || this == boolType || this == stringType || this == errorType;
}

bool Type::is_equal_to(const Type *other) const {
    return this == other || other == errorType;
}

bool Type::can_perform_arithmetic() const {
    return this == intType || this == doubleType || this == errorType;
}

bool Type::can_perform_arithmetic_with(const Type *other) const {
    return can_perform_arithmetic() && is_equal_to(other);
}

bool Type::can_perform_relational_with(const Type *other) const {
    return (this == intType || this == doubleType || this == errorType) && is_equal_to(other);
}

bool Type::can_perform_equality_with(const Type *other) const {
    return is_equal_to(other);
}

bool Type::can_perform_logical() const {
    return this == boolType || this == errorType;
}

bool Type::can_perform_logical_with(const Type *other) const {
    return can_perform_logical() && other->can_perform_logical();
}

bool Type::can_perform_assignment_with(const Type *other) const {
    return is_equal_to(other);
}

Type* Type::type_check() {
    return this;
}


NamedType::NamedType(Identifier *i) : Type(*i->get_location()) {
    Assert(i != nullptr);
    (id = i)->set_parent(this);
}

bool NamedType::is_equal_to(const Type *other) const {
    if (other == errorType) return true;

    auto named_other = dynamic_cast<const NamedType*>(other);
    if (!named_other) { return false; }
    return std::strcmp(id->get_name(), named_other->id->get_name()) == 0;
}

bool NamedType::can_perform_equality_with(const Type *other) const {
    return other == nullType || is_equal_to(other); // types must be same or comparing to null
}

void NamedType::check() {
    if (!id->is_defined()) {
        ReportError::identifier_not_found(id, Reason_e::LookingForType);
    }
}

Type* NamedType::type_check() {
    // if id is in sym table, return that otherwise, errorType
    if (!id->is_defined()) {
        return Type::errorType;
    } else {
        return Sym_tbl_t::shared().get_symbol(id->get_name());
    }
}


ArrayType::ArrayType(yyltype loc, Type *et) : Type(loc) {
    Assert(et != nullptr);
    (elemType = et)->set_parent(this);
}

bool ArrayType::is_equal_to(const Type *other) const {
    if (other == errorType) { return true; }

    auto array_other = dynamic_cast<const ArrayType*>(other);
    if (!array_other) {
        return elemType->is_equal_to(other);
    } else {
        return elemType->is_equal_to(array_other->elemType);
    }
}

void ArrayType::check() {
    elemType->check();
}

Type* ArrayType::type_check() {
    return elemType->type_check();
}


