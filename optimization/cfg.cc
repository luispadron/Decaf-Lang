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


SuccessorTree::SuccessorTree(List<Instruction *> &code) {
    vector<CFInstruction *> instructions(code.NumElements());
    for (int i = 0; i < instructions.size(); ++i) {
        instructions[i] = new CFInstruction(code.Nth(i));
    }

    this->code = instructions;
    this->root = SuccessorTree::generate(0, code, this->code, nullptr);
}

void SuccessorTree::print() {
    cout << "Successor tree:" << endl;
    for (auto *line : code) {
        line->print();
    }
    cout << "\\===============/" << endl;
}

CFInstruction* SuccessorTree::generate(int pos, List<Instruction *> &code,
                                       const vector<CFInstruction *> &instructions, CFInstruction *predecessor) {
    if (pos >= instructions.size()) return nullptr;

    auto cfi = instructions[pos];

    if (predecessor) {
        auto has_pred = find(
                cfi->predecessors.begin(),
                cfi->predecessors.end(), predecessor) != cfi->predecessors.end();

        if (!has_pred) {
            cfi->predecessors.push_back(predecessor);
        }

        auto has_succ = find(
                predecessor->successors.begin(),
                predecessor->successors.end(), cfi) != predecessor->successors.end();

        if (!has_succ) {
            predecessor->successors.push_back(cfi);
        }
    }

    auto ifz = dynamic_cast<IfZ*>(cfi->instruction);
    auto goTo = dynamic_cast<Goto*>(cfi->instruction);

    if (ifz) {
        generate(pos + 1, code, instructions, cfi);
        generate(get_pos_of_label(ifz->GetLabel(), code), code, instructions, cfi);
    } else if (goTo) {
        generate(get_pos_of_label(goTo->GetLabel(), code), code, instructions, cfi);
    } else {
        generate(pos + 1, code, instructions, cfi);
    }

    return cfi;
}

int SuccessorTree::get_pos_of_label(const char *label, List<Instruction *> &code) {
    for (int i = 0; i < code.NumElements(); ++i) {
        auto ilabel = dynamic_cast<Label*>(code.Nth(i));
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


CFBlock::CFBlock() {
    code.push_back(new CFInstruction(nullptr));
    code.push_back(new CFInstruction(nullptr));
}

CFBlock::~CFBlock() {
    traverse_code([](CFInstruction *instr, CFInstruction *prev) {
       delete instr;
    });
}

void CFBlock::traverse_impl(CFBlock *start, queue<CFBlock *> &blocks, set<CFBlock *> &visited) {
    if (!start) return;

    auto seen = visited.find(start) != visited.end();
    if (seen) return;

    blocks.push(start);

    for (auto *exit : start->edges) {
        CFBlock::traverse_impl(exit, blocks, visited);
    }
}

void CFBlock::add_instruction(CFInstruction *instruction) {
    code.insert(prev(code.end()), instruction);
}

void CFBlock::add_exit(CFBlock *block) {
    edges.push_back(block);
}

void CFBlock::print() {
    cout << "block: " << this << endl;
    cout << "---------------" << endl;

    for (auto &line : code) {
        cout << typeid(*(line->instruction)).name() << endl;
    }

    cout << "exits: \n";
    for (auto &exit : edges) {
        cout << "\t" << exit << endl;
    }

    cout << "---------------" << endl << endl;
}

// resets all in/out vectors of the blocks
void CFGraph::prepare() {
    traverse([](CFBlock *block) {
       block->traverse_code([](CFInstruction *instr, CFInstruction *prev) {
          instr->in.clear();
          instr->out.clear();
       });
    });
}

CFGraph::CFGraph(CFInstruction *root) {
    gen_graph(root);
}

CFGraph::~CFGraph() {
    traverse([](CFBlock *block) {
        delete block;
    });
}

void CFGraph::gen_graph(CFInstruction *root) {
    set<CFInstruction*> visited;
    start = gen_graph_impl(root, new CFBlock, nullptr, visited);
}

CFBlock * CFGraph::gen_graph_impl(CFInstruction *curr_instr, CFBlock *curr_block, CFBlock *else_block, set<CFInstruction *> &visited) {
    if (!curr_instr || visited.find(curr_instr) != visited.end()) return nullptr;

    visited.insert(curr_instr);

//    if (curr_instr->successors.first && curr_instr->successors.second) {
//        auto block1 = new CFBlock;
//        auto block2 = new CFBlock;
//
//        curr_block->add_instruction(curr_instr);
//
//        curr_block->add_exit(block1);
//        curr_block->add_exit(block2);
//
//        gen_graph_impl(curr_instr->successors.first, block1, block2, visited);
//        gen_graph_impl(curr_instr->successors.second, block2, else_block, visited);
//    } else if (curr_instr->predecessors.first && curr_instr->predecessors.second) {
//        auto block = new CFBlock;
//        block->add_instruction(curr_instr);
//
//        curr_block->add_exit(block);
//        Assert(else_block);
//        else_block->add_exit(block);
//
//        gen_graph_impl(curr_instr->successors.first, block, else_block, visited);
//    } else {
//        curr_block->add_instruction(curr_instr);
//        gen_graph_impl(curr_instr->successors.first, curr_block, else_block, visited);
//    }

    return curr_block;
}