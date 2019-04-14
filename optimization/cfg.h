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
    void analyze(Direction d, std::set<T> &values, F transform, std::set<I> &initial) {

    }

    void print();

private:
    CFBlock *start = nullptr;

    void gen_graph(CFInstruction *root);
    CFBlock * gen_graph_impl(CFInstruction *curr_instr, CFBlock *curr_block, std::set<CFInstruction *> &);
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

#endif //OPTIMIZATION_CFG_H