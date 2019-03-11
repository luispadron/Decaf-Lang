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

void Symbol_table::enter_scope(const string &scope_name) {
    auto new_scope = new Scope(scope_name);
    new_scope->parent_ptr = scope_ptr;
    new_scope->super_ptr = scope_ptr ? scope_ptr->super_ptr : nullptr;
    new_scope->this_ptr = scope_ptr ? scope_ptr->this_ptr : nullptr;
    scopes.push_back(new_scope);
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { cout << "pushing scope: " << scope_name << endl; debug_print(); }
}

void Symbol_table::enter_class_scope(const string &key) {
    auto new_scope = new Scope(key);
    new_scope->parent_ptr = scope_ptr;
    new_scope->this_ptr = new_scope;
    scopes.push_back(new_scope);
    class_scopes.insert({key, new_scope});
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { cout << "pushing class scope: " << key << endl; debug_print(); }
}

void Symbol_table::enter_interface_scope(const std::string &key) {
    auto new_scope = new Scope(key);
    new_scope->parent_ptr = scope_ptr;
    scopes.push_back(new_scope);
    interface_scopes.insert({key, new_scope});
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { cout << "pushing interface scope: " << key << endl; debug_print(); }
}

void Symbol_table::set_super_class(const string &super_class_key) {
    if (!is_class_scope()) { throw Symbol_table_exception("error: not in class scope, cannot set super"); }

    // find the scope of the super class with given key
    auto class_it = class_scopes.find(super_class_key);
    if (class_it == class_scopes.end()) {
        throw Symbol_table_exception("error: cannot set super class, no class exists.");
    }

    scope_ptr->super_ptr = class_it->second;
}

void Symbol_table::set_interface(const std::string &interface_key) {
    if (!is_class_scope()) { throw Symbol_table_exception("error: not in class scope, cannot set interface"); }

    // find the scope of the interface with given key
    auto intf_scope = interface_scopes.find(interface_key);
    if (intf_scope == interface_scopes.end()) {
        throw Symbol_table_exception("error: could not set interface, no interface found for given key");
    }

    scope_ptr->interfaces.push_back(intf_scope->second);
}

void Symbol_table::leave_scope() {
    if (DEBUG_PRINT) { cout << "popping scope " << scope_ptr->name << endl; debug_print(); }

    if (!scope_ptr) return;
    scope_ptr = scope_ptr->parent_ptr;
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

bool Symbol_table::is_declared_in_scope(const string &scope_name, const string &k) const {
    auto class_scope_it = class_scopes.find(scope_name);
    auto interface_scope_it = interface_scopes.find(scope_name);
    if (class_scope_it == class_scopes.end()) {
        if (interface_scope_it == interface_scopes.end()) {
            return false;
        } else {
            return interface_scope_it->second->is_declared(k);
        }
    } else {
        return class_scope_it->second->is_declared(k);
    }
}

bool Symbol_table::is_class_scope() const {
    return scope_ptr->this_ptr != nullptr;
}

bool Symbol_table::inherits_from(const std::string &child, const std::string &parent) const {
    auto class_scope = class_scopes.find(child);
    if (class_scope == class_scopes.end()) {
        return false;
    }

    // check base classes
    for (auto base = class_scope->second; base; base = base->super_ptr) {
        if (base->name == parent) { return true; }

        for (const auto &intf : base->interfaces) {
            if (intf->name == parent) { return true; }
        }
    }

    return false;
}

Decl * Symbol_table::get_declaration(const string &k) {
    return scope_ptr->get_declaration(k);
}

Decl * Symbol_table::get_declaration_in_scope(const string &scope_name, const string &k) const {
    auto class_scope_it = class_scopes.find(scope_name);
    auto interface_scope_it = interface_scopes.find(scope_name);

    if (class_scope_it == class_scopes.end()) {
        if (interface_scope_it == interface_scopes.end()) {
            throw Symbol_table_exception("error: could not get declaration, not found");
        } else {
            return interface_scope_it->second->get_declaration(k);
        }
    } else {
        return class_scope_it->second->get_declaration(k);
    }
}

const string& Symbol_table::get_class_scope_name() const {
    if (!is_class_scope()) { throw Symbol_table_exception("error: cant get class scope name, not in class scope"); }
    return scope_ptr->this_ptr->name;
}

void Symbol_table::debug_print() const {
    scope_ptr->debug_print();
}