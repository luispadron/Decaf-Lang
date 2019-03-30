//
// Created by Luis on 2019-03-16.
//

#include "Scope.h"
#include "ast_decl.h"

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

pair<int, bool> Scope::get_decl_position(const std::string &name) const {
    auto res = super_ptr ? super_ptr->get_decl_position(name) : make_pair(1, false);
    if (res.second) return res;

    int pos = res.first;

    for (const auto &symbol : symbols) {
        if (symbol.second->get_decl_type() == DeclType::Variable) {
            if (symbol.first == name) {
                return make_pair(pos, true);
            } else {
                ++pos;
            }
        }
    }

    return make_pair(pos, false);
}