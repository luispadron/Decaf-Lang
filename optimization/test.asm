	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _factorial:
	# BeginFunc 36
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 36	# decrement sp to make space for locals/temps
	# _tmp0 = 1
	  li $v0, 1		# load constant value 1 into $v0
	  sw $v0, -8($fp)	# spill _tmp0 from $v0 to $fp-8
	# _tmp1 = n < _tmp0
	  lw $v0, 4($fp)	# fill n to $v0 from $fp+4
	  lw $v1, -8($fp)	# fill _tmp0 to $v1 from $fp-8
	  slt $v0, $v0, $v1	
	  sw $v0, -12($fp)	# spill _tmp1 from $v0 to $fp-12
	# _tmp2 = n == _tmp0
	  lw $v0, 4($fp)	# fill n to $v0 from $fp+4
	  lw $v1, -8($fp)	# fill _tmp0 to $v1 from $fp-8
	  seq $v0, $v0, $v1	
	  sw $v0, -16($fp)	# spill _tmp2 from $v0 to $fp-16
	# _tmp3 = _tmp1 || _tmp2
	  lw $v0, -12($fp)	# fill _tmp1 to $v0 from $fp-12
	  lw $v1, -16($fp)	# fill _tmp2 to $v1 from $fp-16
	  or $v0, $v0, $v1	
	  sw $v0, -20($fp)	# spill _tmp3 from $v0 to $fp-20
	# IfZ _tmp3 Goto _L0
	  lw $v0, -20($fp)	# fill _tmp3 to $v0 from $fp-20
	  beqz $v0, _L0	# branch if _tmp3 is zero 
	# _tmp4 = 1
	  li $v0, 1		# load constant value 1 into $v0
	  sw $v0, -24($fp)	# spill _tmp4 from $v0 to $fp-24
	# Return _tmp4
	  lw $v0, -24($fp)	# fill _tmp4 to $v0 from $fp-24
	  move $v0, $v0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L0:
	# _tmp5 = 1
	  li $v0, 1		# load constant value 1 into $v0
	  sw $v0, -28($fp)	# spill _tmp5 from $v0 to $fp-28
	# _tmp6 = n - _tmp5
	  lw $v0, 4($fp)	# fill n to $v0 from $fp+4
	  lw $v1, -28($fp)	# fill _tmp5 to $v1 from $fp-28
	  sub $v0, $v0, $v1	
	  sw $v0, -32($fp)	# spill _tmp6 from $v0 to $fp-32
	# PushParam _tmp6
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, -32($fp)	# fill _tmp6 to $v0 from $fp-32
	  sw $v0, 4($sp)	# copy param value to stack
	# _tmp7 = LCall _factorial
	  jal _factorial     	# jump to function
	  move $v0, $v0		# copy function return value from $v0
	  sw $v0, -36($fp)	# spill _tmp7 from $v0 to $fp-36
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp8 = n * _tmp7
	  lw $v0, 4($fp)	# fill n to $v0 from $fp+4
	  lw $v1, -36($fp)	# fill _tmp7 to $v1 from $fp-36
	  mul $v0, $v0, $v1	
	  sw $v0, -40($fp)	# spill _tmp8 from $v0 to $fp-40
	# Return _tmp8
	  lw $v0, -40($fp)	# fill _tmp8 to $v0 from $fp-40
	  move $v0, $v0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  main:
	# BeginFunc 48
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 48	# decrement sp to make space for locals/temps
	# _tmp9 = 1
	  li $v0, 1		# load constant value 1 into $v0
	  sw $v0, -12($fp)	# spill _tmp9 from $v0 to $fp-12
	# n = _tmp9
	  lw $v0, -12($fp)	# fill _tmp9 to $v0 from $fp-12
	  sw $v0, -8($fp)	# spill n from $v0 to $fp-8
  _L1:
	# _tmp10 = 15
	  li $v0, 15		# load constant value 15 into $v0
	  sw $v0, -16($fp)	# spill _tmp10 from $v0 to $fp-16
	# _tmp11 = n < _tmp10
	  lw $v0, -8($fp)	# fill n to $v0 from $fp-8
	  lw $v1, -16($fp)	# fill _tmp10 to $v1 from $fp-16
	  slt $v0, $v0, $v1	
	  sw $v0, -20($fp)	# spill _tmp11 from $v0 to $fp-20
	# _tmp12 = n == _tmp10
	  lw $v0, -8($fp)	# fill n to $v0 from $fp-8
	  lw $v1, -16($fp)	# fill _tmp10 to $v1 from $fp-16
	  seq $v0, $v0, $v1	
	  sw $v0, -24($fp)	# spill _tmp12 from $v0 to $fp-24
	# _tmp13 = _tmp11 || _tmp12
	  lw $v0, -20($fp)	# fill _tmp11 to $v0 from $fp-20
	  lw $v1, -24($fp)	# fill _tmp12 to $v1 from $fp-24
	  or $v0, $v0, $v1	
	  sw $v0, -28($fp)	# spill _tmp13 from $v0 to $fp-28
	# IfZ _tmp13 Goto _L2
	  lw $v0, -28($fp)	# fill _tmp13 to $v0 from $fp-28
	  beqz $v0, _L2	# branch if _tmp13 is zero 
	# _tmp14 = "Factorial("
	  .data			# create string constant marked with label
	  _string1: .asciiz "Factorial("
	  .text
	  la $v0, _string1	# load label
	  sw $v0, -32($fp)	# spill _tmp14 from $v0 to $fp-32
	# PushParam _tmp14
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, -32($fp)	# fill _tmp14 to $v0 from $fp-32
	  sw $v0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam n
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, -8($fp)	# fill n to $v0 from $fp-8
	  sw $v0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp15 = ") = "
	  .data			# create string constant marked with label
	  _string2: .asciiz ") = "
	  .text
	  la $v0, _string2	# load label
	  sw $v0, -36($fp)	# spill _tmp15 from $v0 to $fp-36
	# PushParam _tmp15
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, -36($fp)	# fill _tmp15 to $v0 from $fp-36
	  sw $v0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam n
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, -8($fp)	# fill n to $v0 from $fp-8
	  sw $v0, 4($sp)	# copy param value to stack
	# _tmp16 = LCall _factorial
	  jal _factorial     	# jump to function
	  move $v0, $v0		# copy function return value from $v0
	  sw $v0, -40($fp)	# spill _tmp16 from $v0 to $fp-40
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp16
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, -40($fp)	# fill _tmp16 to $v0 from $fp-40
	  sw $v0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp17 = "\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "\n"
	  .text
	  la $v0, _string3	# load label
	  sw $v0, -44($fp)	# spill _tmp17 from $v0 to $fp-44
	# PushParam _tmp17
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, -44($fp)	# fill _tmp17 to $v0 from $fp-44
	  sw $v0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp18 = 1
	  li $v0, 1		# load constant value 1 into $v0
	  sw $v0, -48($fp)	# spill _tmp18 from $v0 to $fp-48
	# _tmp19 = n + _tmp18
	  lw $v0, -8($fp)	# fill n to $v0 from $fp-8
	  lw $v1, -48($fp)	# fill _tmp18 to $v1 from $fp-48
	  add $v0, $v0, $v1	
	  sw $v0, -52($fp)	# spill _tmp19 from $v0 to $fp-52
	# n = _tmp19
	  lw $v0, -52($fp)	# fill _tmp19 to $v0 from $fp-52
	  sw $v0, -8($fp)	# spill n from $v0 to $fp-8
	# Goto _L1
	  b _L1		# unconditional branch
  _L2:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _PrintInt:
	  subu $sp, $sp, 8	# decrement sp to make space to save ra,fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  lw $a0, 4($fp)	# fill a from $fp+4
	# LCall _PrintInt
	  li $v0, 1
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function

  _ReadInteger:
	  subu $sp, $sp, 8	# decrement sp to make space to save ra,fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  li $v0, 5
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function


  _PrintBool:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  li $v0, 4
	  beq $a0, $0, PrintBoolFalse
	  la $a0, _PrintBoolTrueString
	  j PrintBoolEnd
  PrintBoolFalse:
 	  la $a0, _PrintBoolFalseString
  PrintBoolEnd:
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function

      .data			# create string constant marked with label
      _PrintBoolTrueString: .asciiz "true"
      .text

      .data			# create string constant marked with label
      _PrintBoolFalseString: .asciiz "false"
      .text

  _PrintString:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  li $v0, 4
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function

  _Alloc:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra,fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  li $v0, 9
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function

  _Halt:
	  li $v0, 10
	  syscall
	# EndFunc


  _StringEqual:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  lw $a1, 8($fp)        # fill a from $fp+8
	  beq $a0,$a1,Lrunt10
  Lrunt12:
	  lbu  $v0,($a0)
	  lbu  $a2,($a1)
	  bne $v0,$a2,Lrunt11
	  addiu $a0,$a0,1
	  addiu $a1,$a1,1
	  bne $v0,$0,Lrunt12
      li  $v0,1
      j Lrunt10
  Lrunt11:
	  li  $v0,0
  Lrunt10:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function



  _ReadLine:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  li $a0, 101
	  li $v0, 9
	  syscall
	  addi $a0, $v0, 0
	  li $v0, 8
	  li $a1,101 
	  syscall
	  addiu $v0,$a0,0       # pointer to begin of string
  Lrunt21:
	  lb $a1,($a0)          # load character at pointer
	  addiu $a0,$a0,1       # forward pointer
	  bnez $a1,Lrunt21      # loop until end of string is reached
	  lb $a1,-2($a0)        # load character before end of string
	  li $a2,10             # newline character	  bneq $a1,$a2,Lrunt20  # do not remove last character if not newline
	  sb $0,-2($a0)         # Add the terminating character in its place
  Lrunt20:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function
