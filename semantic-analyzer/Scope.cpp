#include "Scope.h"
#include "ast_decl.h"

#include <stack>

using namespace std;

void Scope::insert_symbol(const string &k, Decl *decl) {
    if (this_ptr) { return insert_symbol_in_class(k, decl); }

    auto it = symbols.find(k);

    if (it != symbols.end()) {
        throw Duplicate_symbol_exception(it->second);
    } else {
        symbols.insert({k, decl});
    }
}

/// handles inserting symbol in a class like scope, since duplicate declarations depend
/// on whether base class has that symbol as well
void Scope::insert_symbol_in_class(const std::string &k, Decl *decl) {
    auto this_it = symbols.find(k);
    if (this_it != symbols.end()) {
        throw Duplicate_symbol_exception(this_it->second);
    }

    // check any base class symbols, make sure its not in there
    for (auto b = super_ptr; b; b = b->super_ptr) {
        auto it = b->symbols.find(k);

        if (it != b->symbols.end() && it->second->get_decl_type() == DeclType::Variable) {
            // found this symbol in this class or a base class, this is a duplicate thus error
            throw Duplicate_symbol_exception(it->second);
        }
    }

    symbols.insert({k, decl});
}

bool Scope::is_declared(const string &k) {
    return get_symbol_iter(k) != symbols.end();
}

Decl * Scope::get_declaration(const string &k) {
    auto it = get_symbol_iter(k);

    if (it == symbols.end()) {
        throw Symbol_table_exception{"error (get_symbol) no symbol exists for given key"};
    }

    return it->second;
}

Scope::Symbol_iter Scope::get_symbol_iter(const string &k) {
    // first search through this scope
    auto scope_ptr = this;
    for (; scope_ptr; scope_ptr = scope_ptr->parent_ptr) {
        auto it = scope_ptr->symbols.find(k);
        if (it != scope_ptr->symbols.end()) {
            return it;
        }
    }

    // if not found, go to super scope if possible and check there
    scope_ptr = super_ptr;
    for (; scope_ptr; scope_ptr = scope_ptr->parent_ptr) {
        auto it = scope_ptr->symbols.find(k);
        if (it != scope_ptr->symbols.end()) {
            return it;
        }
    }

    return symbols.end();
}

void Scope::debug_print() const {
    auto scope_ptr = this;
    std::stack<std::string> pstack; // used to print in reverse since we go current->parent

    for (; scope_ptr; scope_ptr = scope_ptr->parent_ptr) {
        std::stringstream ss;
        ss << "------- " << scope_ptr->name << " scope -------" << std::endl;
        for (const auto &symbol : scope_ptr->symbols) {
            ss << symbol.first << std::endl;
        }

        ss << std::endl;
        pstack.push(ss.str());
    }

    // print in reverse, thus prints in the current order from root->children
    for (; !pstack.empty(); pstack.pop()) {
        std::cout << pstack.top();
    }
}