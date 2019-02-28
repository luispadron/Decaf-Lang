/* File: errors.h
 * --------------
 * This file defines an error-reporting class with a set of already
 * implemented static methods for reporting the standard Decaf errors.
 * You should report all errors via this class so that your error
 * messages will have the same wording/spelling as ours and thus
 * diff can easily compare the two. If needed, you can add new
 * methods if you have some fancy error-reporting, but for the most
 * part, you will just use the class as given.
 */

#ifndef _H_errors
#define _H_errors

#include <map>
#include <string>
using std::multimap;
using std::string;
#include "location.h"
class Type;
class Identifier;
class Expr;
class BreakStmt;
class ReturnStmt;
class This;
class Decl;
class Operator;

/* General notes on using this class
 * ----------------------------------
 * Each of the methods in thie class matches one of the standard Decaf
 * errors and reports a specific problem such as an unterminated string,
 * type mismatch, declaration conflict, etc. You will call these methods
 * to report problems encountered during the analysis phases. All methods
 * on this class are static, thus you can invoke methods directly via
 * the class name, e.g.
 *
 *    if (missingEnd) ReportError::UntermString(&yylloc, str);
 *
 * For some methods, the first argument is the pointer to the location
 * structure that identifies where the problem is (usually this is the
 * location of the offending token). You can pass NULL for the argument
 * if there is no appropriate position to point out. For other methods,
 * location is accessed by messaging the node in error which is passed
 * as an argument. You cannot pass NULL for these arguments.
 */


enum class Reason_e {LookingForType, LookingForClass, LookingForInterface, LookingForVariable, LookingForFunction};

class ReportError {
public:

  // Errors used by preprocessor
  static void unterm_comment();
  static void invalid_directive(int linenum);


  // Errors used by scanner
  static void long_identifier(yyltype *loc, const char *ident);
  static void unterm_string(yyltype *loc, const char *str);
  static void unrecog_char(yyltype *loc, char ch);

  
  // Errors used by semantic analyzer for declarations
  static void decl_conflict(Decl *newDecl, Decl *prevDecl);
  static void override_mismatch(Decl *fnDecl);
  static void interface_not_implemented(Decl *classDecl, Type *intfType);


  // Errors used by semantic analyzer for identifiers
  static void identifier_not_found(Identifier *ident, Reason_e whyNeeded);

  
  // Errors used by semantic analyzer for expressions
  static void incompatible_operand(Operator *op, Type *rhs); // unary
  static void incompatible_operands(Operator *op, Type *lhs, Type *rhs); // binary
  static void this_outside_class_scope(This *th);

  
 // Errors used by semantic analyzer for array acesss & NewArray
  static void brackets_on_non_array(Expr *baseExpr);
  static void subscript_not_integer(Expr *subscriptExpr);
  static void new_array_size_not_integer(Expr *sizeExpr);


  // Errors used by semantic analyzer for function/method calls
  static void num_args_mismatch(Identifier *fnIdentifier, int numExpected, int numGiven);
  static void arg_mismatch(Expr *arg, int argIndex, Type *given, Type *expected);
  static void print_arg_mismatch(Expr *arg, int argIndex, Type *given);


  // Errors used by semantic analyzer for field access
  static void field_not_found_in_base(Identifier *field, Type *base);
  static void inaccessible_field(Identifier *field, Type *base);


  // Errors used by semantic analyzer for control structures
  static void test_not_boolean(Expr *testExpr);
  static void return_mismatch(ReturnStmt *rStmt, Type *given, Type *expected);
  static void break_outside_loop(BreakStmt *bStmt);


  // Generic method to report a printf-style error message
  static void formatted(yyltype *loc, const char *format, ...);


  // Returns number of error messages printed
  static int num_errors() { return _num_errors; }

  // Print out all error messages in lexical order
  static void print_errors();
  
 private:

  static void underline_error_in_line(const char *line, const yyltype *pos);
  static void emit_error(yyltype *loc, string msg);
  static void output_error(const yyltype *loc, string msg);
  static int _num_errors;
  static multimap<yyltype,string> errors;
  
};

#endif
