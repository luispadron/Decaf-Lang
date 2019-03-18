/* File: ast.cc
 * ------------
 */

#include "ast.h"
#include "ast_type.h"
#include "ast_decl.h"

#include <cstring>

CodeGenerator *g_codeGen = new CodeGenerator();

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

