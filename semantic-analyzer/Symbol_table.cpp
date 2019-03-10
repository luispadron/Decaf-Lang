#include "Symbol_table.h"

#include <algorithm>

using namespace std;

/////////////// Implementation ///////////////

Symbol_table::~Symbol_table() {
    if (DEBUG_PRINT) { cout << "destroying table" << endl; }
    // delete all scopes
    for (auto scope : scopes) {
        delete scope;
    }
}

void Symbol_table::enter_scope(const string &debug_name) {
    auto new_scope = new Scope(debug_name);
    new_scope->parent_ptr = scope_ptr;
    new_scope->super_ptr = scope_ptr ? scope_ptr->super_ptr : nullptr;
    new_scope->this_ptr = scope_ptr ? scope_ptr->this_ptr : nullptr;
    scopes.push_back(new_scope);
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { cout << "pushing scope: " << debug_name << endl; debug_print(); }
}

void Symbol_table::enter_class_scope(const string &key) {
    auto new_scope = new Scope(key);
    new_scope->parent_ptr = scope_ptr;
    new_scope->this_ptr = new_scope;
    scopes.push_back(new_scope);
    class_scopes.insert({key, new_scope});
    scope_ptr = new_scope;

    // add to inheritance table
    inheritance_tbl.insert({key, {}});

    if (DEBUG_PRINT) { cout << "pushing class scope: " << key << endl; debug_print(); }
}

void Symbol_table::set_super_class(const string &super_class_key) {
    if (!is_class_scope()) { throw Symbol_table_exception("error: not in class scope, cannot set super"); }

    // find the scope of the super class with given key
    auto class_it = class_scopes.find(super_class_key);
    if (class_it == class_scopes.end()) {
        throw Symbol_table_exception("error: cannot set super class, no class exists.");
    }

    scope_ptr->super_ptr = class_it->second;

    // also update inheritance table
    auto inh_it = inheritance_tbl.find(scope_ptr->name);
    if (inh_it == inheritance_tbl.end()) {
        throw Symbol_table_exception("error: could not update inheritance table");
    }

    inh_it->second.push_back(super_class_key);
}

void Symbol_table::set_interface(const std::string &interface_key) {
    if (!is_class_scope()) { throw Symbol_table_exception("error: not in class scope, cannot set interface"); }

    // find the scope of the super class with given key
    if (!is_declared(interface_key)) { throw Symbol_table_exception("error: cannot set interface, it's not declared"); }

    // update inheritance table
    auto inh_it = inheritance_tbl.find(scope_ptr->name);
    if (inh_it == inheritance_tbl.end()) {
        throw Symbol_table_exception("error: could not update inheritance table");
    }

    inh_it->second.push_back(interface_key);
}

void Symbol_table::leave_scope() {
    if (!scope_ptr) return;
    scope_ptr = scope_ptr->parent_ptr;

    if (DEBUG_PRINT) { cout << "popping scope " << scope_ptr->name << endl; debug_print(); }
}

void Symbol_table::insert_declaration(const string &k, Decl *d) {
    if (!scope_ptr) {
        throw Symbol_table_exception{"error (Symbol_table::insert_symbol) no scopes available."};
    }

    scope_ptr->insert_symbol(k, d);

    if (DEBUG_PRINT) {
        cout << "inserting symbol '" << k << "' in scope: " << scope_ptr->name << endl;
        debug_print();
    }
}

bool Symbol_table::is_declared(const string &k) const {
    return scope_ptr->is_declared(k);
}

bool Symbol_table::is_declared_in_class(const string &class_key, const string &k) const {
    auto class_scope_it = class_scopes.find(class_key);
    if (class_scope_it == class_scopes.end()) {
        return false;
    } else {
        return class_scope_it->second->is_declared(k);
    }
}

bool Symbol_table::is_class_scope() const {
    return scope_ptr->this_ptr != nullptr;
}

bool Symbol_table::inherits_from(const std::string &child, const std::string &parent) const {
    auto inh_it = inheritance_tbl.find(child);
    if (inh_it == inheritance_tbl.end()) {
        return false;
    } else {
        return find(inh_it->second.begin(), inh_it->second.end(), parent) != inh_it->second.end();
    }
}

Decl * Symbol_table::get_declaration(const string &k) {
    return scope_ptr->get_declaration(k);
}

Decl * Symbol_table::get_declaration_in_class(const string &class_key, const string &k) const {
    auto class_scope_it = class_scopes.find(class_key);
    if (class_scope_it == class_scopes.end()) {
        throw Symbol_table_exception("error: cant get symbol in class, no class with given key");
    }

    return class_scope_it->second->get_declaration(k);
}

const string& Symbol_table::get_class_scope_name() const {
    if (!is_class_scope()) { throw Symbol_table_exception("error: cant get class scope name, not in class scope"); }
    return scope_ptr->this_ptr->name;
}

void Symbol_table::debug_print() const {
    scope_ptr->debug_print();
    
    // print out inheritance table
    
    cout << "=== Inheritance table ===" << endl;
    for (const auto &kv : inheritance_tbl) {
        if (!kv.second.empty()) {
            cout << kv.first << " inherits from: " << endl;
        } else {
            cout << kv.first << " inherits from: nothing" << endl;
        }

        for (const auto &super_class : kv.second) {
            cout << "\t" << super_class << endl;
        }
    }
}