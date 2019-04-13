//
// Created by Luis on 2019-04-12.
//

#ifndef OPTIMIZATION_CFG_H
#define OPTIMIZATION_CFG_H

#include <vector>

class Instruction;

/**
 * Control flow block
 *
 * A block is defined as a single executable list of instructions.
 * blocks cannot contain branches or gotos
 *
 */
class CFBlock {
public:

    void add_instruction(Instruction *);

    void print() const;

private:
    std::vector<Instruction *> code;
    std::vector<Instruction *> exits;
};


/**
 * Control flow graph
 *
 * Contains a graph of blocks.
 *  - An edge between a block and another block define the next piece of executions.
 *
 */
class CFGraph {
public:

    void add_block(CFBlock);

    void print() const;

private:
    std::vector<CFBlock> blocks;
};


#endif //OPTIMIZATION_CFG_H
