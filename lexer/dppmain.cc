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
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');
                    cin.putback('\n');
                    break;
                default:
                    cout << "error: unknown preprocessor error thrown" << endl;
                    abort();
            }

            cin.clear();
        }
    }
}

/** function definitions **/

/**
 * Responsible for processing the input stream.
 * Handles calling the appropriate functions for parsing tokens and or declaratives/comments.
 *
 * @throws Preprocessor_error, if encounters an error with declaratives or comments
*/
void handle_preprocessing(Tokens& tokens, int& line) {
    unsigned char c;
    bool in_multiline = false;

    while (cin >> noskipws >> c) {
        if (!in_multiline && c == '/' && cin.peek() == '*') {
            in_multiline = true;
            cin.ignore();
        } else if (in_multiline) {
            if (c == '*' && cin.peek() == '/') {
                in_multiline = false;
                cin.ignore();
            } else if (c == '\n') { 
                cout << c; 
                ++line; 
            }
        } else if (c == '"') {
            // in string literal, output until next "
            cout << c;
            while(cin >> noskipws >> c && c != '"') cout << c;
            cout << c;
        } else if (c == '#') {
            handle_declarative(tokens, line);
        }  else if (c == '/' && cin.peek() == '/') {
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            cin.putback('\n');
        } else if (c == '\n') {
            cout << c; ++line;
        } else {
            cout << c;
        }
    }

    if (in_multiline) {
        throw Preprocessor_error::comment;
    }
}


/*
 * Parses the input until a valid token is found or space is seen.
 * If valid token (previously defined with "#define") is found, replaces it with actual value.
 * If no valid token is found (found a whitespace) throws an error.
 *
 * @throws Preprocessor_error, if no valid token is found.
 */
void handle_declarative(Tokens& tokens, int& line) {
    unsigned char c;
    string str;
    while (cin >> c) {
        // declaratives are delimited by a whitespace
        // thus if we have not found a valid token or "define" then throw
        if (isspace(c)) {
            cin.putback(c);
            throw Preprocessor_error::directive;
        }

        str += c;
        if (str == def_c) {
            handle_creating_token(tokens);
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

/*
 * Creates the token and modifies the tokens hash map.
 *
 * @throws Preprocessor_error, if expected format is not followed.
 */
void handle_creating_token(Tokens& tokens) {
    read_space(); // expect space after "define"

    // read the token name
    string tname;
    cin >> tname;

    // token names must be all uppercase
    bool allupper = all_of(tname.begin(), tname.end(), [](char c) { return isupper(c); });
    if (!allupper) {
        throw Preprocessor_error::directive;
    }

    read_space(); // expect space after name of token

    string trep;
    getline(cin, trep);
    cin.putback('\n');

    tokens[tname] = trep;
}


/*
 * Attempts to read a space from the input stream, throws error if unable.
 *
 * @throws Preprocessor_error, if unable to read space character from stream.
 */
void read_space() {
    if (cin.peek() != ' ') {
        throw Preprocessor_error::directive;
    }
    
    cin.ignore();
}