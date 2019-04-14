//
// Created by Luis on 2019-04-12.
//

#include "cfg.h"

#include <iostream>
#include <utility>
#include <queue>
#include <functional>

#include "tac.h"

using namespace std;

CFInstruction::CFInstruction() : instruction{nullptr} {
    successors = std::make_pair(nullptr, nullptr);
    predecessors = std::make_pair(nullptr, nullptr);
}

void CFInstruction::print() {
    cout << "instruction: " << typeid(*instruction).name() << endl;
    cout << "\tsuccessors:";
    if (successors.first)
        cout << "\t\t" << typeid(*(successors.first->instruction)).name() << " ";
    if (successors.second)
        cout << "\t\t" << typeid(*(successors.second->instruction)).name() << " ";

    cout << "\n\tpredecessors:";
    if (predecessors.first)
        cout << "\t\t" << typeid(*(predecessors.first->instruction)).name() << " ";
    if (predecessors.second)
        cout << "\t\t" << typeid(*(predecessors.second->instruction)).name() << " ";

    cout << "\n\n";
}


void CFBlock::traverse_impl(CFBlock *start, queue<CFBlock *> &blocks, set<CFBlock *> &visited) {
    if (!start) return;

    auto seen = visited.find(start) != visited.end();
    if (seen) return;

    blocks.push(start);

    for (auto *exit : start->exits) {
        CFBlock::traverse_impl(exit, blocks, visited);
    }
}

void CFBlock::add_instruction(CFInstruction *instruction) {
    code.push_back(instruction);
}

void CFBlock::add_exit(CFBlock *block) {
    exits.push_back(block);
}

void CFBlock::print() {
    cout << "block: " << this << endl;
    cout << "---------------" << endl;

    for (auto &line : code) {
        cout << typeid(*(line->instruction)).name() << endl;
    }

    cout << "exits: \n";
    for (auto &exit : exits) {
        cout << "\t" << exit << endl;
    }

    cout << "---------------" << endl << endl;
}

CFGraph::CFGraph(CFInstruction *root) {
    gen_graph(root);
}


void CFGraph::print() {
    traverse(mem_fn(&CFBlock::print));
}

void CFGraph::gen_graph(CFInstruction *root) {
    set<CFInstruction*> visited;
    start = gen_graph_impl(root, new CFBlock, nullptr, visited);
}

CFBlock * CFGraph::gen_graph_impl(CFInstruction *curr_instr, CFBlock *curr_block, CFBlock *else_block, set<CFInstruction *> &visited) {
    if (!curr_instr || visited.find(curr_instr) != visited.end()) return nullptr;

    visited.insert(curr_instr);

    if (curr_instr->successors.first && curr_instr->successors.second) {
        auto block1 = new CFBlock;
        auto block2 = new CFBlock;

        curr_block->add_instruction(curr_instr);

        curr_block->add_exit(block1);
        curr_block->add_exit(block2);

        gen_graph_impl(curr_instr->successors.first, block1, block2, visited);
        gen_graph_impl(curr_instr->successors.second, block2, else_block, visited);
    } else if (curr_instr->predecessors.first && curr_instr->predecessors.second) {
        auto block = new CFBlock;
        block->add_instruction(curr_instr);

        curr_block->add_exit(block);
        Assert(else_block);
        else_block->add_exit(block);

        gen_graph_impl(curr_instr->successors.first, block, else_block, visited);
    } else {
        curr_block->add_instruction(curr_instr);
        gen_graph_impl(curr_instr->successors.first, curr_block, else_block, visited);
    }

    return curr_block;
}