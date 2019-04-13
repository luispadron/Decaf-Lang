//
// Created by Luis on 2019-04-12.
//

#include "cfg.h"

#include "tac.h"

#include <iostream>
#include <utility>

using namespace std;

void CFBlock::add_instruction(Instruction *instr) {
    code.push_back(instr);
}

void CFBlock::add_exit(CFBlock *exit) {
    exits.push_back(exit);
}

void CFBlock::print() const {
    for (const auto &instr : code) {
        instr->Print();
    }

    cout << "exits: " << exits.size() << endl;
}

CFGraph::~CFGraph() {
    for (const auto *block : blocks) {
        delete block;
    }
}

void CFGraph::add_block(CFBlock *block) {
    blocks.push_back(block);
}

void CFGraph::print() const {
    int id = 0;
    for (const auto &block : blocks) {
        cout << "block: " << id << endl;
        block->print();
        cout << endl;
    }
}