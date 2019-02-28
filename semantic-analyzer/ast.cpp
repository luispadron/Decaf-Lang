/* File: ast.cc
 * ------------
 */

#include "ast.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "errors.h"

#include <string.h> // strdup
#include <stdio.h>  // printf

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

void Identifier::check(Symbol_table<std::string, Node *> &sym_table) {
    // check that this identifier is in the symbol table
    if (!sym_table.is_symbol(name)) {
        ReportError::identifier_not_found(this, Reason_e::LookingForVariable);
    }
}
