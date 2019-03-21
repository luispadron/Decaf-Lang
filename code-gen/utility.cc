/* File: utiliy.cc
 * ---------------
 * Implementation of simple printing functions to report failures or
 * debugging information triggered by keys.
 */

#include "utility.h"
#include <stdarg.h>
#include <string.h>
#include "list.h"
#include "tac.h"
#include "ast_decl.h"

static List<const char*> debugKeys;
static const int BufferSize = 2048;

using namespace std;

void failure(const char *format, ...) {
    va_list args;
    char errbuf[BufferSize];

    va_start(args, format);
    vsprintf(errbuf, format, args);
    va_end(args);
    fflush(stdout);
    fprintf(stderr,"\n*** failure: %s\n\n", errbuf);
    abort();
}



int index_of(const char *key) {
    for (int i = 0; i < debugKeys.size(); i++)
        if (!strcmp(debugKeys.get(i), key)) return i;
    return -1;
}

bool is_debug_on(const char *key) {
    return (index_of(key) != -1);
}


void set_debug_for_key(const char *key, bool value) {
    int k = index_of(key);
    if (!value && k != -1)
        debugKeys.erase(k);
    else if (value && k == -1)
        debugKeys.append(key);
}



void debug_print(const char *key, const char *format, ...) {
    va_list args;
    char buf[BufferSize];

    if (!is_debug_on(key))
        return;

    va_start(args, format);
    vsprintf(buf, format, args);
    va_end(args);
    printf("+++ (%s): %s%s", key, buf, buf[strlen(buf)-1] != '\n'? "\n" : "");
}


void parse_command_line(int argc, char **argv) {
    if (argc == 1)
        return;

    if (strcmp(argv[1], "-d") != 0) { // first arg is not -d
        printf("Usage:   -d <debug-key-1> <debug-key-2> ... \n");
        exit(2);
    }

    for (int i = 2; i < argc; i++)
        set_debug_for_key(argv[i], true);
}