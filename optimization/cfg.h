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

struct CFInstruction {

    CFInstruction();

    void print();

    using CFIPair = std::pair<CFInstruction *, CFInstruction *>;

    Instruction *instruction;
    CFIPair successors;
    CFIPair predecessors;
};

class CFBlock {
public:

    template<typename F>
    static void traverse(CFBlock *start, F fn);

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
    std::vector<CFBlock *> exits;
};

class CFGraph {
public:

    enum class Direction {
        forward,
        backward
    };

    explicit CFGraph(CFInstruction *root);

    template <typename  T, typename F, typename I>
    void analyze(Direction d, std::vector<T> &values, F transform, std::vector<I> &initial);

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
void CFBlock::traverse(CFBlock *start, F fn) {
    std::queue<CFBlock *> blocks;
    std::set<CFBlock *> visited;

    CFBlock::traverse_impl(start, blocks, visited);

    while (!blocks.empty()) {
        fn(blocks.front());
        blocks.pop();
    }
}

template<typename F>
void CFBlock::traverse_code(F fn)  {
    for (auto *line : code) {
        fn(line);
    }
}

template<typename F>
void CFBlock::rtraverse_code(F fn) {
    for (auto it = code.rbegin(); it != code.rend(); ++it) {
        fn(*it);
    }
}


template <typename  T, typename F, typename I>
void CFGraph::analyze(CFGraph::Direction d, std::vector<T> &values, F transform, std::vector<I> &initial)  {
    if (!start) return;

    CFBlock::traverse(start, [&](CFBlock *block) { // for each block
        if (d == Direction::forward) {
            block->traverse_code([&](CFInstruction *instr) { // for each line of code in a block, in forward manner
                auto out = transform(initial, values, instr);
                values = out;
            });
        } else {
            block->rtraverse_code([&](CFInstruction *instr) { // for each line of code in a block, in backward manner
                auto out = transform(initial, values, instr);
                values = out;
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

        for (auto &exit : block->exits) {
            blocks.push(exit);
        }
    }
}

#endif //OPTIMIZATION_CFG_H
