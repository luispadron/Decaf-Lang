/* File: dppmain.cc
 * ----------------
 * This file defines the main() routine for the preprocessor,
 * the filtering tool which runs before the compiler.
 */

#include "errors.h"
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

void handle_creating_token(Tokens&);

void replace_token(Tokens&, const string&);

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
            if (c == '\n') cout << c;
            continue;
        } else if (c == '#') {
            string str;
            if ((cin >> str) && str == def_c) {
                handle_creating_token(tokens);
            } else {
                replace_token(tokens, str);
            }
            ++line;
        } else if (c == '"') {
            // in string literal, cout until next "
            cout << c;
            while(cin >> noskipws >> c && c != '"') cout << c;
            cout << c;
        } else if (c == '/' && cin.peek() == '/') {
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            cout << '\n';
            ++line;
        } else if (c == '\n') {
            ++line;
            cout << c;
        } else {
            cout << c;
        }
    }

    if (in_multiline) {
        throw Preprocessor_error::comment;
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

void replace_token(Tokens& tokens, const string& str) {
    auto trep = tokens.find(str);
    if (trep != tokens.end()) {
        cout << trep->second;
    } else {
        throw Preprocessor_error::directive;
    }
}

void read_space() {
    if (cin.get() != ' ') {
        throw Preprocessor_error::directive;
    }
}