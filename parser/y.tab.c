/* A Bison parser, made by GNU Bison 3.3.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2019 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.3.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 6 "parser.y" /* yacc.c:337  */

#include <algorithm>
#include "scanner.h" // for yylex
#include "parser.h"
#include "errors.h"

void yyerror(const char *msg);                  // standard error-handling routine

/*
 * Constants
 * ---------
 */
const char * const equalOp_c = "=";             // '=' character needed for assignment, etc
const char * const lessThanOp_c = "<";          // '<' less than operator
const char * const lessThanEqlOp_c = "<=";      // '<=' less than or equal operator
const char * const greaterThanOp_c = ">";       // '>' greater than operator
const char * const greaterThanEqlOp_C = ">=";   // '>=' greater than or equal operator
const char * const equalEqualOp_C = "==";       // '==' equal to operator
const char * const notEqualOp_c = "!=";         // '!=' not equal to operator
const char * const plusOp_c = "+";              // '+' plus operator
const char * const minusOp_c = "-";             // '-' minus operator
const char * const multOp_c = "*";              // '*' multiplication operator
const char * const divOp_c = "/";               // '/' division operator
const char * const modOp_c = "%";               // '%' (mod) operator
const char * const notOp_c = "!";               // '!' not (negation) operator
const char * const andOp_c = "&&";              // '&&' and operator
const char * const orOp_c = "||";               // '||' or operator
const char * const incremOp_c = "++";           // '++' increment operator
const char * const decremOp_c = "--";           // '--' decrement operator


#line 102 "y.tab.c" /* yacc.c:337  */
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_Void = 258,
    T_Bool = 259,
    T_Int = 260,
    T_Double = 261,
    T_String = 262,
    T_Class = 263,
    T_LessEqual = 264,
    T_GreaterEqual = 265,
    T_Equal = 266,
    T_NotEqual = 267,
    T_Dims = 268,
    T_And = 269,
    T_Or = 270,
    T_Null = 271,
    T_Extends = 272,
    T_This = 273,
    T_Interface = 274,
    T_Implements = 275,
    T_While = 276,
    T_For = 277,
    T_If = 278,
    T_Else = 279,
    T_Return = 280,
    T_Break = 281,
    T_New = 282,
    T_NewArray = 283,
    T_Print = 284,
    T_ReadInteger = 285,
    T_ReadLine = 286,
    T_Identifier = 287,
    T_StringConstant = 288,
    T_IntConstant = 289,
    T_DoubleConstant = 290,
    T_BoolConstant = 291,
    T_Increm = 292,
    T_Decrem = 293,
    T_Switch = 294,
    T_Case = 295,
    T_Default = 296,
    UMINUS = 297
  };
#endif
/* Tokens.  */
#define T_Void 258
#define T_Bool 259
#define T_Int 260
#define T_Double 261
#define T_String 262
#define T_Class 263
#define T_LessEqual 264
#define T_GreaterEqual 265
#define T_Equal 266
#define T_NotEqual 267
#define T_Dims 268
#define T_And 269
#define T_Or 270
#define T_Null 271
#define T_Extends 272
#define T_This 273
#define T_Interface 274
#define T_Implements 275
#define T_While 276
#define T_For 277
#define T_If 278
#define T_Else 279
#define T_Return 280
#define T_Break 281
#define T_New 282
#define T_NewArray 283
#define T_Print 284
#define T_ReadInteger 285
#define T_ReadLine 286
#define T_Identifier 287
#define T_StringConstant 288
#define T_IntConstant 289
#define T_DoubleConstant 290
#define T_BoolConstant 291
#define T_Increm 292
#define T_Decrem 293
#define T_Switch 294
#define T_Case 295
#define T_Default 296
#define UMINUS 297

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 41 "parser.y" /* yacc.c:352  */

    int integerConstant;
    bool boolConstant;
    char *stringConstant;
    double doubleConstant;
    char identifier[MaxIdentLen + 1]; // +1 for terminating null

    Identifier *ident;

    Decl *decl;
    List<Decl*> *declList;

    VarDecl *varDecl;
    List<VarDecl*> *varDeclList;

    ClassDecl *classDecl;
    List<NamedType*> *namedTypeList;

    InterfaceDecl *interfaceDecl;

    Type *type;

    FnDecl *fnDecl;

    Stmt *stmt;
    List<Stmt*> *stmtList;
    StmtBlock *stmtBlock;
    SwitchCaseStmt *switchCaseStmt;
    List<SwitchCaseStmt*> *switchCaseList;

    Expr *expr;
    List<Expr*> *exprList;

#line 263 "y.tab.c" /* yacc.c:352  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
             && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  23
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   580

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  62
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  38
/* YYNRULES -- Number of rules.  */
#define YYNRULES  108
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  227

#define YYUNDEFTOK  2
#define YYMAXUTOK   297

/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  ((unsigned) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    51,     2,     2,     2,    49,     2,     2,
      54,    55,    47,    45,    56,    46,    52,    48,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    59,    53,
      43,    42,    44,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    60,     2,    61,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    57,     2,    58,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    50
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   145,   145,   155,   157,   161,   163,   165,   167,   171,
     173,   177,   181,   185,   187,   189,   191,   193,   195,   197,
     201,   207,   215,   217,   219,   223,   226,   234,   237,   247,
     249,   253,   255,   259,   261,   265,   270,   272,   276,   279,
     284,   288,   290,   294,   296,   298,   300,   302,   304,   306,
     308,   310,   312,   316,   318,   322,   326,   330,   332,   336,
     341,   345,   349,   353,   357,   361,   363,   367,   369,   373,
     375,   377,   379,   381,   383,   385,   387,   389,   391,   393,
     395,   397,   399,   401,   403,   405,   407,   409,   411,   413,
     415,   417,   419,   421,   423,   425,   429,   431,   433,   437,
     439,   443,   445,   449,   451,   453,   455,   457,   461
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_Void", "T_Bool", "T_Int", "T_Double",
  "T_String", "T_Class", "T_LessEqual", "T_GreaterEqual", "T_Equal",
  "T_NotEqual", "T_Dims", "T_And", "T_Or", "T_Null", "T_Extends", "T_This",
  "T_Interface", "T_Implements", "T_While", "T_For", "T_If", "T_Else",
  "T_Return", "T_Break", "T_New", "T_NewArray", "T_Print", "T_ReadInteger",
  "T_ReadLine", "T_Identifier", "T_StringConstant", "T_IntConstant",
  "T_DoubleConstant", "T_BoolConstant", "T_Increm", "T_Decrem", "T_Switch",
  "T_Case", "T_Default", "'='", "'<'", "'>'", "'+'", "'-'", "'*'", "'/'",
  "'%'", "UMINUS", "'!'", "'.'", "';'", "'('", "')'", "','", "'{'", "'}'",
  "':'", "'['", "']'", "$accept", "Program", "DeclList", "Decl",
  "VariableDeclList", "VariableDecl", "Variable", "Type", "FunctionDecl",
  "Formals", "ClassDecl", "NamedTypeList", "FieldList", "Field",
  "InterfaceDecl", "PrototypeList", "Prototype", "StmtBlock", "StmtList",
  "Stmt", "SwitchCaseList", "SwitchCase", "SwitchDefaultCase", "IfStmt",
  "SwitchStmt", "WhileStmt", "ForStmt", "ReturnStmt", "BreakStmt",
  "PrintStmt", "ExprList", "OptExpr", "Expr", "LValue", "Call", "Actuals",
  "Constant", "Ident", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,    61,    60,    62,    43,    45,    42,    47,    37,
     297,    33,    46,    59,    40,    41,    44,   123,   125,    58,
      91,    93
};
# endif

#define YYPACT_NINF -124

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-124)))

#define YYTABLE_NINF -19

#define yytable_value_is_error(Yytable_value) \
  (!!((Yytable_value) == (-19)))

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     166,   -22,  -124,  -124,  -124,  -124,   -22,  -124,   -22,  -124,
      16,   166,  -124,  -124,   -34,     7,  -124,  -124,  -124,  -124,
     -32,    17,   -15,  -124,  -124,  -124,  -124,    12,   478,   -22,
     -22,  -124,  -124,   478,  -124,     7,    44,    -2,   -25,  -124,
      20,    54,    52,  -124,    26,   478,   -22,  -124,  -124,  -124,
    -124,  -124,  -124,  -124,   -22,  -124,     7,  -124,    26,  -124,
    -124,  -124,    18,    86,   144,    34,    49,  -124,   183,  -124,
    -124,  -124,   478,   478,    64,  -124,    56,    89,    91,   526,
      66,   105,   107,   112,   126,   129,  -124,  -124,  -124,  -124,
     139,   526,   526,  -124,   526,  -124,  -124,   133,   495,  -124,
    -124,  -124,  -124,  -124,  -124,  -124,   235,   158,  -124,  -124,
      -1,   149,    65,    84,   526,   526,   526,  -124,   141,   401,
     167,  -124,   -22,   526,   526,   148,   165,   526,    -9,    -9,
     260,  -124,  -124,   526,   526,   526,   526,   526,   526,   526,
     526,   526,   526,   526,   526,   526,   -22,  -124,   526,  -124,
    -124,   526,   526,  -124,   170,   171,   282,   179,   307,  -124,
     178,   329,   102,   401,  -124,  -124,   354,  -124,   429,   429,
     455,   455,   411,   411,   429,   429,   115,   115,    -9,    -9,
      -9,   181,   216,   401,   182,   184,  -124,  -124,   495,   526,
     495,  -124,   478,   188,   526,   185,   526,  -124,  -124,  -124,
     381,   219,    -8,  -124,   401,   208,   196,   526,   495,  -124,
     218,   137,  -124,  -124,   198,  -124,   195,   197,  -124,   199,
     495,   495,   495,  -124,  -124,  -124,  -124
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,    15,    13,    14,    17,     0,    16,     0,   108,
       0,     2,     4,     5,     0,     0,     6,     7,     8,    18,
       0,     0,     0,     1,     3,    11,    19,    12,    24,     0,
       0,    32,    37,    24,    23,     0,     0,     0,     0,    30,
       0,     0,     0,    12,     0,     0,     0,    32,    32,    29,
      25,    34,    33,    31,     0,    35,     0,    36,     0,    10,
      21,    22,     0,     0,     0,     0,     0,    20,    42,    32,
      26,    27,    24,    24,   107,    74,     0,     0,     0,    68,
       0,     0,     0,     0,     0,     0,   106,   103,   104,   105,
       0,     0,     0,    43,     0,     9,    52,     0,    42,    45,
      46,    47,    48,    50,    49,    51,     0,    73,    75,    72,
      96,     0,     0,     0,     0,    68,     0,   107,     0,    67,
      96,    63,     0,     0,     0,     0,     0,     0,    82,    91,
       0,    40,    41,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    44,     0,    70,
      71,     0,   102,    28,     0,     0,     0,     0,     0,    62,
       0,     0,     0,    66,    92,    93,     0,    76,    84,    86,
      87,    88,    89,    90,    83,    85,    77,    78,    79,    80,
      81,    97,     0,    69,   101,     0,    39,    38,     0,     0,
       0,    94,     0,     0,     0,     0,   102,    98,    99,    60,
       0,    57,     0,    64,    65,     0,     0,    68,     0,    95,
       0,     0,    54,   100,     0,    58,     0,     0,    53,     0,
       0,    42,    42,    59,    61,    55,    56
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -124,  -124,  -124,   244,  -124,     3,   407,   -24,    87,    43,
    -124,   212,    32,  -124,  -124,  -124,  -124,    51,   -85,  -123,
    -124,    55,  -124,  -124,  -124,  -124,  -124,  -124,  -124,  -124,
     143,  -113,   -10,  -124,  -124,    77,  -124,     0
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    10,    11,    12,    68,    51,    14,    15,    52,    36,
      17,    38,    40,    53,    18,    41,    57,    96,    97,    98,
     211,   212,   219,    99,   100,   101,   102,   103,   104,   105,
     184,   118,   106,   107,   108,   185,   109,   120
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      19,    20,   157,    13,    35,    26,    21,     9,    22,    35,
       9,    19,   -18,   132,    13,    27,    23,    56,    46,    25,
      26,    35,    28,     1,     2,     3,     4,     5,    19,    37,
      39,   -18,    48,    19,    29,    43,     7,    30,    49,     9,
      19,    19,    32,   146,    35,    19,    39,   209,    35,    35,
       9,   148,     9,   152,    65,    47,    66,    54,     2,     3,
       4,     5,    49,    19,    19,   199,    33,   201,   110,   119,
       7,    95,    19,    19,    31,    69,    42,   -16,    50,    63,
      64,   128,   129,    59,   130,   215,     9,    16,    72,     1,
       2,     3,     4,     5,   214,    60,   -16,   224,    16,    44,
      45,   111,     7,    73,   156,   119,   158,    58,    45,    67,
     114,    19,    55,   161,   163,   112,   113,   166,     9,   121,
     154,    45,   160,   168,   169,   170,   171,   172,   173,   174,
     175,   176,   177,   178,   179,   180,   225,   226,   182,   155,
      45,   183,   163,   115,    70,   116,   181,     1,     2,     3,
       4,     5,     1,     2,     3,     4,     5,   193,   194,   122,
       7,   123,   143,   144,   145,     7,   124,   146,   202,     1,
       2,     3,     4,     5,     6,   148,     9,   210,   217,   200,
     125,     9,     7,   126,   204,     8,   163,     2,     3,     4,
       5,   131,    19,   127,   159,   149,   150,   119,     9,    74,
     151,    75,    71,   164,    76,    77,    78,   153,    79,    80,
      81,    82,    83,    84,    85,     9,    86,    87,    88,    89,
     165,   152,    90,   186,   187,   133,   134,   135,   136,    91,
     137,   138,   189,   191,    92,   196,    93,    94,   194,   198,
      59,   203,   205,   208,   133,   134,   135,   136,   210,   137,
     138,   213,   216,   220,   221,    24,   222,   223,    62,   139,
     140,   141,   142,   143,   144,   145,   218,   162,   146,   133,
     134,   135,   136,   206,   137,   138,   148,   197,   139,   140,
     141,   142,   143,   144,   145,     0,     0,   146,   147,     0,
       0,   133,   134,   135,   136,   148,   137,   138,     0,     0,
       0,     0,     0,   139,   140,   141,   142,   143,   144,   145,
       0,     0,   146,     0,     0,   167,   133,   134,   135,   136,
     148,   137,   138,     0,     0,   139,   140,   141,   142,   143,
     144,   145,     0,     0,   146,     0,     0,   188,   133,   134,
     135,   136,   148,   137,   138,     0,     0,     0,     0,     0,
     139,   140,   141,   142,   143,   144,   145,     0,     0,   146,
       0,     0,   190,   133,   134,   135,   136,   148,   137,   138,
       0,     0,   139,   140,   141,   142,   143,   144,   145,     0,
       0,   146,     0,     0,     0,   192,     0,     0,     0,   148,
     133,   134,   135,   136,     0,   137,   138,   139,   140,   141,
     142,   143,   144,   145,     0,     0,   146,     0,     0,   195,
     133,   134,   135,   136,   148,   137,   138,     0,     0,     0,
     133,   134,   135,   136,   139,   140,   141,   142,   143,   144,
     145,     0,     0,   146,   207,    34,     0,     0,   -19,   -19,
      34,   148,     0,     0,   139,   140,   141,   142,   143,   144,
     145,     0,    61,   146,   139,   140,   141,   142,   143,   144,
     145,   148,     0,   146,   133,   134,     0,     0,     0,     0,
       0,   148,   -19,   -19,   141,   142,   143,   144,   145,    34,
      34,   146,     2,     3,     4,     5,     0,     0,     0,   148,
       0,     0,     0,     0,     7,     0,     0,     0,   139,   140,
     141,   142,   143,   144,   145,     0,     0,   146,     0,     0,
       9,   117,     0,    75,     0,   148,    76,    77,    78,     0,
      79,    80,    81,    82,    83,    84,    85,     9,    86,    87,
      88,    89,     0,     0,    90,     0,     0,     0,     0,     0,
       0,    91,   117,     0,    75,     0,    92,     0,    93,    94,
       0,     0,    59,    81,    82,     0,    84,    85,     9,    86,
      87,    88,    89,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    91,     0,     0,     0,     0,    92,     0,     0,
      94
};

static const yytype_int16 yycheck[] =
{
       0,     1,   115,     0,    28,    13,     6,    32,     8,    33,
      32,    11,    13,    98,    11,    15,     0,    41,    20,    53,
      13,    45,    54,     3,     4,     5,     6,     7,    28,    29,
      30,    32,    57,    33,    17,    35,    16,    20,    38,    32,
      40,    41,    57,    52,    68,    45,    46,    55,    72,    73,
      32,    60,    32,    54,    54,    57,    56,     3,     4,     5,
       6,     7,    62,    63,    64,   188,    54,   190,    68,    79,
      16,    68,    72,    73,    57,    57,    33,    13,    58,    47,
      48,    91,    92,    57,    94,   208,    32,     0,    54,     3,
       4,     5,     6,     7,   207,    44,    32,   220,    11,    55,
      56,    69,    16,    54,   114,   115,   116,    55,    56,    58,
      54,   111,    58,   123,   124,    72,    73,   127,    32,    53,
      55,    56,   122,   133,   134,   135,   136,   137,   138,   139,
     140,   141,   142,   143,   144,   145,   221,   222,   148,    55,
      56,   151,   152,    54,    58,    54,   146,     3,     4,     5,
       6,     7,     3,     4,     5,     6,     7,    55,    56,    54,
      16,    54,    47,    48,    49,    16,    54,    52,   192,     3,
       4,     5,     6,     7,     8,    60,    32,    40,    41,   189,
      54,    32,    16,    54,   194,    19,   196,     4,     5,     6,
       7,    58,   192,    54,    53,    37,    38,   207,    32,    16,
      42,    18,    58,    55,    21,    22,    23,    58,    25,    26,
      27,    28,    29,    30,    31,    32,    33,    34,    35,    36,
      55,    54,    39,    53,    53,     9,    10,    11,    12,    46,
      14,    15,    53,    55,    51,    54,    53,    54,    56,    55,
      57,    53,    57,    24,     9,    10,    11,    12,    40,    14,
      15,    55,    34,    55,    59,    11,    59,    58,    46,    43,
      44,    45,    46,    47,    48,    49,   211,   124,    52,     9,
      10,    11,    12,   196,    14,    15,    60,    61,    43,    44,
      45,    46,    47,    48,    49,    -1,    -1,    52,    53,    -1,
      -1,     9,    10,    11,    12,    60,    14,    15,    -1,    -1,
      -1,    -1,    -1,    43,    44,    45,    46,    47,    48,    49,
      -1,    -1,    52,    -1,    -1,    55,     9,    10,    11,    12,
      60,    14,    15,    -1,    -1,    43,    44,    45,    46,    47,
      48,    49,    -1,    -1,    52,    -1,    -1,    55,     9,    10,
      11,    12,    60,    14,    15,    -1,    -1,    -1,    -1,    -1,
      43,    44,    45,    46,    47,    48,    49,    -1,    -1,    52,
      -1,    -1,    55,     9,    10,    11,    12,    60,    14,    15,
      -1,    -1,    43,    44,    45,    46,    47,    48,    49,    -1,
      -1,    52,    -1,    -1,    -1,    56,    -1,    -1,    -1,    60,
       9,    10,    11,    12,    -1,    14,    15,    43,    44,    45,
      46,    47,    48,    49,    -1,    -1,    52,    -1,    -1,    55,
       9,    10,    11,    12,    60,    14,    15,    -1,    -1,    -1,
       9,    10,    11,    12,    43,    44,    45,    46,    47,    48,
      49,    -1,    -1,    52,    53,    28,    -1,    -1,     9,    10,
      33,    60,    -1,    -1,    43,    44,    45,    46,    47,    48,
      49,    -1,    45,    52,    43,    44,    45,    46,    47,    48,
      49,    60,    -1,    52,     9,    10,    -1,    -1,    -1,    -1,
      -1,    60,    43,    44,    45,    46,    47,    48,    49,    72,
      73,    52,     4,     5,     6,     7,    -1,    -1,    -1,    60,
      -1,    -1,    -1,    -1,    16,    -1,    -1,    -1,    43,    44,
      45,    46,    47,    48,    49,    -1,    -1,    52,    -1,    -1,
      32,    16,    -1,    18,    -1,    60,    21,    22,    23,    -1,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    -1,    -1,    39,    -1,    -1,    -1,    -1,    -1,
      -1,    46,    16,    -1,    18,    -1,    51,    -1,    53,    54,
      -1,    -1,    57,    27,    28,    -1,    30,    31,    32,    33,
      34,    35,    36,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    46,    -1,    -1,    -1,    -1,    51,    -1,    -1,
      54
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     4,     5,     6,     7,     8,    16,    19,    32,
      63,    64,    65,    67,    68,    69,    70,    72,    76,    99,
      99,    99,    99,     0,    65,    53,    13,    99,    54,    17,
      20,    57,    57,    54,    68,    69,    71,    99,    73,    99,
      74,    77,    71,    99,    55,    56,    20,    57,    57,    99,
      58,    67,    70,    75,     3,    58,    69,    78,    55,    57,
      79,    68,    73,    74,    74,    99,    99,    79,    66,    57,
      58,    58,    54,    54,    16,    18,    21,    22,    23,    25,
      26,    27,    28,    29,    30,    31,    33,    34,    35,    36,
      39,    46,    51,    53,    54,    67,    79,    80,    81,    85,
      86,    87,    88,    89,    90,    91,    94,    95,    96,    98,
      99,    74,    71,    71,    54,    54,    54,    16,    93,    94,
      99,    53,    54,    54,    54,    54,    54,    54,    94,    94,
      94,    58,    80,     9,    10,    11,    12,    14,    15,    43,
      44,    45,    46,    47,    48,    49,    52,    53,    60,    37,
      38,    42,    54,    58,    55,    55,    94,    93,    94,    53,
      99,    94,    92,    94,    55,    55,    94,    55,    94,    94,
      94,    94,    94,    94,    94,    94,    94,    94,    94,    94,
      94,    99,    94,    94,    92,    97,    53,    53,    55,    53,
      55,    55,    56,    55,    56,    55,    54,    61,    55,    81,
      94,    81,    69,    53,    94,    57,    97,    53,    24,    55,
      40,    82,    83,    55,    93,    81,    34,    41,    83,    84,
      55,    59,    59,    58,    81,    80,    80
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    62,    63,    64,    64,    65,    65,    65,    65,    66,
      66,    67,    68,    69,    69,    69,    69,    69,    69,    69,
      70,    70,    71,    71,    71,    72,    72,    72,    72,    73,
      73,    74,    74,    75,    75,    76,    77,    77,    78,    78,
      79,    80,    80,    81,    81,    81,    81,    81,    81,    81,
      81,    81,    81,    82,    82,    83,    84,    85,    85,    86,
      87,    88,    89,    90,    91,    92,    92,    93,    93,    94,
      94,    94,    94,    94,    94,    94,    94,    94,    94,    94,
      94,    94,    94,    94,    94,    94,    94,    94,    94,    94,
      94,    94,    94,    94,    94,    94,    95,    95,    95,    96,
      96,    97,    97,    98,    98,    98,    98,    98,    99
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     1,     2,
       0,     2,     2,     1,     1,     1,     1,     1,     1,     2,
       6,     6,     3,     1,     0,     5,     7,     7,     9,     2,
       1,     2,     0,     1,     1,     5,     2,     0,     6,     6,
       4,     2,     0,     1,     2,     1,     1,     1,     1,     1,
       1,     1,     1,     2,     1,     4,     3,     5,     7,     8,
       5,     9,     3,     2,     5,     3,     1,     1,     0,     3,
       2,     2,     1,     1,     1,     1,     3,     3,     3,     3,
       3,     3,     2,     3,     3,     3,     3,     3,     3,     3,
       3,     2,     3,     3,     4,     6,     1,     3,     4,     4,
       6,     1,     0,     1,     1,     1,     1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

YY_ATTRIBUTE_UNUSED
static int
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  int res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
 }

#  define YY_LOCATION_PRINT(File, Loc)          \
  yy_location_print_ (File, &(Loc))

# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value, Location); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  YYUSE (yylocationp);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  YY_LOCATION_PRINT (yyo, *yylocationp);
  YYFPRINTF (yyo, ": ");
  yy_symbol_value_print (yyo, yytype, yyvaluep, yylocationp);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule)
{
  unsigned long yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                       , &(yylsp[(yyi + 1) - (yynrhs)])                       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return (YYSIZE_T) (yystpcpy (yyres, yystr) - yyres);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp)
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Location data for the lookahead symbol.  */
YYLTYPE yylloc
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.
       'yyls': related to locations.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[3];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yylsp = yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  yylsp[0] = yylloc;
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yynewstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  *yyssp = (yytype_int16) yystate;

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = (YYSIZE_T) (yyssp - yyss + 1);

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yyls1, yysize * sizeof (*yylsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
        yyls = yyls1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location. */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  yyerror_range[1] = yyloc;
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 146 "parser.y" /* yacc.c:1667  */
    {
            Program *program = new Program((yyvsp[0].declList));
            // if no errors, advance to next phase
            if (ReportError::NumErrors() == 0)
                program->Print(0);
        }
#line 1701 "y.tab.c" /* yacc.c:1667  */
    break;

  case 3:
#line 155 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList)=(yyvsp[-1].declList))->Append((yyvsp[0].decl)); }
#line 1707 "y.tab.c" /* yacc.c:1667  */
    break;

  case 4:
#line 157 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList) = new List<Decl*>)->Append((yyvsp[0].decl)); }
#line 1713 "y.tab.c" /* yacc.c:1667  */
    break;

  case 5:
#line 161 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].varDecl); }
#line 1719 "y.tab.c" /* yacc.c:1667  */
    break;

  case 6:
#line 163 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].fnDecl); }
#line 1725 "y.tab.c" /* yacc.c:1667  */
    break;

  case 7:
#line 165 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].classDecl); }
#line 1731 "y.tab.c" /* yacc.c:1667  */
    break;

  case 8:
#line 167 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].interfaceDecl); }
#line 1737 "y.tab.c" /* yacc.c:1667  */
    break;

  case 9:
#line 171 "parser.y" /* yacc.c:1667  */
    { ((yyval.varDeclList)=(yyvsp[-1].varDeclList))->Append((yyvsp[0].varDecl)); }
#line 1743 "y.tab.c" /* yacc.c:1667  */
    break;

  case 10:
#line 173 "parser.y" /* yacc.c:1667  */
    { (yyval.varDeclList) = new List<VarDecl*>; }
#line 1749 "y.tab.c" /* yacc.c:1667  */
    break;

  case 11:
#line 177 "parser.y" /* yacc.c:1667  */
    { (yyval.varDecl) = (yyvsp[-1].varDecl); }
#line 1755 "y.tab.c" /* yacc.c:1667  */
    break;

  case 12:
#line 181 "parser.y" /* yacc.c:1667  */
    { (yyval.varDecl) = new VarDecl((yyvsp[0].ident), (yyvsp[-1].type)); }
#line 1761 "y.tab.c" /* yacc.c:1667  */
    break;

  case 13:
#line 185 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::intType; }
#line 1767 "y.tab.c" /* yacc.c:1667  */
    break;

  case 14:
#line 187 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::doubleType; }
#line 1773 "y.tab.c" /* yacc.c:1667  */
    break;

  case 15:
#line 189 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::boolType; }
#line 1779 "y.tab.c" /* yacc.c:1667  */
    break;

  case 16:
#line 191 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::nullType; }
#line 1785 "y.tab.c" /* yacc.c:1667  */
    break;

  case 17:
#line 193 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::stringType; }
#line 1791 "y.tab.c" /* yacc.c:1667  */
    break;

  case 18:
#line 195 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = new NamedType((yyvsp[0].ident)); }
#line 1797 "y.tab.c" /* yacc.c:1667  */
    break;

  case 19:
#line 197 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = new ArrayType((yylsp[-1]), (yyvsp[-1].type)); }
#line 1803 "y.tab.c" /* yacc.c:1667  */
    break;

  case 20:
#line 202 "parser.y" /* yacc.c:1667  */
    { 
            (yyval.fnDecl) = new FnDecl((yyvsp[-4].ident), (yyvsp[-5].type), (yyvsp[-2].varDeclList));
            (yyval.fnDecl)->SetFunctionBody((yyvsp[0].stmtBlock));
        }
#line 1812 "y.tab.c" /* yacc.c:1667  */
    break;

  case 21:
#line 208 "parser.y" /* yacc.c:1667  */
    {
            (yyval.fnDecl) = new FnDecl((yyvsp[-4].ident), Type::voidType, (yyvsp[-2].varDeclList));
            (yyval.fnDecl)->SetFunctionBody((yyvsp[0].stmtBlock));
        }
#line 1821 "y.tab.c" /* yacc.c:1667  */
    break;

  case 22:
#line 215 "parser.y" /* yacc.c:1667  */
    { ((yyval.varDeclList)=(yyvsp[-2].varDeclList))->Append((yyvsp[0].varDecl)); }
#line 1827 "y.tab.c" /* yacc.c:1667  */
    break;

  case 23:
#line 217 "parser.y" /* yacc.c:1667  */
    { ((yyval.varDeclList) = new List<VarDecl*>)->Append((yyvsp[0].varDecl)); }
#line 1833 "y.tab.c" /* yacc.c:1667  */
    break;

  case 24:
#line 219 "parser.y" /* yacc.c:1667  */
    { (yyval.varDeclList) = new List<VarDecl*>; }
#line 1839 "y.tab.c" /* yacc.c:1667  */
    break;

  case 25:
#line 224 "parser.y" /* yacc.c:1667  */
    { (yyval.classDecl) = new ClassDecl((yyvsp[-3].ident), nullptr, new List<NamedType*>, (yyvsp[-1].declList)); }
#line 1845 "y.tab.c" /* yacc.c:1667  */
    break;

  case 26:
#line 227 "parser.y" /* yacc.c:1667  */
    { 
            (yyval.classDecl) = new ClassDecl((yyvsp[-5].ident), 
                               new NamedType((yyvsp[-3].ident)), 
                               new List<NamedType*>, 
                               (yyvsp[-1].declList)); 
        }
#line 1856 "y.tab.c" /* yacc.c:1667  */
    break;

  case 27:
#line 235 "parser.y" /* yacc.c:1667  */
    { (yyval.classDecl) = new ClassDecl((yyvsp[-5].ident), nullptr, (yyvsp[-3].namedTypeList), (yyvsp[-1].declList)); }
#line 1862 "y.tab.c" /* yacc.c:1667  */
    break;

  case 28:
#line 238 "parser.y" /* yacc.c:1667  */
    { 
            (yyval.classDecl) = new ClassDecl((yyvsp[-7].ident), 
                               new NamedType((yyvsp[-5].ident)), 
                               (yyvsp[-3].namedTypeList), 
                               (yyvsp[-1].declList)); 
        }
#line 1873 "y.tab.c" /* yacc.c:1667  */
    break;

  case 29:
#line 247 "parser.y" /* yacc.c:1667  */
    { ((yyval.namedTypeList)=(yyvsp[-1].namedTypeList))->Append(new NamedType((yyvsp[0].ident))); }
#line 1879 "y.tab.c" /* yacc.c:1667  */
    break;

  case 30:
#line 249 "parser.y" /* yacc.c:1667  */
    { ((yyval.namedTypeList) = new List<NamedType*>)->Append(new NamedType((yyvsp[0].ident))); }
#line 1885 "y.tab.c" /* yacc.c:1667  */
    break;

  case 31:
#line 253 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList)=(yyvsp[-1].declList))->Append((yyvsp[0].decl)); }
#line 1891 "y.tab.c" /* yacc.c:1667  */
    break;

  case 32:
#line 255 "parser.y" /* yacc.c:1667  */
    { (yyval.declList) = new List<Decl*>; }
#line 1897 "y.tab.c" /* yacc.c:1667  */
    break;

  case 33:
#line 259 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].fnDecl); }
#line 1903 "y.tab.c" /* yacc.c:1667  */
    break;

  case 34:
#line 261 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].varDecl); }
#line 1909 "y.tab.c" /* yacc.c:1667  */
    break;

  case 35:
#line 266 "parser.y" /* yacc.c:1667  */
    { (yyval.interfaceDecl) = new InterfaceDecl((yyvsp[-3].ident), (yyvsp[-1].declList)); }
#line 1915 "y.tab.c" /* yacc.c:1667  */
    break;

  case 36:
#line 270 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList)=(yyvsp[-1].declList))->Append((yyvsp[0].decl)); }
#line 1921 "y.tab.c" /* yacc.c:1667  */
    break;

  case 37:
#line 272 "parser.y" /* yacc.c:1667  */
    { (yyval.declList) = new List<Decl*>; }
#line 1927 "y.tab.c" /* yacc.c:1667  */
    break;

  case 38:
#line 277 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = new FnDecl((yyvsp[-4].ident), (yyvsp[-5].type), (yyvsp[-2].varDeclList)); }
#line 1933 "y.tab.c" /* yacc.c:1667  */
    break;

  case 39:
#line 280 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = new FnDecl((yyvsp[-4].ident), Type::voidType, (yyvsp[-2].varDeclList)); }
#line 1939 "y.tab.c" /* yacc.c:1667  */
    break;

  case 40:
#line 284 "parser.y" /* yacc.c:1667  */
    { (yyval.stmtBlock) = new StmtBlock((yyvsp[-2].varDeclList), (yyvsp[-1].stmtList)); }
#line 1945 "y.tab.c" /* yacc.c:1667  */
    break;

  case 41:
#line 288 "parser.y" /* yacc.c:1667  */
    { ((yyval.stmtList)=(yyvsp[0].stmtList))->InsertAt((yyvsp[-1].stmt), 0); }
#line 1951 "y.tab.c" /* yacc.c:1667  */
    break;

  case 42:
#line 290 "parser.y" /* yacc.c:1667  */
    { (yyval.stmtList) = new List<Stmt*>; }
#line 1957 "y.tab.c" /* yacc.c:1667  */
    break;

  case 43:
#line 294 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new EmptyExpr(); }
#line 1963 "y.tab.c" /* yacc.c:1667  */
    break;

  case 44:
#line 296 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[-1].expr); }
#line 1969 "y.tab.c" /* yacc.c:1667  */
    break;

  case 45:
#line 298 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 1975 "y.tab.c" /* yacc.c:1667  */
    break;

  case 46:
#line 300 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 1981 "y.tab.c" /* yacc.c:1667  */
    break;

  case 47:
#line 302 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 1987 "y.tab.c" /* yacc.c:1667  */
    break;

  case 48:
#line 304 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 1993 "y.tab.c" /* yacc.c:1667  */
    break;

  case 49:
#line 306 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 1999 "y.tab.c" /* yacc.c:1667  */
    break;

  case 50:
#line 308 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 2005 "y.tab.c" /* yacc.c:1667  */
    break;

  case 51:
#line 310 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 2011 "y.tab.c" /* yacc.c:1667  */
    break;

  case 52:
#line 312 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmtBlock); }
#line 2017 "y.tab.c" /* yacc.c:1667  */
    break;

  case 53:
#line 316 "parser.y" /* yacc.c:1667  */
    { ((yyval.switchCaseList)=(yyvsp[-1].switchCaseList))->Append((yyvsp[0].switchCaseStmt)); }
#line 2023 "y.tab.c" /* yacc.c:1667  */
    break;

  case 54:
#line 318 "parser.y" /* yacc.c:1667  */
    { ((yyval.switchCaseList) = new List<SwitchCaseStmt*>)->Append((yyvsp[0].switchCaseStmt)); }
#line 2029 "y.tab.c" /* yacc.c:1667  */
    break;

  case 55:
#line 322 "parser.y" /* yacc.c:1667  */
    { (yyval.switchCaseStmt) = new SwitchCaseStmt(new IntConstant((yylsp[-2]), (yyvsp[-2].integerConstant)), (yyvsp[0].stmtList)); }
#line 2035 "y.tab.c" /* yacc.c:1667  */
    break;

  case 56:
#line 326 "parser.y" /* yacc.c:1667  */
    { (yyval.switchCaseStmt) = new SwitchCaseStmt(nullptr, (yyvsp[0].stmtList)); }
#line 2041 "y.tab.c" /* yacc.c:1667  */
    break;

  case 57:
#line 330 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new IfStmt((yyvsp[-2].expr), (yyvsp[0].stmt), nullptr); }
#line 2047 "y.tab.c" /* yacc.c:1667  */
    break;

  case 58:
#line 332 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new IfStmt((yyvsp[-4].expr), (yyvsp[-2].stmt), (yyvsp[0].stmt)); }
#line 2053 "y.tab.c" /* yacc.c:1667  */
    break;

  case 59:
#line 337 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new SwitchStmt((yyvsp[-5].expr), (yyvsp[-2].switchCaseList), (yyvsp[-1].switchCaseStmt)); }
#line 2059 "y.tab.c" /* yacc.c:1667  */
    break;

  case 60:
#line 341 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new WhileStmt((yyvsp[-2].expr), (yyvsp[0].stmt)); }
#line 2065 "y.tab.c" /* yacc.c:1667  */
    break;

  case 61:
#line 345 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new ForStmt((yyvsp[-6].expr), (yyvsp[-4].expr), (yyvsp[-2].expr), (yyvsp[0].stmt)); }
#line 2071 "y.tab.c" /* yacc.c:1667  */
    break;

  case 62:
#line 349 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new ReturnStmt((yylsp[-2]), (yyvsp[-1].expr)); }
#line 2077 "y.tab.c" /* yacc.c:1667  */
    break;

  case 63:
#line 353 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new BreakStmt((yylsp[-1])); }
#line 2083 "y.tab.c" /* yacc.c:1667  */
    break;

  case 64:
#line 357 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new PrintStmt((yyvsp[-2].exprList)); }
#line 2089 "y.tab.c" /* yacc.c:1667  */
    break;

  case 65:
#line 361 "parser.y" /* yacc.c:1667  */
    { ((yyval.exprList)=(yyvsp[-2].exprList))->Append((yyvsp[0].expr)); }
#line 2095 "y.tab.c" /* yacc.c:1667  */
    break;

  case 66:
#line 363 "parser.y" /* yacc.c:1667  */
    { ((yyval.exprList) = new List<Expr*>)->Append((yyvsp[0].expr)); }
#line 2101 "y.tab.c" /* yacc.c:1667  */
    break;

  case 67:
#line 367 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[0].expr); }
#line 2107 "y.tab.c" /* yacc.c:1667  */
    break;

  case 68:
#line 369 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new EmptyExpr(); }
#line 2113 "y.tab.c" /* yacc.c:1667  */
    break;

  case 69:
#line 373 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new AssignExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), equalOp_c), (yyvsp[0].expr)); }
#line 2119 "y.tab.c" /* yacc.c:1667  */
    break;

  case 70:
#line 375 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new PostfixExpr((yyvsp[-1].expr), new Operator((yylsp[0]), incremOp_c)); }
#line 2125 "y.tab.c" /* yacc.c:1667  */
    break;

  case 71:
#line 377 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new PostfixExpr((yyvsp[-1].expr), new Operator((yylsp[0]), decremOp_c)); }
#line 2131 "y.tab.c" /* yacc.c:1667  */
    break;

  case 72:
#line 379 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[0].expr); }
#line 2137 "y.tab.c" /* yacc.c:1667  */
    break;

  case 73:
#line 381 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[0].expr); }
#line 2143 "y.tab.c" /* yacc.c:1667  */
    break;

  case 74:
#line 383 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new This((yylsp[0])); }
#line 2149 "y.tab.c" /* yacc.c:1667  */
    break;

  case 75:
#line 385 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[0].expr); }
#line 2155 "y.tab.c" /* yacc.c:1667  */
    break;

  case 76:
#line 387 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[-1].expr); }
#line 2161 "y.tab.c" /* yacc.c:1667  */
    break;

  case 77:
#line 389 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), plusOp_c), (yyvsp[0].expr)); }
#line 2167 "y.tab.c" /* yacc.c:1667  */
    break;

  case 78:
#line 391 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), minusOp_c), (yyvsp[0].expr)); }
#line 2173 "y.tab.c" /* yacc.c:1667  */
    break;

  case 79:
#line 393 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), multOp_c), (yyvsp[0].expr)); }
#line 2179 "y.tab.c" /* yacc.c:1667  */
    break;

  case 80:
#line 395 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), divOp_c), (yyvsp[0].expr)); }
#line 2185 "y.tab.c" /* yacc.c:1667  */
    break;

  case 81:
#line 397 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), modOp_c), (yyvsp[0].expr)); }
#line 2191 "y.tab.c" /* yacc.c:1667  */
    break;

  case 82:
#line 399 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr(new Operator((yylsp[-1]), minusOp_c), (yyvsp[0].expr)); }
#line 2197 "y.tab.c" /* yacc.c:1667  */
    break;

  case 83:
#line 401 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), lessThanOp_c), (yyvsp[0].expr)); }
#line 2203 "y.tab.c" /* yacc.c:1667  */
    break;

  case 84:
#line 403 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), lessThanEqlOp_c), (yyvsp[0].expr)); }
#line 2209 "y.tab.c" /* yacc.c:1667  */
    break;

  case 85:
#line 405 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), greaterThanOp_c), (yyvsp[0].expr)); }
#line 2215 "y.tab.c" /* yacc.c:1667  */
    break;

  case 86:
#line 407 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), greaterThanEqlOp_C), (yyvsp[0].expr)); }
#line 2221 "y.tab.c" /* yacc.c:1667  */
    break;

  case 87:
#line 409 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new EqualityExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), equalEqualOp_C), (yyvsp[0].expr)); }
#line 2227 "y.tab.c" /* yacc.c:1667  */
    break;

  case 88:
#line 411 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new EqualityExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), notEqualOp_c), (yyvsp[0].expr)); }
#line 2233 "y.tab.c" /* yacc.c:1667  */
    break;

  case 89:
#line 413 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new LogicalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), andOp_c), (yyvsp[0].expr)); }
#line 2239 "y.tab.c" /* yacc.c:1667  */
    break;

  case 90:
#line 415 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new LogicalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), orOp_c), (yyvsp[0].expr)); }
#line 2245 "y.tab.c" /* yacc.c:1667  */
    break;

  case 91:
#line 417 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new LogicalExpr(new Operator((yylsp[-1]), notOp_c), (yyvsp[0].expr)); }
#line 2251 "y.tab.c" /* yacc.c:1667  */
    break;

  case 92:
#line 419 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ReadIntegerExpr((yylsp[-2])); }
#line 2257 "y.tab.c" /* yacc.c:1667  */
    break;

  case 93:
#line 421 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ReadLineExpr((yylsp[-2])); }
#line 2263 "y.tab.c" /* yacc.c:1667  */
    break;

  case 94:
#line 423 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new NewExpr((yylsp[-3]), new NamedType((yyvsp[-1].ident))); }
#line 2269 "y.tab.c" /* yacc.c:1667  */
    break;

  case 95:
#line 425 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new NewArrayExpr((yylsp[-5]), (yyvsp[-3].expr), (yyvsp[-1].type)); }
#line 2275 "y.tab.c" /* yacc.c:1667  */
    break;

  case 96:
#line 429 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new FieldAccess(nullptr, (yyvsp[0].ident)); }
#line 2281 "y.tab.c" /* yacc.c:1667  */
    break;

  case 97:
#line 431 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new FieldAccess((yyvsp[-2].expr), (yyvsp[0].ident)); }
#line 2287 "y.tab.c" /* yacc.c:1667  */
    break;

  case 98:
#line 433 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArrayAccess((yylsp[-3]), (yyvsp[-3].expr), (yyvsp[-1].expr)); }
#line 2293 "y.tab.c" /* yacc.c:1667  */
    break;

  case 99:
#line 437 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new Call((yylsp[-3]), nullptr, (yyvsp[-3].ident), (yyvsp[-1].exprList)); }
#line 2299 "y.tab.c" /* yacc.c:1667  */
    break;

  case 100:
#line 439 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new Call((yylsp[-3]), (yyvsp[-5].expr), (yyvsp[-3].ident), (yyvsp[-1].exprList)); }
#line 2305 "y.tab.c" /* yacc.c:1667  */
    break;

  case 101:
#line 443 "parser.y" /* yacc.c:1667  */
    { (yyval.exprList) = (yyvsp[0].exprList); }
#line 2311 "y.tab.c" /* yacc.c:1667  */
    break;

  case 102:
#line 445 "parser.y" /* yacc.c:1667  */
    { (yyval.exprList) = new List<Expr*>; }
#line 2317 "y.tab.c" /* yacc.c:1667  */
    break;

  case 103:
#line 449 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new IntConstant((yylsp[0]), (yyvsp[0].integerConstant)); }
#line 2323 "y.tab.c" /* yacc.c:1667  */
    break;

  case 104:
#line 451 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new DoubleConstant((yylsp[0]), (yyvsp[0].doubleConstant)); }
#line 2329 "y.tab.c" /* yacc.c:1667  */
    break;

  case 105:
#line 453 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new BoolConstant((yylsp[0]), (yyvsp[0].boolConstant)); }
#line 2335 "y.tab.c" /* yacc.c:1667  */
    break;

  case 106:
#line 455 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new StringConstant((yylsp[0]), (yyvsp[0].stringConstant)); }
#line 2341 "y.tab.c" /* yacc.c:1667  */
    break;

  case 107:
#line 457 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new NullConstant((yylsp[0])); }
#line 2347 "y.tab.c" /* yacc.c:1667  */
    break;

  case 108:
#line 461 "parser.y" /* yacc.c:1667  */
    { (yyval.ident) = new Identifier((yylsp[0]), (yyvsp[0].identifier)); }
#line 2353 "y.tab.c" /* yacc.c:1667  */
    break;


#line 2357 "y.tab.c" /* yacc.c:1667  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }

  yyerror_range[1] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp, yylsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp, yylsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 464 "parser.y" /* yacc.c:1918  */


/* Function: InitParser
 * --------------------
 * This function will be called before any calls to yyparse().  It is designed
 * to give you an opportunity to do anything that must be done to initialize
 * the parser (set global variables, configure starting state, etc.). One
 * thing it already does for you is assign the value of the global variable
 * yydebug that controls whether yacc prints debugging information about
 * parser actions (shift/reduce) and contents of state stack during parser.
 * If set to false, no information is printed. Setting it to true will give
 * you a running trail that might be helpful when debugging your parser.
 * Please be sure the variable is set to false when submitting your final
 * version.
 */
void InitParser() {
    PrintDebug("parser", "Initializing parser");
    yydebug = false;
}
