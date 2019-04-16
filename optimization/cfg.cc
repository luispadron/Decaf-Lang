//
// Created by Luis on 2019-04-12.
//

#include "cfg.h"

#include <iostream>
#include <utility>
#include <queue>
#include <functional>

#include "tac.h"
#include "list.h"

using namespace std;

SuccessorTree::SuccessorTree(List<Instruction *> &code_) : code{code_} {
    this->root = SuccessorTree::generate();
}

void SuccessorTree::print() { }

Instruction* SuccessorTree::generate() {
    for (int i = 0; i < code.NumElements(); ++i) {
        auto cfi = code.Nth(i);
        cfi->GenSuccSet(i, code);

        for (auto *si : cfi->successors) {
            si->predecessors.insert(cfi);
        }
    }

    return code.Nth(0);
}