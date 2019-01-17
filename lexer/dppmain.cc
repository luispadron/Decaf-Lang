/* File: dppmain.cc
 * ----------------
 * This file defines the main() routine for the preprocessor,
 * the filtering tool which runs before the compiler.
 */

#include "errors.h"

#include <algorithm>
#include <cctype>
#include <exception>
#include <iostream>
#include <limits>
#include <string>
#include <unordered_map>

using namespace std;

/** type-defs **/

using Tokens = unordered_map<string, string>;


/** constants **/

const char * const def_c = "define";


/** types **/

enum class Preprocessor_error {
    comment, directive
};


/** function declarations **/

void handle_preprocessing(Tokens&, int&);

void handle_declarative(Tokens&, int&);

void handle_creating_token(Tokens&);

void read_space();

/** main **/

int main() {
    int line = 1;
    Tokens tokens;

    while (true) {
        try {
            handle_preprocessing(tokens, line);
            // done preprocessing
            return 0;
        } catch (const Preprocessor_error &e) {
            switch (e) {
                case Preprocessor_error::comment:
                    ReportError::UntermComment();
                    break;
                case Preprocessor_error::directive:
                    ReportError::InvalidDirective(line);
                    break;
                default:
                    cout << "error: unknown preprocessor error thrown" << endl;
                    abort();
            }

            cin.clear();
            ++line;
        }
    }
}

void handle_preprocessing(Tokens& tokens, int& line) {
    unsigned char c;
    bool in_multiline = false;

    while (cin >> noskipws >> c) {
        if ((c == '/' && cin.peek() == '*') || (c == '*' && cin.peek() == '/')) {
            cin.ignore();
            in_multiline = !in_multiline;
        } else if (in_multiline) {
            if (c == '\n') { cout << c; ++line; }
        } else if (c == '#') {
            handle_declarative(tokens, line);
        } else if (c == '"') {
            // in string literal, output until next "
            cout << c;
            while(cin >> noskipws >> c && c != '"') cout << c;
            cout << c;
        } else if (c == '/' && cin.peek() == '/') {
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            cout << '\n';
            ++line;
        } else if (c == '\n') {
            cout << c;
            ++line;
        } else {
            cout << c;
        }
    }

    if (in_multiline) {
        throw Preprocessor_error::comment;
    }
}

/** function definitions **/

void handle_declarative(Tokens& tokens, int& line) {
    unsigned char c;
    string str;
    while (cin >> c) {
        // declaratives are delimited by a whitespace
        // thus if we have not found a valid token or "define" then throw
        if (isspace(c)) {
            throw Preprocessor_error::directive;
        }

        str += c;
        if (str == def_c) {
            handle_creating_token(tokens);
            ++line;
            break;
        } else {
            auto trep = tokens.find(str);
            if (trep != tokens.end()) {
                cout << trep->second;
                break;
            }
        }
    }
}

void handle_creating_token(Tokens& tokens) {
    read_space(); // expect space after "define"

    // read the token name
    string tname;
    cin >> tname;

    // token names must be all uppercase
    bool allupper = all_of(tname.begin(), tname.end(), [](char c) { return isupper(c); });
    if (!allupper) throw Preprocessor_error::directive;

    read_space(); // expect space after name of token

    string trep;
    getline(cin, trep);

    tokens[tname] = trep;
}

void read_space() {
    if (cin.get() != ' ') {
        throw Preprocessor_error::directive;
    }
}