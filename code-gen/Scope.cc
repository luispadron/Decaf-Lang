//
// Created by Luis on 2019-03-16.
//

#include "Scope.h"

using namespace std;

bool Scope::insert_decl(const string &name, Decl *decl) {
    if (symbols.find(name) != symbols.end()) {
        return false;
    }

    symbols.insert({name, decl});
    return true;
}


pair<Decl*, bool> Scope::get_decl(const string &name) const {
    // first search current scope
    for (auto scope = this; scope; scope = scope->parent_ptr) {
        auto it = scope->symbols.find(name);
        if (it != scope->symbols.end()) {
            return make_pair(it->second, true);
        }
    }

    // search "this" scope
    if (this_ptr) {
        auto this_it = this_ptr->symbols.find(name);
        if (this_it != this_ptr->symbols.end()) {
            return make_pair(this_it->second, true);
        }
    }

    // search "super" scope
    if (this_ptr && this_ptr->super_ptr) {
        auto super_it = this_ptr->super_ptr->symbols.find(name);
        if (super_it != this_ptr->super_ptr->symbols.end()) {
            return make_pair(super_it->second, true);
        }
    }

    return make_pair(nullptr, false); // not found
}