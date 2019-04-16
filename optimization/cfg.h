//
// Created by Luis on 2019-04-12.
//

#ifndef OPTIMIZATION_CFG_H
#define OPTIMIZATION_CFG_H

#include "list.h"

class Instruction;

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
    Instruction *root = nullptr;
    List<Instruction *> &code;

    Instruction * generate();
};


//////////// implementations ///////////////////

template <typename F>
void SuccessorTree::traverse(F fn) {
    for (int i = 0; i < code.NumElements(); ++i) {
        fn(code.Nth(i));
    }
}

#endif //OPTIMIZATION_CFG_H
