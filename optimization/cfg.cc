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
    for (int i = 0; i < code.size(); ++i) {
        auto cfi = code[i];
        auto successors = cfi->instruction->GetSuccSet(i, instructions);

        for (auto *si : successors) {
            auto succ = find_if(code.begin(), code.end(), [&si](CFInstruction *instr) {
               return si == instr->instruction;
            });
            Assert(succ != code.end());

            cfi->successors.insert(*succ);
            (*succ)->predecessors.insert(cfi);
        }
    }

    return code[0];
}

void SuccessorTree::reset() {
    for_each(code.begin(), code.end(), mem_fn(&CFInstruction::reset));
}