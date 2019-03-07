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
	 
Identifier::Identifier(yyltype loc, const char *n) : Node(loc) {
    name = strdup(n);
}

bool Identifier::check() {

}

bool Error::check() {

}
