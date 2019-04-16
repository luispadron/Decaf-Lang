//
// Created by Luis on 2019-04-11.
//

#ifndef OPTIMIZATION_AST_PROGRAM_H
#define OPTIMIZATION_AST_PROGRAM_H

#include "ast.h"
#include "list.h"

class Decl;

class Program : public Node {
protected:
    List<Decl*> *decls;

public:
    explicit Program(List<Decl*> *declList);

    void Check() override;
    void Emit(CodeGenerator *cg) override;
};


#endif //OPTIMIZATION_AST_PROGRAM_H
