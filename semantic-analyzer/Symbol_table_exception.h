//
// Created by Luis on 2019-02-27.
//

#ifndef SYMBOLTABLE_SYMBOL_TABLE_EXCEPTION_H
#define SYMBOLTABLE_SYMBOL_TABLE_EXCEPTION_H

#include <exception>

class Decl;

class Symbol_table_exception: public std::exception {
public:

    explicit Symbol_table_exception(const char *msg_): msg{msg_} { }

    const char* what() const noexcept override { return msg; }

private:
    const char *msg;
};

class Duplicate_symbol_exception: public Symbol_table_exception {
public:
    Duplicate_symbol_exception(Decl *decl_):
        Symbol_table_exception("error: duplicate symbol inserted into table"), decl(decl_) { }

    Decl * get_decl() const { return decl; }
private:
    Decl *decl;
};

#endif // SYMBOLTABLE_SYMBOL_TABLE_EXCEPTION_H
