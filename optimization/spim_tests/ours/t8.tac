	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Squash.Grow:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp0 = "But I don't like squash\n"
	  .data			# create string constant marked with label
	  _string1: .asciiz "But I don't like squash\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp0
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1 = 10
	  li $t1, 10		# load constant value 10 into $t1
	# _tmp2 = 5
	  li $t0, 5		# load constant value 5 into $t0
	# _tmp3 = _tmp1 * _tmp2
	  mul $t0, $t1, $t0	
	# PushParam _tmp3
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
	# VTable for class Squash
	  .data
	  .align 2
	  Squash:		# label for class Squash vtable
	  .word _Vegetable.Eat
	  .word _Squash.Grow
	  .text
  _Vegetable.Eat:
	# BeginFunc 40
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 40	# decrement sp to make space for locals/temps
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  lw $t2, 8($fp)	# fill veg to $t2 from $fp+8
	  lw $t2, -8($fp)	# fill s to $t2 from $fp-8
	  lw $t2, -12($fp)	# fill w to $t2 from $fp-12
	# _tmp4 = 5
	  li $t1, 5		# load constant value 5 into $t1
	# _tmp5 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# _tmp6 = _tmp4 % _tmp5
	  rem $t0, $t1, $t0	
	# *(this + 4) = _tmp6
	  sw $t0, 4($t1) 	# store with offset
	# _tmp7 = "Yum! "
	  .data			# create string constant marked with label
	  _string2: .asciiz "Yum! "
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp7
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t1, 4($fp)	# spill this from $t1 to $fp+4
	  sw $t2, 8($fp)	# spill veg from $t2 to $fp+8
	  sw $t2, -8($fp)	# spill s from $t2 to $fp-8
	  sw $t2, -12($fp)	# spill w from $t2 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  lw $t2, 8($fp)	# fill veg to $t2 from $fp+8
	  lw $t2, -8($fp)	# fill s to $t2 from $fp-8
	  lw $t2, -12($fp)	# fill w to $t2 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp8 = *(this + 4)
	  lw $t0, 4($t1) 	# load with offset
	# PushParam _tmp8
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t2, 8($fp)	# spill veg from $t2 to $fp+8
	  sw $t2, -8($fp)	# spill s from $t2 to $fp-8
	  sw $t2, -12($fp)	# spill w from $t2 to $fp-12
	  jal _PrintInt      	# jump to function
	  lw $t2, 8($fp)	# fill veg to $t2 from $fp+8
	  lw $t2, -8($fp)	# fill s to $t2 from $fp-8
	  lw $t2, -12($fp)	# fill w to $t2 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp9 = "\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp9
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 8($fp)	# spill veg from $t2 to $fp+8
	  sw $t2, -8($fp)	# spill s from $t2 to $fp-8
	  sw $t2, -12($fp)	# spill w from $t2 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 8($fp)	# fill veg to $t2 from $fp+8
	  lw $t2, -8($fp)	# fill s to $t2 from $fp-8
	  lw $t2, -12($fp)	# fill w to $t2 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp10 = *(veg)
	  lw $t0, 0($t2) 	# load with offset
	# _tmp11 = *(_tmp10 + 4)
	  lw $t3, 4($t0) 	# load with offset
	# PushParam w
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam s
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam veg
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp11
	  jalr $t3            	# jump to function
	# PopParams 12
	  add $sp, $sp, 12	# pop params off stack
	# Return 
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
  _Vegetable.Grow:
	# BeginFunc 12
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 12	# decrement sp to make space for locals/temps
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	# _tmp12 = "Grow, little vegetables, grow!\n"
	  .data			# create string constant marked with label
	  _string4: .asciiz "Grow, little vegetables, grow!\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp12
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t1, 4($fp)	# spill this from $t1 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp13 = *(this)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp14 = *(_tmp13)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp14
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Vegetable
	  .data
	  .align 2
	  Vegetable:		# label for class Vegetable vtable
	  .word _Vegetable.Eat
	  .word _Vegetable.Grow
	  .text
  _Grow:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp15 = "mmm... veggies!\n"
	  .data			# create string constant marked with label
	  _string5: .asciiz "mmm... veggies!\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp15
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Seeds
	  .data
	  .align 2
	  Seeds:		# label for class Seeds vtable
	  .text
  main:
	# BeginFunc 264
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 264	# decrement sp to make space for locals/temps
	# _tmp16 = 2
	  li $t3, 2		# load constant value 2 into $t3
	# _tmp17 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp18 = _tmp16 < _tmp17
	  slt $t0, $t3, $t0	
	# IfZ _tmp18 Goto _L0
	  beqz $t0, _L0	# branch if _tmp18 is zero 
	# _tmp19 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string6	# load label
	# PushParam _tmp19
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, -12($fp)	# spill _tmp16 from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t3, -12($fp)	# fill _tmp16 to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, -12($fp)	# spill _tmp16 from $t3 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t3, -12($fp)	# fill _tmp16 to $t3 from $fp-12
  _L0:
	# _tmp20 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp21 = _tmp20 + _tmp16
	  add $t2, $t0, $t3	
	# _tmp22 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp23 = _tmp21 * _tmp22
	  mul $t0, $t2, $t1	
	# PushParam _tmp23
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp24 = LCall _Alloc
	  sw $t3, -12($fp)	# spill _tmp16 from $t3 to $fp-12
	  sw $t1, -36($fp)	# spill _tmp22 from $t1 to $fp-36
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, -12($fp)	# fill _tmp16 to $t3 from $fp-12
	  lw $t1, -36($fp)	# fill _tmp22 to $t1 from $fp-36
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp24) = _tmp16
	  sw $t3, 0($t0) 	# store with offset
	# _tmp25 = _tmp24 + _tmp22
	  add $t0, $t0, $t1	
	# veggies = _tmp25
	  move $t0, $t0	# copy regs
	# _tmp26 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp27 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp28 = _tmp26 < _tmp27
	  slt $t2, $t4, $t3	
	# _tmp29 = *(veggies + -4)
	  lw $t1, -4($t0) 	# load with offset
	# _tmp30 = _tmp26 < _tmp29
	  slt $t1, $t4, $t1	
	# _tmp31 = _tmp30 == _tmp27
	  seq $t1, $t1, $t3	
	# _tmp32 = _tmp28 || _tmp31
	  or $t1, $t2, $t1	
	# IfZ _tmp32 Goto _L1
	  beqz $t1, _L1	# branch if _tmp32 is zero 
	# _tmp33 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t1, _string7	# load label
	# PushParam _tmp33
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t4, -52($fp)	# spill _tmp26 from $t4 to $fp-52
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t4, -52($fp)	# fill _tmp26 to $t4 from $fp-52
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t4, -52($fp)	# spill _tmp26 from $t4 to $fp-52
	  jal _Halt          	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t4, -52($fp)	# fill _tmp26 to $t4 from $fp-52
  _L1:
	# _tmp34 = 4
	  li $t5, 4		# load constant value 4 into $t5
	# _tmp35 = _tmp34 * _tmp26
	  mul $t1, $t5, $t4	
	# _tmp36 = veggies + _tmp35
	  add $t3, $t0, $t1	
	# _tmp37 = 12
	  li $t1, 12		# load constant value 12 into $t1
	# PushParam _tmp37
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp38 = LCall _Alloc
	  sw $t3, -92($fp)	# spill _tmp36 from $t3 to $fp-92
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  lw $t3, -92($fp)	# fill _tmp36 to $t3 from $fp-92
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp39 = Squash
	  la $t1, Squash	# load label
	# *(_tmp38) = _tmp39
	  sw $t1, 0($t2) 	# store with offset
	# *(_tmp36) = _tmp38
	  sw $t2, 0($t3) 	# store with offset
	# _tmp40 = 1
	  li $t4, 1		# load constant value 1 into $t4
	# _tmp41 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp42 = _tmp40 < _tmp41
	  slt $t2, $t4, $t3	
	# _tmp43 = *(veggies + -4)
	  lw $t1, -4($t0) 	# load with offset
	# _tmp44 = _tmp40 < _tmp43
	  slt $t1, $t4, $t1	
	# _tmp45 = _tmp44 == _tmp41
	  seq $t1, $t1, $t3	
	# _tmp46 = _tmp42 || _tmp45
	  or $t1, $t2, $t1	
	# IfZ _tmp46 Goto _L2
	  beqz $t1, _L2	# branch if _tmp46 is zero 
	# _tmp47 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t1, _string8	# load label
	# PushParam _tmp47
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t4, -108($fp)	# spill _tmp40 from $t4 to $fp-108
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t4, -108($fp)	# fill _tmp40 to $t4 from $fp-108
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t4, -108($fp)	# spill _tmp40 from $t4 to $fp-108
	  jal _Halt          	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t4, -108($fp)	# fill _tmp40 to $t4 from $fp-108
  _L2:
	# _tmp48 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp49 = _tmp48 * _tmp40
	  mul $t1, $t1, $t4	
	# _tmp50 = veggies + _tmp49
	  add $t2, $t0, $t1	
	# _tmp51 = 12
	  li $t1, 12		# load constant value 12 into $t1
	# PushParam _tmp51
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp52 = LCall _Alloc
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t2, -148($fp)	# spill _tmp50 from $t2 to $fp-148
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t2, -148($fp)	# fill _tmp50 to $t2 from $fp-148
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp53 = Vegetable
	  la $t3, Vegetable	# load label
	# *(_tmp52) = _tmp53
	  sw $t3, 0($t1) 	# store with offset
	# *(_tmp50) = _tmp52
	  sw $t1, 0($t2) 	# store with offset
	# _tmp54 = 10
	  li $t1, 10		# load constant value 10 into $t1
	# PushParam _tmp54
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _Grow
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  jal _Grow          	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp55 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp56 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp57 = _tmp55 < _tmp56
	  slt $t3, $t2, $t4	
	# _tmp58 = *(veggies + -4)
	  lw $t1, -4($t0) 	# load with offset
	# _tmp59 = _tmp55 < _tmp58
	  slt $t1, $t2, $t1	
	# _tmp60 = _tmp59 == _tmp56
	  seq $t1, $t1, $t4	
	# _tmp61 = _tmp57 || _tmp60
	  or $t1, $t3, $t1	
	# IfZ _tmp61 Goto _L3
	  beqz $t1, _L3	# branch if _tmp61 is zero 
	# _tmp62 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t1, _string9	# load label
	# PushParam _tmp62
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t2, -168($fp)	# spill _tmp55 from $t2 to $fp-168
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t2, -168($fp)	# fill _tmp55 to $t2 from $fp-168
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t2, -168($fp)	# spill _tmp55 from $t2 to $fp-168
	  jal _Halt          	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t2, -168($fp)	# fill _tmp55 to $t2 from $fp-168
  _L3:
	# _tmp63 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp64 = _tmp63 * _tmp55
	  mul $t1, $t1, $t2	
	# _tmp65 = veggies + _tmp64
	  add $t1, $t0, $t1	
	# _tmp66 = *(_tmp65)
	  lw $t5, 0($t1) 	# load with offset
	# _tmp67 = 1
	  li $t4, 1		# load constant value 1 into $t4
	# _tmp68 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp69 = _tmp67 < _tmp68
	  slt $t2, $t4, $t3	
	# _tmp70 = *(veggies + -4)
	  lw $t1, -4($t0) 	# load with offset
	# _tmp71 = _tmp67 < _tmp70
	  slt $t1, $t4, $t1	
	# _tmp72 = _tmp71 == _tmp68
	  seq $t1, $t1, $t3	
	# _tmp73 = _tmp69 || _tmp72
	  or $t1, $t2, $t1	
	# IfZ _tmp73 Goto _L4
	  beqz $t1, _L4	# branch if _tmp73 is zero 
	# _tmp74 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t1, _string10	# load label
	# PushParam _tmp74
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t5, -212($fp)	# spill _tmp66 from $t5 to $fp-212
	  sw $t4, -216($fp)	# spill _tmp67 from $t4 to $fp-216
	  jal _PrintString   	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t5, -212($fp)	# fill _tmp66 to $t5 from $fp-212
	  lw $t4, -216($fp)	# fill _tmp67 to $t4 from $fp-216
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t0, -8($fp)	# spill veggies from $t0 to $fp-8
	  sw $t5, -212($fp)	# spill _tmp66 from $t5 to $fp-212
	  sw $t4, -216($fp)	# spill _tmp67 from $t4 to $fp-216
	  jal _Halt          	# jump to function
	  lw $t0, -8($fp)	# fill veggies to $t0 from $fp-8
	  lw $t5, -212($fp)	# fill _tmp66 to $t5 from $fp-212
	  lw $t4, -216($fp)	# fill _tmp67 to $t4 from $fp-216
  _L4:
	# _tmp75 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp76 = _tmp75 * _tmp67
	  mul $t1, $t1, $t4	
	# _tmp77 = veggies + _tmp76
	  add $t0, $t0, $t1	
	# _tmp78 = *(_tmp77)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp79 = *(_tmp78)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp80 = *(_tmp79)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp66
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam _tmp78
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp80
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
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
