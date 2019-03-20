//
// Created by Luis on 2019-03-16.
//

#include <cassert>
#include <stack>
#include <iostream>

#include "SymbolTable.h"

using namespace std;

SymbolTable::~SymbolTable() {
    for (const auto &scope_it : scopes) {
        delete scope_it.second;
    }
}

Scope * SymbolTable::create_scope(const string &name, ScopeType type) {
    if (scopes.find(name) != scopes.end()) {
        assert(false);
        return nullptr;
    }

    auto new_scope = new Scope(name, type);
    new_scope->parent_ptr = scope_ptr;

    if (type == ScopeType::Class || type == ScopeType::Interface) {
        new_scope->this_ptr = new_scope;
    } else {
        new_scope->this_ptr = scope_ptr ? scope_ptr->this_ptr : nullptr;
    }

    new_scope->super_ptr = scope_ptr ? scope_ptr->super_ptr : nullptr;
    scope_ptr = new_scope;

    scopes.insert({name, new_scope});

    return new_scope;
}

Scope * SymbolTable::enter_scope(const std::string &name) {
    auto scope_it = scopes.find(name);
    if (scope_it != scopes.end()) {
        return scope_it->second;
    } else {
        assert(false);
        return nullptr;
    }
}

bool SymbolTable::leave_scope() {
    if (!scope_ptr) return false;

    scope_ptr = scope_ptr->parent_ptr;
    return true;
}

Scope* SymbolTable::get_scope() const {
    return scope_ptr;
}

pair<Scope*, bool> SymbolTable::get_scope(const std::string &name) const {
    auto it = scopes.find(name);
    if (it != scopes.end()) return make_pair(it->second, true);
    return make_pair(nullptr, false);
}

void SymbolTable::debug_print() const {
    #if DEBUG==1
    for (const auto &scope : scopes) {
        cout << "----- " << scope.first << " -----" << endl;
        for (const auto &sym : scope.second->symbols) {
            cout << sym.first << endl;
        }
    }
    cout << "------------------------------------" << endl;
    #endif
}