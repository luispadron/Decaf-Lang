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

    using Edges = std::set<CFInstruction*>;
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
    explicit SuccessorTree(List<Instruction *> &instructions);

    template<typename F>
    void traverse(F fn);

    void print();

private:
    CFInstruction *root = nullptr;
    std::vector<CFInstruction *> code;

    CFInstruction * generate(int pos, List<Instruction *> &instructions, CFInstruction *predecessor);

    void reset();
};


//////////// implementations ///////////////////

template <typename F>
void SuccessorTree::traverse(F fn) {
    std::for_each(code.begin(), code.end(), fn);
}

#endif //OPTIMIZATION_CFG_H
