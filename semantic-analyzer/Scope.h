//
// Created by Luis on 2019-02-27.
//

#ifndef SYMBOLTABLE_SCOPE_H
#define SYMBOLTABLE_SCOPE_H

#include "Symbol_table_exception.h"

#include <iostream>
#include <map>
#include <stack>
#include <string>
#include <strstream>

// forward declare Symbol_table
template<typename K, typename V>
class Symbol_table;

/**
 * Scope
 *
 * This class defines what a scope looks like.
 *
 * A scope is made up of identifier (key) -> value definitions.
 * Scopes have pointers to their parent scope, as well as "super" and "this" for OOP languages.
 * @tparam Key
 * @tparam Value
 */
template<typename Key, typename Value>
class Scope {

public:
    /// declares Symbol_table class as a friend
    friend class Symbol_table<Key, Value>;

    /// inserts a new entry this scope
    /// if symbol with given key already exists, exception is thrown
    void insert_symbol(const Key& k, const Value& v);

    /// returns whether or not the given symbol is in the given scope
    /// searches this scope and any parent scopes that are above this scope
    bool is_symbol(const Key& k) const;

    /// returns the first value for given key in this scope or any parent scope
    /// if does not exist, exception is thrown
    Value& get_symbol(const Key& k);

    /// prints a representation of this current scope and any of its parent scopes
    void debug_print() const;

private:

    /// typedef for map of symbols
    using Symbols = std::map<Key, Value>;

    /// typedef for iterator of symbol type
    using Symbol_iter = typename std::map<Key, Value>::iterator;

    /// the symbols this scope knows about
    Symbols symbols;

    /// the parent scope of this current scope
    Scope* parent_ptr;

    /// the scope of the "super" class, only applies to classes
    Scope* super_ptr;

    /// the scope of the "this" class, only applies to classes
    Scope* this_ptr;

    // helper functions //

    Symbol_iter get_symbol_iter(const Key &k);
};


////////////// Implementation //////////////


template <typename Key, typename Value>
void Scope<Key, Value>::insert_symbol(const Key &k, const Value &v) {
    auto it = symbols.find(k);

    if (it != symbols.end()) {
        throw Symbol_table_exception{"error (insert_symbol) called with duplicate key"};
    } else {
        symbols.insert({k, v});
    }
}

template <typename Key, typename Value>
bool Scope<Key, Value>::is_symbol(const Key &k) const {
    return get_symbol_iter(k) != symbols.end();
}

template <typename Key, typename Value>
Value& Scope<Key, Value>::get_symbol(const Key &k) {
    auto it = get_symbol_iter(k);

    if (it == symbols.end()) {
        throw Symbol_table_exception{"error (get_symbol) no symbol exists for given key"};
    }

    return it->second;
}

template <typename Key, typename Value>
typename Scope<Key, Value>::Symbol_iter Scope<Key, Value>::get_symbol_iter(const Key &k) {
    auto scope_ptr = this;
    for (; scope_ptr; scope_ptr = scope_ptr->parent_ptr) {
        auto it = scope_ptr->symbols.find();
        if (it != scope_ptr->symbols.end()) {
            return it;
        }
    }

    return symbols.end();
}

template <typename Key, typename Value>
void Scope<Key, Value>::debug_print() const {
    auto scope_ptr = this;
    std::stack<std::string> pstack; // used to print in reverse since we go current->parent

    for (; scope_ptr; scope_ptr = scope_ptr->parent_ptr) {
        std::strstream ss;
        ss << "----------- Scope -----------" << std::endl;
        for (auto symbol : scope_ptr->symbols) {
            ss << symbol.first << "\t|\t" << symbol.second << std::endl;
        }

        ss << std::endl;
        pstack.push(ss.str());
    }

    // print in reverse, thus prints in the current order from root->children
    for (; !pstack.empty(); pstack.pop()) {
        std::cout << pstack.top();
    }
}

#endif //SYMBOLTABLE_SCOPE_H
