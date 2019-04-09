## 
## Simple makefile for decaf programming projects
##


.PHONY: clean strip

# C++11 support on CAEN machines
PATH := /usr/um/gcc-4.7.0/bin:$(PATH) 
LD_LIBRARY_PATH := /usr/um/gcc-4.7.0/lib64 
LD_RUN_PATH := /usr/um/gcc-4.7.0/lib64

# Set the default target. When you make with no arguments,
# this will be the target built.
COMPILER = dcc
PRODUCTS = $(COMPILER) 
default: $(PRODUCTS)

# Set up the list of source and object files
SRCS = ast.cc ast_decl.cc ast_expr.cc ast_stmt.cc ast_type.cc codegen.cc tac.cc mips.cc errors.cc utility.cc main.cc ast_program.cc SymbolTable.cc Scope.cc Vtable.cc

# OBJS can deal with either .cc or .c files listed in SRCS
OBJS = lex.yy.o y.tab.o $(patsubst %.cc, %.o, $(filter %.cc,$(SRCS))) $(patsubst %.c, %.o, $(filter %.c, $(SRCS)))

JUNK = $(OBJS) lex.yy.c dpp.yy.c y.tab.c y.tab.h *.core core $(COMPILER).purify purify.log 

# Define the tools we are going to use
UNAME := $(shell uname -s)

ifeq ($(UNAME), Darwin)
	CC = g++-8
	LD = g++-8
else
	CC = g++
	LD = g++
endif
LEX = flex
YACC = bison

# Set up the necessary flags for the tools

# We want debugging and most warnings, but lex/yacc generate some
# static symbols we don't use, so turn off unused warnings to avoid clutter
# Also STL has some signed/unsigned comparisons we want to suppress
CFLAGS = -g -Wall -Wno-unused -Wno-sign-compare -std=c++11

# The -d flag tells lex to set up for debugging. Can turn on/off by
# setting value of global yy_flex_debug inside the scanner itself
LEXFLAGS = -d

# The -d flag tells yacc to generate header with token types
# The -v flag writes out a verbose description of the states and conflicts
# The -t flag turns on debugging capability
# The -y flag means imitate yacc's output file naming conventions
YACCFLAGS = -dvty

# Link with standard c library, math library, and lex library
LIBS = -lc -lm -ll

# Rules for various parts of the target

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $*.c

%.o: %.cc
	$(CC) $(CFLAGS) -c -o $@ $*.cc

lex.yy.c: scanner.l y.tab.h
	$(LEX) $(LEXFLAGS) scanner.l

y.tab.h y.tab.c: parser.y
	$(YACC) $(YACCFLAGS) parser.y

# rules to build compiler (dcc)

$(COMPILER) : $(OBJS)
	$(LD) -o $@ $(OBJS) $(LIBS)

$(COMPILER).purify : $(OBJS)
	purify -log-file=purify.log -cache-dir=/tmp/$(USER) -leaks-at-exit=no $(LD) -o $@ $(OBJS) $(LIBS)


# This target is to build small for testing (no debugging info), removes
# all intermediate products, too
strip : $(PRODUCTS)
	strip $(PRODUCTS)
	rm -rf $(JUNK)


# make depend will set up the header file dependencies for the 
# assignment.  You should make depend whenever you add a new header
# file to the project or move the project between machines
#
depend:
	gsed -i '/^# DO NOT DELETE$$/{q}' Makefile
	$(CC) -MM -MG $(SRCS) >> Makefile

clean:
	rm -f $(JUNK) y.output $(PRODUCTS)

# DO NOT DELETE
ast.o: ast.cc ast.h location.h SymbolTable.h Scope.h utility.h tac.h \
 list.h codegen.h mips.h errors.h ast_type.h ast_decl.h Vtable.h
ast_decl.o: ast_decl.cc ast_decl.h ast.h location.h SymbolTable.h Scope.h \
 utility.h tac.h list.h codegen.h mips.h errors.h ast_type.h Vtable.h \
 ast_expr.h ast_stmt.h
ast_expr.o: ast_expr.cc ast_expr.h ast.h location.h SymbolTable.h Scope.h \
 utility.h tac.h list.h codegen.h mips.h errors.h ast_decl.h ast_type.h \
 Vtable.h ast_stmt.h
ast_stmt.o: ast_stmt.cc ast_stmt.h list.h utility.h ast.h location.h \
 SymbolTable.h Scope.h tac.h codegen.h mips.h errors.h ast_type.h \
 ast_decl.h Vtable.h ast_expr.h
ast_type.o: ast_type.cc ast_type.h ast.h location.h SymbolTable.h Scope.h \
 utility.h tac.h list.h codegen.h mips.h errors.h ast_decl.h Vtable.h
codegen.o: codegen.cc codegen.h list.h utility.h tac.h errors.h \
 location.h mips.h
tac.o: tac.cc tac.h list.h utility.h mips.h
mips.o: mips.cc mips.h tac.h list.h utility.h
errors.o: errors.cc errors.h location.h scanner.h ast_type.h ast.h \
 SymbolTable.h Scope.h utility.h tac.h list.h codegen.h mips.h ast_expr.h \
 ast_decl.h Vtable.h ast_stmt.h
utility.o: utility.cc utility.h list.h tac.h ast_decl.h ast.h location.h \
 SymbolTable.h Scope.h codegen.h mips.h errors.h ast_type.h Vtable.h
main.o: main.cc utility.h errors.h location.h parser.h scanner.h list.h \
 ast.h SymbolTable.h Scope.h tac.h codegen.h mips.h ast_type.h ast_decl.h \
 Vtable.h ast_expr.h ast_stmt.h y.tab.h
ast_program.o: ast_program.cc ast_program.h ast.h location.h \
 SymbolTable.h Scope.h utility.h tac.h list.h codegen.h mips.h errors.h \
 ast_decl.h ast_type.h Vtable.h
SymbolTable.o: SymbolTable.cc SymbolTable.h Scope.h utility.h
Scope.o: Scope.cc Scope.h utility.h ast_decl.h ast.h location.h \
 SymbolTable.h tac.h list.h codegen.h mips.h errors.h ast_type.h Vtable.h
Vtable.o: Vtable.cc Vtable.h ast_decl.h ast.h location.h SymbolTable.h \
 Scope.h utility.h tac.h list.h codegen.h mips.h errors.h ast_type.h
