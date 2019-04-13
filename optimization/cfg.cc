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
