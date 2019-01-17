/* File: dppmain.cc
 * ----------------
 * This file defines the main() routine for the preprocessor,
 * the filtering tool which runs before the compiler.
 */

#include<algorithm>
#include <cstdio>
#include <iostream>
#include <limits>
#include <string>
#include <unordered_map>

using namespace std;


/** type-defs **/

using Tokens = unordered_map<string, string>;


/** constants **/

const char * const def_c = "define";


/** function declarations **/

void handle_creating_token(Tokens&);

void read_space();

/** main **/

int main() {
    int line = 0;
    unsigned char c;
    Tokens tokens;

    while (cin >> c) {
        if (c == '#') {
            string str;
            if ((cin >> str) && str == def_c) {
                handle_creating_token(tokens);
            } else {
                // handle replacing
            }
            ++line;
        } else if (c == '/' && cin.peek() == '/') {
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            ++line;
        } else if (c == '\n') {
            ++line;
        } else {
            cout << c;
        }
    }
}


/** function definitions **/

void handle_creating_token(Tokens& tokens) {
    read_space(); // expect space after "define"

    string tname;
    cin >> tname;

    read_space(); // expect space after name of token

    string trep;
    getline(cin, trep);

    tokens[tname] = trep;
}

void read_space() {
    if (getchar() != ' ') {
        cout << "error: expected empty space" << endl;
        abort();
    }
}