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

CFInstruction::CFInstruction(Instruction *instruction_) : instruction{instruction_} { }

void CFInstruction::print() {
    cout << "instruction: ";
    instruction->Print();
    cout << endl;

    cout << "IN: \n";
    for (auto loc : in) {
        cout << "\t" << loc->GetName();
    }

    cout << "\nOUT: \n";
    for (auto loc : out) {
        cout << "\t" << loc->GetName();
    }

    cout << "\n==================\n\n";
}

void CFInstruction::reset() {
    in.clear();
    out.clear();
}


SuccessorTree::SuccessorTree(List<Instruction *> &instructions) {
    this->code.reserve(instructions.NumElements());

    for (int i = 0; i < instructions.NumElements(); ++i) {
        this->code.push_back(new CFInstruction(instructions.Nth(i)));
    }

    this->root = SuccessorTree::generate(0, instructions, nullptr);
}

void SuccessorTree::print() {
    cout << "Successor tree:" << endl;
    for (auto *line : code) {
        line->print();
    }
    cout << "\\===============/" << endl;
}

CFInstruction* SuccessorTree::generate(int pos, List<Instruction *> &instructions, CFInstruction *predecessor) {
    if (pos >= code.size()) return nullptr;
    auto cfi = code[pos];

    if (predecessor) {
        cfi->predecessors.insert(predecessor);
        predecessor->successors.insert(cfi);
    }

    auto ifz = dynamic_cast<IfZ*>(cfi->instruction);
    auto goTo = dynamic_cast<Goto*>(cfi->instruction);

    if (ifz) {
        generate(pos + 1, instructions, cfi);
        generate(get_pos_of_label(ifz->GetLabel(), instructions), instructions, cfi);
    } else if (goTo) {
        generate(get_pos_of_label(goTo->GetLabel(), instructions), instructions, cfi);
    } else {
        generate(pos + 1, instructions, cfi);
    }

    return cfi;
}

int SuccessorTree::get_pos_of_label(const char *label, List<Instruction *> &instructions) {
    for (int i = 0; i < instructions.NumElements(); ++i) {
        auto ilabel = dynamic_cast<Label*>(instructions.Nth(i));
        if (ilabel && strcmp(ilabel->GetLabel(), label) == 0) {
            return i;
        }
    }

    Assert(false);
    return -1;
}

void SuccessorTree::reset() {
    for_each(code.begin(), code.end(), mem_fn(&CFInstruction::reset));
}