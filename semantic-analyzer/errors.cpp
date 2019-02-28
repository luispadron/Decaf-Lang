/* File: errors.cc
 * ---------------
 * Implementation for error-reporting class.
 */

#include "errors.h"
#include <iostream>
#include <sstream>
#include <stdarg.h>
#include <stdio.h>
#include <utility>
using namespace std;

#include "scanner.h" // for GetLineNumbered
#include "ast_type.h"
#include "ast_expr.h"
#include "ast_stmt.h"
#include "ast_decl.h"


int ReportError::_num_errors = 0;
multimap<yyltype,string> ReportError::errors;

void ReportError::underline_error_in_line(const char *line, const yyltype *pos) {
    if (!line) return;
    cerr << line << endl;
    for (int i = 1; i <= pos->last_column; i++)
        cerr << (i >= pos->first_column ? '^' : ' ');
    cerr << endl;
}

 
void ReportError::emit_error(yyltype *loc, string msg) {
    _num_errors++;
    if (loc)
	errors.insert(make_pair(*loc, msg));
    else
        output_error(loc, msg);
}

void ReportError::output_error(const yyltype *loc, string msg) {
    fflush(stdout); // make sure any buffered text has been output
    if (loc) {
        cerr << endl << "*** Error line " << loc->first_line << "." << endl;
        underline_error_in_line(GetLineNumbered(loc->first_line), loc);
    } else
        cerr << endl << "*** Error." << endl;
    cerr << "*** " << msg << endl << endl;
}

void ReportError::print_errors() {
    for (multimap<yyltype,string>::iterator iter = errors.begin(); iter != errors.end(); ++iter)
        output_error(&iter->first, iter->second);
}

void ReportError::formatted(yyltype *loc, const char *format, ...) {
    va_list args;
    char errbuf[2048];
    
    va_start(args, format);
    vsprintf(errbuf,format, args);
    va_end(args);
    emit_error(loc, errbuf);
}

void ReportError::unterm_comment() {
    emit_error(nullptr, "Input ends with unterminated comment");
}

void ReportError::invalid_directive(int linenum) {
    yyltype ll = {0, linenum, 0, 0};
    emit_error(&ll, "Invalid # directive");
}

void ReportError::long_identifier(yyltype *loc, const char *ident) {
    ostringstream s;
    s << "Identifier too long: \"" << ident << "\"";
    emit_error(loc, s.str());
}

void ReportError::unterm_string(yyltype *loc, const char *str) {
    ostringstream s;
    s << "Unterminated string constant: " << str;
    emit_error(loc, s.str());
}

void ReportError::unrecog_char(yyltype *loc, char ch) {
    ostringstream s;
    s << "Unrecognized char: '" << ch << "'";
    emit_error(loc, s.str());
}

void ReportError::decl_conflict(Decl *newDecl, Decl *prevDecl) {
    ostringstream s;
    s << "Declaration of '" << newDecl << "' here conflicts with declaration on line "
      << prevDecl->get_location()->first_line;
    emit_error(newDecl->get_location(), s.str());
}
  
void ReportError::override_mismatch(Decl *fnDecl) {
    ostringstream s;
    s << "Method '" << fnDecl << "' must match inherited type signature";
    emit_error(fnDecl->get_location(), s.str());
}

void ReportError::interface_not_implemented(Decl *classDecl, Type *intfType) {
    ostringstream s;
    s << "Class '" << classDecl << "' does not implement entire interface '" << intfType << "'";
    emit_error(intfType->get_location(), s.str());
}

void ReportError::identifier_not_found(Identifier *ident, Reason_e whyNeeded) {
    ostringstream s;
    static const char *names[] =  {"type", "class", "interface", "variable", "function"};
    s << "No declaration found for "<< names[static_cast<int>(whyNeeded)] << " '" << ident << "'";
    emit_error(ident->get_location(), s.str());
}

void ReportError::incompatible_operands(Operator *op, Type *lhs, Type *rhs) {
    ostringstream s;
    s << "Incompatible operands: " << lhs << " " << op << " " << rhs;
    emit_error(op->get_location(), s.str());
}
     
void ReportError::incompatible_operand(Operator *op, Type *rhs) {
    ostringstream s;
    s << "Incompatible operand: " << op << " " << rhs;
    emit_error(op->get_location(), s.str());
}

void ReportError::this_outside_class_scope(This *th) {
    emit_error(th->get_location(), "'this' is only valid within class scope");
}

void ReportError::brackets_on_non_array(Expr *baseExpr) {
    emit_error(baseExpr->get_location(), "[] can only be applied to arrays");
}

void ReportError::subscript_not_integer(Expr *subscriptExpr) {
    emit_error(subscriptExpr->get_location(), "Array subscript must be an integer");
}

void ReportError::new_array_size_not_integer(Expr *sizeExpr) {
    emit_error(sizeExpr->get_location(), "Size for NewArray must be an integer");
}

void ReportError::num_args_mismatch(Identifier *fnIdentifier, int numExpected, int numGiven) {
    ostringstream s;
    s << "Function '"<< fnIdentifier << "' expects " << numExpected << " argument" << (numExpected==1?"":"s")
      << " but " << numGiven << " given";
    emit_error(fnIdentifier->get_location(), s.str());
}

void ReportError::arg_mismatch(Expr *arg, int argIndex, Type *given, Type *expected) {
  ostringstream s;
  s << "Incompatible argument " << argIndex << ": " << given << " given, " << expected << " expected";
    emit_error(arg->get_location(), s.str());
}

void ReportError::return_mismatch(ReturnStmt *rStmt, Type *given, Type *expected) {
    ostringstream s;
    s << "Incompatible return: " << given << " given, " << expected << " expected";
    emit_error(rStmt->get_location(), s.str());
}

void ReportError::field_not_found_in_base(Identifier *field, Type *base) {
    ostringstream s;
    s << base << " has no such field '" << field << "'";
    emit_error(field->get_location(), s.str());
}
     
void ReportError::inaccessible_field(Identifier *field, Type *base) {
    ostringstream s;
    s  << base << " field '" << field << "' only accessible within class scope";
    emit_error(field->get_location(), s.str());
}

void ReportError::print_arg_mismatch(Expr *arg, int argIndex, Type *given) {
    ostringstream s;
    s << "Incompatible argument " << argIndex << ": " << given
        << " given, int/bool/string expected";
    emit_error(arg->get_location(), s.str());
}

void ReportError::test_not_boolean(Expr *testExpr) {
    emit_error(testExpr->get_location(), "Test expression must have boolean type");
}

void ReportError::break_outside_loop(BreakStmt *bStmt) {
    emit_error(bStmt->get_location(), "break is only allowed inside a loop");
}
  
/* Function: yyerror()
 * -------------------
 * Standard error-reporting function expected by yacc. Our version merely
 * just calls into the error reporter above, passing the location of
 * the last token read. If you want to suppress the ordinary "parse error"
 * message from yacc, you can implement yyerror to do nothing and
 * then call ReportError::Formatted yourself with a more descriptive 
 * message.
 */
void yyerror(const char *msg) {
    ReportError::formatted(&yylloc, "%s", msg);
}
