/* File: parser.y
 * --------------
 * Yacc input file to generate the parser for the compiler.
 */

%{
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
const char * const notOp_c = "!";               // '!' not (negation) operator
const char * const plusOp_c = "+";              // '+' plus operator
const char * const minusOp_c = "-";             // '-' minus operator
const char * const multOp_c = "*";              // '*' multiplication operator
const char * const divOp_c = "/";               // '/' division operator
const char * const modOp_c = "%";               // '%' (mod) operator

%}

/* yylval
 * ------
 */
%union {
    int integerConstant;
    bool boolConstant;
    char *stringConstant;
    double doubleConstant;
    char identifier[MaxIdentLen + 1]; // +1 for terminating null

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

    Expr *expr;
    List<Expr*> *exprList;
}


/* Tokens
 * ------
 */
%token   T_Void T_Bool T_Int T_Double T_String T_Class
%token   T_LessEqual T_GreaterEqual T_Equal T_NotEqual T_Dims
%token   T_And T_Or T_Null T_Extends T_This T_Interface T_Implements
%token   T_While T_For T_If T_Else T_Return T_Break
%token   T_New T_NewArray T_Print T_ReadInteger T_ReadLine

%token   <identifier> T_Identifier
%token   <stringConstant> T_StringConstant
%token   <integerConstant> T_IntConstant
%token   <doubleConstant> T_DoubleConstant
%token   <boolConstant> T_BoolConstant

%token   T_Increm T_Decrem T_Switch T_Case T_Default


/* Precedence
 * ----------
 */
%left '<' '>' T_LessEqual T_GreaterEqual T_Equal T_NotEqual
%left '+' '-'
%left '*' '/' '%'
%left UMINUS    // used for unary minus since precedence is higher than just simple '-'


/* Non-terminal types
 * ------------------
 */
%type <declList>        DeclList FieldList PrototypeList
%type <decl>            Decl Field Prototype

%type <varDecl>         Variable VariableDecl 
%type <varDeclList>     VariableDeclList Formals

%type <fnDecl>          FunctionDecl 

%type <classDecl>       ClassDecl
%type <namedTypeList>   NamedTypeList

%type <interfaceDecl>   InterfaceDecl       

%type <type>            Type

%type <stmt>            Stmt IfStmt WhileStmt ForStmt ReturnStmt BreakStmt PrintStmt
%type <stmtList>        StmtList
%type <stmtBlock>       StmtBlock

%type <expr>            Expr LValue Constant
%type <exprList>        ExprList

%%
/* Rules
 * -----
 * All productions and actions should be placed between the start and stop
 * %% markers which delimit the Rules section.

 */
Program:
    DeclList
        {
            Program *program = new Program($1);
            // if no errors, advance to next phase
            if (ReportError::NumErrors() == 0)
                program->Print(0);
        }
    ;

DeclList:
    DeclList Decl { ($$=$1)->Append($2); }
    |
    Decl { ($$ = new List<Decl*>)->Append($1); }
    ;

Decl:
    VariableDecl { $$ = $1; }
    | 
    FunctionDecl { $$ = $1; }
    |
    ClassDecl { $$ = $1; }
    |
    InterfaceDecl { $$ = $1; }
    ;

VariableDeclList:
    VariableDeclList VariableDecl { ($$=$1)->Append($2); }
    |
    VariableDecl { ($$ = new List<VarDecl*>)->Append($1); }
    |
    %empty  { $$ = new List<VarDecl*>; }
    ;

VariableDecl:
    Variable ';' { $$ = $1; }
    ;

Variable:
    Type T_Identifier { $$ = new VarDecl(new Identifier(@2, $2), $1); }
    ;

Type:
    T_Int { $$ = Type::intType; }
    |
    T_Double { $$ = Type::doubleType; }
    |
    T_Bool { $$ = Type::boolType; }
    |
    T_Null { $$ = Type::nullType; }
    |
    T_String { $$ = Type::stringType; }
    |
    T_Identifier { $$ = new NamedType(new Identifier(@1, $1)); }
    |
    Type T_Dims { $$ = new ArrayType(@1, $1); }
    ;

FunctionDecl:
    Type T_Identifier '(' Formals ')' StmtBlock 
        { 
            $$ = new FnDecl(new Identifier(@2, $2), $1, $4);
            $$->SetFunctionBody($6);
        }
    |
    T_Void T_Identifier '(' Formals ')' StmtBlock
        {
            $$ = new FnDecl(new Identifier(@2, $2), Type::voidType, $4);
            $$->SetFunctionBody($6);
        }
    ;

Formals: 
    Formals ',' Variable { ($$=$1)->Append($3); }
    |
    Variable { ($$ = new List<VarDecl*>)->Append($1); }
    |
    %empty { $$ = new List<VarDecl*>; }
    ;

ClassDecl: 
    T_Class T_Identifier '{' FieldList '}' 
        { $$ = new ClassDecl(new Identifier(@2, $2), nullptr, new List<NamedType*>, $4); }
    |
    T_Class T_Identifier T_Extends T_Identifier '{' FieldList '}' 
        { 
            $$ = new ClassDecl(new Identifier(@2, $2), 
                               new NamedType(new Identifier(@4, $4)), 
                               new List<NamedType*>, 
                               $6); 
        }
    |
    T_Class T_Identifier T_Implements NamedTypeList '{' FieldList '}' 
        { $$ = new ClassDecl(new Identifier(@2, $2), nullptr, $4, $6); }
    |
    T_Class T_Identifier T_Extends T_Identifier T_Implements NamedTypeList '{' FieldList '}'
        { 
            $$ = new ClassDecl(new Identifier(@2, $2), 
                               new NamedType(new Identifier(@4, $4)), 
                               $6, 
                               $8); 
        }
    ;

NamedTypeList:
    NamedTypeList T_Identifier { ($$=$1)->Append(new NamedType(new Identifier(@2, $2))); }
    |
    T_Identifier { ($$ = new List<NamedType*>)->Append(new NamedType(new Identifier(@1, $1))); }
    ;

FieldList:
    FieldList Field { ($$=$1)->Append($2); }
    |
    Field { ($$ = new List<Decl*>)->Append($1); }
    |
    %empty { $$ = new List<Decl*>; }
    ;

Field:
    FunctionDecl { $$ = $1; }
    | 
    VariableDecl { $$ = $1; }
    ;

InterfaceDecl:
    T_Interface T_Identifier '{' PrototypeList '}' 
        { $$ = new InterfaceDecl(new Identifier(@2, $2), $4); }
    ;

PrototypeList:
    PrototypeList Prototype { ($$=$1)->Append($2); }
    |
    Prototype { ($$ = new List<Decl*>)->Append($1); }
    |
    %empty { $$ = new List<Decl*>; }
    ;

Prototype:
    Type T_Identifier '(' Formals ')' ';' 
        { $$ = new FnDecl(new Identifier(@2, $2), $1, $4); }
    |
    T_Void T_Identifier '(' Formals ')' ';'
        { $$ = new FnDecl(new Identifier(@2, $2), Type::voidType, $4); }
    ;

StmtBlock:
    '{' VariableDeclList StmtList '}' { $$ = new StmtBlock($2, $3); }
    ;

StmtList:
    StmtList Stmt { ($$=$1)->Append($2); }
    |
    Stmt { ($$ = new List<Stmt*>)->Append($1); }
    |
    %empty { $$ = new List<Stmt*>; }
    ;

Stmt: 
    ';' { $$ = new EmptyExpr(); }
    | 
    Expr ';' { $$ = $1; }
    |
    IfStmt { $$ = $1; }
    |
    WhileStmt { $$ = $1; }
    | 
    ForStmt { $$ = $1; }
    |
    ReturnStmt { $$ = $1; }
    |
    BreakStmt { $$ = $1; }
    |
    PrintStmt { $$ = $1; }
    |
    StmtBlock { $$ = $1; }
    ;

IfStmt:
    T_If '(' Expr ')' Stmt { $$ = new IfStmt($3, $5, nullptr); }
    |
    T_If '(' Expr ')' Stmt T_Else Stmt { $$ = new IfStmt($3, $5, $7); }
    ;

WhileStmt:
    T_While '(' Expr ')' Stmt { $$ = new WhileStmt($3, $5); }
    ;

ForStmt:
    T_For '(' ';' Expr ';' ')' Stmt { $$ = new ForStmt(new EmptyExpr(), $4, new EmptyExpr(), $7); }
    |
    T_For '(' Expr ';' Expr ';' ')' Stmt { $$ = new ForStmt($3, $5, new EmptyExpr(), $8); }
    |
    T_For '(' Expr ';' Expr ';' Expr ')' Stmt { $$ = new ForStmt($3, $5, $7, $9); }
    ;

ReturnStmt:
    T_Return ';' { $$ = new ReturnStmt(@1, new EmptyExpr()); }
    |
    T_Return Expr ';' { $$ = new ReturnStmt(@1, $2); }
    ;

BreakStmt:
    T_Break ';' { $$ = new BreakStmt(@1); }
    ;

PrintStmt:
    T_Print '(' ExprList ')' ';' { $$ = new PrintStmt($3); }
    ;

ExprList:
    ExprList ',' Expr { ($$=$1)->Append($3); }
    |
    Expr { ($$ = new List<Expr*>)->Append($1); }
    ;

Expr: 
    LValue '=' Expr { $$ = new AssignExpr($1, new Operator(@2, equalOp_c), $3); }
    |
    Constant { $$ = $1; }
    |
    LValue { $$ = $1; }
    |
    T_This { $$ = new This(@1); }
    |
    Expr '+' Expr { $$ = new ArithmeticExpr($1, new Operator(@2, plusOp_c), $3); }
    |
    Expr '-' Expr { $$ = new ArithmeticExpr($1, new Operator(@2, minusOp_c), $3); }
    |
    Expr '*' Expr { $$ = new ArithmeticExpr($1, new Operator(@2, multOp_c), $3); }
    |
    Expr '/' Expr { $$ = new ArithmeticExpr($1, new Operator(@2, divOp_c), $3); }
    |
    Expr '%' Expr { $$ = new ArithmeticExpr($1, new Operator(@2, modOp_c), $3); }
    |
    '-' Expr %prec UMINUS { $$ = new ArithmeticExpr(new Operator(@1, minusOp_c), $2); }
    |
    Expr '<' Expr { $$ = new RelationalExpr($1, new Operator(@2, lessThanOp_c), $3); }
    |
    Expr T_LessEqual Expr { $$ = new RelationalExpr($1, new Operator(@2, lessThanEqlOp_c), $3); }
    |
    Expr '>' Expr { $$ = new RelationalExpr($1, new Operator(@2, greaterThanOp_c), $3); }
    |
    Expr T_GreaterEqual Expr { $$ = new RelationalExpr($1, new Operator(@2, greaterThanEqlOp_C), $3); }
    |
    Expr T_Equal Expr { $$ = new EqualityExpr($1, new Operator(@2, equalEqualOp_C), $3); }
    |
    Expr T_NotEqual Expr { $$ = new EqualityExpr($1, new Operator(@2, notEqualOp_c), $3); }
    ;

LValue:
    T_Identifier { $$ = new FieldAccess(nullptr, new Identifier(@1, $1)); }
    |
    Expr '.' T_Identifier { $$ = new FieldAccess($1, new Identifier(@3, $3)); }
    |
    Expr '[' Expr ']' { $$ = new ArrayAccess(@1, $1, $3); }
    ;

Constant:
    T_IntConstant { $$ = new IntConstant(@1, $1); }
    |
    T_DoubleConstant { $$ = new DoubleConstant(@1, $1); }
    |
    T_BoolConstant { $$ = new BoolConstant(@1, $1); }
    |
    T_StringConstant { $$ = new StringConstant(@1, $1); }
    |
    T_Null { $$ = new NullConstant(@1); }                                
    ;

%%

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
