//
// Created by Luis on 2019-03-29.
//

#ifndef SEMANTIC_ANALYZER_VTABLE_H
#define SEMANTIC_ANALYZER_VTABLE_H

#include <string>
#include <vector>
#include <type_traits>

class ClassDecl;

struct Vtable_method {
    std::string name;
    std::string mangled_name;
    mutable int offset = 0;

    Vtable_method(std::string name, std::string mangled_name, int offset = 0);
};

bool operator<(const Vtable_method &lhs, const Vtable_method &rhs);

bool operator==(const Vtable_method &lhs, const Vtable_method &rhs);

class Vtable {
public:
    void create(ClassDecl *child, ClassDecl *parent = nullptr);

    int offset_for(const std::string &method) const;

    void generate_vtable_assembly(const std::string &class_name) const;

private:
    std::vector<Vtable_method> table;
};


#endif //SEMANTIC_ANALYZER_VTABLE_H
