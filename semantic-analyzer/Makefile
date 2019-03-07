## 
## Simple makefile for decaf programming projects
##


.PHONY: clean strip

# Set the default target. When you make with no arguments,
# this will be the target built.
COMPILER = dcc
PRODUCTS = $(COMPILER) 
default: $(PRODUCTS)

# Set up the list of source and object files
SRCS = ast_program.cpp Scope.cpp Symbol_table.cpp ast.cpp ast_decl.cpp ast_expr.cpp ast_stmt.cpp ast_type.cpp errors.cpp utility.cpp main.cpp

# OBJS can deal with either .cpp or .c files listed in SRCS
OBJS = y.tab.o lex.yy.o $(patsubst %.cpp, %.o, $(filter %.cpp,$(SRCS))) $(patsubst %.c, %.o, $(filter %.c, $(SRCS)))

JUNK = $(OBJS) lex.yy.c dpp.yy.c y.tab.c y.tab.h *.core core $(COMPILER).purify purify.log 

# Define the tools we are going to use
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
CFLAGS = -std=c++11  -ggdb -Wall -Wno-unused -Wno-sign-compare

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

%.yy.o: %.yy.c
	$(CC) $(CFLAGS) -c -o $@ $*.yy.c

lex.yy.c: scanner.l parser.y y.tab.h 
	$(LEX) $(LEXFLAGS) scanner.l

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) -c -o y.tab.o y.tab.c

y.tab.h y.tab.c: parser.y
	$(YACC) $(YACCFLAGS) parser.y
%.o: %.cpp
	$(CC) $(CFLAGS) -c -o $@ $*.cpp

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
	sed -i '/^# DO NOT DELETE$$/{q}' Makefile
	$(CC) -MM -MG $(SRCS) >> Makefile

clean:
	rm -f $(JUNK) y.output $(PRODUCTS)

# DO NOT DELETE
ast_program.o: ast_program.cpp ast_program.h ast.h Symbol_table.h Scope.h \
 Symbol_table_exception.h location.h list.h utility.h ast_decl.h \
 ast_type.h
Scope.o: Scope.cpp Scope.h Symbol_table_exception.h
Symbol_table.o: Symbol_table.cpp Symbol_table.h Scope.h \
 Symbol_table_exception.h
ast.o: ast.cpp ast.h Symbol_table.h Scope.h Symbol_table_exception.h \
 location.h ast_type.h list.h utility.h ast_decl.h errors.h
ast_decl.o: ast_decl.cpp ast_decl.h ast.h Symbol_table.h Scope.h \
 Symbol_table_exception.h location.h ast_type.h list.h utility.h \
 ast_stmt.h errors.h
ast_expr.o: ast_expr.cpp ast_expr.h ast.h Symbol_table.h Scope.h \
 Symbol_table_exception.h location.h ast_stmt.h list.h utility.h \
 ast_type.h ast_decl.h errors.h
ast_stmt.o: ast_stmt.cpp ast_stmt.h list.h Symbol_table.h Scope.h \
 Symbol_table_exception.h utility.h ast.h location.h ast_type.h \
 ast_decl.h ast_expr.h
ast_type.o: ast_type.cpp ast_type.h ast.h Symbol_table.h Scope.h \
 Symbol_table_exception.h location.h list.h utility.h ast_decl.h errors.h
errors.o: errors.cpp errors.h location.h scanner.h ast_type.h ast.h \
 Symbol_table.h Scope.h Symbol_table_exception.h list.h utility.h \
 ast_expr.h ast_stmt.h ast_decl.h
utility.o: utility.cpp utility.h list.h Symbol_table.h Scope.h \
 Symbol_table_exception.h
main.o: main.cpp utility.h errors.h location.h parser.h scanner.h list.h \
 Symbol_table.h Scope.h Symbol_table_exception.h ast.h ast_type.h \
 ast_decl.h ast_expr.h ast_stmt.h y.tab.h
