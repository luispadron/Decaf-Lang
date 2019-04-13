//
// Created by Luis on 2019-04-12.
//

#ifndef OPTIMIZATION_CFG_H
#define OPTIMIZATION_CFG_H

#include <vector>

class Instruction;

struct CFInstruction {
    Instruction *instruction;
    std::vector<CFInstruction *> successors;
    std::vector<CFInstruction *> predecessors;

    void print();
};

class SuccessorTree {
public:

    void add_instruction(CFInstruction *);

    void add_successor(CFInstruction *);

    void add_predecessor(CFInstruction *);

    void print();

private:
    CFInstruction *root = nullptr;
    CFInstruction *curr = nullptr;

    void print_impl(CFInstruction *node);
};


#endif //OPTIMIZATION_CFG_H
