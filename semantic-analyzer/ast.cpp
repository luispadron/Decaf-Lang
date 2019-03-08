/* File: ast.cc
 * ------------
 */

#include "ast.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "errors.h"

#include <cstring>

Node::Node(yyltype loc) {
    location = new yyltype(loc);
    parent = nullptr;
}

Node::Node() {
    location = nullptr;
    parent = nullptr;
}

void Node::check() { /* do nothing */ }

Type* Node::type_check() { return Type::errorType; }


Identifier::Identifier(yyltype loc, const char *n) : Node(loc) {
    name = strdup(n);
}

void Identifier::check() { /* we don't want to print error out here, other classes will */ }

bool Identifier::is_defined() {
    return Sym_tbl_t::shared().is_declared(name);
}