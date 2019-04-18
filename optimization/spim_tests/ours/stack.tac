	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Stack.Init:
	# BeginFunc 56
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 56	# decrement sp to make space for locals/temps
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	# _tmp0 = 100
	  li $t3, 100		# load constant value 100 into $t3
	# _tmp1 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp2 = _tmp0 < _tmp1
	  slt $t0, $t3, $t0	
	# IfZ _tmp2 Goto _L0
	  beqz $t0, _L0	# branch if _tmp2 is zero 
	# _tmp3 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp3
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, 4($fp)	# spill this from $t0 to $fp+4
	  sw $t3, -8($fp)	# spill _tmp0 from $t3 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t3, -8($fp)	# fill _tmp0 to $t3 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t0, 4($fp)	# spill this from $t0 to $fp+4
	  sw $t3, -8($fp)	# spill _tmp0 from $t3 to $fp-8
	  jal _Halt          	# jump to function
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t3, -8($fp)	# fill _tmp0 to $t3 from $fp-8
  _L0:
	# _tmp4 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp5 = _tmp4 + _tmp0
	  add $t2, $t0, $t3	
	# _tmp6 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp7 = _tmp5 * _tmp6
	  mul $t0, $t2, $t1	
	# PushParam _tmp7
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp8 = LCall _Alloc
	  sw $t0, 4($fp)	# spill this from $t0 to $fp+4
	  sw $t3, -8($fp)	# spill _tmp0 from $t3 to $fp-8
	  sw $t1, -32($fp)	# spill _tmp6 from $t1 to $fp-32
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t3, -8($fp)	# fill _tmp0 to $t3 from $fp-8
	  lw $t1, -32($fp)	# fill _tmp6 to $t1 from $fp-32
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp8) = _tmp0
	  sw $t3, 0($t0) 	# store with offset
	# _tmp9 = _tmp8 + _tmp6
	  add $t0, $t0, $t1	
	# *(this + 8) = _tmp9
	  sw $t0, 8($t0) 	# store with offset
	# _tmp10 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 4) = _tmp10
	  sw $t0, 4($t0) 	# store with offset
	# _tmp11 = 3
	  li $t0, 3		# load constant value 3 into $t0
	# _tmp12 = *(this)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp13 = *(_tmp12 + 4)
	  lw $t1, 4($t1) 	# load with offset
	# PushParam _tmp11
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp13
	  jalr $t1            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Stack.Push:
	# BeginFunc 60
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 60	# decrement sp to make space for locals/temps
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t5, 8($fp)	# fill i to $t5 from $fp+8
	# _tmp14 = *(this + 8)
	  lw $t4, 8($t0) 	# load with offset
	# _tmp15 = *(this + 4)
	  lw $t3, 4($t0) 	# load with offset
	# _tmp16 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp17 = _tmp15 < _tmp16
	  slt $t1, $t3, $t2	
	# _tmp18 = *(_tmp14 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp19 = _tmp15 < _tmp18
	  slt $t0, $t3, $t0	
	# _tmp20 = _tmp19 == _tmp16
	  seq $t0, $t0, $t2	
	# _tmp21 = _tmp17 || _tmp20
	  or $t0, $t1, $t0	
	# IfZ _tmp21 Goto _L1
	  beqz $t0, _L1	# branch if _tmp21 is zero 
	# _tmp22 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp22
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, 4($fp)	# spill this from $t0 to $fp+4
	  sw $t5, 8($fp)	# spill i from $t5 to $fp+8
	  sw $t4, -8($fp)	# spill _tmp14 from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill _tmp15 from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t5, 8($fp)	# fill i to $t5 from $fp+8
	  lw $t4, -8($fp)	# fill _tmp14 to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill _tmp15 to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t0, 4($fp)	# spill this from $t0 to $fp+4
	  sw $t5, 8($fp)	# spill i from $t5 to $fp+8
	  sw $t4, -8($fp)	# spill _tmp14 from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill _tmp15 from $t3 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t5, 8($fp)	# fill i to $t5 from $fp+8
	  lw $t4, -8($fp)	# fill _tmp14 to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill _tmp15 to $t3 from $fp-12
  _L1:
	# _tmp23 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp24 = _tmp23 * _tmp15
	  mul $t0, $t0, $t3	
	# _tmp25 = _tmp14 + _tmp24
	  add $t0, $t4, $t0	
	# *(_tmp25) = i
	  sw $t5, 0($t0) 	# store with offset
	# _tmp26 = *(this + 4)
	  lw $t1, 4($t0) 	# load with offset
	# _tmp27 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp28 = _tmp26 + _tmp27
	  add $t0, $t1, $t0	
	# *(this + 4) = _tmp28
	  sw $t0, 4($t0) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Stack.Pop:
	# BeginFunc 76
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 76	# decrement sp to make space for locals/temps
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	# _tmp29 = *(this + 8)
	  lw $t5, 8($t0) 	# load with offset
	# _tmp30 = *(this + 4)
	  lw $t2, 4($t0) 	# load with offset
	# _tmp31 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp32 = _tmp30 - _tmp31
	  sub $t4, $t2, $t1	
	# _tmp33 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp34 = _tmp32 < _tmp33
	  slt $t2, $t4, $t3	
	# _tmp35 = *(_tmp29 + -4)
	  lw $t1, -4($t5) 	# load with offset
	# _tmp36 = _tmp32 < _tmp35
	  slt $t1, $t4, $t1	
	# _tmp37 = _tmp36 == _tmp33
	  seq $t1, $t1, $t3	
	# _tmp38 = _tmp34 || _tmp37
	  or $t1, $t2, $t1	
	# IfZ _tmp38 Goto _L2
	  beqz $t1, _L2	# branch if _tmp38 is zero 
	# _tmp39 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t1, _string3	# load label
	# PushParam _tmp39
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, 4($fp)	# spill this from $t0 to $fp+4
	  sw $t5, -12($fp)	# spill _tmp29 from $t5 to $fp-12
	  sw $t4, -24($fp)	# spill _tmp32 from $t4 to $fp-24
	  jal _PrintString   	# jump to function
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t5, -12($fp)	# fill _tmp29 to $t5 from $fp-12
	  lw $t4, -24($fp)	# fill _tmp32 to $t4 from $fp-24
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t0, 4($fp)	# spill this from $t0 to $fp+4
	  sw $t5, -12($fp)	# spill _tmp29 from $t5 to $fp-12
	  sw $t4, -24($fp)	# spill _tmp32 from $t4 to $fp-24
	  jal _Halt          	# jump to function
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t5, -12($fp)	# fill _tmp29 to $t5 from $fp-12
	  lw $t4, -24($fp)	# fill _tmp32 to $t4 from $fp-24
  _L2:
	# _tmp40 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp41 = _tmp40 * _tmp32
	  mul $t1, $t1, $t4	
	# _tmp42 = _tmp29 + _tmp41
	  add $t1, $t5, $t1	
	# _tmp43 = *(_tmp42)
	  lw $t1, 0($t1) 	# load with offset
	# val = _tmp43
	  move $t3, $t1	# copy regs
	# _tmp44 = *(this + 4)
	  lw $t2, 4($t0) 	# load with offset
	# _tmp45 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp46 = _tmp44 - _tmp45
	  sub $t1, $t2, $t1	
	# *(this + 4) = _tmp46
	  sw $t1, 4($t0) 	# store with offset
	# Return val
	  move $v0, $t3		# assign return value into $v0
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
  _Stack.NumElems:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	# _tmp47 = *(this + 4)
	  lw $t0, 4($t0) 	# load with offset
	# Return _tmp47
	  move $v0, $t0		# assign return value into $v0
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
	# VTable for class Stack
	  .data
	  .align 2
	  Stack:		# label for class Stack vtable
	  .word _Stack.Init
	  .word _Stack.Push
	  .word _Stack.Pop
	  .word _Stack.NumElems
	  .text
  main:
	# BeginFunc 136
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 136	# decrement sp to make space for locals/temps
	# _tmp48 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp48
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp49 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp50 = Stack
	  la $t0, Stack	# load label
	# *(_tmp49) = _tmp50
	  sw $t0, 0($t1) 	# store with offset
	# s = _tmp49
	  move $t0, $t1	# copy regs
	# _tmp51 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp52 = *(_tmp51)
	  lw $t1, 0($t1) 	# load with offset
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp52
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp53 = 3
	  li $t2, 3		# load constant value 3 into $t2
	# _tmp54 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp55 = *(_tmp54 + 4)
	  lw $t1, 4($t1) 	# load with offset
	# PushParam _tmp53
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp55
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp56 = 7
	  li $t2, 7		# load constant value 7 into $t2
	# _tmp57 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp58 = *(_tmp57 + 4)
	  lw $t1, 4($t1) 	# load with offset
	# PushParam _tmp56
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp58
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp59 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp60 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp61 = *(_tmp60 + 4)
	  lw $t1, 4($t1) 	# load with offset
	# PushParam _tmp59
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp61
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp62 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp63 = *(_tmp62 + 12)
	  lw $t1, 12($t1) 	# load with offset
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp64 = ACall _tmp63
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp64
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintInt      	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp65 = " "
	  .data			# create string constant marked with label
	  _string4: .asciiz " "
	  .text
	  la $t1, _string4	# load label
	# PushParam _tmp65
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp66 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp67 = *(_tmp66 + 8)
	  lw $t1, 8($t1) 	# load with offset
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp68 = ACall _tmp67
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp68
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintInt      	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp69 = " "
	  .data			# create string constant marked with label
	  _string5: .asciiz " "
	  .text
	  la $t1, _string5	# load label
	# PushParam _tmp69
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp70 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp71 = *(_tmp70 + 8)
	  lw $t1, 8($t1) 	# load with offset
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp72 = ACall _tmp71
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp72
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintInt      	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp73 = " "
	  .data			# create string constant marked with label
	  _string6: .asciiz " "
	  .text
	  la $t1, _string6	# load label
	# PushParam _tmp73
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp74 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp75 = *(_tmp74 + 8)
	  lw $t1, 8($t1) 	# load with offset
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp76 = ACall _tmp75
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jalr $t1            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp76
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintInt      	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp77 = " "
	  .data			# create string constant marked with label
	  _string7: .asciiz " "
	  .text
	  la $t1, _string7	# load label
	# PushParam _tmp77
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill s from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill s to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp78 = *(s)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp79 = *(_tmp78 + 12)
	  lw $t1, 12($t1) 	# load with offset
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp80 = ACall _tmp79
	  jalr $t1            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp80
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
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
