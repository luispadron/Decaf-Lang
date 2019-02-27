//
// Created by Luis on 2019-02-27.
//

#ifndef SYMBOLTABLE_SYMBOL_TABLE_EXCEPTION_H
#define SYMBOLTABLE_SYMBOL_TABLE_EXCEPTION_H

#include <exception>

class Symbol_table_exception: public std::exception {
public:

    explicit Symbol_table_exception(const char *msg_): msg{msg_} { }

    const char* what() const noexcept override { return msg; }

private:
    const char *msg;
};

#endif // SYMBOLTABLE_SYMBOL_TABLE_EXCEPTION_H
