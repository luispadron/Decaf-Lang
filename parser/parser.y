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
const char * const plusOp_c = "+";              // '+' plus operator
const char * const minusOp_c = "-";             // '-' minus operator
const char * const multOp_c = "*";              // '*' multiplication operator
const char * const divOp_c = "/";               // '/' division operator
const char * const modOp_c = "%";               // '%' (mod) operator
const char * const notOp_c = "!";               // '!' not (negation) operator
const char * const andOp_c = "&&";              // '&&' and operator
const char * const orOp_c = "||";               // '||' or operator

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
%left T_Or T_And
%left '<' '>' T_LessEqual T_GreaterEqual T_Equal T_NotEqual
%left '+' '-'
%left '*' '/' '%'
%left UMINUS    // used for unary minus since precedence is higher than just simple '-'


/* Non-terminal types
 * ------------------
 */

%type<ident>            Ident

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

%type <expr>            Expr LValue Call Constant
%type <exprList>        ExprList Actuals

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
    Type Ident { $$ = new VarDecl($2, $1); }
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
    Ident { $$ = new NamedType($1); }
    |
    Type T_Dims { $$ = new ArrayType(@1, $1); }
    ;

FunctionDecl:
    Type Ident '(' Formals ')' StmtBlock 
        { 
            $$ = new FnDecl($2, $1, $4);
            $$->SetFunctionBody($6);
        }
    |
    T_Void Ident '(' Formals ')' StmtBlock
        {
            $$ = new FnDecl($2, Type::voidType, $4);
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
    T_Class Ident '{' FieldList '}' 
        { $$ = new ClassDecl($2, nullptr, new List<NamedType*>, $4); }
    |
    T_Class Ident T_Extends Ident '{' FieldList '}' 
        { 
            $$ = new ClassDecl($2, 
                               new NamedType($4), 
                               new List<NamedType*>, 
                               $6); 
        }
    |
    T_Class Ident T_Implements NamedTypeList '{' FieldList '}' 
        { $$ = new ClassDecl($2, nullptr, $4, $6); }
    |
    T_Class Ident T_Extends Ident T_Implements NamedTypeList '{' FieldList '}'
        { 
            $$ = new ClassDecl($2, 
                               new NamedType($4), 
                               $6, 
                               $8); 
        }
    ;

NamedTypeList:
    NamedTypeList Ident { ($$=$1)->Append(new NamedType($2)); }
    |
    Ident { ($$ = new List<NamedType*>)->Append(new NamedType($1)); }
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
    T_Interface Ident '{' PrototypeList '}' 
        { $$ = new InterfaceDecl($2, $4); }
    ;

PrototypeList:
    PrototypeList Prototype { ($$=$1)->Append($2); }
    |
    Prototype { ($$ = new List<Decl*>)->Append($1); }
    |
    %empty { $$ = new List<Decl*>; }
    ;

Prototype:
    Type Ident '(' Formals ')' ';' 
        { $$ = new FnDecl($2, $1, $4); }
    |
    T_Void Ident '(' Formals ')' ';'
        { $$ = new FnDecl($2, Type::voidType, $4); }
    ;

StmtBlock:
    '{' VariableDeclList StmtList '}' { $$ = new StmtBlock($2, $3); }
    |
    '{' VariableDeclList '}' { $$ = new StmtBlock($2, new List<Stmt*>); }
    |
    '{' StmtList '}' { $$ = new StmtBlock(new List<VarDecl*>, $2); }
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
    BreakStmt { $$ = $1; }
    |
    ReturnStmt { $$ = $1; }
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
    T_For '(' ';' Expr ';' Expr ')' Stmt { $$ = new ForStmt(new EmptyExpr(), $4, $6, $8); }
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
    Call { $$ = $1; }
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
    |
    Expr T_And Expr { $$ = new LogicalExpr($1, new Operator(@2, andOp_c), $3); }
    |
    Expr T_Or Expr { $$ = new LogicalExpr($1, new Operator(@2, orOp_c), $3); }
    |
    '!' Expr { $$ = new LogicalExpr(new Operator(@1, notOp_c), $2); }
    |
    T_ReadInteger '(' ')' { $$ = new ReadIntegerExpr(@1); }
    |
    T_ReadLine '(' ')' { $$ = new ReadLineExpr(@1); }
    |
    T_New '(' Ident ')' { $$ = new NewExpr(@1, new NamedType($3)); }
    |
    T_NewArray '(' Expr ',' Type ')' { $$ = new NewArrayExpr(@1, $3, $5); }
    ;

LValue:
    Ident { $$ = new FieldAccess(nullptr, $1); }
    |
    Expr '.' Ident { $$ = new FieldAccess($1, $3); }
    |
    Expr '[' Expr ']' { $$ = new ArrayAccess(@1, $1, $3); }
    ;

Call:
    Ident '(' Actuals ')' { $$ = new Call(@1, nullptr, $1, $3); }
    |
    Expr '.' Ident '(' Actuals ')' { $$ = new Call(@3, $1, $3, $5); }
    ;

Actuals:
    ExprList { $$ = $1; }
    |
    %empty { $$ = new List<Expr*>; }
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

Ident:
    T_Identifier { $$ = new Identifier(@1, $1); }
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
