/* File: ast.cc
 * ------------
 */

#include "ast.h"
#include "ast_type.h"
#include "ast_decl.h"

#include <cstring>

Node::Node(yyltype loc) {
    location = new yyltype(loc);
    parent = nullptr;
}

Node::Node() {
    location = nullptr;
    parent = nullptr;
}

Type* Node::type_check() {
    return Type::errorType;
}

	 
Identifier::Identifier(yyltype loc, const char *n) : Node(loc) {
    name = strdup(n);
} 

bool Identifier::is_defined() const {
    return Sym_tbl_t::shared().get_scope()->get_decl(name).second;
}
