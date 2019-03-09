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

bool Type::is_printable() {
    auto type = type_check();
    return type == intType || type == boolType || type == stringType || type == errorType;
}

bool Type::is_equal_to(Type *other) {
    if (other->is_array_type() || other->is_named_type()) {
        return other->is_equal_to(this);
    } else {
        return this == other || this == errorType || other == errorType;
    }
}

bool Type::can_perform_arithmetic()  {
    auto type = type_check();
    return type == intType || type == doubleType || type == errorType;
}

bool Type::can_perform_arithmetic_with(Type *other) {
    return can_perform_arithmetic() && is_equal_to(other);
}

bool Type::can_perform_relational_with(Type *other) {
    auto type = type_check();
    return (type == intType || type == doubleType || type == errorType) && is_equal_to(other);
}

bool Type::can_perform_equality_with(Type *other) {
    return is_equal_to(other);
}

bool Type::can_perform_logical() {
    auto type = type_check();
    return type == boolType || type == errorType;
}

bool Type::can_perform_logical_with(Type *other) {
    return can_perform_logical() && other->can_perform_logical();
}

bool Type::can_perform_assignment_with(Type *other) {
    return is_equal_to(other);
}

Type* Type::type_check() {
    return this;
}


NamedType::NamedType(Identifier *i) : Type(*i->get_location()) {
    Assert(i != nullptr);
    (id = i)->set_parent(this);
}

bool NamedType::is_equal_to(Type *other) {
    if (other == errorType) return true;
    if (other == nullType) return true;

    auto named_other = dynamic_cast<NamedType*>(other);
    if (!named_other) { return false; }
    return id->is_equal_to(named_other->id);
}

bool NamedType::can_perform_equality_with(Type *other) {
    return other == nullType || is_equal_to(other); // types must be same or comparing to null
}

void NamedType::check() {
    if (!id->is_defined()) {
        ReportError::identifier_not_found(id, Reason_e::LookingForType);
    } else {
        // need to make sure that the identifier is used for a class/interface decl
        auto decl = Sym_tbl_t::shared().get_declaration(id->get_name());
        if (decl->get_decl_type() != DeclType::Class && decl->get_decl_type() != DeclType::Interface) {
            ReportError::identifier_not_found(id, Reason_e::LookingForType);
        }
    }
}

Type* NamedType::type_check() {
    if (!id->is_defined()) {
        return Type::errorType;
    } else {
        // need to make sure that the identifier is used for a class/interface decl
        auto decl = Sym_tbl_t::shared().get_declaration(id->get_name());
        if (decl->get_decl_type() != DeclType::Class && decl->get_decl_type() != DeclType::Interface) {
            return Type::errorType;
        }
    }

    return Sym_tbl_t::shared().get_declaration(id->get_name())->type_check();
}


ArrayType::ArrayType(yyltype loc, Type *et) : Type(loc) {
    Assert(et != nullptr);
    (elemType = et)->set_parent(this);
}

bool ArrayType::is_equal_to(Type *other) {
    if (other == errorType) { return true; }

    auto array_other = dynamic_cast<ArrayType*>(other);
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
    return elemType;
}


