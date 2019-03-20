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

    /**
     * @return SymbolTable &, returns a singleton instance to a SymbolTable object.
     */
    static SymbolTable & shared() {
        static SymbolTable s;
        return s;
    }

    /**
     * Clean up the memory by deleting all scopes
     */
    ~SymbolTable();

    /**
     * Adds a scope to the symbol table and enters it, that is, the new scope will be the current scope.

     * @param name, the name of the scope (usually a mangled name in order to be unique).
     * @param type, the type of the scope.
     * @return Scope *, the new scope that was created
     */
    Scope * create_scope(const std::string &name, ScopeType type);

    /**
     * Enters a given scope, that is, sets the current scope to the given scope.
     * The scope must have been previously created.
     *
     * @param name, the scope name to enter.
     * @return Scope *, a pointer to the entered scope, nullptr if no scope with given name exists.
     */
    Scope * enter_scope(const std::string &name);

    /**
     * Leaves a currently entered scope.
     * If no current scope is available, false is returned. Otherwise returns true.

     * @return bool, whether the scope was left successfully
     */
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
