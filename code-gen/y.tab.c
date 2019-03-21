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


#include "scanner.h" // for yylex
#include "parser.h"
#include "errors.h"
#include "ast_program.h"

#include <string>

void yyerror(const char *msg); // standard error-handling routine

#line 82 "y.tab.c" /* yacc.c:337  */
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
    T_UnaryMinus = 292,
    T_Lower_Than_Else = 293
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
#define T_UnaryMinus 292
#define T_Lower_Than_Else 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 22 "parser.y" /* yacc.c:352  */

    int integerConstant;
    bool boolConstant;
    char *stringConstant;
    double doubleConstant;
    char identifier[MaxIdentLen+1]; // +1 for terminating null
    Decl *decl;
    List<Decl*> *declList;
    Type *type;
    NamedType *cType;
    List<NamedType*> *cTypeList;
    FnDecl *fDecl;
    VarDecl *var;
    List<VarDecl*> *varList;
    Expr *expr;
    List<Expr*> *exprList;
    Stmt *stmt;
    List<Stmt*> *stmtList;
    LValue *lvalue;

#line 222 "y.tab.c" /* yacc.c:352  */
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
#define YYFINAL  22
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   566

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  57
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  31
/* YYNRULES -- Number of rules.  */
#define YYNRULES  94
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  183

#define YYUNDEFTOK  2
#define YYMAXUTOK   293

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
       2,     2,     2,    46,     2,     2,     2,    44,     2,     2,
      54,    55,    42,    40,    53,    41,    47,    43,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    50,
      38,    37,    39,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    48,     2,    56,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    51,     2,    52,     2,     2,     2,     2,
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
      35,    36,    45,    49
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   100,   100,   116,   117,   120,   121,   122,   123,   126,
     129,   132,   133,   134,   135,   136,   137,   140,   144,   146,
     149,   153,   155,   158,   160,   163,   165,   168,   169,   172,
     173,   177,   179,   183,   184,   187,   189,   192,   195,   199,
     200,   203,   204,   207,   208,   209,   211,   213,   215,   217,
     219,   221,   224,   225,   226,   229,   231,   235,   236,   239,
     240,   241,   242,   243,   244,   245,   246,   247,   248,   249,
     250,   251,   252,   254,   256,   257,   258,   259,   261,   262,
     264,   265,   267,   269,   272,   273,   274,   275,   276,   279,
     280,   283,   284,   287,   288
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
  "T_DoubleConstant", "T_BoolConstant", "'='", "'<'", "'>'", "'+'", "'-'",
  "'*'", "'/'", "'%'", "T_UnaryMinus", "'!'", "'.'", "'['",
  "T_Lower_Than_Else", "';'", "'{'", "'}'", "','", "'('", "')'", "']'",
  "$accept", "Program", "DeclList", "Decl", "VarDecl", "Variable", "Type",
  "IntfDecl", "IntfList", "ClassDecl", "OptExt", "OptImpl", "ImpList",
  "FieldList", "Field", "FnHeader", "Formals", "FormalList", "FnDecl",
  "StmtBlock", "VarDecls", "StmtList", "Stmt", "LValue", "Call", "OptExpr",
  "Expr", "Constant", "Actuals", "ExprList", "OptElse", YY_NULLPTR
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
     285,   286,   287,   288,   289,   290,   291,    61,    60,    62,
      43,    45,    42,    47,    37,   292,    33,    46,    91,   293,
      59,   123,   125,    44,    40,    41,    93
};
# endif

#define YYPACT_NINF -131

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-131)))

#define YYTABLE_NINF -59

#define yytable_value_is_error(Yytable_value) \
  (!!((Yytable_value) == (-59)))

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      77,     1,  -131,  -131,  -131,  -131,     6,     7,  -131,    32,
      77,  -131,  -131,   -10,    -1,  -131,  -131,    20,  -131,   -13,
      33,    22,  -131,  -131,  -131,  -131,    21,  -131,  -131,   123,
      17,    54,  -131,   123,    72,  -131,     4,    31,    34,  -131,
      79,    61,     2,    60,  -131,  -131,    62,    65,    67,   483,
      74,    71,    78,    83,    86,    87,    -2,  -131,  -131,  -131,
    -131,   512,   512,   512,  -131,  -131,    90,   417,    94,  -131,
      93,   308,  -131,  -131,  -131,   123,  -131,    95,  -131,  -131,
      59,   104,  -131,   512,   512,   512,   105,  -131,   253,  -131,
     126,   512,   512,   114,   115,   512,   -22,   -22,   135,  -131,
    -131,   512,  -131,   512,   512,   512,   512,   512,   512,   512,
     512,   512,   512,   512,   512,   512,   128,   512,  -131,   149,
      16,    21,  -131,   177,   134,   195,  -131,   130,   237,   308,
     -37,  -131,  -131,   138,   141,  -131,   308,   384,   384,   359,
     359,   370,   348,   384,   384,   109,   109,   -22,   -22,   -22,
     142,   124,  -131,  -131,  -131,  -131,  -131,   454,   512,   454,
    -131,   123,   512,   145,  -131,   512,  -131,  -131,   295,   173,
      -9,   308,  -131,   143,   512,   454,  -131,  -131,  -131,   144,
    -131,   454,  -131
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,    12,    11,    14,    13,     0,     0,    15,     0,
       2,     4,     7,     0,     0,     8,     5,     0,     6,     0,
      22,     0,     1,     3,     9,    16,    10,    40,    37,    34,
       0,    24,    19,    34,    42,    36,     0,     0,    33,    21,
       0,     0,     0,     0,    88,    83,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    52,    87,    84,    86,
      85,     0,     0,     0,    39,    44,     0,    42,    59,    60,
       0,    57,    61,    10,    32,     0,    26,    23,    28,    17,
       0,     0,    31,     0,    58,     0,    52,    49,     0,    51,
       0,     0,     0,     0,     0,    90,    77,    78,     0,    38,
      41,     0,    43,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    35,     0,
       0,     0,    18,     0,     0,     0,    48,     0,     0,    92,
       0,    79,    80,     0,    89,    76,    62,    72,    73,    68,
      69,    74,    75,    70,    71,    63,    64,    66,    65,    67,
      53,     0,    25,    20,    29,    27,    30,    58,     0,    58,
      81,     0,     0,     0,    55,    90,    54,    46,     0,    94,
       0,    91,    50,     0,    58,    58,    45,    82,    56,     0,
      93,    58,    47
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -131,  -131,  -131,   190,   -31,    -5,     0,  -131,  -131,  -131,
    -131,  -131,  -131,  -131,  -131,   159,   169,  -131,    88,   186,
    -131,   146,  -130,  -131,  -131,   -82,   -48,  -131,    46,   120,
    -131
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     9,    10,    11,    12,    13,    36,    15,    42,    16,
      31,    41,    77,   120,   155,    17,    37,    38,    18,    65,
      34,    66,    67,    68,    69,    70,    71,    72,   133,   134,
     176
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      14,    88,   124,    64,    25,     1,     2,     3,     4,     5,
      14,   -15,    25,    96,    97,    98,   162,    25,   163,     1,
       2,     3,     4,     5,    35,   116,   117,   167,    35,   169,
     -15,    26,    22,    19,     8,   123,    73,   125,    20,    21,
      24,    29,    80,   128,   129,   180,   177,   129,     8,    39,
      30,   182,    95,   136,    79,   137,   138,   139,   140,   141,
     142,   143,   144,   145,   146,   147,   148,   149,   153,   151,
     118,    27,    25,    32,    40,    33,     2,     3,     4,     5,
       1,     2,     3,     4,     5,     6,    74,    75,    44,   154,
      45,   121,   179,    46,    47,    48,     7,    49,    50,    51,
      52,    53,    54,    55,    56,    57,    58,    59,    60,     8,
     168,    76,    78,    61,   171,    82,    83,   129,    62,    84,
      14,    85,   -58,    27,    89,    90,    63,     2,     3,     4,
       5,   101,    91,   103,   104,   105,   106,    92,   107,   108,
      93,    94,    99,   102,   103,   104,   105,   106,   119,   107,
     108,   113,   114,   115,   122,     8,   116,   117,   127,    95,
     150,   170,   109,   110,   111,   112,   113,   114,   115,   131,
     132,   116,   117,   109,   110,   111,   112,   113,   114,   115,
     166,   152,   116,   117,   158,   160,   103,   104,   105,   106,
     135,   107,   108,   164,   162,   172,   165,   175,   178,   181,
      23,    81,    43,    28,   103,   104,   105,   106,   156,   107,
     108,   173,   130,   100,     0,   109,   110,   111,   112,   113,
     114,   115,     0,     0,   116,   117,     0,     0,     0,     0,
       0,     0,   157,   109,   110,   111,   112,   113,   114,   115,
       0,     0,   116,   117,     0,     0,   103,   104,   105,   106,
     159,   107,   108,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   103,   104,   105,   106,     0,   107,   108,     0,
       0,     0,     0,     0,     0,   109,   110,   111,   112,   113,
     114,   115,     0,     0,   116,   117,     0,     0,     0,     0,
     161,   109,   110,   111,   112,   113,   114,   115,     0,     0,
     116,   117,     0,   126,   103,   104,   105,   106,     0,   107,
     108,     0,     0,     0,     0,     0,     0,   103,   104,   105,
     106,     0,   107,   108,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   109,   110,   111,   112,   113,   114,   115,
       0,     0,   116,   117,     0,   174,   109,   110,   111,   112,
     113,   114,   115,     0,     0,   116,   117,   103,   104,   105,
     106,     0,   107,     0,     0,     0,     0,     0,   103,   104,
     -59,   -59,     0,     0,     0,     0,     0,     0,     0,   103,
     104,   105,   106,     0,     0,     0,   109,   110,   111,   112,
     113,   114,   115,   -59,   -59,   116,   117,   109,   110,   111,
     112,   113,   114,   115,     0,     0,   116,   117,   109,   110,
     111,   112,   113,   114,   115,     0,     0,   116,   117,     0,
       0,     0,   -59,   -59,   111,   112,   113,   114,   115,     0,
       0,   116,   117,    44,     0,    45,     0,     0,    46,    47,
      48,     0,    49,    50,    51,    52,    53,    54,    55,    86,
      57,    58,    59,    60,     0,     0,     0,     0,    61,     0,
       0,     0,     0,    62,     0,     0,     0,   -58,    27,     0,
      44,    63,    45,     0,     0,    46,    47,    48,     0,    49,
      50,    51,    52,    53,    54,    55,    86,    57,    58,    59,
      60,     0,     0,     0,     0,    61,     0,     0,     0,    44,
      62,    45,     0,     0,     0,    27,     0,     0,    63,     0,
      51,    52,     0,    54,    55,    86,    57,    58,    59,    60,
       0,     0,     0,     0,    61,     0,     0,     0,    44,    62,
      45,     0,     0,    87,     0,     0,     0,    63,     0,    51,
      52,     0,    54,    55,    86,    57,    58,    59,    60,     0,
       0,     0,     0,    61,     0,     0,     0,     0,    62,     0,
       0,     0,     0,     0,     0,     0,    63
};

static const yytype_int16 yycheck[] =
{
       0,    49,    84,    34,    13,     3,     4,     5,     6,     7,
      10,    13,    13,    61,    62,    63,    53,    13,    55,     3,
       4,     5,     6,     7,    29,    47,    48,   157,    33,   159,
      32,    32,     0,    32,    32,    83,    32,    85,    32,    32,
      50,    54,    42,    91,    92,   175,    55,    95,    32,    32,
      17,   181,    54,   101,    52,   103,   104,   105,   106,   107,
     108,   109,   110,   111,   112,   113,   114,   115,    52,   117,
      75,    51,    13,    51,    20,    54,     4,     5,     6,     7,
       3,     4,     5,     6,     7,     8,    55,    53,    16,   120,
      18,    32,   174,    21,    22,    23,    19,    25,    26,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    32,
     158,    32,    51,    41,   162,    55,    54,   165,    46,    54,
     120,    54,    50,    51,    50,    54,    54,     4,     5,     6,
       7,    37,    54,     9,    10,    11,    12,    54,    14,    15,
      54,    54,    52,    50,     9,    10,    11,    12,    53,    14,
      15,    42,    43,    44,    50,    32,    47,    48,    32,    54,
      32,   161,    38,    39,    40,    41,    42,    43,    44,    55,
      55,    47,    48,    38,    39,    40,    41,    42,    43,    44,
      56,    32,    47,    48,    50,    55,     9,    10,    11,    12,
      55,    14,    15,    55,    53,    50,    54,    24,    55,    55,
      10,    42,    33,    17,     9,    10,    11,    12,   120,    14,
      15,   165,    92,    67,    -1,    38,    39,    40,    41,    42,
      43,    44,    -1,    -1,    47,    48,    -1,    -1,    -1,    -1,
      -1,    -1,    55,    38,    39,    40,    41,    42,    43,    44,
      -1,    -1,    47,    48,    -1,    -1,     9,    10,    11,    12,
      55,    14,    15,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,     9,    10,    11,    12,    -1,    14,    15,    -1,
      -1,    -1,    -1,    -1,    -1,    38,    39,    40,    41,    42,
      43,    44,    -1,    -1,    47,    48,    -1,    -1,    -1,    -1,
      53,    38,    39,    40,    41,    42,    43,    44,    -1,    -1,
      47,    48,    -1,    50,     9,    10,    11,    12,    -1,    14,
      15,    -1,    -1,    -1,    -1,    -1,    -1,     9,    10,    11,
      12,    -1,    14,    15,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    38,    39,    40,    41,    42,    43,    44,
      -1,    -1,    47,    48,    -1,    50,    38,    39,    40,    41,
      42,    43,    44,    -1,    -1,    47,    48,     9,    10,    11,
      12,    -1,    14,    -1,    -1,    -1,    -1,    -1,     9,    10,
      11,    12,    -1,    -1,    -1,    -1,    -1,    -1,    -1,     9,
      10,    11,    12,    -1,    -1,    -1,    38,    39,    40,    41,
      42,    43,    44,     9,    10,    47,    48,    38,    39,    40,
      41,    42,    43,    44,    -1,    -1,    47,    48,    38,    39,
      40,    41,    42,    43,    44,    -1,    -1,    47,    48,    -1,
      -1,    -1,    38,    39,    40,    41,    42,    43,    44,    -1,
      -1,    47,    48,    16,    -1,    18,    -1,    -1,    21,    22,
      23,    -1,    25,    26,    27,    28,    29,    30,    31,    32,
      33,    34,    35,    36,    -1,    -1,    -1,    -1,    41,    -1,
      -1,    -1,    -1,    46,    -1,    -1,    -1,    50,    51,    -1,
      16,    54,    18,    -1,    -1,    21,    22,    23,    -1,    25,
      26,    27,    28,    29,    30,    31,    32,    33,    34,    35,
      36,    -1,    -1,    -1,    -1,    41,    -1,    -1,    -1,    16,
      46,    18,    -1,    -1,    -1,    51,    -1,    -1,    54,    -1,
      27,    28,    -1,    30,    31,    32,    33,    34,    35,    36,
      -1,    -1,    -1,    -1,    41,    -1,    -1,    -1,    16,    46,
      18,    -1,    -1,    50,    -1,    -1,    -1,    54,    -1,    27,
      28,    -1,    30,    31,    32,    33,    34,    35,    36,    -1,
      -1,    -1,    -1,    41,    -1,    -1,    -1,    -1,    46,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    54
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     4,     5,     6,     7,     8,    19,    32,    58,
      59,    60,    61,    62,    63,    64,    66,    72,    75,    32,
      32,    32,     0,    60,    50,    13,    32,    51,    76,    54,
      17,    67,    51,    54,    77,    62,    63,    73,    74,    32,
      20,    68,    65,    73,    16,    18,    21,    22,    23,    25,
      26,    27,    28,    29,    30,    31,    32,    33,    34,    35,
      36,    41,    46,    54,    61,    76,    78,    79,    80,    81,
      82,    83,    84,    32,    55,    53,    32,    69,    51,    52,
      63,    72,    55,    54,    54,    54,    32,    50,    83,    50,
      54,    54,    54,    54,    54,    54,    83,    83,    83,    52,
      78,    37,    50,     9,    10,    11,    12,    14,    15,    38,
      39,    40,    41,    42,    43,    44,    47,    48,    62,    53,
      70,    32,    50,    83,    82,    83,    50,    32,    83,    83,
      86,    55,    55,    85,    86,    55,    83,    83,    83,    83,
      83,    83,    83,    83,    83,    83,    83,    83,    83,    83,
      32,    83,    32,    52,    61,    71,    75,    55,    50,    55,
      55,    53,    53,    55,    55,    54,    56,    79,    83,    79,
      63,    83,    50,    85,    50,    24,    87,    55,    55,    82,
      79,    55,    79
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    57,    58,    59,    59,    60,    60,    60,    60,    61,
      62,    63,    63,    63,    63,    63,    63,    64,    65,    65,
      66,    67,    67,    68,    68,    69,    69,    70,    70,    71,
      71,    72,    72,    73,    73,    74,    74,    75,    76,    77,
      77,    78,    78,    79,    79,    79,    79,    79,    79,    79,
      79,    79,    80,    80,    80,    81,    81,    82,    82,    83,
      83,    83,    83,    83,    83,    83,    83,    83,    83,    83,
      83,    83,    83,    83,    83,    83,    83,    83,    83,    83,
      83,    83,    83,    83,    84,    84,    84,    84,    84,    85,
      85,    86,    86,    87,    87
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     1,     2,
       2,     1,     1,     1,     1,     1,     2,     5,     3,     0,
       7,     2,     0,     2,     0,     3,     1,     2,     0,     1,
       1,     5,     5,     1,     0,     3,     1,     2,     4,     2,
       0,     2,     0,     2,     1,     6,     5,     9,     3,     2,
       5,     2,     1,     3,     4,     4,     6,     1,     0,     1,
       1,     1,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     2,     2,     3,
       3,     4,     6,     1,     1,     1,     1,     1,     1,     1,
       0,     3,     1,     2,     0
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
#line 100 "parser.y" /* yacc.c:1667  */
    {
                                      (yylsp[0]);
                                      Program *program = new Program((yyvsp[0].declList));
                                      // if no errors, advance to next phase which is semantic analysis
                                      // we create a sybmol table object and pass it to program
                                      // program will then tell its children to traverse the AST
                                      // and check for any semantic errors

                                      if (ReportError::NumErrors() == 0) {
                                      	  program->check();
                                          program->emit();
                                      }
                                    }
#line 1644 "y.tab.c" /* yacc.c:1667  */
    break;

  case 3:
#line 116 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList)=(yyvsp[-1].declList))->append((yyvsp[0].decl)); }
#line 1650 "y.tab.c" /* yacc.c:1667  */
    break;

  case 4:
#line 117 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList) = new List<Decl*>)->append((yyvsp[0].decl)); }
#line 1656 "y.tab.c" /* yacc.c:1667  */
    break;

  case 6:
#line 121 "parser.y" /* yacc.c:1667  */
    { (yyval.decl)=(yyvsp[0].fDecl); }
#line 1662 "y.tab.c" /* yacc.c:1667  */
    break;

  case 7:
#line 122 "parser.y" /* yacc.c:1667  */
    { (yyval.decl)=(yyvsp[0].var); }
#line 1668 "y.tab.c" /* yacc.c:1667  */
    break;

  case 10:
#line 129 "parser.y" /* yacc.c:1667  */
    { (yyval.var) = new VarDecl(new Identifier((yylsp[0]), (yyvsp[0].identifier)), (yyvsp[-1].type)); }
#line 1674 "y.tab.c" /* yacc.c:1667  */
    break;

  case 11:
#line 132 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::intType; }
#line 1680 "y.tab.c" /* yacc.c:1667  */
    break;

  case 12:
#line 133 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::boolType; }
#line 1686 "y.tab.c" /* yacc.c:1667  */
    break;

  case 13:
#line 134 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::stringType; }
#line 1692 "y.tab.c" /* yacc.c:1667  */
    break;

  case 14:
#line 135 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = Type::doubleType; }
#line 1698 "y.tab.c" /* yacc.c:1667  */
    break;

  case 15:
#line 136 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = new NamedType(new Identifier((yylsp[0]),(yyvsp[0].identifier))); }
#line 1704 "y.tab.c" /* yacc.c:1667  */
    break;

  case 16:
#line 137 "parser.y" /* yacc.c:1667  */
    { (yyval.type) = new ArrayType(Join((yylsp[-1]), (yylsp[0])), (yyvsp[-1].type)); }
#line 1710 "y.tab.c" /* yacc.c:1667  */
    break;

  case 17:
#line 141 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = new InterfaceDecl(new Identifier((yylsp[-3]), (yyvsp[-3].identifier)), (yyvsp[-1].declList)); }
#line 1716 "y.tab.c" /* yacc.c:1667  */
    break;

  case 18:
#line 145 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList)=(yyvsp[-2].declList))->append((yyvsp[-1].fDecl)); }
#line 1722 "y.tab.c" /* yacc.c:1667  */
    break;

  case 19:
#line 146 "parser.y" /* yacc.c:1667  */
    { (yyval.declList) = new List<Decl*>(); }
#line 1728 "y.tab.c" /* yacc.c:1667  */
    break;

  case 20:
#line 150 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = new ClassDecl(new Identifier((yylsp[-5]), (yyvsp[-5].identifier)), (yyvsp[-4].cType), (yyvsp[-3].cTypeList), (yyvsp[-1].declList)); }
#line 1734 "y.tab.c" /* yacc.c:1667  */
    break;

  case 21:
#line 154 "parser.y" /* yacc.c:1667  */
    { (yyval.cType) = new NamedType(new Identifier((yylsp[0]), (yyvsp[0].identifier))); }
#line 1740 "y.tab.c" /* yacc.c:1667  */
    break;

  case 22:
#line 155 "parser.y" /* yacc.c:1667  */
    { (yyval.cType) = nullptr; }
#line 1746 "y.tab.c" /* yacc.c:1667  */
    break;

  case 23:
#line 159 "parser.y" /* yacc.c:1667  */
    { (yyval.cTypeList) = (yyvsp[0].cTypeList); }
#line 1752 "y.tab.c" /* yacc.c:1667  */
    break;

  case 24:
#line 160 "parser.y" /* yacc.c:1667  */
    { (yyval.cTypeList) = new List<NamedType*>; }
#line 1758 "y.tab.c" /* yacc.c:1667  */
    break;

  case 25:
#line 164 "parser.y" /* yacc.c:1667  */
    { ((yyval.cTypeList)=(yyvsp[-2].cTypeList))->append(new NamedType(new Identifier((yylsp[0]), (yyvsp[0].identifier)))); }
#line 1764 "y.tab.c" /* yacc.c:1667  */
    break;

  case 26:
#line 165 "parser.y" /* yacc.c:1667  */
    { ((yyval.cTypeList)=new List<NamedType*>)->append(new NamedType(new Identifier((yylsp[0]), (yyvsp[0].identifier)))); }
#line 1770 "y.tab.c" /* yacc.c:1667  */
    break;

  case 27:
#line 168 "parser.y" /* yacc.c:1667  */
    { ((yyval.declList)=(yyvsp[-1].declList))->append((yyvsp[0].decl)); }
#line 1776 "y.tab.c" /* yacc.c:1667  */
    break;

  case 28:
#line 169 "parser.y" /* yacc.c:1667  */
    { (yyval.declList) = new List<Decl*>(); }
#line 1782 "y.tab.c" /* yacc.c:1667  */
    break;

  case 29:
#line 172 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].var); }
#line 1788 "y.tab.c" /* yacc.c:1667  */
    break;

  case 30:
#line 173 "parser.y" /* yacc.c:1667  */
    { (yyval.decl) = (yyvsp[0].fDecl); }
#line 1794 "y.tab.c" /* yacc.c:1667  */
    break;

  case 31:
#line 178 "parser.y" /* yacc.c:1667  */
    { (yyval.fDecl) = new FnDecl(new Identifier((yylsp[-3]), (yyvsp[-3].identifier)), (yyvsp[-4].type), (yyvsp[-1].varList)); }
#line 1800 "y.tab.c" /* yacc.c:1667  */
    break;

  case 32:
#line 180 "parser.y" /* yacc.c:1667  */
    { (yyval.fDecl) = new FnDecl(new Identifier((yylsp[-3]), (yyvsp[-3].identifier)), Type::voidType, (yyvsp[-1].varList)); }
#line 1806 "y.tab.c" /* yacc.c:1667  */
    break;

  case 33:
#line 183 "parser.y" /* yacc.c:1667  */
    { (yyval.varList) = (yyvsp[0].varList); }
#line 1812 "y.tab.c" /* yacc.c:1667  */
    break;

  case 34:
#line 184 "parser.y" /* yacc.c:1667  */
    { (yyval.varList) = new List<VarDecl*>; }
#line 1818 "y.tab.c" /* yacc.c:1667  */
    break;

  case 35:
#line 188 "parser.y" /* yacc.c:1667  */
    { ((yyval.varList)=(yyvsp[-2].varList))->append((yyvsp[0].var)); }
#line 1824 "y.tab.c" /* yacc.c:1667  */
    break;

  case 36:
#line 189 "parser.y" /* yacc.c:1667  */
    { ((yyval.varList) = new List<VarDecl*>)->append((yyvsp[0].var)); }
#line 1830 "y.tab.c" /* yacc.c:1667  */
    break;

  case 37:
#line 192 "parser.y" /* yacc.c:1667  */
    { ((yyval.fDecl)=(yyvsp[-1].fDecl))->set_function_body((yyvsp[0].stmt)); }
#line 1836 "y.tab.c" /* yacc.c:1667  */
    break;

  case 38:
#line 196 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new StmtBlock((yyvsp[-2].varList), (yyvsp[-1].stmtList)); }
#line 1842 "y.tab.c" /* yacc.c:1667  */
    break;

  case 39:
#line 199 "parser.y" /* yacc.c:1667  */
    { ((yyval.varList)=(yyvsp[-1].varList))->append((yyvsp[0].var)); }
#line 1848 "y.tab.c" /* yacc.c:1667  */
    break;

  case 40:
#line 200 "parser.y" /* yacc.c:1667  */
    { (yyval.varList) = new List<VarDecl*>; }
#line 1854 "y.tab.c" /* yacc.c:1667  */
    break;

  case 41:
#line 203 "parser.y" /* yacc.c:1667  */
    { (yyval.stmtList) = (yyvsp[0].stmtList); (yyval.stmtList)->insert((yyvsp[-1].stmt), 0); }
#line 1860 "y.tab.c" /* yacc.c:1667  */
    break;

  case 42:
#line 204 "parser.y" /* yacc.c:1667  */
    { (yyval.stmtList) = new List<Stmt*>; }
#line 1866 "y.tab.c" /* yacc.c:1667  */
    break;

  case 43:
#line 207 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[-1].expr); }
#line 1872 "y.tab.c" /* yacc.c:1667  */
    break;

  case 45:
#line 210 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new IfStmt((yyvsp[-3].expr), (yyvsp[-1].stmt), (yyvsp[0].stmt)); }
#line 1878 "y.tab.c" /* yacc.c:1667  */
    break;

  case 46:
#line 212 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new WhileStmt((yyvsp[-2].expr), (yyvsp[0].stmt)); }
#line 1884 "y.tab.c" /* yacc.c:1667  */
    break;

  case 47:
#line 214 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new ForStmt((yyvsp[-6].expr), (yyvsp[-4].expr), (yyvsp[-2].expr), (yyvsp[0].stmt)); }
#line 1890 "y.tab.c" /* yacc.c:1667  */
    break;

  case 48:
#line 216 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new ReturnStmt((yylsp[-1]), (yyvsp[-1].expr)); }
#line 1896 "y.tab.c" /* yacc.c:1667  */
    break;

  case 49:
#line 218 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new ReturnStmt((yylsp[-1]), new EmptyExpr()); }
#line 1902 "y.tab.c" /* yacc.c:1667  */
    break;

  case 50:
#line 220 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new PrintStmt((yyvsp[-2].exprList)); }
#line 1908 "y.tab.c" /* yacc.c:1667  */
    break;

  case 51:
#line 221 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = new BreakStmt((yylsp[-1])); }
#line 1914 "y.tab.c" /* yacc.c:1667  */
    break;

  case 52:
#line 224 "parser.y" /* yacc.c:1667  */
    { (yyval.lvalue) = new FieldAccess(nullptr, new Identifier((yylsp[0]), (yyvsp[0].identifier))); }
#line 1920 "y.tab.c" /* yacc.c:1667  */
    break;

  case 53:
#line 225 "parser.y" /* yacc.c:1667  */
    { (yyval.lvalue) = new FieldAccess((yyvsp[-2].expr), new Identifier((yylsp[0]), (yyvsp[0].identifier))); }
#line 1926 "y.tab.c" /* yacc.c:1667  */
    break;

  case 54:
#line 226 "parser.y" /* yacc.c:1667  */
    { (yyval.lvalue) = new ArrayAccess(Join((yylsp[-3]), (yylsp[0])), (yyvsp[-3].expr), (yyvsp[-1].expr)); }
#line 1932 "y.tab.c" /* yacc.c:1667  */
    break;

  case 55:
#line 230 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new Call(Join((yylsp[-3]),(yylsp[0])), nullptr, new Identifier((yylsp[-3]),(yyvsp[-3].identifier)), (yyvsp[-1].exprList)); }
#line 1938 "y.tab.c" /* yacc.c:1667  */
    break;

  case 56:
#line 232 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new Call(Join((yylsp[-5]),(yylsp[0])), (yyvsp[-5].expr), new Identifier((yylsp[-3]),(yyvsp[-3].identifier)), (yyvsp[-1].exprList)); }
#line 1944 "y.tab.c" /* yacc.c:1667  */
    break;

  case 57:
#line 235 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[0].expr); }
#line 1950 "y.tab.c" /* yacc.c:1667  */
    break;

  case 58:
#line 236 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new EmptyExpr(); }
#line 1956 "y.tab.c" /* yacc.c:1667  */
    break;

  case 59:
#line 239 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[0].lvalue); }
#line 1962 "y.tab.c" /* yacc.c:1667  */
    break;

  case 62:
#line 242 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new AssignExpr((yyvsp[-2].lvalue), new Operator((yylsp[-1]),"="), (yyvsp[0].expr)); }
#line 1968 "y.tab.c" /* yacc.c:1667  */
    break;

  case 63:
#line 243 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), "+"), (yyvsp[0].expr)); }
#line 1974 "y.tab.c" /* yacc.c:1667  */
    break;

  case 64:
#line 244 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]), "-"), (yyvsp[0].expr)); }
#line 1980 "y.tab.c" /* yacc.c:1667  */
    break;

  case 65:
#line 245 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"/"), (yyvsp[0].expr)); }
#line 1986 "y.tab.c" /* yacc.c:1667  */
    break;

  case 66:
#line 246 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"*"), (yyvsp[0].expr)); }
#line 1992 "y.tab.c" /* yacc.c:1667  */
    break;

  case 67:
#line 247 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"%"), (yyvsp[0].expr)); }
#line 1998 "y.tab.c" /* yacc.c:1667  */
    break;

  case 68:
#line 248 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new EqualityExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"=="), (yyvsp[0].expr)); }
#line 2004 "y.tab.c" /* yacc.c:1667  */
    break;

  case 69:
#line 249 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new EqualityExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"!="), (yyvsp[0].expr)); }
#line 2010 "y.tab.c" /* yacc.c:1667  */
    break;

  case 70:
#line 250 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"<"), (yyvsp[0].expr)); }
#line 2016 "y.tab.c" /* yacc.c:1667  */
    break;

  case 71:
#line 251 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),">"), (yyvsp[0].expr)); }
#line 2022 "y.tab.c" /* yacc.c:1667  */
    break;

  case 72:
#line 253 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"<="), (yyvsp[0].expr)); }
#line 2028 "y.tab.c" /* yacc.c:1667  */
    break;

  case 73:
#line 255 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new RelationalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),">="), (yyvsp[0].expr)); }
#line 2034 "y.tab.c" /* yacc.c:1667  */
    break;

  case 74:
#line 256 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new LogicalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"&&"), (yyvsp[0].expr)); }
#line 2040 "y.tab.c" /* yacc.c:1667  */
    break;

  case 75:
#line 257 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new LogicalExpr((yyvsp[-2].expr), new Operator((yylsp[-1]),"||"), (yyvsp[0].expr)); }
#line 2046 "y.tab.c" /* yacc.c:1667  */
    break;

  case 76:
#line 258 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = (yyvsp[-1].expr); }
#line 2052 "y.tab.c" /* yacc.c:1667  */
    break;

  case 77:
#line 260 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ArithmeticExpr(new Operator((yylsp[-1]),"-"), (yyvsp[0].expr)); }
#line 2058 "y.tab.c" /* yacc.c:1667  */
    break;

  case 78:
#line 261 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new LogicalExpr(new Operator((yylsp[-1]),"!"), (yyvsp[0].expr)); }
#line 2064 "y.tab.c" /* yacc.c:1667  */
    break;

  case 79:
#line 263 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ReadIntegerExpr(Join((yylsp[-2]),(yylsp[0]))); }
#line 2070 "y.tab.c" /* yacc.c:1667  */
    break;

  case 80:
#line 264 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new ReadLineExpr(Join((yylsp[-2]),(yylsp[0]))); }
#line 2076 "y.tab.c" /* yacc.c:1667  */
    break;

  case 81:
#line 266 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new NewExpr(Join((yylsp[-3]),(yylsp[0])),new NamedType(new Identifier((yylsp[-1]),(yyvsp[-1].identifier)))); }
#line 2082 "y.tab.c" /* yacc.c:1667  */
    break;

  case 82:
#line 268 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new NewArrayExpr(Join((yylsp[-5]),(yylsp[0])),(yyvsp[-3].expr), (yyvsp[-1].type)); }
#line 2088 "y.tab.c" /* yacc.c:1667  */
    break;

  case 83:
#line 269 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new This((yylsp[0])); }
#line 2094 "y.tab.c" /* yacc.c:1667  */
    break;

  case 84:
#line 272 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new IntConstant((yylsp[0]),(yyvsp[0].integerConstant)); }
#line 2100 "y.tab.c" /* yacc.c:1667  */
    break;

  case 85:
#line 273 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new BoolConstant((yylsp[0]),(yyvsp[0].boolConstant)); }
#line 2106 "y.tab.c" /* yacc.c:1667  */
    break;

  case 86:
#line 274 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new DoubleConstant((yylsp[0]),(yyvsp[0].doubleConstant)); }
#line 2112 "y.tab.c" /* yacc.c:1667  */
    break;

  case 87:
#line 275 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new StringConstant((yylsp[0]),(yyvsp[0].stringConstant)); }
#line 2118 "y.tab.c" /* yacc.c:1667  */
    break;

  case 88:
#line 276 "parser.y" /* yacc.c:1667  */
    { (yyval.expr) = new NullConstant((yylsp[0])); }
#line 2124 "y.tab.c" /* yacc.c:1667  */
    break;

  case 89:
#line 279 "parser.y" /* yacc.c:1667  */
    { (yyval.exprList) = (yyvsp[0].exprList); }
#line 2130 "y.tab.c" /* yacc.c:1667  */
    break;

  case 90:
#line 280 "parser.y" /* yacc.c:1667  */
    { (yyval.exprList) = new List<Expr*>; }
#line 2136 "y.tab.c" /* yacc.c:1667  */
    break;

  case 91:
#line 283 "parser.y" /* yacc.c:1667  */
    { ((yyval.exprList)=(yyvsp[-2].exprList))->append((yyvsp[0].expr)); }
#line 2142 "y.tab.c" /* yacc.c:1667  */
    break;

  case 92:
#line 284 "parser.y" /* yacc.c:1667  */
    { ((yyval.exprList) = new List<Expr*>)->append((yyvsp[0].expr)); }
#line 2148 "y.tab.c" /* yacc.c:1667  */
    break;

  case 93:
#line 287 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = (yyvsp[0].stmt); }
#line 2154 "y.tab.c" /* yacc.c:1667  */
    break;

  case 94:
#line 289 "parser.y" /* yacc.c:1667  */
    { (yyval.stmt) = nullptr; }
#line 2160 "y.tab.c" /* yacc.c:1667  */
    break;


#line 2164 "y.tab.c" /* yacc.c:1667  */
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
#line 292 "parser.y" /* yacc.c:1918  */



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
   debug_print("parser", "Initializing parser");
   yydebug = false;
}
