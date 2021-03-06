#include <utility>

//
// Created by Luis on 2019-03-16.
//

#ifndef SEMANTIC_ANALYZER_SCOPE_H
#define SEMANTIC_ANALYZER_SCOPE_H

#include <utility>
#include <map>
#include <string>
#include "utility.h"

class Decl;

enum class ScopeType {
    Global,
    Interface,
    Function,
    Block,
    Class
};

class Scope {
public:

    Scope(std::string name__, ScopeType type_) : name_(std::move(name__)), type(type_) { }

    /// inserts a declaration in the scope
    /// if symbol already exists, false is returned, otherwise true
    bool insert_decl(const std::string &name, Decl *decl);

    /// returns a declaration within the scope
    /// if no such declaration is found, false is returned in the pare
    std::pair<Decl*, bool> get_decl(const std::string &name) const;

    /// returns the position of the given decl name, that is the
    /// position in the symbol table (in alphabetical order)
    std::pair<int, bool> get_decl_position(const std::string &name) const;

    /// sets the super scope (used in class hierarachy)
    void set_super_scope(Scope *scope) { super_ptr = scope; }

    /// returns the name of the scope
    const std::string & name() const { return name_; }

    /// returns whether this scope is currently inside of a class scope
    bool is_class_scope() const { return this_ptr; }

    std::string get_class_scope_name() { Assert(this_ptr); return this_ptr->name();}

private:

    friend class SymbolTable;

    using Symbols = std::map<std::string, Decl*>;

    std::string name_;

    ScopeType type;

    Scope *parent_ptr = nullptr;

    Scope *this_ptr = nullptr;

    Scope *super_ptr = nullptr;

    Symbols symbols;
};


#endif //SEMANTIC_ANALYZER_SCOPE_H
