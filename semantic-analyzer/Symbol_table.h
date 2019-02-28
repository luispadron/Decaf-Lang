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
 *
 * Scopes can be added or removed while traversing the program using `pop_scope` and `push_scope`.
 * @tparam Key
 * @tparam Value
 */
template <typename Key, typename Value>
class Symbol_table {
public:

    /// whether to print debug messages or not
    bool DEBUG_PRINT = false;

    /// cleans up any associated memory
    ~Symbol_table();

    /// pushes a new scope to the symbol table
    void push_scope(const std::string &name);

    /// pops the current scope to be the parent scope
    void pop_scope();

    /// inserts a symbol into the current scope
    /// if no scope exists, exception is thrown
    void insert_symbol(const Key& k, const Value& v);

    /// returns whether or not given symbol is defined in current scope (or parent scopes)
    bool is_symbol(const Key& k) const;

    /// returns the value of the symbol with given key
    /// if no such symbol exists, exception is thrown
    Value& get_symbol(const Key& k);

    /// prints the symbol table for debugging purposes
    void debug_print() const;

private:
    /// the current scope were at
    Scope<Key, Value>* scope_ptr = nullptr;

    /// all possible scopes added to the symbol table, used to clean up memory, etc
    std::vector<Scope<Key, Value>*> scopes;
};


/////////////// Implementation ///////////////

template <typename Key, typename Value>
Symbol_table<Key, Value>::~Symbol_table() {
    if (DEBUG_PRINT) { std::cout << "destroying table" << std::endl; }
    // delete all scopes
    for (auto scope : scopes) {
        delete scope;
    }
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::push_scope(const std::string &name) {
    if (DEBUG_PRINT) { std::cout << "pushing scope: " << name << std::endl; }

    auto new_scope = new Scope<Key, Value>(name);
    new_scope->parent_ptr = scope_ptr;
    scopes.push_back(new_scope);
    scope_ptr = new_scope;
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::pop_scope() {
    if (DEBUG_PRINT) { std::cout << "popping scope " << scope_ptr->name << std::endl; }

    if (!scope_ptr) return;
    scope_ptr = scope_ptr->parent_ptr;
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::insert_symbol(const Key& k, const Value& v) {
    if (DEBUG_PRINT) {
        std::cout << "inserting symbol '" << k << "' in scope: " << scope_ptr->name << std::endl;
    }

    if (!scope_ptr) {
        throw Symbol_table_exception{"error (Symbol_table::insert_symbol) no scopes available."};
    }

    scope_ptr->insert_symbol(k, v);
}

template <typename Key, typename Value>
bool Symbol_table<Key, Value>::is_symbol(const Key &k) const {
    return scope_ptr->is_symbol(k);
}

template <typename Key, typename Value>
Value& Symbol_table<Key, Value>::get_symbol(const Key& k) {
    return scope_ptr->get_symbol(k);
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::debug_print() const {
    scope_ptr->debug_print();
}


#endif // SYMBOLTABLE_SYMBOLTABLE_H
