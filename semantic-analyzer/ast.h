/* File: ast.h
 * ----------- 
 * This file defines the abstract base class Node and the concrete 
 * Identifier and Error node subclasses that are used through the tree as 
 * leaf nodes. A parse tree is a hierarchical collection of ast nodes (or, 
 * more correctly, of instances of concrete subclassses such as VarDecl,
 * ForStmt, and AssignExpr).
 * 
 * Location: Each node maintains its lexical location (line and columns in 
 * file), that location can be NULL for those nodes that don't care/use 
 * locations. The location is typcially set by the node constructor.  The 
 * location is used to provide the context when reporting semantic errors.
 *
 * Parent: Each node has a pointer to its parent. For a Program node, the 
 * parent is NULL, for all other nodes it is the pointer to the node one level
 * up in the parse tree.  The parent is not set in the constructor (during a 
 * bottom-up parse we don't know the parent at the time of construction) but 
 * instead we wait until assigning the children into the parent node and then 
 * set up links in both directions. The parent link is typically not used 
 * during parsing, but is more important in later phases.
 *
 * Semantic analysis: For pp3 you are adding "check" behavior to the ast
 * node classes. Your semantic analyzer should do an inorder walk on the
 * parse tree, and when visiting each node, verify the particular
 * semantic rules that apply to that construct.

 */

#ifndef _H_ast
#define _H_ast

#include "Symbol_table.h"
#include "location.h"

#include <string>
#include <iostream>

class Node;
class Decl;

/// type alias for the symbol table type
using Sym_table_t = Symbol_table<std::string, Decl*>;

class Node {
protected:
    yyltype *location;
    Node *parent;

public:
    explicit Node(yyltype loc);
    Node();
    
    yyltype *get_location()   { return location; }
    void set_parent(Node *p)  { parent = p; }
    Node *get_parent()        { return parent; }

    /// this method gives any Node in the AST the ability to check that
    /// they are semantically correct, if an error is found implementations should return false
    virtual bool check() = 0;

    /// traverses the AST upwards, at each step calling the given function
    /// with the current node, if the function predicate returns true this function returns the current node.
    /// if predicate never returns true, nullptr is returned.
    template <typename Fn>
    Node * find_if(Fn pred) {
        for (auto curr = this; curr; curr = curr->get_parent()) {
            if (pred(curr)) return curr;
        }

        return nullptr;
    }
};
   

class Identifier : public Node {
protected:
    char *name;
    
public:
    Identifier(yyltype loc, const char *name);

    friend std::ostream& operator<<(std::ostream& out, Identifier *id) { return out << id->name; }

    const char * get_str() const { return name; }

    bool check() override;
};


// This node class is designed to represent a portion of the tree that 
// encountered syntax errors during parsing. The partial completed tree
// is discarded along with the states being popped, and an instance of
// the Error class can stand in as the placeholder in the parse tree
// when your parser can continue after an error.
class Error : public Node {
public:
    Error() : Node() {}

    bool check() override;
};

#endif
