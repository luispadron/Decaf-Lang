//
// Created by Luis on 2019-04-12.
//

#ifndef OPTIMIZATION_CFG_H
#define OPTIMIZATION_CFG_H

#include <utility>
#include <set>

class Instruction;

struct CFInstruction {

    CFInstruction();

    void print();

    using CFIPair = std::pair<CFInstruction *, CFInstruction *>;

    Instruction *instruction;
    CFIPair successors;
    CFIPair predecessors;
    bool visited = false;
};

class CFBlock {
public:
    void add_instruction(CFInstruction *instruction);

    void add_exit(CFBlock *block);

    void print();

private:
    friend class CFGraph;
    std::set<CFInstruction *> code;
    std::set<CFBlock *> exits;
};

class CFGraph {
public:
    explicit CFGraph(CFInstruction *root);

    void print();

private:
    CFBlock *start = nullptr;

    void gen_graph(CFInstruction *root);
    CFBlock * gen_graph_impl(CFInstruction *curr_instr, CFBlock *curr_block);
};


#endif //OPTIMIZATION_CFG_H
