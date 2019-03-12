//
// Created by Luis on 2019-02-27.
//

#ifndef SYMBOLTABLE_SCOPE_H
#define SYMBOLTABLE_SCOPE_H

#include "Symbol_table_exception.h"

#include <iostream>
#include <map>
#include <string>
#include <sstream>
#include <vector>

// forward declare Symbol_table and Type
class Symbol_table;
class Decl;

/**
 * Scope
 *
 * This class defines what a scope looks like.
 *
 * A scope is made up of identifier (key) -> value definitions.
 * Scopes have pointers to their parent scope, as well as "super" and "this" for OOP languages.
 */
class Scope {

public:

    /// constructs a scope with no name
    Scope() = default;

    /// constructs a scope with a name
    explicit Scope(std::string name_) : name{name_} { }

    /// declares Symbol_table class as a friend
    friend class Symbol_table;

    /// inserts a new entry this scope
    /// if symbol with given key already exists, exception is thrown
    void insert_symbol(const std::string &k, Decl *decl);

    /// returns whether or not the given symbol is in the given scope
    /// searches this scope and any parent scopes that are above this scope
    bool is_declared(const std::string &k);

    /// returns the first value for given key in this scope or any parent scope
    /// if does not exist, exception is thrown
    Decl * get_declaration(const std::string &k);

    /// prints a representation of this current scope and any of its parent scopes
    void debug_print() const;

private:

    /// typedef for map of symbols
    using Symbols = std::map<std::string, Decl*>;

    /// typedef for iterator of symbol type
    using Symbol_iter = typename std::map<std::string, Decl*>::iterator;

    /// the name of the scope
    std::string name;

    /// the symbols this scope knows about
    Symbols symbols;

    /// the parent scope of this current scope
    Scope* parent_ptr = nullptr;

    /// the scope of the "super" class, only applies to classes
    Scope* super_ptr = nullptr;

    /// the scope of the "this" class, only applies to classes
    Scope* this_ptr = nullptr;

    /// collection of pointers to interfaces, only applies to classes
    std::vector<Scope*> interfaces;

    // helper functions //

    Symbol_iter get_symbol_iter(const std::string &k);

    void insert_symbol_in_class(const std::string &k, Decl *decl);
};

#endif //SYMBOLTABLE_SCOPE_H
