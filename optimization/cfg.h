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

    template <typename I, typename F>
    void analyze(CFGraph::Direction d, std::vector<I> &initial, std::vector<std::vector<I>> &results, F transform);

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
    for (int i = 0; i < code.size(); ++i) {
        fn(i, code[i]);
    }
}

template<typename F>
void CFBlock::rtraverse_code(F fn) {
    for (auto it = code.rbegin(); it != code.rend(); ++it) {
        fn(it - code.rbegin(), *it);
    }
}


template <typename I, typename F>
void CFGraph::analyze(CFGraph::Direction d, std::vector<I> &initial, std::vector<std::vector<I>> &results, F transform)  {
    if (!start) return;

    traverse([&](CFBlock *block) { // for each block
        if (d == Direction::forward) {
            std::vector<std::vector<I>> output;
            output.push_back(initial);

            block->traverse_code([&](int index, CFInstruction *instr) { // for each line of code in a block, in forward manner
                auto in = output[index];
                auto out = transform(instr, in);
                output.push_back(out);
            });

            results.push_back(*output.rbegin());

        } else {
            std::vector<std::vector<I>> input;
            input.push_back(initial);

            block->rtraverse_code([&](int index, CFInstruction *instr) { // for each line of code in a block, in backward manner
                auto in = input[index];
                auto out = transform(instr, in);
                input.push_back(out);
            });

            results.push_back(*input.rbegin());
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
