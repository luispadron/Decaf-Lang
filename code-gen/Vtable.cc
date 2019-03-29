//
// Created by Luis on 2019-03-29.
//

#include "Vtable.h"
#include "ast_decl.h"
#include "codegen.h"
#include "list.h"

#include <algorithm>
#include <cassert>

using namespace std;

bool operator<(const Vtable_method &lhs, const Vtable_method &rhs) {
    return lhs.name < rhs.name;
}

bool operator==(const Vtable_method &lhs, const Vtable_method &rhs) {
    return lhs.name == rhs.name;
}

Vtable_method::Vtable_method(string name_, string mangled_name_, int offset_) :
    name(move(name_)), mangled_name(move(mangled_name_)), offset(offset_) { }

void Vtable::create(ClassDecl *child, ClassDecl *parent) {
    assert(child);

    // add parent parent methods if they exist
    if (parent) {
        for (int i = 0; i < parent->members->size(); ++i) {
            auto method = dynamic_cast<FnDecl*>(parent->members->get(i));
            if (!method) continue;

            auto vmethod = Vtable_method(method->get_id()->get_name(),
                                         method->get_mangled_name(parent->get_id()->get_name()));
            table.push_back(vmethod);
        }
    }

    // find methods in child that override methods in parent
    vector<Vtable_method> unique_methods;
    for (int i = 0; i < child->members->size(); ++i) {
        auto method = dynamic_cast<FnDecl*>(child->members->get(i));
        if (!method) continue;

        auto child_vmethod = Vtable_method(
                method->get_id()->get_name(),
                method->get_mangled_name(child->get_id()->get_name())
                );

        auto it = find(table.begin(), table.end(), child_vmethod);
        if (it != table.end()) { // child overrides method, thus we need to remove parent and add child method
            table.erase(it);
            table.push_back(child_vmethod);
        } else {
            unique_methods.push_back(child_vmethod); // a method unique to child
        }
    }

    // append all unique child methods to table
    table.insert(table.end(), unique_methods.begin(), unique_methods.end());

    // fix offsets
    int offset = 0;
    for (const auto &method : table) {
        method.offset = offset;
        offset += CodeGenerator::word_size;
    }
}

int Vtable::offset_for(const string &method) const {
    auto it = find(table.begin(), table.end(), Vtable_method(method, ""));
    assert(it != table.end());
    return it->offset;
}

void Vtable::generate_vtable_assembly(const string &class_name) const {
    List<const char*> methods;
    for (const auto &method : table) {
        methods.append(method.mangled_name.c_str());
    }

    CodeGenerator::shared().gen_vtable(class_name.c_str(), methods);
}