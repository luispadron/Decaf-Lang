#include "Scope.h"

using namespace std;

void Scope::insert_symbol(const string &k, Type* v) {
    auto it = symbols.find(k);

    if (it != symbols.end()) {
        throw Symbol_table_exception{"error (insert_symbol) called with duplicate key"};
    } else {
        symbols.insert({k, v});
    }
}

bool Scope::is_symbol(const string &k) {
    return get_symbol_iter(k) != symbols.end();
}

Type* Scope::get_symbol(const string &k) {
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
    if (super_ptr) {
        scope_ptr = super_ptr;
        for (; scope_ptr; scope_ptr = scope_ptr->parent_ptr) {
            auto it = scope_ptr->symbols.find(k);
            if (it != scope_ptr->symbols.end()) {
                return it;
            }
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