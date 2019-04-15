//
// Created by Luis on 2019-04-12.
//

#ifndef OPTIMIZATION_CFG_H
#define OPTIMIZATION_CFG_H

#include <algorithm>
#include <utility>
#include <set>
#include <queue>
#include <vector>
#include <iostream>

class Instruction;
class Location;
template<typename T>
class List;


/**
 * CFInstruction
 */
struct CFInstruction {

    explicit CFInstruction(Instruction *instruction_);

    /// prints out the content of this type
    void print();

    /// resets the in and out sets for use with traversal
    void reset();

    using Edges = std::vector<CFInstruction*>;
    using SetType = std::set<Location*>;

    Instruction *instruction;
    Edges successors;
    Edges predecessors;

    SetType in;
    SetType out;
};


/**
 * SuccessorTree
 */
class SuccessorTree {
public:
    explicit SuccessorTree(List<Instruction *> &code);

    template<typename F>
    void traverse(F fn);

    void print();

private:
    CFInstruction *root = nullptr;
    std::vector<CFInstruction *> code;

    static CFInstruction * generate(int pos, List<Instruction *> &code,
                                    const std::vector<CFInstruction *> &instructions, CFInstruction *predecessor);
    static int get_pos_of_label(const char *label, List<Instruction *> &code);

    void reset();
};


/**
 * CFBlock
 */
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


/**
 * CFGraph
 */
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

private:
    CFBlock *start = nullptr;

    void prepare();
    void gen_graph(CFInstruction *root);
    CFBlock * gen_graph_impl(CFInstruction *curr_instr, CFBlock *curr_block, CFBlock *else_block, std::set<CFInstruction *> &);
};


//////////// implementations ///////////////////

template <typename F>
void SuccessorTree::traverse(F fn) {
    std::for_each(code.begin(), code.end(), fn);
}

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

    prepare();

    traverse([&](CFBlock *block) { // for each block
        if (d == Direction::forward) {
            // prime entry
            auto entry = *block->code.begin();
            entry->out = initial;

            // for each line of code in a block, in forward manner
            block->traverse_code([&](CFInstruction *curr, CFInstruction *prev) {
                curr->in = prev->out;
                curr->out = transform(curr);
            });
        } else {
            // prime entry
            auto exit = *block->code.rbegin();
            exit->in = initial;

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
