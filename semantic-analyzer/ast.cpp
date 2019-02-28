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
    parent = NULL;
}

Node::Node() {
    location = NULL;
    parent = NULL;
}
	 
Identifier::Identifier(yyltype loc, const char *n) : Node(loc) {
    name = strdup(n);
} 

void Identifier::Check(Symbol_table<std::string, Node *> &sym_table) {
    // check that this identifier is in the symbol table
    if (!sym_table.is_symbol(name)) {
        ReportError::IdentifierNotDeclared(this, reasonT::LookingForVariable);
    }
}
