//
// Created by Luis on 2019-03-16.
//

#ifndef SEMANTIC_ANALYZER_SYMBOLTABLE_H
#define SEMANTIC_ANALYZER_SYMBOLTABLE_H

#include <string>
#include <map>

#include "Scope.h"

class SymbolTable {
public:

    static SymbolTable & shared() {
        static SymbolTable s;
        return s;
    }

    /// adds a scope, returns the newly created scope
    Scope * enter_scope(const std::string &name, ScopeType type);

    /// leaves the current scope
    bool leave_scope();

    /// returns the current scope
    Scope * get_scope() const;

    /// returns the scope with given name
    std::pair<Scope *, bool> get_scope(const std::string &name) const;

    void debug_print() const;

private:

    using Scopes = std::map<std::string, Scope *>; // mapping of scope name -> scope *

    Scope *scope_ptr = nullptr; // current scope

    Scopes scopes;
};


#endif //SEMANTIC_ANALYZER_SYMBOLTABLE_H
