//
// Created by Luis on 2019-04-12.
//

#ifndef OPTIMIZATION_CFG_H
#define OPTIMIZATION_CFG_H

#include <set>

class Instruction;

struct CFInstruction {
    Instruction *instruction;
    std::set<CFInstruction *> successors;
    std::set<CFInstruction *> predecessors;

    void print();
};



#endif //OPTIMIZATION_CFG_H
