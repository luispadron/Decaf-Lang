#include "Symbol_table.h"

/////////////// Implementation ///////////////

Symbol_table::~Symbol_table() {
    if (DEBUG_PRINT) { std::cout << "destroying table" << std::endl; }
    // delete all scopes
    for (auto scope : scopes) {
        delete scope;
    }
}

void Symbol_table::enter_scope(const std::string &debug_name) {
    auto new_scope = new Scope(debug_name);
    new_scope->parent_ptr = scope_ptr;
    new_scope->super_ptr = scope_ptr ? scope_ptr->super_ptr : nullptr;
    new_scope->this_ptr = scope_ptr ? scope_ptr->this_ptr : nullptr;
    scopes.push_back(new_scope);
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { std::cout << "pushing scope: " << debug_name << std::endl; debug_print(); }
}

void Symbol_table::enter_class_scope(const std::string &key) {
    auto new_scope = new Scope(key);
    new_scope->parent_ptr = scope_ptr;
    new_scope->this_ptr = new_scope;
    scopes.push_back(new_scope);
    class_scopes.insert({key, new_scope});
    scope_ptr = new_scope;

    if (DEBUG_PRINT) { std::cout << "pushing class scope: " << key << std::endl; debug_print(); }
}

void Symbol_table::leave_scope() {
    if (!scope_ptr) return;
    scope_ptr = scope_ptr->parent_ptr;

    if (DEBUG_PRINT) { std::cout << "popping scope " << scope_ptr->name << std::endl; debug_print(); }
}

void Symbol_table::insert_declaration(const std::string &k, Decl *d) {
    if (!scope_ptr) {
        throw Symbol_table_exception{"error (Symbol_table::insert_symbol) no scopes available."};
    }

    scope_ptr->insert_symbol(k, d);

    if (DEBUG_PRINT) {
        std::cout << "inserting symbol '" << k << "' in scope: " << scope_ptr->name << std::endl;
        debug_print();
    }
}

bool Symbol_table::is_declared(const std::string &k) const {
    return scope_ptr->is_declared(k);
}

bool Symbol_table::is_declared_in_class(const std::string &class_key, const std::string &k) const {
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

Decl * Symbol_table::get_declaration(const std::string &k) {
    return scope_ptr->get_declaration(k);
}

Decl * Symbol_table::get_declaration_in_class(const std::string &class_key, const std::string &k) const {
    auto class_scope_it = class_scopes.find(class_key);
    if (class_scope_it == class_scopes.end()) {
        throw Symbol_table_exception("error: cant get symbol in class, no class with given key");
    }

    return class_scope_it->second->get_declaration(k);
}

const std::string& Symbol_table::get_class_scope_name() const {
    if (!is_class_scope()) { throw Symbol_table_exception("error: cant get class scope name, not in class scope"); }
    return scope_ptr->this_ptr->name;
}

void Symbol_table::debug_print() const {
    scope_ptr->debug_print();
}