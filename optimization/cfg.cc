//
// Created by Luis on 2019-04-12.
//

#include "cfg.h"

#include "tac.h"

#include <iostream>
#include <utility>

using namespace std;

void CFInstruction::print() {
    cout << "instruction: " << typeid(*instruction).name() << endl;
    cout << "\tsuccessors:";
    for (auto &s : successors) {
        cout << "\t\t" << typeid(*(s->instruction)).name() << " ";
    }

    cout << "\n\tpredecessors:";
    for (auto &p : predecessors) {
        cout << "\t\t" << typeid(*(p->instruction)).name() << " ";
    }

    cout << "\n\n";
}

void SuccessorTree::add_instruction(CFInstruction *instr) {
    if (!root) {
        root = instr;
        curr = root;
    } else {
        curr = instr;
    }
}

void SuccessorTree::add_successor(CFInstruction *instr) {
    Assert(curr);
    curr->successors.push_back(instr);
}

void SuccessorTree::add_predecessor(CFInstruction *instr) {
    curr->predecessors.push_back(instr);
}

void SuccessorTree::print() {
    print_impl(root);
}

void SuccessorTree::print_impl(CFInstruction *node) {
    cout << "instruction: " << typeid(*node).name() << endl;

    cout << "\tsuccessors:";
    for (auto &s : node->successors) {
        cout << "\t\t" << typeid(*(s->instruction)).name() << endl;
    }

    cout << "\tpredecessors:";
    for (auto &p : node->predecessors) {
        cout << "\t\t" << typeid(*(p->instruction)).name() << endl;
    }

    for (auto &s : node->successors) {
        print_impl(s);
    }
}