//
// Created by Luis on 2019-02-27.
//

#ifndef SYMBOLTABLE_SYMBOLTABLE_H
#define SYMBOLTABLE_SYMBOLTABLE_H

#include "Scope.h"

#include <iostream>
#include <vector>

/**
 * Symbol_table
 *
 * Represents a "spaghetti" style symbol table for a programming language,
 * where every scope has pointer to the parent scope.
 *
 * A scope is simply a mapping of identifier (key) to value.
 */
class Symbol_table {
public:

    /// returns singleton instance
    static Symbol_table & shared() {
        static Symbol_table table = Symbol_table();
        return table;
    }

    /// whether to print debug messages or not
    bool DEBUG_PRINT = false;

    /// cleans up any associated memory
    ~Symbol_table();

    /// pushes a new scope to the symbol table
    void enter_scope(const std::string &debug_name);

    /// pushes a new class scope to the symbol table
    void enter_class_scope(const std::string &key, const std::string &debug_name);

    /// pops the current scope to be the parent scope
    void leave_scope();

    /// inserts a symbol into the current scope
    /// if no scope exists, exception is thrown
    void insert_symbol(const std::string& k, Type* v);

    /// returns whether or not given symbol is defined in current scope (or parent scopes)
    bool is_symbol(const std::string& k) const;

    /// returns whether or not the given symbol is defined in the given class scope
    bool is_symbol_in_class(const std::string &class_key, const std::string& k) const;

    /// returns whether the current scope is within a class
    bool is_class_scope() const;

    /// returns the value of the symbol with given key
    /// if no such symbol exists, exception is thrown
    Type* get_symbol(const std::string& k);

    /// returns the value of the symbol with given key in the given class scope
    Type* get_symbol_in_class(const std::string &class_key, const std::string& k) const;

    /// prints the symbol table for debugging purposes
    void debug_print() const;

private:
    /// disallow creation
    Symbol_table() = default;

    /// the current scope were at
    Scope* scope_ptr = nullptr;

    /// all possible scopes added to the symbol table, used to clean up memory, etc
    std::vector<Scope*> scopes;

    /// the scopes relating to a class, organized by string, Scope
    std::map<std::string, Scope*> class_scopes;
};


#endif // SYMBOLTABLE_SYMBOLTABLE_H
