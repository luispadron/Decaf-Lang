//
// Created by Luis on 2019-03-16.
//

#include "SymbolTable.h"

using namespace std;

bool SymbolTable::enter_scope(const string &name, ScopeType type) {

    // create the scope names
    string scope_name;
    if (type == ScopeType::Block) {
        scope_name = scope_ptr->parent_ptr->name_ + "_" + name + to_string(scope_ptr->parent_ptr->block_counter++);
    } else if (scope_ptr->this_ptr) {
        scope_name = scope_ptr->this_ptr->name_ + "_" + name;
    }

    if (scopes.find(scope_name) != scopes.end()) {
        return false;
    }

    auto new_scope = new Scope(scope_name, type);
    new_scope->parent_ptr = scope_ptr;
    new_scope->this_ptr = scope_ptr->this_ptr;
    new_scope->super_ptr = scope_ptr->super_ptr;

    return true;
}

bool SymbolTable::leave_scope(const std::string &name, ScopeType type) {
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