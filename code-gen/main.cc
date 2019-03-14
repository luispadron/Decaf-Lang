/* File: main.cc
 * -------------
 * This file defines the main() routine for the program and not much else.
 * You should not need to modify this file.
 */
 
#include <string.h>
#include <stdio.h>
#include "utility.h"
#include "errors.h"
#include "parser.h"

void SysCallCodeGen();


/* Function: main()
 * ----------------
 * Entry point to the entire program.  We parse the command line and turn
 * on any debugging flags requested by the user when invoking the program.
 * InitScanner() is used to set up the scanner.
 * InitParser() is used to set up the parser. The call to yyparse() will
 * attempt to parse a complete program from the input. 
 */
int main(int argc, char *argv[])
{
    ParseCommandLine(argc, argv);
  
    InitScanner();
    InitParser();
    yyparse();
    if (ReportError::NumErrors() > 0)
	ReportError::PrintErrors();
    if (ReportError::NumErrors() == 0)
	SysCallCodeGen();
    return (ReportError::NumErrors() == 0? 0 : -1);
}

void SysCallCodeGen()
{
    printf("  _PrintInt:\n");
    printf("	  subu $sp, $sp, 8	# decrement sp to make space to save ra,fp\n");
    printf("	  sw $fp, 8($sp)	# save fp\n");
    printf("	  sw $ra, 4($sp)	# save ra\n");
    printf("	  addiu $fp, $sp, 8	# set up new fp\n");
    printf("	  lw $a0, 4($fp)	# fill a from $fp+4\n");
    printf("	# LCall _PrintInt\n");
    printf("	  li $v0, 1\n");
    printf("	  syscall\n");
    printf("	# EndFunc\n");
    printf("	# (below handles reaching end of fn body with no explicit return)\n");
    printf("	  move $sp, $fp		# pop callee frame off stack\n");
    printf("	  lw $ra, -4($fp)	# restore saved ra\n");
    printf("	  lw $fp, 0($fp)	# restore saved fp\n");
    printf("	  jr $ra		# return from function\n");
    printf("\n");
    printf("  _ReadInteger:\n");
    printf("	  subu $sp, $sp, 8	# decrement sp to make space to save ra,fp\n");
    printf("	  sw $fp, 8($sp)	# save fp\n");
    printf("	  sw $ra, 4($sp)	# save ra\n");
    printf("	  addiu $fp, $sp, 8	# set up new fp\n");
    printf("	  li $v0, 5\n");
    printf("	  syscall\n");
    printf("	# EndFunc\n");
    printf("	# (below handles reaching end of fn body with no explicit return)\n");
    printf("	  move $sp, $fp		# pop callee frame off stack\n");
    printf("	  lw $ra, -4($fp)	# restore saved ra\n");
    printf("	  lw $fp, 0($fp)	# restore saved fp\n");
    printf("	  jr $ra		# return from function\n");
    printf("\n");
    printf("\n");
    printf("  _PrintBool:\n");
    printf("	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp\n");
    printf("	  sw $fp, 8($sp)        # save fp\n");
    printf("	  sw $ra, 4($sp)        # save ra\n");
    printf("	  addiu $fp, $sp, 8     # set up new fp\n");
    printf("	  lw $a0, 4($fp)        # fill a from $fp+4\n");
    printf("	  li $v0, 4\n");
    printf("	  beq $a0, $0, PrintBoolFalse\n");
    printf("	  la $a0, _PrintBoolTrueString\n");
    printf("	  j PrintBoolEnd\n");
    printf("  PrintBoolFalse:\n");
    printf(" 	  la $a0, _PrintBoolFalseString\n");
    printf("  PrintBoolEnd:\n");
    printf("	  syscall\n");
    printf("	# EndFunc\n");
    printf("	# (below handles reaching end of fn body with no explicit return)\n");
    printf("	  move $sp, $fp         # pop callee frame off stack\n");
    printf("	  lw $ra, -4($fp)       # restore saved ra\n");
    printf("	  lw $fp, 0($fp)        # restore saved fp\n");
    printf("	  jr $ra                # return from function\n");
    printf("\n");
    printf("      .data			# create string constant marked with label\n");
    printf("      _PrintBoolTrueString: .asciiz \"true\"\n");
    printf("      .text\n");
    printf("\n");
    printf("      .data			# create string constant marked with label\n");
    printf("      _PrintBoolFalseString: .asciiz \"false\"\n");
    printf("      .text\n");
    printf("\n");
    printf("  _PrintString:\n");
    printf("	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp\n");
    printf("	  sw $fp, 8($sp)        # save fp\n");
    printf("	  sw $ra, 4($sp)        # save ra\n");
    printf("	  addiu $fp, $sp, 8     # set up new fp\n");
    printf("	  lw $a0, 4($fp)        # fill a from $fp+4\n");
    printf("	  li $v0, 4\n");
    printf("	  syscall\n");
    printf("	# EndFunc\n");
    printf("	# (below handles reaching end of fn body with no explicit return)\n");
    printf("	  move $sp, $fp         # pop callee frame off stack\n");
    printf("	  lw $ra, -4($fp)       # restore saved ra\n");
    printf("	  lw $fp, 0($fp)        # restore saved fp\n");
    printf("	  jr $ra                # return from function\n");
    printf("\n");
    printf("  _Alloc:\n");
    printf("	  subu $sp, $sp, 8      # decrement sp to make space to save ra,fp\n");
    printf("	  sw $fp, 8($sp)        # save fp\n");
    printf("	  sw $ra, 4($sp)        # save ra\n");
    printf("	  addiu $fp, $sp, 8     # set up new fp\n");
    printf("	  lw $a0, 4($fp)        # fill a from $fp+4\n");
    printf("	  li $v0, 9\n");
    printf("	  syscall\n");
    printf("	# EndFunc\n");
    printf("	# (below handles reaching end of fn body with no explicit return)\n");
    printf("	  move $sp, $fp         # pop callee frame off stack\n");
    printf("	  lw $ra, -4($fp)       # restore saved ra\n");
    printf("	  lw $fp, 0($fp)        # restore saved fp\n");
    printf("	  jr $ra                # return from function\n");
    printf("\n");
    printf("  _Halt:\n");
    printf("	  li $v0, 10\n");
    printf("	  syscall\n");
    printf("	# EndFunc\n");
    printf("\n");
    printf("\n");
    printf("  _StringEqual:\n");
    printf("	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp\n");
    printf("	  sw $fp, 8($sp)        # save fp\n");
    printf("	  sw $ra, 4($sp)        # save ra\n");
    printf("	  addiu $fp, $sp, 8     # set up new fp\n");
    printf("	  lw $a0, 4($fp)        # fill a from $fp+4\n");
    printf("	  lw $a1, 8($fp)        # fill a from $fp+8\n");
    printf("	  beq $a0,$a1,Lrunt10\n");
    printf("  Lrunt12:\n");
    printf("	  lbu  $v0,($a0)\n");
    printf("	  lbu  $a2,($a1)\n");
    printf("	  bne $v0,$a2,Lrunt11\n");
    printf("	  addiu $a0,$a0,1\n");
    printf("	  addiu $a1,$a1,1\n");
    printf("	  bne $v0,$0,Lrunt12\n");
    printf("      li  $v0,1\n");
    printf("      j Lrunt10\n");
    printf("  Lrunt11:\n");
    printf("	  li  $v0,0\n");
    printf("  Lrunt10:\n");
    printf("	# EndFunc\n");
    printf("	# (below handles reaching end of fn body with no explicit return)\n");
    printf("	  move $sp, $fp         # pop callee frame off stack\n");
    printf("	  lw $ra, -4($fp)       # restore saved ra\n");
    printf("	  lw $fp, 0($fp)        # restore saved fp\n");
    printf("	  jr $ra                # return from function\n");
    printf("\n");
    printf("\n");
    printf("\n");
    printf("  _ReadLine:\n");
    printf("	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp\n");
    printf("	  sw $fp, 8($sp)        # save fp\n");
    printf("	  sw $ra, 4($sp)        # save ra\n");
    printf("	  addiu $fp, $sp, 8     # set up new fp\n");
    printf("	  li $a0, 101\n");
    printf("	  li $v0, 9\n");
    printf("	  syscall\n");
    printf("	  addi $a0, $v0, 0\n");
    printf("	  li $v0, 8\n");
    printf("	  li $a1,101 \n");
    printf("	  syscall\n");
    printf("	  addiu $v0,$a0,0       # pointer to begin of string\n");
    printf("  Lrunt21:\n");
    printf("	  lb $a1,($a0)          # load character at pointer\n");
    printf("	  addiu $a0,$a0,1       # forward pointer\n");
    printf("	  bnez $a1,Lrunt21      # loop until end of string is reached\n");
    printf("	  lb $a1,-2($a0)        # load character before end of string\n");
    printf("	  li $a2,10             # newline character");
    printf("	  bneq $a1,$a2,Lrunt20  # do not remove last character if not newline\n");
    printf("	  sb $0,-2($a0)         # Add the terminating character in its place\n");
    printf("  Lrunt20:\n");
    printf("	# EndFunc\n");
    printf("	# (below handles reaching end of fn body with no explicit return)\n");
    printf("	  move $sp, $fp         # pop callee frame off stack\n");
    printf("	  lw $ra, -4($fp)       # restore saved ra\n");
    printf("	  lw $fp, 0($fp)        # restore saved fp\n");
    printf("	  jr $ra                # return from function\n");
}
