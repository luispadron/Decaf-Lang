//
// Created by Luis on 2019-04-12.
//

#ifndef OPTIMIZATION_CFG_H
#define OPTIMIZATION_CFG_H

#include <utility>
#include <set>
#include <queue>

#include <iostream>

class Instruction;
class Location;

struct CFInstruction {

    CFInstruction();

    void print();

    using CFIPair = std::pair<CFInstruction *, CFInstruction *>;

    Instruction *instruction;
    CFIPair successors;
    CFIPair predecessors;

    std::vector<Location *> in;
    std::vector<Location *> out;
};

class CFBlock {
public:
    CFBlock();
    ~CFBlock();

    void add_instruction(CFInstruction *instruction);

    void add_exit(CFBlock *block);

    template <typename F>
    void traverse_code(F fn);

    template <typename F>
    void rtraverse_code(F fn);

    void print();

private:
    static void traverse_impl(CFBlock *start, std::queue<CFBlock *> &blocks, std::set<CFBlock *> &visited);

    friend class CFGraph;

    std::vector<CFInstruction *> code;
    std::vector<CFBlock *> edges;
};

class CFGraph {
public:

    enum class Direction {
        forward,
        backward
    };

    explicit CFGraph(CFInstruction *root);
    ~CFGraph();

    template <typename I, typename F>
    void analyze(CFGraph::Direction d, std::vector<I> &initial, F transform);

    template <typename F>
    void traverse(F fn);

    void print();

private:
    CFBlock *start = nullptr;

    void gen_graph(CFInstruction *root);
    CFBlock * gen_graph_impl(CFInstruction *curr_instr, CFBlock *curr_block, CFBlock *else_block, std::set<CFInstruction *> &);
};


//////////// implementations ///////////////////

template<typename F>
void CFBlock::traverse_code(F fn)  {
    for (int i = 1; i < code.size(); ++i) {
        fn(code[i], code[i - 1]);
    }
}

template<typename F>
void CFBlock::rtraverse_code(F fn) {
    for (int i = code.size() - 2; i >= 1; --i) {
        fn(code[i], code[i + 1]);
    }
}


template <typename I, typename F>
void CFGraph::analyze(CFGraph::Direction d, std::vector<I> &initial, F transform)  {
    if (!start) return;

    traverse([&](CFBlock *block) { // for each block
        if (d == Direction::forward) {
            // prime entry
            block->code[0]->out = initial;

            // for each line of code in a block, in forward manner
            block->traverse_code([&](CFInstruction *curr, CFInstruction *prev) {
                curr->in = prev->out;
                curr->out = transform(curr);
            });
        } else {
            // prime entry
            block->code[0]->in = initial;

            // for each line of code in a block, in backward manner
            block->rtraverse_code([&](CFInstruction *curr, CFInstruction *prev) {
                curr->out = prev->in;
                curr->in = transform(curr);
            });
        }
    });
}

template <typename F>
void CFGraph::traverse(F fn) {
    std::set<CFBlock *> visited;
    std::queue<CFBlock *> blocks;
    blocks.push(start);

    while (!blocks.empty()) {
        auto block = blocks.front();
        blocks.pop();

        if (visited.find(block) != visited.end()) continue;

        visited.insert(block);

        fn(block);

        for (auto &exit : block->edges) {
            blocks.push(exit);
        }
    }
}

#endif //OPTIMIZATION_CFG_H
