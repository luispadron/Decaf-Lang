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

    /// adds a scope
    bool enter_scope(const std::string &name, ScopeType type);

    /// leaves a scope
    bool leave_scope(const std::string &name, ScopeType type);

    /// returns the current scope
    Scope * get_scope() const;

    /// returns the scope with given name
    std::pair<Scope *, bool> get_scope(const std::string &name) const;

private:

    using Scopes = std::map<std::string, Scope *>; // mapping of scope name -> scope *

    Scope *scope_ptr; // current scope

    Scopes scopes;
};


#endif //SEMANTIC_ANALYZER_SYMBOLTABLE_H
