#ifndef SEMANTIC_ANALYZER_AST_PROGRAM_H
#define SEMANTIC_ANALYZER_AST_PROGRAM_H

#include "ast.h"
#include "list.h"

class Decl;

class Program : public Node {
protected:
    List<Decl*> *decls;

public:
    explicit Program(List<Decl*> *declList);

    bool check() override;
};


#endif //SEMANTIC_ANALYZER_AST_PROGRAM_H
