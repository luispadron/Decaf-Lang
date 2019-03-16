#include <utility>

//
// Created by Luis on 2019-03-16.
//

#ifndef SEMANTIC_ANALYZER_SCOPE_H
#define SEMANTIC_ANALYZER_SCOPE_H

#include <utility>
#include <map>
#include <string>

class Decl;

enum class ScopeType {
    Global,
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

    const std::string & name() const { return name_; }

    ScopeType scope_type() const { return type; }

private:

    friend class SymbolTable;

    using Symbols = std::map<std::string, Decl*>;

    std::string name_;

    int block_counter = 1;

    ScopeType type;

    Scope *parent_ptr = nullptr;

    Scope *this_ptr = nullptr;

    Scope *super_ptr = nullptr;

    Symbols symbols;
};


#endif //SEMANTIC_ANALYZER_SCOPE_H
