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

    /// returns singleton instance
    static Symbol_table<Key, Value> & shared() {
        static Symbol_table<Key, Value> table = Symbol_table<Key, Value>();
        return table;
    }

    /// whether to print debug messages or not
    bool DEBUG_PRINT = true;

    /// cleans up any associated memory
    ~Symbol_table();

    /// pushes a new scope to the symbol table
    void push_scope(const std::string &debug_name);

    /// pushes a new class scope to the symbol table
    void push_class_scope(const std::string &key, const std::string &debug_name);

    /// pops the current scope to be the parent scope
    void pop_scope();

    /// inserts a symbol into the current scope
    /// if no scope exists, exception is thrown
    void insert_symbol(const Key& k, const Value& v);

    /// returns whether or not given symbol is defined in current scope (or parent scopes)
    bool is_symbol(const Key& k) const;

    /// returns whether or not the given symbol is defined in the given class scope
    bool is_symbol_in_class(const std::string &class_key, const Key& k) const;

    /// returns whether the current scope is within a class
    bool is_class_scope() const;

    /// returns the value of the symbol with given key
    /// if no such symbol exists, exception is thrown
    Value& get_symbol(const Key& k);

    /// returns the value of the symbol with given key in the given class scope
    Value& get_symbol_in_class(const std::string &class_key, const Key& k) const;

    /// prints the symbol table for debugging purposes
    void debug_print() const;

private:
    /// disallow creation
    Symbol_table() = default;

    /// the current scope were at
    Scope<Key, Value>* scope_ptr = nullptr;

    /// all possible scopes added to the symbol table, used to clean up memory, etc
    std::vector<Scope<Key, Value>*> scopes;

    /// the scopes relating to a class, organized by string, Scope
    std::map<std::string, Scope<Key, Value>*> class_scopes;
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
void Symbol_table<Key, Value>::push_scope(const std::string &debug_name) {
    auto new_scope = new Scope<Key, Value>(debug_name);
    new_scope->parent_ptr = scope_ptr;
    new_scope->super_ptr = scope_ptr ? scope_ptr->super_ptr : nullptr;
    new_scope->this_ptr = scope_ptr ? scope_ptr->this_ptr : nullptr;
    scopes.push_back(new_scope);
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { std::cout << "pushing scope: " << debug_name << std::endl; debug_print(); }
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::push_class_scope(const std::string &key, const std::string &debug_name) {
    auto new_scope = new Scope<Key, Value>(debug_name);
    new_scope->parent_ptr = scope_ptr;
    new_scope->this_ptr = new_scope;
    scopes.push_back(new_scope);
    class_scopes.insert({key, new_scope});
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { std::cout << "pushing class scope: " << debug_name << std::endl; debug_print(); }
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::pop_scope() {
    if (!scope_ptr) return;
    scope_ptr = scope_ptr->parent_ptr;

    if (DEBUG_PRINT) { std::cout << "popping scope " << scope_ptr->name << std::endl; debug_print(); }
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::insert_symbol(const Key& k, const Value& v) {
    if (!scope_ptr) {
        throw Symbol_table_exception{"error (Symbol_table::insert_symbol) no scopes available."};
    }

    scope_ptr->insert_symbol(k, v);

    if (DEBUG_PRINT) {
        std::cout << "inserting symbol '" << k << "' in scope: " << scope_ptr->name << std::endl;
        debug_print();
    }
}

template <typename Key, typename Value>
bool Symbol_table<Key, Value>::is_symbol(const Key &k) const {
    return scope_ptr->is_symbol(k);
}

template <typename Key, typename Value>
bool Symbol_table<Key, Value>::is_symbol_in_class(const std::string &class_key, const Key &k) const {
    auto class_scope_it = class_scopes.find(class_key);
    if (class_scope_it == class_scopes.end()) {
        return false;
    } else {
        return class_scope_it->second->is_symbol(k);
    }
}


template <typename Key, typename Value>
bool Symbol_table<Key, Value>::is_class_scope() const {
    return scope_ptr->this_ptr != nullptr;
}

template <typename Key, typename Value>
Value& Symbol_table<Key, Value>::get_symbol(const Key& k) {
    return scope_ptr->get_symbol(k);
}

template <typename Key, typename Value>
Value& Symbol_table<Key, Value>::get_symbol_in_class(const std::string &class_key, const Key &k) const {
    auto class_scope_it = class_scopes.find(class_key);
    if (class_scope_it == class_scopes.end()) {
        throw Symbol_table_exception("error: cant get symbol in class, no class with given key");
    }

    return class_scope_it->second->get_symbol(k);
}

template <typename Key, typename Value>
void Symbol_table<Key, Value>::debug_print() const {
    scope_ptr->debug_print();
}


#endif // SYMBOLTABLE_SYMBOLTABLE_H
