	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Random.Init:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# *(this + 4) = seedVal
	  lw $t0, 8($fp)	# fill seedVal to $t0 from $fp+8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Random.GenRandom:
	# BeginFunc 40
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 40	# decrement sp to make space for locals/temps
	# _tmp0 = 15625
	  li $t2, 15625		# load constant value 15625 into $t2
	  sw $t2, -8($fp)	# spill _tmp0 from $t2 to $fp-8
	# _tmp1 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp1 from $t2 to $fp-12
	# _tmp2 = 10000
	  li $t2, 10000		# load constant value 10000 into $t2
	  sw $t2, -16($fp)	# spill _tmp2 from $t2 to $fp-16
	# _tmp3 = _tmp1 % _tmp2
	  lw $t0, -12($fp)	# fill _tmp1 to $t0 from $fp-12
	  lw $t1, -16($fp)	# fill _tmp2 to $t1 from $fp-16
	  rem $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp3 from $t2 to $fp-20
	# _tmp4 = _tmp0 * _tmp3
	  lw $t0, -8($fp)	# fill _tmp0 to $t0 from $fp-8
	  lw $t1, -20($fp)	# fill _tmp3 to $t1 from $fp-20
	  mul $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp4 from $t2 to $fp-24
	# _tmp5 = 22221
	  li $t2, 22221		# load constant value 22221 into $t2
	  sw $t2, -28($fp)	# spill _tmp5 from $t2 to $fp-28
	# _tmp6 = _tmp4 + _tmp5
	  lw $t0, -24($fp)	# fill _tmp4 to $t0 from $fp-24
	  lw $t1, -28($fp)	# fill _tmp5 to $t1 from $fp-28
	  add $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp6 from $t2 to $fp-32
	# _tmp7 = 65536
	  li $t2, 65536		# load constant value 65536 into $t2
	  sw $t2, -36($fp)	# spill _tmp7 from $t2 to $fp-36
	# _tmp8 = _tmp6 % _tmp7
	  lw $t0, -32($fp)	# fill _tmp6 to $t0 from $fp-32
	  lw $t1, -36($fp)	# fill _tmp7 to $t1 from $fp-36
	  rem $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp8 from $t2 to $fp-40
	# *(this + 4) = _tmp8
	  lw $t0, -40($fp)	# fill _tmp8 to $t0 from $fp-40
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp9 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp9 from $t2 to $fp-44
	# Return _tmp9
	  lw $t2, -44($fp)	# fill _tmp9 to $t2 from $fp-44
	  move $v0, $t2		# assign return value into $v0
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
  _Random.RndInt:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp10 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp10 from $t2 to $fp-8
	# _tmp11 = *(_tmp10 + 4)
	  lw $t0, -8($fp)	# fill _tmp10 to $t0 from $fp-8
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp11 from $t2 to $fp-12
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp12 = ACall _tmp11
	  lw $t0, -12($fp)	# fill _tmp11 to $t0 from $fp-12
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -16($fp)	# spill _tmp12 from $t2 to $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp13 = _tmp12 % max
	  lw $t0, -16($fp)	# fill _tmp12 to $t0 from $fp-16
	  lw $t1, 8($fp)	# fill max to $t1 from $fp+8
	  rem $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp13 from $t2 to $fp-20
	# Return _tmp13
	  lw $t2, -20($fp)	# fill _tmp13 to $t2 from $fp-20
	  move $v0, $t2		# assign return value into $v0
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
	# VTable for class Random
	  .data
	  .align 2
	  Random:		# label for class Random vtable
	  .word _Random.Init
	  .word _Random.GenRandom
	  .word _Random.RndInt
	  .text
  _Deck.Init:
	# BeginFunc 40
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 40	# decrement sp to make space for locals/temps
	# _tmp14 = 52
	  li $t2, 52		# load constant value 52 into $t2
	  sw $t2, -8($fp)	# spill _tmp14 from $t2 to $fp-8
	# _tmp15 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp15 from $t2 to $fp-12
	# _tmp16 = _tmp14 < _tmp15
	  lw $t0, -8($fp)	# fill _tmp14 to $t0 from $fp-8
	  lw $t1, -12($fp)	# fill _tmp15 to $t1 from $fp-12
	  slt $t2, $t0, $t1	
	  sw $t2, -16($fp)	# spill _tmp16 from $t2 to $fp-16
	# IfZ _tmp16 Goto _L0
	  lw $t0, -16($fp)	# fill _tmp16 to $t0 from $fp-16
	  beqz $t0, _L0	# branch if _tmp16 is zero 
	# _tmp17 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string1	# load label
	  sw $t2, -20($fp)	# spill _tmp17 from $t2 to $fp-20
	# PushParam _tmp17
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -20($fp)	# fill _tmp17 to $t0 from $fp-20
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L0:
	# _tmp18 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -24($fp)	# spill _tmp18 from $t2 to $fp-24
	# _tmp19 = _tmp18 + _tmp14
	  lw $t0, -24($fp)	# fill _tmp18 to $t0 from $fp-24
	  lw $t1, -8($fp)	# fill _tmp14 to $t1 from $fp-8
	  add $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp19 from $t2 to $fp-28
	# _tmp20 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -32($fp)	# spill _tmp20 from $t2 to $fp-32
	# _tmp21 = _tmp19 * _tmp20
	  lw $t0, -28($fp)	# fill _tmp19 to $t0 from $fp-28
	  lw $t1, -32($fp)	# fill _tmp20 to $t1 from $fp-32
	  mul $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp21 from $t2 to $fp-36
	# PushParam _tmp21
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -36($fp)	# fill _tmp21 to $t0 from $fp-36
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp22 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -40($fp)	# spill _tmp22 from $t2 to $fp-40
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp22) = _tmp14
	  lw $t0, -8($fp)	# fill _tmp14 to $t0 from $fp-8
	  lw $t2, -40($fp)	# fill _tmp22 to $t2 from $fp-40
	  sw $t0, 0($t2) 	# store with offset
	# _tmp23 = _tmp22 + _tmp20
	  lw $t0, -40($fp)	# fill _tmp22 to $t0 from $fp-40
	  lw $t1, -32($fp)	# fill _tmp20 to $t1 from $fp-32
	  add $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp23 from $t2 to $fp-44
	# *(this + 8) = _tmp23
	  lw $t0, -44($fp)	# fill _tmp23 to $t0 from $fp-44
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.Shuffle:
	# BeginFunc 336
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 336	# decrement sp to make space for locals/temps
	# _tmp24 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -8($fp)	# spill _tmp24 from $t2 to $fp-8
	# *(this + 4) = _tmp24
	  lw $t0, -8($fp)	# fill _tmp24 to $t0 from $fp-8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
  _L1:
	# _tmp25 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp25 from $t2 to $fp-12
	# _tmp26 = 52
	  li $t2, 52		# load constant value 52 into $t2
	  sw $t2, -16($fp)	# spill _tmp26 from $t2 to $fp-16
	# _tmp27 = _tmp25 < _tmp26
	  lw $t0, -12($fp)	# fill _tmp25 to $t0 from $fp-12
	  lw $t1, -16($fp)	# fill _tmp26 to $t1 from $fp-16
	  slt $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp27 from $t2 to $fp-20
	# IfZ _tmp27 Goto _L2
	  lw $t0, -20($fp)	# fill _tmp27 to $t0 from $fp-20
	  beqz $t0, _L2	# branch if _tmp27 is zero 
	# _tmp28 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp28 from $t2 to $fp-24
	# _tmp29 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp29 from $t2 to $fp-28
	# _tmp30 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp30 from $t2 to $fp-32
	# _tmp31 = _tmp29 < _tmp30
	  lw $t0, -28($fp)	# fill _tmp29 to $t0 from $fp-28
	  lw $t1, -32($fp)	# fill _tmp30 to $t1 from $fp-32
	  slt $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp31 from $t2 to $fp-36
	# _tmp32 = *(_tmp28 + -4)
	  lw $t0, -24($fp)	# fill _tmp28 to $t0 from $fp-24
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp32 from $t2 to $fp-40
	# _tmp33 = _tmp29 < _tmp32
	  lw $t0, -28($fp)	# fill _tmp29 to $t0 from $fp-28
	  lw $t1, -40($fp)	# fill _tmp32 to $t1 from $fp-40
	  slt $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp33 from $t2 to $fp-44
	# _tmp34 = _tmp33 == _tmp30
	  lw $t0, -44($fp)	# fill _tmp33 to $t0 from $fp-44
	  lw $t1, -32($fp)	# fill _tmp30 to $t1 from $fp-32
	  seq $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp34 from $t2 to $fp-48
	# _tmp35 = _tmp31 || _tmp34
	  lw $t0, -36($fp)	# fill _tmp31 to $t0 from $fp-36
	  lw $t1, -48($fp)	# fill _tmp34 to $t1 from $fp-48
	  or $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp35 from $t2 to $fp-52
	# IfZ _tmp35 Goto _L3
	  lw $t0, -52($fp)	# fill _tmp35 to $t0 from $fp-52
	  beqz $t0, _L3	# branch if _tmp35 is zero 
	# _tmp36 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string2	# load label
	  sw $t2, -56($fp)	# spill _tmp36 from $t2 to $fp-56
	# PushParam _tmp36
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp36 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L3:
	# _tmp37 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -60($fp)	# spill _tmp37 from $t2 to $fp-60
	# _tmp38 = _tmp37 * _tmp29
	  lw $t0, -60($fp)	# fill _tmp37 to $t0 from $fp-60
	  lw $t1, -28($fp)	# fill _tmp29 to $t1 from $fp-28
	  mul $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp38 from $t2 to $fp-64
	# _tmp39 = _tmp28 + _tmp38
	  lw $t0, -24($fp)	# fill _tmp28 to $t0 from $fp-24
	  lw $t1, -64($fp)	# fill _tmp38 to $t1 from $fp-64
	  add $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp39 from $t2 to $fp-68
	# _tmp40 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp40 from $t2 to $fp-72
	# _tmp41 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -76($fp)	# spill _tmp41 from $t2 to $fp-76
	# _tmp42 = _tmp40 + _tmp41
	  lw $t0, -72($fp)	# fill _tmp40 to $t0 from $fp-72
	  lw $t1, -76($fp)	# fill _tmp41 to $t1 from $fp-76
	  add $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp42 from $t2 to $fp-80
	# _tmp43 = 13
	  li $t2, 13		# load constant value 13 into $t2
	  sw $t2, -84($fp)	# spill _tmp43 from $t2 to $fp-84
	# _tmp44 = _tmp42 % _tmp43
	  lw $t0, -80($fp)	# fill _tmp42 to $t0 from $fp-80
	  lw $t1, -84($fp)	# fill _tmp43 to $t1 from $fp-84
	  rem $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp44 from $t2 to $fp-88
	# *(_tmp39) = _tmp44
	  lw $t0, -88($fp)	# fill _tmp44 to $t0 from $fp-88
	  lw $t2, -68($fp)	# fill _tmp39 to $t2 from $fp-68
	  sw $t0, 0($t2) 	# store with offset
	# _tmp45 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp45 from $t2 to $fp-92
	# _tmp46 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -96($fp)	# spill _tmp46 from $t2 to $fp-96
	# _tmp47 = _tmp45 + _tmp46
	  lw $t0, -92($fp)	# fill _tmp45 to $t0 from $fp-92
	  lw $t1, -96($fp)	# fill _tmp46 to $t1 from $fp-96
	  add $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp47 from $t2 to $fp-100
	# *(this + 4) = _tmp47
	  lw $t0, -100($fp)	# fill _tmp47 to $t0 from $fp-100
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# Goto _L1
	  b _L1		# unconditional branch
  _L2:
  _L4:
	# _tmp48 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp48 from $t2 to $fp-104
	# _tmp49 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -108($fp)	# spill _tmp49 from $t2 to $fp-108
	# _tmp50 = _tmp49 < _tmp48
	  lw $t0, -108($fp)	# fill _tmp49 to $t0 from $fp-108
	  lw $t1, -104($fp)	# fill _tmp48 to $t1 from $fp-104
	  slt $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp50 from $t2 to $fp-112
	# IfZ _tmp50 Goto _L5
	  lw $t0, -112($fp)	# fill _tmp50 to $t0 from $fp-112
	  beqz $t0, _L5	# branch if _tmp50 is zero 
	# _tmp51 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -124($fp)	# spill _tmp51 from $t2 to $fp-124
	# _tmp52 = *(gRnd)
	  lw $t0, 0($gp)	# fill gRnd to $t0 from $gp+0
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -128($fp)	# spill _tmp52 from $t2 to $fp-128
	# _tmp53 = *(_tmp52 + 8)
	  lw $t0, -128($fp)	# fill _tmp52 to $t0 from $fp-128
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -132($fp)	# spill _tmp53 from $t2 to $fp-132
	# PushParam _tmp51
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -124($fp)	# fill _tmp51 to $t0 from $fp-124
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 0($gp)	# fill gRnd to $t0 from $gp+0
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp54 = ACall _tmp53
	  lw $t0, -132($fp)	# fill _tmp53 to $t0 from $fp-132
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -136($fp)	# spill _tmp54 from $t2 to $fp-136
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# r = _tmp54
	  lw $t2, -136($fp)	# fill _tmp54 to $t2 from $fp-136
	  sw $t2, -116($fp)	# spill r from $t2 to $fp-116
	# _tmp55 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -140($fp)	# spill _tmp55 from $t2 to $fp-140
	# _tmp56 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -144($fp)	# spill _tmp56 from $t2 to $fp-144
	# _tmp57 = _tmp55 - _tmp56
	  lw $t0, -140($fp)	# fill _tmp55 to $t0 from $fp-140
	  lw $t1, -144($fp)	# fill _tmp56 to $t1 from $fp-144
	  sub $t2, $t0, $t1	
	  sw $t2, -148($fp)	# spill _tmp57 from $t2 to $fp-148
	# *(this + 4) = _tmp57
	  lw $t0, -148($fp)	# fill _tmp57 to $t0 from $fp-148
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp58 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -152($fp)	# spill _tmp58 from $t2 to $fp-152
	# _tmp59 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -156($fp)	# spill _tmp59 from $t2 to $fp-156
	# _tmp60 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -160($fp)	# spill _tmp60 from $t2 to $fp-160
	# _tmp61 = _tmp59 < _tmp60
	  lw $t0, -156($fp)	# fill _tmp59 to $t0 from $fp-156
	  lw $t1, -160($fp)	# fill _tmp60 to $t1 from $fp-160
	  slt $t2, $t0, $t1	
	  sw $t2, -164($fp)	# spill _tmp61 from $t2 to $fp-164
	# _tmp62 = *(_tmp58 + -4)
	  lw $t0, -152($fp)	# fill _tmp58 to $t0 from $fp-152
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -168($fp)	# spill _tmp62 from $t2 to $fp-168
	# _tmp63 = _tmp59 < _tmp62
	  lw $t0, -156($fp)	# fill _tmp59 to $t0 from $fp-156
	  lw $t1, -168($fp)	# fill _tmp62 to $t1 from $fp-168
	  slt $t2, $t0, $t1	
	  sw $t2, -172($fp)	# spill _tmp63 from $t2 to $fp-172
	# _tmp64 = _tmp63 == _tmp60
	  lw $t0, -172($fp)	# fill _tmp63 to $t0 from $fp-172
	  lw $t1, -160($fp)	# fill _tmp60 to $t1 from $fp-160
	  seq $t2, $t0, $t1	
	  sw $t2, -176($fp)	# spill _tmp64 from $t2 to $fp-176
	# _tmp65 = _tmp61 || _tmp64
	  lw $t0, -164($fp)	# fill _tmp61 to $t0 from $fp-164
	  lw $t1, -176($fp)	# fill _tmp64 to $t1 from $fp-176
	  or $t2, $t0, $t1	
	  sw $t2, -180($fp)	# spill _tmp65 from $t2 to $fp-180
	# IfZ _tmp65 Goto _L6
	  lw $t0, -180($fp)	# fill _tmp65 to $t0 from $fp-180
	  beqz $t0, _L6	# branch if _tmp65 is zero 
	# _tmp66 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string3	# load label
	  sw $t2, -184($fp)	# spill _tmp66 from $t2 to $fp-184
	# PushParam _tmp66
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -184($fp)	# fill _tmp66 to $t0 from $fp-184
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L6:
	# _tmp67 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -188($fp)	# spill _tmp67 from $t2 to $fp-188
	# _tmp68 = _tmp67 * _tmp59
	  lw $t0, -188($fp)	# fill _tmp67 to $t0 from $fp-188
	  lw $t1, -156($fp)	# fill _tmp59 to $t1 from $fp-156
	  mul $t2, $t0, $t1	
	  sw $t2, -192($fp)	# spill _tmp68 from $t2 to $fp-192
	# _tmp69 = _tmp58 + _tmp68
	  lw $t0, -152($fp)	# fill _tmp58 to $t0 from $fp-152
	  lw $t1, -192($fp)	# fill _tmp68 to $t1 from $fp-192
	  add $t2, $t0, $t1	
	  sw $t2, -196($fp)	# spill _tmp69 from $t2 to $fp-196
	# _tmp70 = *(_tmp69)
	  lw $t0, -196($fp)	# fill _tmp69 to $t0 from $fp-196
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -200($fp)	# spill _tmp70 from $t2 to $fp-200
	# temp = _tmp70
	  lw $t2, -200($fp)	# fill _tmp70 to $t2 from $fp-200
	  sw $t2, -120($fp)	# spill temp from $t2 to $fp-120
	# _tmp71 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -204($fp)	# spill _tmp71 from $t2 to $fp-204
	# _tmp72 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -208($fp)	# spill _tmp72 from $t2 to $fp-208
	# _tmp73 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -212($fp)	# spill _tmp73 from $t2 to $fp-212
	# _tmp74 = _tmp72 < _tmp73
	  lw $t0, -208($fp)	# fill _tmp72 to $t0 from $fp-208
	  lw $t1, -212($fp)	# fill _tmp73 to $t1 from $fp-212
	  slt $t2, $t0, $t1	
	  sw $t2, -216($fp)	# spill _tmp74 from $t2 to $fp-216
	# _tmp75 = *(_tmp71 + -4)
	  lw $t0, -204($fp)	# fill _tmp71 to $t0 from $fp-204
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -220($fp)	# spill _tmp75 from $t2 to $fp-220
	# _tmp76 = _tmp72 < _tmp75
	  lw $t0, -208($fp)	# fill _tmp72 to $t0 from $fp-208
	  lw $t1, -220($fp)	# fill _tmp75 to $t1 from $fp-220
	  slt $t2, $t0, $t1	
	  sw $t2, -224($fp)	# spill _tmp76 from $t2 to $fp-224
	# _tmp77 = _tmp76 == _tmp73
	  lw $t0, -224($fp)	# fill _tmp76 to $t0 from $fp-224
	  lw $t1, -212($fp)	# fill _tmp73 to $t1 from $fp-212
	  seq $t2, $t0, $t1	
	  sw $t2, -228($fp)	# spill _tmp77 from $t2 to $fp-228
	# _tmp78 = _tmp74 || _tmp77
	  lw $t0, -216($fp)	# fill _tmp74 to $t0 from $fp-216
	  lw $t1, -228($fp)	# fill _tmp77 to $t1 from $fp-228
	  or $t2, $t0, $t1	
	  sw $t2, -232($fp)	# spill _tmp78 from $t2 to $fp-232
	# IfZ _tmp78 Goto _L7
	  lw $t0, -232($fp)	# fill _tmp78 to $t0 from $fp-232
	  beqz $t0, _L7	# branch if _tmp78 is zero 
	# _tmp79 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string4	# load label
	  sw $t2, -236($fp)	# spill _tmp79 from $t2 to $fp-236
	# PushParam _tmp79
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -236($fp)	# fill _tmp79 to $t0 from $fp-236
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L7:
	# _tmp80 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -240($fp)	# spill _tmp80 from $t2 to $fp-240
	# _tmp81 = _tmp80 * _tmp72
	  lw $t0, -240($fp)	# fill _tmp80 to $t0 from $fp-240
	  lw $t1, -208($fp)	# fill _tmp72 to $t1 from $fp-208
	  mul $t2, $t0, $t1	
	  sw $t2, -244($fp)	# spill _tmp81 from $t2 to $fp-244
	# _tmp82 = _tmp71 + _tmp81
	  lw $t0, -204($fp)	# fill _tmp71 to $t0 from $fp-204
	  lw $t1, -244($fp)	# fill _tmp81 to $t1 from $fp-244
	  add $t2, $t0, $t1	
	  sw $t2, -248($fp)	# spill _tmp82 from $t2 to $fp-248
	# _tmp83 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -252($fp)	# spill _tmp83 from $t2 to $fp-252
	# _tmp84 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -256($fp)	# spill _tmp84 from $t2 to $fp-256
	# _tmp85 = r < _tmp84
	  lw $t0, -116($fp)	# fill r to $t0 from $fp-116
	  lw $t1, -256($fp)	# fill _tmp84 to $t1 from $fp-256
	  slt $t2, $t0, $t1	
	  sw $t2, -260($fp)	# spill _tmp85 from $t2 to $fp-260
	# _tmp86 = *(_tmp83 + -4)
	  lw $t0, -252($fp)	# fill _tmp83 to $t0 from $fp-252
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -264($fp)	# spill _tmp86 from $t2 to $fp-264
	# _tmp87 = r < _tmp86
	  lw $t0, -116($fp)	# fill r to $t0 from $fp-116
	  lw $t1, -264($fp)	# fill _tmp86 to $t1 from $fp-264
	  slt $t2, $t0, $t1	
	  sw $t2, -268($fp)	# spill _tmp87 from $t2 to $fp-268
	# _tmp88 = _tmp87 == _tmp84
	  lw $t0, -268($fp)	# fill _tmp87 to $t0 from $fp-268
	  lw $t1, -256($fp)	# fill _tmp84 to $t1 from $fp-256
	  seq $t2, $t0, $t1	
	  sw $t2, -272($fp)	# spill _tmp88 from $t2 to $fp-272
	# _tmp89 = _tmp85 || _tmp88
	  lw $t0, -260($fp)	# fill _tmp85 to $t0 from $fp-260
	  lw $t1, -272($fp)	# fill _tmp88 to $t1 from $fp-272
	  or $t2, $t0, $t1	
	  sw $t2, -276($fp)	# spill _tmp89 from $t2 to $fp-276
	# IfZ _tmp89 Goto _L8
	  lw $t0, -276($fp)	# fill _tmp89 to $t0 from $fp-276
	  beqz $t0, _L8	# branch if _tmp89 is zero 
	# _tmp90 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string5	# load label
	  sw $t2, -280($fp)	# spill _tmp90 from $t2 to $fp-280
	# PushParam _tmp90
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -280($fp)	# fill _tmp90 to $t0 from $fp-280
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L8:
	# _tmp91 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -284($fp)	# spill _tmp91 from $t2 to $fp-284
	# _tmp92 = _tmp91 * r
	  lw $t0, -284($fp)	# fill _tmp91 to $t0 from $fp-284
	  lw $t1, -116($fp)	# fill r to $t1 from $fp-116
	  mul $t2, $t0, $t1	
	  sw $t2, -288($fp)	# spill _tmp92 from $t2 to $fp-288
	# _tmp93 = _tmp83 + _tmp92
	  lw $t0, -252($fp)	# fill _tmp83 to $t0 from $fp-252
	  lw $t1, -288($fp)	# fill _tmp92 to $t1 from $fp-288
	  add $t2, $t0, $t1	
	  sw $t2, -292($fp)	# spill _tmp93 from $t2 to $fp-292
	# _tmp94 = *(_tmp93)
	  lw $t0, -292($fp)	# fill _tmp93 to $t0 from $fp-292
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -296($fp)	# spill _tmp94 from $t2 to $fp-296
	# *(_tmp82) = _tmp94
	  lw $t0, -296($fp)	# fill _tmp94 to $t0 from $fp-296
	  lw $t2, -248($fp)	# fill _tmp82 to $t2 from $fp-248
	  sw $t0, 0($t2) 	# store with offset
	# _tmp95 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -300($fp)	# spill _tmp95 from $t2 to $fp-300
	# _tmp96 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -304($fp)	# spill _tmp96 from $t2 to $fp-304
	# _tmp97 = r < _tmp96
	  lw $t0, -116($fp)	# fill r to $t0 from $fp-116
	  lw $t1, -304($fp)	# fill _tmp96 to $t1 from $fp-304
	  slt $t2, $t0, $t1	
	  sw $t2, -308($fp)	# spill _tmp97 from $t2 to $fp-308
	# _tmp98 = *(_tmp95 + -4)
	  lw $t0, -300($fp)	# fill _tmp95 to $t0 from $fp-300
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -312($fp)	# spill _tmp98 from $t2 to $fp-312
	# _tmp99 = r < _tmp98
	  lw $t0, -116($fp)	# fill r to $t0 from $fp-116
	  lw $t1, -312($fp)	# fill _tmp98 to $t1 from $fp-312
	  slt $t2, $t0, $t1	
	  sw $t2, -316($fp)	# spill _tmp99 from $t2 to $fp-316
	# _tmp100 = _tmp99 == _tmp96
	  lw $t0, -316($fp)	# fill _tmp99 to $t0 from $fp-316
	  lw $t1, -304($fp)	# fill _tmp96 to $t1 from $fp-304
	  seq $t2, $t0, $t1	
	  sw $t2, -320($fp)	# spill _tmp100 from $t2 to $fp-320
	# _tmp101 = _tmp97 || _tmp100
	  lw $t0, -308($fp)	# fill _tmp97 to $t0 from $fp-308
	  lw $t1, -320($fp)	# fill _tmp100 to $t1 from $fp-320
	  or $t2, $t0, $t1	
	  sw $t2, -324($fp)	# spill _tmp101 from $t2 to $fp-324
	# IfZ _tmp101 Goto _L9
	  lw $t0, -324($fp)	# fill _tmp101 to $t0 from $fp-324
	  beqz $t0, _L9	# branch if _tmp101 is zero 
	# _tmp102 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string6	# load label
	  sw $t2, -328($fp)	# spill _tmp102 from $t2 to $fp-328
	# PushParam _tmp102
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -328($fp)	# fill _tmp102 to $t0 from $fp-328
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L9:
	# _tmp103 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -332($fp)	# spill _tmp103 from $t2 to $fp-332
	# _tmp104 = _tmp103 * r
	  lw $t0, -332($fp)	# fill _tmp103 to $t0 from $fp-332
	  lw $t1, -116($fp)	# fill r to $t1 from $fp-116
	  mul $t2, $t0, $t1	
	  sw $t2, -336($fp)	# spill _tmp104 from $t2 to $fp-336
	# _tmp105 = _tmp95 + _tmp104
	  lw $t0, -300($fp)	# fill _tmp95 to $t0 from $fp-300
	  lw $t1, -336($fp)	# fill _tmp104 to $t1 from $fp-336
	  add $t2, $t0, $t1	
	  sw $t2, -340($fp)	# spill _tmp105 from $t2 to $fp-340
	# *(_tmp105) = temp
	  lw $t0, -120($fp)	# fill temp to $t0 from $fp-120
	  lw $t2, -340($fp)	# fill _tmp105 to $t2 from $fp-340
	  sw $t0, 0($t2) 	# store with offset
	# Goto _L4
	  b _L4		# unconditional branch
  _L5:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.GetCard:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	# _tmp106 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp106 from $t2 to $fp-12
	# _tmp107 = 52
	  li $t2, 52		# load constant value 52 into $t2
	  sw $t2, -16($fp)	# spill _tmp107 from $t2 to $fp-16
	# _tmp108 = _tmp107 < _tmp106
	  lw $t0, -16($fp)	# fill _tmp107 to $t0 from $fp-16
	  lw $t1, -12($fp)	# fill _tmp106 to $t1 from $fp-12
	  slt $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp108 from $t2 to $fp-20
	# _tmp109 = _tmp107 == _tmp106
	  lw $t0, -16($fp)	# fill _tmp107 to $t0 from $fp-16
	  lw $t1, -12($fp)	# fill _tmp106 to $t1 from $fp-12
	  seq $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp109 from $t2 to $fp-24
	# _tmp110 = _tmp108 || _tmp109
	  lw $t0, -20($fp)	# fill _tmp108 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp109 to $t1 from $fp-24
	  or $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp110 from $t2 to $fp-28
	# IfZ _tmp110 Goto _L10
	  lw $t0, -28($fp)	# fill _tmp110 to $t0 from $fp-28
	  beqz $t0, _L10	# branch if _tmp110 is zero 
	# _tmp111 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp111 from $t2 to $fp-32
	# Return _tmp111
	  lw $t2, -32($fp)	# fill _tmp111 to $t2 from $fp-32
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L10:
	# _tmp112 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp112 from $t2 to $fp-36
	# _tmp113 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp113 from $t2 to $fp-40
	# _tmp114 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -44($fp)	# spill _tmp114 from $t2 to $fp-44
	# _tmp115 = _tmp113 < _tmp114
	  lw $t0, -40($fp)	# fill _tmp113 to $t0 from $fp-40
	  lw $t1, -44($fp)	# fill _tmp114 to $t1 from $fp-44
	  slt $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp115 from $t2 to $fp-48
	# _tmp116 = *(_tmp112 + -4)
	  lw $t0, -36($fp)	# fill _tmp112 to $t0 from $fp-36
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -52($fp)	# spill _tmp116 from $t2 to $fp-52
	# _tmp117 = _tmp113 < _tmp116
	  lw $t0, -40($fp)	# fill _tmp113 to $t0 from $fp-40
	  lw $t1, -52($fp)	# fill _tmp116 to $t1 from $fp-52
	  slt $t2, $t0, $t1	
	  sw $t2, -56($fp)	# spill _tmp117 from $t2 to $fp-56
	# _tmp118 = _tmp117 == _tmp114
	  lw $t0, -56($fp)	# fill _tmp117 to $t0 from $fp-56
	  lw $t1, -44($fp)	# fill _tmp114 to $t1 from $fp-44
	  seq $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp118 from $t2 to $fp-60
	# _tmp119 = _tmp115 || _tmp118
	  lw $t0, -48($fp)	# fill _tmp115 to $t0 from $fp-48
	  lw $t1, -60($fp)	# fill _tmp118 to $t1 from $fp-60
	  or $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp119 from $t2 to $fp-64
	# IfZ _tmp119 Goto _L11
	  lw $t0, -64($fp)	# fill _tmp119 to $t0 from $fp-64
	  beqz $t0, _L11	# branch if _tmp119 is zero 
	# _tmp120 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string7	# load label
	  sw $t2, -68($fp)	# spill _tmp120 from $t2 to $fp-68
	# PushParam _tmp120
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -68($fp)	# fill _tmp120 to $t0 from $fp-68
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L11:
	# _tmp121 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -72($fp)	# spill _tmp121 from $t2 to $fp-72
	# _tmp122 = _tmp121 * _tmp113
	  lw $t0, -72($fp)	# fill _tmp121 to $t0 from $fp-72
	  lw $t1, -40($fp)	# fill _tmp113 to $t1 from $fp-40
	  mul $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp122 from $t2 to $fp-76
	# _tmp123 = _tmp112 + _tmp122
	  lw $t0, -36($fp)	# fill _tmp112 to $t0 from $fp-36
	  lw $t1, -76($fp)	# fill _tmp122 to $t1 from $fp-76
	  add $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp123 from $t2 to $fp-80
	# _tmp124 = *(_tmp123)
	  lw $t0, -80($fp)	# fill _tmp123 to $t0 from $fp-80
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp124 from $t2 to $fp-84
	# result = _tmp124
	  lw $t2, -84($fp)	# fill _tmp124 to $t2 from $fp-84
	  sw $t2, -8($fp)	# spill result from $t2 to $fp-8
	# _tmp125 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp125 from $t2 to $fp-88
	# _tmp126 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -92($fp)	# spill _tmp126 from $t2 to $fp-92
	# _tmp127 = _tmp125 + _tmp126
	  lw $t0, -88($fp)	# fill _tmp125 to $t0 from $fp-88
	  lw $t1, -92($fp)	# fill _tmp126 to $t1 from $fp-92
	  add $t2, $t0, $t1	
	  sw $t2, -96($fp)	# spill _tmp127 from $t2 to $fp-96
	# *(this + 4) = _tmp127
	  lw $t0, -96($fp)	# fill _tmp127 to $t0 from $fp-96
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# Return result
	  lw $t2, -8($fp)	# fill result to $t2 from $fp-8
	  move $v0, $t2		# assign return value into $v0
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
	# VTable for class Deck
	  .data
	  .align 2
	  Deck:		# label for class Deck vtable
	  .word _Deck.Init
	  .word _Deck.Shuffle
	  .word _Deck.GetCard
	  .text
  _BJDeck.Init:
	# BeginFunc 176
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 176	# decrement sp to make space for locals/temps
	# _tmp128 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -12($fp)	# spill _tmp128 from $t2 to $fp-12
	# _tmp129 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp129 from $t2 to $fp-16
	# _tmp130 = _tmp128 < _tmp129
	  lw $t0, -12($fp)	# fill _tmp128 to $t0 from $fp-12
	  lw $t1, -16($fp)	# fill _tmp129 to $t1 from $fp-16
	  slt $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp130 from $t2 to $fp-20
	# IfZ _tmp130 Goto _L12
	  lw $t0, -20($fp)	# fill _tmp130 to $t0 from $fp-20
	  beqz $t0, _L12	# branch if _tmp130 is zero 
	# _tmp131 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string8	# load label
	  sw $t2, -24($fp)	# spill _tmp131 from $t2 to $fp-24
	# PushParam _tmp131
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -24($fp)	# fill _tmp131 to $t0 from $fp-24
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L12:
	# _tmp132 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -28($fp)	# spill _tmp132 from $t2 to $fp-28
	# _tmp133 = _tmp132 + _tmp128
	  lw $t0, -28($fp)	# fill _tmp132 to $t0 from $fp-28
	  lw $t1, -12($fp)	# fill _tmp128 to $t1 from $fp-12
	  add $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp133 from $t2 to $fp-32
	# _tmp134 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -36($fp)	# spill _tmp134 from $t2 to $fp-36
	# _tmp135 = _tmp133 * _tmp134
	  lw $t0, -32($fp)	# fill _tmp133 to $t0 from $fp-32
	  lw $t1, -36($fp)	# fill _tmp134 to $t1 from $fp-36
	  mul $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp135 from $t2 to $fp-40
	# PushParam _tmp135
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -40($fp)	# fill _tmp135 to $t0 from $fp-40
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp136 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -44($fp)	# spill _tmp136 from $t2 to $fp-44
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp136) = _tmp128
	  lw $t0, -12($fp)	# fill _tmp128 to $t0 from $fp-12
	  lw $t2, -44($fp)	# fill _tmp136 to $t2 from $fp-44
	  sw $t0, 0($t2) 	# store with offset
	# _tmp137 = _tmp136 + _tmp134
	  lw $t0, -44($fp)	# fill _tmp136 to $t0 from $fp-44
	  lw $t1, -36($fp)	# fill _tmp134 to $t1 from $fp-36
	  add $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp137 from $t2 to $fp-48
	# *(this + 4) = _tmp137
	  lw $t0, -48($fp)	# fill _tmp137 to $t0 from $fp-48
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp138 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -52($fp)	# spill _tmp138 from $t2 to $fp-52
	# i = _tmp138
	  lw $t2, -52($fp)	# fill _tmp138 to $t2 from $fp-52
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L13:
	# _tmp139 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -56($fp)	# spill _tmp139 from $t2 to $fp-56
	# _tmp140 = i < _tmp139
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -56($fp)	# fill _tmp139 to $t1 from $fp-56
	  slt $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp140 from $t2 to $fp-60
	# IfZ _tmp140 Goto _L14
	  lw $t0, -60($fp)	# fill _tmp140 to $t0 from $fp-60
	  beqz $t0, _L14	# branch if _tmp140 is zero 
	# _tmp141 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp141 from $t2 to $fp-64
	# _tmp142 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -68($fp)	# spill _tmp142 from $t2 to $fp-68
	# _tmp143 = i < _tmp142
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -68($fp)	# fill _tmp142 to $t1 from $fp-68
	  slt $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp143 from $t2 to $fp-72
	# _tmp144 = *(_tmp141 + -4)
	  lw $t0, -64($fp)	# fill _tmp141 to $t0 from $fp-64
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp144 from $t2 to $fp-76
	# _tmp145 = i < _tmp144
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -76($fp)	# fill _tmp144 to $t1 from $fp-76
	  slt $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp145 from $t2 to $fp-80
	# _tmp146 = _tmp145 == _tmp142
	  lw $t0, -80($fp)	# fill _tmp145 to $t0 from $fp-80
	  lw $t1, -68($fp)	# fill _tmp142 to $t1 from $fp-68
	  seq $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp146 from $t2 to $fp-84
	# _tmp147 = _tmp143 || _tmp146
	  lw $t0, -72($fp)	# fill _tmp143 to $t0 from $fp-72
	  lw $t1, -84($fp)	# fill _tmp146 to $t1 from $fp-84
	  or $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp147 from $t2 to $fp-88
	# IfZ _tmp147 Goto _L15
	  lw $t0, -88($fp)	# fill _tmp147 to $t0 from $fp-88
	  beqz $t0, _L15	# branch if _tmp147 is zero 
	# _tmp148 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string9	# load label
	  sw $t2, -92($fp)	# spill _tmp148 from $t2 to $fp-92
	# PushParam _tmp148
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -92($fp)	# fill _tmp148 to $t0 from $fp-92
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L15:
	# _tmp149 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -96($fp)	# spill _tmp149 from $t2 to $fp-96
	# _tmp150 = _tmp149 * i
	  lw $t0, -96($fp)	# fill _tmp149 to $t0 from $fp-96
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp150 from $t2 to $fp-100
	# _tmp151 = _tmp141 + _tmp150
	  lw $t0, -64($fp)	# fill _tmp141 to $t0 from $fp-64
	  lw $t1, -100($fp)	# fill _tmp150 to $t1 from $fp-100
	  add $t2, $t0, $t1	
	  sw $t2, -104($fp)	# spill _tmp151 from $t2 to $fp-104
	# _tmp152 = 12
	  li $t2, 12		# load constant value 12 into $t2
	  sw $t2, -108($fp)	# spill _tmp152 from $t2 to $fp-108
	# PushParam _tmp152
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -108($fp)	# fill _tmp152 to $t0 from $fp-108
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp153 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -112($fp)	# spill _tmp153 from $t2 to $fp-112
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp154 = Deck
	  la $t2, Deck	# load label
	  sw $t2, -116($fp)	# spill _tmp154 from $t2 to $fp-116
	# *(_tmp153) = _tmp154
	  lw $t0, -116($fp)	# fill _tmp154 to $t0 from $fp-116
	  lw $t2, -112($fp)	# fill _tmp153 to $t2 from $fp-112
	  sw $t0, 0($t2) 	# store with offset
	# *(_tmp151) = _tmp153
	  lw $t0, -112($fp)	# fill _tmp153 to $t0 from $fp-112
	  lw $t2, -104($fp)	# fill _tmp151 to $t2 from $fp-104
	  sw $t0, 0($t2) 	# store with offset
	# _tmp155 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -120($fp)	# spill _tmp155 from $t2 to $fp-120
	# _tmp156 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -124($fp)	# spill _tmp156 from $t2 to $fp-124
	# _tmp157 = i < _tmp156
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -124($fp)	# fill _tmp156 to $t1 from $fp-124
	  slt $t2, $t0, $t1	
	  sw $t2, -128($fp)	# spill _tmp157 from $t2 to $fp-128
	# _tmp158 = *(_tmp155 + -4)
	  lw $t0, -120($fp)	# fill _tmp155 to $t0 from $fp-120
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -132($fp)	# spill _tmp158 from $t2 to $fp-132
	# _tmp159 = i < _tmp158
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -132($fp)	# fill _tmp158 to $t1 from $fp-132
	  slt $t2, $t0, $t1	
	  sw $t2, -136($fp)	# spill _tmp159 from $t2 to $fp-136
	# _tmp160 = _tmp159 == _tmp156
	  lw $t0, -136($fp)	# fill _tmp159 to $t0 from $fp-136
	  lw $t1, -124($fp)	# fill _tmp156 to $t1 from $fp-124
	  seq $t2, $t0, $t1	
	  sw $t2, -140($fp)	# spill _tmp160 from $t2 to $fp-140
	# _tmp161 = _tmp157 || _tmp160
	  lw $t0, -128($fp)	# fill _tmp157 to $t0 from $fp-128
	  lw $t1, -140($fp)	# fill _tmp160 to $t1 from $fp-140
	  or $t2, $t0, $t1	
	  sw $t2, -144($fp)	# spill _tmp161 from $t2 to $fp-144
	# IfZ _tmp161 Goto _L16
	  lw $t0, -144($fp)	# fill _tmp161 to $t0 from $fp-144
	  beqz $t0, _L16	# branch if _tmp161 is zero 
	# _tmp162 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string10	# load label
	  sw $t2, -148($fp)	# spill _tmp162 from $t2 to $fp-148
	# PushParam _tmp162
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -148($fp)	# fill _tmp162 to $t0 from $fp-148
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L16:
	# _tmp163 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -152($fp)	# spill _tmp163 from $t2 to $fp-152
	# _tmp164 = _tmp163 * i
	  lw $t0, -152($fp)	# fill _tmp163 to $t0 from $fp-152
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -156($fp)	# spill _tmp164 from $t2 to $fp-156
	# _tmp165 = _tmp155 + _tmp164
	  lw $t0, -120($fp)	# fill _tmp155 to $t0 from $fp-120
	  lw $t1, -156($fp)	# fill _tmp164 to $t1 from $fp-156
	  add $t2, $t0, $t1	
	  sw $t2, -160($fp)	# spill _tmp165 from $t2 to $fp-160
	# _tmp166 = *(_tmp165)
	  lw $t0, -160($fp)	# fill _tmp165 to $t0 from $fp-160
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -164($fp)	# spill _tmp166 from $t2 to $fp-164
	# _tmp167 = *(_tmp166)
	  lw $t0, -164($fp)	# fill _tmp166 to $t0 from $fp-164
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -168($fp)	# spill _tmp167 from $t2 to $fp-168
	# _tmp168 = *(_tmp167)
	  lw $t0, -168($fp)	# fill _tmp167 to $t0 from $fp-168
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -172($fp)	# spill _tmp168 from $t2 to $fp-172
	# PushParam _tmp166
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -164($fp)	# fill _tmp166 to $t0 from $fp-164
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp168
	  lw $t0, -172($fp)	# fill _tmp168 to $t0 from $fp-172
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp169 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -176($fp)	# spill _tmp169 from $t2 to $fp-176
	# _tmp170 = i + _tmp169
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -176($fp)	# fill _tmp169 to $t1 from $fp-176
	  add $t2, $t0, $t1	
	  sw $t2, -180($fp)	# spill _tmp170 from $t2 to $fp-180
	# i = _tmp170
	  lw $t2, -180($fp)	# fill _tmp170 to $t2 from $fp-180
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L13
	  b _L13		# unconditional branch
  _L14:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.DealCard:
	# BeginFunc 164
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 164	# decrement sp to make space for locals/temps
	# _tmp171 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp171 from $t2 to $fp-12
	# c = _tmp171
	  lw $t2, -12($fp)	# fill _tmp171 to $t2 from $fp-12
	  sw $t2, -8($fp)	# spill c from $t2 to $fp-8
	# _tmp172 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp172 from $t2 to $fp-16
	# _tmp173 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -20($fp)	# spill _tmp173 from $t2 to $fp-20
	# _tmp174 = 52
	  li $t2, 52		# load constant value 52 into $t2
	  sw $t2, -24($fp)	# spill _tmp174 from $t2 to $fp-24
	# _tmp175 = _tmp173 * _tmp174
	  lw $t0, -20($fp)	# fill _tmp173 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp174 to $t1 from $fp-24
	  mul $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp175 from $t2 to $fp-28
	# _tmp176 = _tmp175 < _tmp172
	  lw $t0, -28($fp)	# fill _tmp175 to $t0 from $fp-28
	  lw $t1, -16($fp)	# fill _tmp172 to $t1 from $fp-16
	  slt $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp176 from $t2 to $fp-32
	# _tmp177 = _tmp175 == _tmp172
	  lw $t0, -28($fp)	# fill _tmp175 to $t0 from $fp-28
	  lw $t1, -16($fp)	# fill _tmp172 to $t1 from $fp-16
	  seq $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp177 from $t2 to $fp-36
	# _tmp178 = _tmp176 || _tmp177
	  lw $t0, -32($fp)	# fill _tmp176 to $t0 from $fp-32
	  lw $t1, -36($fp)	# fill _tmp177 to $t1 from $fp-36
	  or $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp178 from $t2 to $fp-40
	# IfZ _tmp178 Goto _L17
	  lw $t0, -40($fp)	# fill _tmp178 to $t0 from $fp-40
	  beqz $t0, _L17	# branch if _tmp178 is zero 
	# _tmp179 = 11
	  li $t2, 11		# load constant value 11 into $t2
	  sw $t2, -44($fp)	# spill _tmp179 from $t2 to $fp-44
	# Return _tmp179
	  lw $t2, -44($fp)	# fill _tmp179 to $t2 from $fp-44
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L17:
  _L18:
	# _tmp180 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -48($fp)	# spill _tmp180 from $t2 to $fp-48
	# _tmp181 = c == _tmp180
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t1, -48($fp)	# fill _tmp180 to $t1 from $fp-48
	  seq $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp181 from $t2 to $fp-52
	# IfZ _tmp181 Goto _L19
	  lw $t0, -52($fp)	# fill _tmp181 to $t0 from $fp-52
	  beqz $t0, _L19	# branch if _tmp181 is zero 
	# _tmp182 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -60($fp)	# spill _tmp182 from $t2 to $fp-60
	# _tmp183 = *(gRnd)
	  lw $t0, 0($gp)	# fill gRnd to $t0 from $gp+0
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp183 from $t2 to $fp-64
	# _tmp184 = *(_tmp183 + 8)
	  lw $t0, -64($fp)	# fill _tmp183 to $t0 from $fp-64
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp184 from $t2 to $fp-68
	# PushParam _tmp182
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -60($fp)	# fill _tmp182 to $t0 from $fp-60
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 0($gp)	# fill gRnd to $t0 from $gp+0
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp185 = ACall _tmp184
	  lw $t0, -68($fp)	# fill _tmp184 to $t0 from $fp-68
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -72($fp)	# spill _tmp185 from $t2 to $fp-72
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# d = _tmp185
	  lw $t2, -72($fp)	# fill _tmp185 to $t2 from $fp-72
	  sw $t2, -56($fp)	# spill d from $t2 to $fp-56
	# _tmp186 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp186 from $t2 to $fp-76
	# _tmp187 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -80($fp)	# spill _tmp187 from $t2 to $fp-80
	# _tmp188 = d < _tmp187
	  lw $t0, -56($fp)	# fill d to $t0 from $fp-56
	  lw $t1, -80($fp)	# fill _tmp187 to $t1 from $fp-80
	  slt $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp188 from $t2 to $fp-84
	# _tmp189 = *(_tmp186 + -4)
	  lw $t0, -76($fp)	# fill _tmp186 to $t0 from $fp-76
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp189 from $t2 to $fp-88
	# _tmp190 = d < _tmp189
	  lw $t0, -56($fp)	# fill d to $t0 from $fp-56
	  lw $t1, -88($fp)	# fill _tmp189 to $t1 from $fp-88
	  slt $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp190 from $t2 to $fp-92
	# _tmp191 = _tmp190 == _tmp187
	  lw $t0, -92($fp)	# fill _tmp190 to $t0 from $fp-92
	  lw $t1, -80($fp)	# fill _tmp187 to $t1 from $fp-80
	  seq $t2, $t0, $t1	
	  sw $t2, -96($fp)	# spill _tmp191 from $t2 to $fp-96
	# _tmp192 = _tmp188 || _tmp191
	  lw $t0, -84($fp)	# fill _tmp188 to $t0 from $fp-84
	  lw $t1, -96($fp)	# fill _tmp191 to $t1 from $fp-96
	  or $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp192 from $t2 to $fp-100
	# IfZ _tmp192 Goto _L20
	  lw $t0, -100($fp)	# fill _tmp192 to $t0 from $fp-100
	  beqz $t0, _L20	# branch if _tmp192 is zero 
	# _tmp193 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string11	# load label
	  sw $t2, -104($fp)	# spill _tmp193 from $t2 to $fp-104
	# PushParam _tmp193
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -104($fp)	# fill _tmp193 to $t0 from $fp-104
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L20:
	# _tmp194 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -108($fp)	# spill _tmp194 from $t2 to $fp-108
	# _tmp195 = _tmp194 * d
	  lw $t0, -108($fp)	# fill _tmp194 to $t0 from $fp-108
	  lw $t1, -56($fp)	# fill d to $t1 from $fp-56
	  mul $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp195 from $t2 to $fp-112
	# _tmp196 = _tmp186 + _tmp195
	  lw $t0, -76($fp)	# fill _tmp186 to $t0 from $fp-76
	  lw $t1, -112($fp)	# fill _tmp195 to $t1 from $fp-112
	  add $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp196 from $t2 to $fp-116
	# _tmp197 = *(_tmp196)
	  lw $t0, -116($fp)	# fill _tmp196 to $t0 from $fp-116
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -120($fp)	# spill _tmp197 from $t2 to $fp-120
	# _tmp198 = *(_tmp197)
	  lw $t0, -120($fp)	# fill _tmp197 to $t0 from $fp-120
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -124($fp)	# spill _tmp198 from $t2 to $fp-124
	# _tmp199 = *(_tmp198 + 8)
	  lw $t0, -124($fp)	# fill _tmp198 to $t0 from $fp-124
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -128($fp)	# spill _tmp199 from $t2 to $fp-128
	# PushParam _tmp197
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -120($fp)	# fill _tmp197 to $t0 from $fp-120
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp200 = ACall _tmp199
	  lw $t0, -128($fp)	# fill _tmp199 to $t0 from $fp-128
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -132($fp)	# spill _tmp200 from $t2 to $fp-132
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# c = _tmp200
	  lw $t2, -132($fp)	# fill _tmp200 to $t2 from $fp-132
	  sw $t2, -8($fp)	# spill c from $t2 to $fp-8
	# Goto _L18
	  b _L18		# unconditional branch
  _L19:
	# _tmp201 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -136($fp)	# spill _tmp201 from $t2 to $fp-136
	# _tmp202 = _tmp201 < c
	  lw $t0, -136($fp)	# fill _tmp201 to $t0 from $fp-136
	  lw $t1, -8($fp)	# fill c to $t1 from $fp-8
	  slt $t2, $t0, $t1	
	  sw $t2, -140($fp)	# spill _tmp202 from $t2 to $fp-140
	# IfZ _tmp202 Goto _L21
	  lw $t0, -140($fp)	# fill _tmp202 to $t0 from $fp-140
	  beqz $t0, _L21	# branch if _tmp202 is zero 
	# _tmp203 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -144($fp)	# spill _tmp203 from $t2 to $fp-144
	# c = _tmp203
	  lw $t2, -144($fp)	# fill _tmp203 to $t2 from $fp-144
	  sw $t2, -8($fp)	# spill c from $t2 to $fp-8
	# Goto _L22
	  b _L22		# unconditional branch
  _L21:
	# _tmp204 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -148($fp)	# spill _tmp204 from $t2 to $fp-148
	# _tmp205 = c == _tmp204
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t1, -148($fp)	# fill _tmp204 to $t1 from $fp-148
	  seq $t2, $t0, $t1	
	  sw $t2, -152($fp)	# spill _tmp205 from $t2 to $fp-152
	# IfZ _tmp205 Goto _L23
	  lw $t0, -152($fp)	# fill _tmp205 to $t0 from $fp-152
	  beqz $t0, _L23	# branch if _tmp205 is zero 
	# _tmp206 = 11
	  li $t2, 11		# load constant value 11 into $t2
	  sw $t2, -156($fp)	# spill _tmp206 from $t2 to $fp-156
	# c = _tmp206
	  lw $t2, -156($fp)	# fill _tmp206 to $t2 from $fp-156
	  sw $t2, -8($fp)	# spill c from $t2 to $fp-8
  _L23:
  _L22:
	# _tmp207 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -160($fp)	# spill _tmp207 from $t2 to $fp-160
	# _tmp208 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -164($fp)	# spill _tmp208 from $t2 to $fp-164
	# _tmp209 = _tmp207 + _tmp208
	  lw $t0, -160($fp)	# fill _tmp207 to $t0 from $fp-160
	  lw $t1, -164($fp)	# fill _tmp208 to $t1 from $fp-164
	  add $t2, $t0, $t1	
	  sw $t2, -168($fp)	# spill _tmp209 from $t2 to $fp-168
	# *(this + 8) = _tmp209
	  lw $t0, -168($fp)	# fill _tmp209 to $t0 from $fp-168
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# Return c
	  lw $t2, -8($fp)	# fill c to $t2 from $fp-8
	  move $v0, $t2		# assign return value into $v0
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
  _BJDeck.Shuffle:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	# _tmp210 = "Shuffling..."
	  .data			# create string constant marked with label
	  _string12: .asciiz "Shuffling..."
	  .text
	  la $t2, _string12	# load label
	  sw $t2, -12($fp)	# spill _tmp210 from $t2 to $fp-12
	# PushParam _tmp210
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp210 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp211 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp211 from $t2 to $fp-16
	# i = _tmp211
	  lw $t2, -16($fp)	# fill _tmp211 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L24:
	# _tmp212 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -20($fp)	# spill _tmp212 from $t2 to $fp-20
	# _tmp213 = i < _tmp212
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -20($fp)	# fill _tmp212 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp213 from $t2 to $fp-24
	# IfZ _tmp213 Goto _L25
	  lw $t0, -24($fp)	# fill _tmp213 to $t0 from $fp-24
	  beqz $t0, _L25	# branch if _tmp213 is zero 
	# _tmp214 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp214 from $t2 to $fp-28
	# _tmp215 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp215 from $t2 to $fp-32
	# _tmp216 = i < _tmp215
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -32($fp)	# fill _tmp215 to $t1 from $fp-32
	  slt $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp216 from $t2 to $fp-36
	# _tmp217 = *(_tmp214 + -4)
	  lw $t0, -28($fp)	# fill _tmp214 to $t0 from $fp-28
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp217 from $t2 to $fp-40
	# _tmp218 = i < _tmp217
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -40($fp)	# fill _tmp217 to $t1 from $fp-40
	  slt $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp218 from $t2 to $fp-44
	# _tmp219 = _tmp218 == _tmp215
	  lw $t0, -44($fp)	# fill _tmp218 to $t0 from $fp-44
	  lw $t1, -32($fp)	# fill _tmp215 to $t1 from $fp-32
	  seq $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp219 from $t2 to $fp-48
	# _tmp220 = _tmp216 || _tmp219
	  lw $t0, -36($fp)	# fill _tmp216 to $t0 from $fp-36
	  lw $t1, -48($fp)	# fill _tmp219 to $t1 from $fp-48
	  or $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp220 from $t2 to $fp-52
	# IfZ _tmp220 Goto _L26
	  lw $t0, -52($fp)	# fill _tmp220 to $t0 from $fp-52
	  beqz $t0, _L26	# branch if _tmp220 is zero 
	# _tmp221 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string13: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string13	# load label
	  sw $t2, -56($fp)	# spill _tmp221 from $t2 to $fp-56
	# PushParam _tmp221
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp221 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L26:
	# _tmp222 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -60($fp)	# spill _tmp222 from $t2 to $fp-60
	# _tmp223 = _tmp222 * i
	  lw $t0, -60($fp)	# fill _tmp222 to $t0 from $fp-60
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp223 from $t2 to $fp-64
	# _tmp224 = _tmp214 + _tmp223
	  lw $t0, -28($fp)	# fill _tmp214 to $t0 from $fp-28
	  lw $t1, -64($fp)	# fill _tmp223 to $t1 from $fp-64
	  add $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp224 from $t2 to $fp-68
	# _tmp225 = *(_tmp224)
	  lw $t0, -68($fp)	# fill _tmp224 to $t0 from $fp-68
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp225 from $t2 to $fp-72
	# _tmp226 = *(_tmp225)
	  lw $t0, -72($fp)	# fill _tmp225 to $t0 from $fp-72
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp226 from $t2 to $fp-76
	# _tmp227 = *(_tmp226 + 4)
	  lw $t0, -76($fp)	# fill _tmp226 to $t0 from $fp-76
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp227 from $t2 to $fp-80
	# PushParam _tmp225
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -72($fp)	# fill _tmp225 to $t0 from $fp-72
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp227
	  lw $t0, -80($fp)	# fill _tmp227 to $t0 from $fp-80
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp228 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -84($fp)	# spill _tmp228 from $t2 to $fp-84
	# _tmp229 = i + _tmp228
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -84($fp)	# fill _tmp228 to $t1 from $fp-84
	  add $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp229 from $t2 to $fp-88
	# i = _tmp229
	  lw $t2, -88($fp)	# fill _tmp229 to $t2 from $fp-88
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L24
	  b _L24		# unconditional branch
  _L25:
	# _tmp230 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -92($fp)	# spill _tmp230 from $t2 to $fp-92
	# *(this + 8) = _tmp230
	  lw $t0, -92($fp)	# fill _tmp230 to $t0 from $fp-92
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# _tmp231 = "done.\n"
	  .data			# create string constant marked with label
	  _string14: .asciiz "done.\n"
	  .text
	  la $t2, _string14	# load label
	  sw $t2, -96($fp)	# spill _tmp231 from $t2 to $fp-96
	# PushParam _tmp231
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -96($fp)	# fill _tmp231 to $t0 from $fp-96
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
  _BJDeck.NumCardsRemaining:
	# BeginFunc 20
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 20	# decrement sp to make space for locals/temps
	# _tmp232 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -8($fp)	# spill _tmp232 from $t2 to $fp-8
	# _tmp233 = 52
	  li $t2, 52		# load constant value 52 into $t2
	  sw $t2, -12($fp)	# spill _tmp233 from $t2 to $fp-12
	# _tmp234 = _tmp232 * _tmp233
	  lw $t0, -8($fp)	# fill _tmp232 to $t0 from $fp-8
	  lw $t1, -12($fp)	# fill _tmp233 to $t1 from $fp-12
	  mul $t2, $t0, $t1	
	  sw $t2, -16($fp)	# spill _tmp234 from $t2 to $fp-16
	# _tmp235 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp235 from $t2 to $fp-20
	# _tmp236 = _tmp234 - _tmp235
	  lw $t0, -16($fp)	# fill _tmp234 to $t0 from $fp-16
	  lw $t1, -20($fp)	# fill _tmp235 to $t1 from $fp-20
	  sub $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp236 from $t2 to $fp-24
	# Return _tmp236
	  lw $t2, -24($fp)	# fill _tmp236 to $t2 from $fp-24
	  move $v0, $t2		# assign return value into $v0
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
	# VTable for class BJDeck
	  .data
	  .align 2
	  BJDeck:		# label for class BJDeck vtable
	  .word _BJDeck.Init
	  .word _BJDeck.DealCard
	  .word _BJDeck.Shuffle
	  .word _BJDeck.NumCardsRemaining
	  .text
  _Player.Init:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp237 = 1000
	  li $t2, 1000		# load constant value 1000 into $t2
	  sw $t2, -8($fp)	# spill _tmp237 from $t2 to $fp-8
	# *(this + 12) = _tmp237
	  lw $t0, -8($fp)	# fill _tmp237 to $t0 from $fp-8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 12($t2) 	# store with offset
	# _tmp238 = "What is the name of player #"
	  .data			# create string constant marked with label
	  _string15: .asciiz "What is the name of player #"
	  .text
	  la $t2, _string15	# load label
	  sw $t2, -12($fp)	# spill _tmp238 from $t2 to $fp-12
	# PushParam _tmp238
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp238 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam num
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill num to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp239 = "? "
	  .data			# create string constant marked with label
	  _string16: .asciiz "? "
	  .text
	  la $t2, _string16	# load label
	  sw $t2, -16($fp)	# spill _tmp239 from $t2 to $fp-16
	# PushParam _tmp239
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp239 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp240 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp240 from $t2 to $fp-20
	# *(this + 16) = _tmp240
	  lw $t0, -20($fp)	# fill _tmp240 to $t0 from $fp-20
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 16($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.Hit:
	# BeginFunc 120
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 120	# decrement sp to make space for locals/temps
	# _tmp241 = *(deck)
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp241 from $t2 to $fp-12
	# _tmp242 = *(_tmp241 + 4)
	  lw $t0, -12($fp)	# fill _tmp241 to $t0 from $fp-12
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp242 from $t2 to $fp-16
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp243 = ACall _tmp242
	  lw $t0, -16($fp)	# fill _tmp242 to $t0 from $fp-16
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp243 from $t2 to $fp-20
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# card = _tmp243
	  lw $t2, -20($fp)	# fill _tmp243 to $t2 from $fp-20
	  sw $t2, -8($fp)	# spill card from $t2 to $fp-8
	# _tmp244 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp244 from $t2 to $fp-24
	# PushParam _tmp244
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -24($fp)	# fill _tmp244 to $t0 from $fp-24
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp245 = " was dealt a "
	  .data			# create string constant marked with label
	  _string17: .asciiz " was dealt a "
	  .text
	  la $t2, _string17	# load label
	  sw $t2, -28($fp)	# spill _tmp245 from $t2 to $fp-28
	# PushParam _tmp245
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# fill _tmp245 to $t0 from $fp-28
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam card
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill card to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp246 = ".\n"
	  .data			# create string constant marked with label
	  _string18: .asciiz ".\n"
	  .text
	  la $t2, _string18	# load label
	  sw $t2, -32($fp)	# spill _tmp246 from $t2 to $fp-32
	# PushParam _tmp246
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -32($fp)	# fill _tmp246 to $t0 from $fp-32
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp247 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp247 from $t2 to $fp-36
	# _tmp248 = _tmp247 + card
	  lw $t0, -36($fp)	# fill _tmp247 to $t0 from $fp-36
	  lw $t1, -8($fp)	# fill card to $t1 from $fp-8
	  add $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp248 from $t2 to $fp-40
	# *(this + 24) = _tmp248
	  lw $t0, -40($fp)	# fill _tmp248 to $t0 from $fp-40
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 24($t2) 	# store with offset
	# _tmp249 = *(this + 20)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp249 from $t2 to $fp-44
	# _tmp250 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -48($fp)	# spill _tmp250 from $t2 to $fp-48
	# _tmp251 = _tmp249 + _tmp250
	  lw $t0, -44($fp)	# fill _tmp249 to $t0 from $fp-44
	  lw $t1, -48($fp)	# fill _tmp250 to $t1 from $fp-48
	  add $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp251 from $t2 to $fp-52
	# *(this + 20) = _tmp251
	  lw $t0, -52($fp)	# fill _tmp251 to $t0 from $fp-52
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 20($t2) 	# store with offset
	# _tmp252 = 11
	  li $t2, 11		# load constant value 11 into $t2
	  sw $t2, -56($fp)	# spill _tmp252 from $t2 to $fp-56
	# _tmp253 = card == _tmp252
	  lw $t0, -8($fp)	# fill card to $t0 from $fp-8
	  lw $t1, -56($fp)	# fill _tmp252 to $t1 from $fp-56
	  seq $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp253 from $t2 to $fp-60
	# IfZ _tmp253 Goto _L27
	  lw $t0, -60($fp)	# fill _tmp253 to $t0 from $fp-60
	  beqz $t0, _L27	# branch if _tmp253 is zero 
	# _tmp254 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp254 from $t2 to $fp-64
	# _tmp255 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -68($fp)	# spill _tmp255 from $t2 to $fp-68
	# _tmp256 = _tmp254 + _tmp255
	  lw $t0, -64($fp)	# fill _tmp254 to $t0 from $fp-64
	  lw $t1, -68($fp)	# fill _tmp255 to $t1 from $fp-68
	  add $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp256 from $t2 to $fp-72
	# *(this + 4) = _tmp256
	  lw $t0, -72($fp)	# fill _tmp256 to $t0 from $fp-72
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
  _L27:
  _L28:
	# _tmp257 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp257 from $t2 to $fp-76
	# _tmp258 = 21
	  li $t2, 21		# load constant value 21 into $t2
	  sw $t2, -80($fp)	# spill _tmp258 from $t2 to $fp-80
	# _tmp259 = _tmp258 < _tmp257
	  lw $t0, -80($fp)	# fill _tmp258 to $t0 from $fp-80
	  lw $t1, -76($fp)	# fill _tmp257 to $t1 from $fp-76
	  slt $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp259 from $t2 to $fp-84
	# _tmp260 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp260 from $t2 to $fp-88
	# _tmp261 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -92($fp)	# spill _tmp261 from $t2 to $fp-92
	# _tmp262 = _tmp261 < _tmp260
	  lw $t0, -92($fp)	# fill _tmp261 to $t0 from $fp-92
	  lw $t1, -88($fp)	# fill _tmp260 to $t1 from $fp-88
	  slt $t2, $t0, $t1	
	  sw $t2, -96($fp)	# spill _tmp262 from $t2 to $fp-96
	# _tmp263 = _tmp259 && _tmp262
	  lw $t0, -84($fp)	# fill _tmp259 to $t0 from $fp-84
	  lw $t1, -96($fp)	# fill _tmp262 to $t1 from $fp-96
	  and $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp263 from $t2 to $fp-100
	# IfZ _tmp263 Goto _L29
	  lw $t0, -100($fp)	# fill _tmp263 to $t0 from $fp-100
	  beqz $t0, _L29	# branch if _tmp263 is zero 
	# _tmp264 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp264 from $t2 to $fp-104
	# _tmp265 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -108($fp)	# spill _tmp265 from $t2 to $fp-108
	# _tmp266 = _tmp264 - _tmp265
	  lw $t0, -104($fp)	# fill _tmp264 to $t0 from $fp-104
	  lw $t1, -108($fp)	# fill _tmp265 to $t1 from $fp-108
	  sub $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp266 from $t2 to $fp-112
	# *(this + 24) = _tmp266
	  lw $t0, -112($fp)	# fill _tmp266 to $t0 from $fp-112
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 24($t2) 	# store with offset
	# _tmp267 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -116($fp)	# spill _tmp267 from $t2 to $fp-116
	# _tmp268 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -120($fp)	# spill _tmp268 from $t2 to $fp-120
	# _tmp269 = _tmp267 - _tmp268
	  lw $t0, -116($fp)	# fill _tmp267 to $t0 from $fp-116
	  lw $t1, -120($fp)	# fill _tmp268 to $t1 from $fp-120
	  sub $t2, $t0, $t1	
	  sw $t2, -124($fp)	# spill _tmp269 from $t2 to $fp-124
	# *(this + 4) = _tmp269
	  lw $t0, -124($fp)	# fill _tmp269 to $t0 from $fp-124
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# Goto _L28
	  b _L28		# unconditional branch
  _L29:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.DoubleDown:
	# BeginFunc 104
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 104	# decrement sp to make space for locals/temps
	# _tmp270 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp270 from $t2 to $fp-12
	# _tmp271 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -16($fp)	# spill _tmp271 from $t2 to $fp-16
	# _tmp272 = _tmp270 == _tmp271
	  lw $t0, -12($fp)	# fill _tmp270 to $t0 from $fp-12
	  lw $t1, -16($fp)	# fill _tmp271 to $t1 from $fp-16
	  seq $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp272 from $t2 to $fp-20
	# _tmp273 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -24($fp)	# spill _tmp273 from $t2 to $fp-24
	# _tmp274 = _tmp272 == _tmp273
	  lw $t0, -20($fp)	# fill _tmp272 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp273 to $t1 from $fp-24
	  seq $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp274 from $t2 to $fp-28
	# _tmp275 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp275 from $t2 to $fp-32
	# _tmp276 = 11
	  li $t2, 11		# load constant value 11 into $t2
	  sw $t2, -36($fp)	# spill _tmp276 from $t2 to $fp-36
	# _tmp277 = _tmp275 == _tmp276
	  lw $t0, -32($fp)	# fill _tmp275 to $t0 from $fp-32
	  lw $t1, -36($fp)	# fill _tmp276 to $t1 from $fp-36
	  seq $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp277 from $t2 to $fp-40
	# _tmp278 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -44($fp)	# spill _tmp278 from $t2 to $fp-44
	# _tmp279 = _tmp277 == _tmp278
	  lw $t0, -40($fp)	# fill _tmp277 to $t0 from $fp-40
	  lw $t1, -44($fp)	# fill _tmp278 to $t1 from $fp-44
	  seq $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp279 from $t2 to $fp-48
	# _tmp280 = _tmp274 && _tmp279
	  lw $t0, -28($fp)	# fill _tmp274 to $t0 from $fp-28
	  lw $t1, -48($fp)	# fill _tmp279 to $t1 from $fp-48
	  and $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp280 from $t2 to $fp-52
	# IfZ _tmp280 Goto _L30
	  lw $t0, -52($fp)	# fill _tmp280 to $t0 from $fp-52
	  beqz $t0, _L30	# branch if _tmp280 is zero 
	# _tmp281 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp281 from $t2 to $fp-56
	# Return _tmp281
	  lw $t2, -56($fp)	# fill _tmp281 to $t2 from $fp-56
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L30:
	# _tmp282 = "Would you like to double down?"
	  .data			# create string constant marked with label
	  _string19: .asciiz "Would you like to double down?"
	  .text
	  la $t2, _string19	# load label
	  sw $t2, -60($fp)	# spill _tmp282 from $t2 to $fp-60
	# PushParam _tmp282
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -60($fp)	# fill _tmp282 to $t0 from $fp-60
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp283 = LCall _GetYesOrNo
	  jal _GetYesOrNo    	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -64($fp)	# spill _tmp283 from $t2 to $fp-64
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp283 Goto _L31
	  lw $t0, -64($fp)	# fill _tmp283 to $t0 from $fp-64
	  beqz $t0, _L31	# branch if _tmp283 is zero 
	# _tmp284 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp284 from $t2 to $fp-68
	# _tmp285 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -72($fp)	# spill _tmp285 from $t2 to $fp-72
	# _tmp286 = _tmp284 * _tmp285
	  lw $t0, -68($fp)	# fill _tmp284 to $t0 from $fp-68
	  lw $t1, -72($fp)	# fill _tmp285 to $t1 from $fp-72
	  mul $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp286 from $t2 to $fp-76
	# *(this + 8) = _tmp286
	  lw $t0, -76($fp)	# fill _tmp286 to $t0 from $fp-76
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# _tmp287 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp287 from $t2 to $fp-80
	# _tmp288 = *(_tmp287 + 4)
	  lw $t0, -80($fp)	# fill _tmp287 to $t0 from $fp-80
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp288 from $t2 to $fp-84
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp288
	  lw $t0, -84($fp)	# fill _tmp288 to $t0 from $fp-84
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp289 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp289 from $t2 to $fp-88
	# PushParam _tmp289
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -88($fp)	# fill _tmp289 to $t0 from $fp-88
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp290 = ", your total is "
	  .data			# create string constant marked with label
	  _string20: .asciiz ", your total is "
	  .text
	  la $t2, _string20	# load label
	  sw $t2, -92($fp)	# spill _tmp290 from $t2 to $fp-92
	# PushParam _tmp290
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -92($fp)	# fill _tmp290 to $t0 from $fp-92
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp291 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp291 from $t2 to $fp-96
	# PushParam _tmp291
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -96($fp)	# fill _tmp291 to $t0 from $fp-96
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp292 = ".\n"
	  .data			# create string constant marked with label
	  _string21: .asciiz ".\n"
	  .text
	  la $t2, _string21	# load label
	  sw $t2, -100($fp)	# spill _tmp292 from $t2 to $fp-100
	# PushParam _tmp292
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -100($fp)	# fill _tmp292 to $t0 from $fp-100
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp293 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -104($fp)	# spill _tmp293 from $t2 to $fp-104
	# Return _tmp293
	  lw $t2, -104($fp)	# fill _tmp293 to $t2 from $fp-104
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L31:
	# _tmp294 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -108($fp)	# spill _tmp294 from $t2 to $fp-108
	# Return _tmp294
	  lw $t2, -108($fp)	# fill _tmp294 to $t2 from $fp-108
	  move $v0, $t2		# assign return value into $v0
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
  _Player.TakeTurn:
	# BeginFunc 168
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 168	# decrement sp to make space for locals/temps
	# _tmp295 = "\n"
	  .data			# create string constant marked with label
	  _string22: .asciiz "\n"
	  .text
	  la $t2, _string22	# load label
	  sw $t2, -12($fp)	# spill _tmp295 from $t2 to $fp-12
	# PushParam _tmp295
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp295 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp296 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp296 from $t2 to $fp-16
	# PushParam _tmp296
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp296 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp297 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string23: .asciiz "'s turn.\n"
	  .text
	  la $t2, _string23	# load label
	  sw $t2, -20($fp)	# spill _tmp297 from $t2 to $fp-20
	# PushParam _tmp297
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -20($fp)	# fill _tmp297 to $t0 from $fp-20
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp298 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -24($fp)	# spill _tmp298 from $t2 to $fp-24
	# *(this + 24) = _tmp298
	  lw $t0, -24($fp)	# fill _tmp298 to $t0 from $fp-24
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 24($t2) 	# store with offset
	# _tmp299 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -28($fp)	# spill _tmp299 from $t2 to $fp-28
	# *(this + 4) = _tmp299
	  lw $t0, -28($fp)	# fill _tmp299 to $t0 from $fp-28
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp300 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp300 from $t2 to $fp-32
	# *(this + 20) = _tmp300
	  lw $t0, -32($fp)	# fill _tmp300 to $t0 from $fp-32
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 20($t2) 	# store with offset
	# _tmp301 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp301 from $t2 to $fp-36
	# _tmp302 = *(_tmp301 + 4)
	  lw $t0, -36($fp)	# fill _tmp301 to $t0 from $fp-36
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp302 from $t2 to $fp-40
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp302
	  lw $t0, -40($fp)	# fill _tmp302 to $t0 from $fp-40
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp303 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp303 from $t2 to $fp-44
	# _tmp304 = *(_tmp303 + 4)
	  lw $t0, -44($fp)	# fill _tmp303 to $t0 from $fp-44
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp304 from $t2 to $fp-48
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp304
	  lw $t0, -48($fp)	# fill _tmp304 to $t0 from $fp-48
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp305 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -52($fp)	# spill _tmp305 from $t2 to $fp-52
	# _tmp306 = *(_tmp305 + 8)
	  lw $t0, -52($fp)	# fill _tmp305 to $t0 from $fp-52
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -56($fp)	# spill _tmp306 from $t2 to $fp-56
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp307 = ACall _tmp306
	  lw $t0, -56($fp)	# fill _tmp306 to $t0 from $fp-56
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -60($fp)	# spill _tmp307 from $t2 to $fp-60
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp308 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -64($fp)	# spill _tmp308 from $t2 to $fp-64
	# _tmp309 = _tmp307 == _tmp308
	  lw $t0, -60($fp)	# fill _tmp307 to $t0 from $fp-60
	  lw $t1, -64($fp)	# fill _tmp308 to $t1 from $fp-64
	  seq $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp309 from $t2 to $fp-68
	# IfZ _tmp309 Goto _L32
	  lw $t0, -68($fp)	# fill _tmp309 to $t0 from $fp-68
	  beqz $t0, _L32	# branch if _tmp309 is zero 
	# _tmp310 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -72($fp)	# spill _tmp310 from $t2 to $fp-72
	# stillGoing = _tmp310
	  lw $t2, -72($fp)	# fill _tmp310 to $t2 from $fp-72
	  sw $t2, -8($fp)	# spill stillGoing from $t2 to $fp-8
  _L33:
	# _tmp311 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp311 from $t2 to $fp-76
	# _tmp312 = 21
	  li $t2, 21		# load constant value 21 into $t2
	  sw $t2, -80($fp)	# spill _tmp312 from $t2 to $fp-80
	# _tmp313 = _tmp311 < _tmp312
	  lw $t0, -76($fp)	# fill _tmp311 to $t0 from $fp-76
	  lw $t1, -80($fp)	# fill _tmp312 to $t1 from $fp-80
	  slt $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp313 from $t2 to $fp-84
	# _tmp314 = _tmp311 == _tmp312
	  lw $t0, -76($fp)	# fill _tmp311 to $t0 from $fp-76
	  lw $t1, -80($fp)	# fill _tmp312 to $t1 from $fp-80
	  seq $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp314 from $t2 to $fp-88
	# _tmp315 = _tmp313 || _tmp314
	  lw $t0, -84($fp)	# fill _tmp313 to $t0 from $fp-84
	  lw $t1, -88($fp)	# fill _tmp314 to $t1 from $fp-88
	  or $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp315 from $t2 to $fp-92
	# _tmp316 = _tmp315 && stillGoing
	  lw $t0, -92($fp)	# fill _tmp315 to $t0 from $fp-92
	  lw $t1, -8($fp)	# fill stillGoing to $t1 from $fp-8
	  and $t2, $t0, $t1	
	  sw $t2, -96($fp)	# spill _tmp316 from $t2 to $fp-96
	# IfZ _tmp316 Goto _L34
	  lw $t0, -96($fp)	# fill _tmp316 to $t0 from $fp-96
	  beqz $t0, _L34	# branch if _tmp316 is zero 
	# _tmp317 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -100($fp)	# spill _tmp317 from $t2 to $fp-100
	# PushParam _tmp317
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -100($fp)	# fill _tmp317 to $t0 from $fp-100
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp318 = ", your total is "
	  .data			# create string constant marked with label
	  _string24: .asciiz ", your total is "
	  .text
	  la $t2, _string24	# load label
	  sw $t2, -104($fp)	# spill _tmp318 from $t2 to $fp-104
	# PushParam _tmp318
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -104($fp)	# fill _tmp318 to $t0 from $fp-104
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp319 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -108($fp)	# spill _tmp319 from $t2 to $fp-108
	# PushParam _tmp319
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -108($fp)	# fill _tmp319 to $t0 from $fp-108
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp320 = ".\n"
	  .data			# create string constant marked with label
	  _string25: .asciiz ".\n"
	  .text
	  la $t2, _string25	# load label
	  sw $t2, -112($fp)	# spill _tmp320 from $t2 to $fp-112
	# PushParam _tmp320
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -112($fp)	# fill _tmp320 to $t0 from $fp-112
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp321 = "Would you like a hit?"
	  .data			# create string constant marked with label
	  _string26: .asciiz "Would you like a hit?"
	  .text
	  la $t2, _string26	# load label
	  sw $t2, -116($fp)	# spill _tmp321 from $t2 to $fp-116
	# PushParam _tmp321
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -116($fp)	# fill _tmp321 to $t0 from $fp-116
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp322 = LCall _GetYesOrNo
	  jal _GetYesOrNo    	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -120($fp)	# spill _tmp322 from $t2 to $fp-120
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# stillGoing = _tmp322
	  lw $t2, -120($fp)	# fill _tmp322 to $t2 from $fp-120
	  sw $t2, -8($fp)	# spill stillGoing from $t2 to $fp-8
	# IfZ stillGoing Goto _L35
	  lw $t0, -8($fp)	# fill stillGoing to $t0 from $fp-8
	  beqz $t0, _L35	# branch if stillGoing is zero 
	# _tmp323 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -124($fp)	# spill _tmp323 from $t2 to $fp-124
	# _tmp324 = *(_tmp323 + 4)
	  lw $t0, -124($fp)	# fill _tmp323 to $t0 from $fp-124
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -128($fp)	# spill _tmp324 from $t2 to $fp-128
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp324
	  lw $t0, -128($fp)	# fill _tmp324 to $t0 from $fp-128
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L35:
	# Goto _L33
	  b _L33		# unconditional branch
  _L34:
  _L32:
	# _tmp325 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -132($fp)	# spill _tmp325 from $t2 to $fp-132
	# _tmp326 = 21
	  li $t2, 21		# load constant value 21 into $t2
	  sw $t2, -136($fp)	# spill _tmp326 from $t2 to $fp-136
	# _tmp327 = _tmp326 < _tmp325
	  lw $t0, -136($fp)	# fill _tmp326 to $t0 from $fp-136
	  lw $t1, -132($fp)	# fill _tmp325 to $t1 from $fp-132
	  slt $t2, $t0, $t1	
	  sw $t2, -140($fp)	# spill _tmp327 from $t2 to $fp-140
	# IfZ _tmp327 Goto _L36
	  lw $t0, -140($fp)	# fill _tmp327 to $t0 from $fp-140
	  beqz $t0, _L36	# branch if _tmp327 is zero 
	# _tmp328 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -144($fp)	# spill _tmp328 from $t2 to $fp-144
	# PushParam _tmp328
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -144($fp)	# fill _tmp328 to $t0 from $fp-144
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp329 = " busts with the big "
	  .data			# create string constant marked with label
	  _string27: .asciiz " busts with the big "
	  .text
	  la $t2, _string27	# load label
	  sw $t2, -148($fp)	# spill _tmp329 from $t2 to $fp-148
	# PushParam _tmp329
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -148($fp)	# fill _tmp329 to $t0 from $fp-148
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp330 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -152($fp)	# spill _tmp330 from $t2 to $fp-152
	# PushParam _tmp330
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -152($fp)	# fill _tmp330 to $t0 from $fp-152
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp331 = "!\n"
	  .data			# create string constant marked with label
	  _string28: .asciiz "!\n"
	  .text
	  la $t2, _string28	# load label
	  sw $t2, -156($fp)	# spill _tmp331 from $t2 to $fp-156
	# PushParam _tmp331
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -156($fp)	# fill _tmp331 to $t0 from $fp-156
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L37
	  b _L37		# unconditional branch
  _L36:
	# _tmp332 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -160($fp)	# spill _tmp332 from $t2 to $fp-160
	# PushParam _tmp332
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -160($fp)	# fill _tmp332 to $t0 from $fp-160
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp333 = " stays at "
	  .data			# create string constant marked with label
	  _string29: .asciiz " stays at "
	  .text
	  la $t2, _string29	# load label
	  sw $t2, -164($fp)	# spill _tmp333 from $t2 to $fp-164
	# PushParam _tmp333
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -164($fp)	# fill _tmp333 to $t0 from $fp-164
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp334 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -168($fp)	# spill _tmp334 from $t2 to $fp-168
	# PushParam _tmp334
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -168($fp)	# fill _tmp334 to $t0 from $fp-168
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp335 = ".\n"
	  .data			# create string constant marked with label
	  _string30: .asciiz ".\n"
	  .text
	  la $t2, _string30	# load label
	  sw $t2, -172($fp)	# spill _tmp335 from $t2 to $fp-172
	# PushParam _tmp335
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -172($fp)	# fill _tmp335 to $t0 from $fp-172
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L37:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.HasMoney:
	# BeginFunc 12
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 12	# decrement sp to make space for locals/temps
	# _tmp336 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp336 from $t2 to $fp-8
	# _tmp337 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp337 from $t2 to $fp-12
	# _tmp338 = _tmp337 < _tmp336
	  lw $t0, -12($fp)	# fill _tmp337 to $t0 from $fp-12
	  lw $t1, -8($fp)	# fill _tmp336 to $t1 from $fp-8
	  slt $t2, $t0, $t1	
	  sw $t2, -16($fp)	# spill _tmp338 from $t2 to $fp-16
	# Return _tmp338
	  lw $t2, -16($fp)	# fill _tmp338 to $t2 from $fp-16
	  move $v0, $t2		# assign return value into $v0
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
  _Player.PrintMoney:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp339 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp339 from $t2 to $fp-8
	# PushParam _tmp339
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill _tmp339 to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp340 = ", you have $"
	  .data			# create string constant marked with label
	  _string31: .asciiz ", you have $"
	  .text
	  la $t2, _string31	# load label
	  sw $t2, -12($fp)	# spill _tmp340 from $t2 to $fp-12
	# PushParam _tmp340
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp340 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp341 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp341 from $t2 to $fp-16
	# PushParam _tmp341
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp341 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp342 = ".\n"
	  .data			# create string constant marked with label
	  _string32: .asciiz ".\n"
	  .text
	  la $t2, _string32	# load label
	  sw $t2, -20($fp)	# spill _tmp342 from $t2 to $fp-20
	# PushParam _tmp342
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -20($fp)	# fill _tmp342 to $t0 from $fp-20
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
  _Player.PlaceBet:
	# BeginFunc 56
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 56	# decrement sp to make space for locals/temps
	# _tmp343 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -8($fp)	# spill _tmp343 from $t2 to $fp-8
	# *(this + 8) = _tmp343
	  lw $t0, -8($fp)	# fill _tmp343 to $t0 from $fp-8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# _tmp344 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp344 from $t2 to $fp-12
	# _tmp345 = *(_tmp344 + 20)
	  lw $t0, -12($fp)	# fill _tmp344 to $t0 from $fp-12
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp345 from $t2 to $fp-16
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp345
	  lw $t0, -16($fp)	# fill _tmp345 to $t0 from $fp-16
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L38:
	# _tmp346 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp346 from $t2 to $fp-20
	# _tmp347 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -24($fp)	# spill _tmp347 from $t2 to $fp-24
	# _tmp348 = _tmp346 < _tmp347
	  lw $t0, -20($fp)	# fill _tmp346 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp347 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp348 from $t2 to $fp-28
	# _tmp349 = _tmp346 == _tmp347
	  lw $t0, -20($fp)	# fill _tmp346 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp347 to $t1 from $fp-24
	  seq $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp349 from $t2 to $fp-32
	# _tmp350 = _tmp348 || _tmp349
	  lw $t0, -28($fp)	# fill _tmp348 to $t0 from $fp-28
	  lw $t1, -32($fp)	# fill _tmp349 to $t1 from $fp-32
	  or $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp350 from $t2 to $fp-36
	# _tmp351 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp351 from $t2 to $fp-40
	# _tmp352 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp352 from $t2 to $fp-44
	# _tmp353 = _tmp352 < _tmp351
	  lw $t0, -44($fp)	# fill _tmp352 to $t0 from $fp-44
	  lw $t1, -40($fp)	# fill _tmp351 to $t1 from $fp-40
	  slt $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp353 from $t2 to $fp-48
	# _tmp354 = _tmp350 || _tmp353
	  lw $t0, -36($fp)	# fill _tmp350 to $t0 from $fp-36
	  lw $t1, -48($fp)	# fill _tmp353 to $t1 from $fp-48
	  or $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp354 from $t2 to $fp-52
	# IfZ _tmp354 Goto _L39
	  lw $t0, -52($fp)	# fill _tmp354 to $t0 from $fp-52
	  beqz $t0, _L39	# branch if _tmp354 is zero 
	# _tmp355 = "How much would you like to bet? "
	  .data			# create string constant marked with label
	  _string33: .asciiz "How much would you like to bet? "
	  .text
	  la $t2, _string33	# load label
	  sw $t2, -56($fp)	# spill _tmp355 from $t2 to $fp-56
	# PushParam _tmp355
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp355 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp356 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -60($fp)	# spill _tmp356 from $t2 to $fp-60
	# *(this + 8) = _tmp356
	  lw $t0, -60($fp)	# fill _tmp356 to $t0 from $fp-60
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# Goto _L38
	  b _L38		# unconditional branch
  _L39:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.GetTotal:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp357 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp357 from $t2 to $fp-8
	# Return _tmp357
	  lw $t2, -8($fp)	# fill _tmp357 to $t2 from $fp-8
	  move $v0, $t2		# assign return value into $v0
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
  _Player.Resolve:
	# BeginFunc 200
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 200	# decrement sp to make space for locals/temps
	# _tmp358 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp358 from $t2 to $fp-16
	# win = _tmp358
	  lw $t2, -16($fp)	# fill _tmp358 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill win from $t2 to $fp-8
	# _tmp359 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -20($fp)	# spill _tmp359 from $t2 to $fp-20
	# lose = _tmp359
	  lw $t2, -20($fp)	# fill _tmp359 to $t2 from $fp-20
	  sw $t2, -12($fp)	# spill lose from $t2 to $fp-12
	# _tmp360 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp360 from $t2 to $fp-24
	# _tmp361 = 21
	  li $t2, 21		# load constant value 21 into $t2
	  sw $t2, -28($fp)	# spill _tmp361 from $t2 to $fp-28
	# _tmp362 = _tmp360 == _tmp361
	  lw $t0, -24($fp)	# fill _tmp360 to $t0 from $fp-24
	  lw $t1, -28($fp)	# fill _tmp361 to $t1 from $fp-28
	  seq $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp362 from $t2 to $fp-32
	# _tmp363 = *(this + 20)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp363 from $t2 to $fp-36
	# _tmp364 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -40($fp)	# spill _tmp364 from $t2 to $fp-40
	# _tmp365 = _tmp363 == _tmp364
	  lw $t0, -36($fp)	# fill _tmp363 to $t0 from $fp-36
	  lw $t1, -40($fp)	# fill _tmp364 to $t1 from $fp-40
	  seq $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp365 from $t2 to $fp-44
	# _tmp366 = _tmp362 && _tmp365
	  lw $t0, -32($fp)	# fill _tmp362 to $t0 from $fp-32
	  lw $t1, -44($fp)	# fill _tmp365 to $t1 from $fp-44
	  and $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp366 from $t2 to $fp-48
	# IfZ _tmp366 Goto _L40
	  lw $t0, -48($fp)	# fill _tmp366 to $t0 from $fp-48
	  beqz $t0, _L40	# branch if _tmp366 is zero 
	# _tmp367 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -52($fp)	# spill _tmp367 from $t2 to $fp-52
	# win = _tmp367
	  lw $t2, -52($fp)	# fill _tmp367 to $t2 from $fp-52
	  sw $t2, -8($fp)	# spill win from $t2 to $fp-8
	# Goto _L41
	  b _L41		# unconditional branch
  _L40:
	# _tmp368 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -56($fp)	# spill _tmp368 from $t2 to $fp-56
	# _tmp369 = 21
	  li $t2, 21		# load constant value 21 into $t2
	  sw $t2, -60($fp)	# spill _tmp369 from $t2 to $fp-60
	# _tmp370 = _tmp369 < _tmp368
	  lw $t0, -60($fp)	# fill _tmp369 to $t0 from $fp-60
	  lw $t1, -56($fp)	# fill _tmp368 to $t1 from $fp-56
	  slt $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp370 from $t2 to $fp-64
	# IfZ _tmp370 Goto _L42
	  lw $t0, -64($fp)	# fill _tmp370 to $t0 from $fp-64
	  beqz $t0, _L42	# branch if _tmp370 is zero 
	# _tmp371 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -68($fp)	# spill _tmp371 from $t2 to $fp-68
	# lose = _tmp371
	  lw $t2, -68($fp)	# fill _tmp371 to $t2 from $fp-68
	  sw $t2, -12($fp)	# spill lose from $t2 to $fp-12
	# Goto _L43
	  b _L43		# unconditional branch
  _L42:
	# _tmp372 = 21
	  li $t2, 21		# load constant value 21 into $t2
	  sw $t2, -72($fp)	# spill _tmp372 from $t2 to $fp-72
	# _tmp373 = _tmp372 < dealer
	  lw $t0, -72($fp)	# fill _tmp372 to $t0 from $fp-72
	  lw $t1, 8($fp)	# fill dealer to $t1 from $fp+8
	  slt $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp373 from $t2 to $fp-76
	# IfZ _tmp373 Goto _L44
	  lw $t0, -76($fp)	# fill _tmp373 to $t0 from $fp-76
	  beqz $t0, _L44	# branch if _tmp373 is zero 
	# _tmp374 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -80($fp)	# spill _tmp374 from $t2 to $fp-80
	# win = _tmp374
	  lw $t2, -80($fp)	# fill _tmp374 to $t2 from $fp-80
	  sw $t2, -8($fp)	# spill win from $t2 to $fp-8
	# Goto _L45
	  b _L45		# unconditional branch
  _L44:
	# _tmp375 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp375 from $t2 to $fp-84
	# _tmp376 = dealer < _tmp375
	  lw $t0, 8($fp)	# fill dealer to $t0 from $fp+8
	  lw $t1, -84($fp)	# fill _tmp375 to $t1 from $fp-84
	  slt $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp376 from $t2 to $fp-88
	# IfZ _tmp376 Goto _L46
	  lw $t0, -88($fp)	# fill _tmp376 to $t0 from $fp-88
	  beqz $t0, _L46	# branch if _tmp376 is zero 
	# _tmp377 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -92($fp)	# spill _tmp377 from $t2 to $fp-92
	# win = _tmp377
	  lw $t2, -92($fp)	# fill _tmp377 to $t2 from $fp-92
	  sw $t2, -8($fp)	# spill win from $t2 to $fp-8
	# Goto _L47
	  b _L47		# unconditional branch
  _L46:
	# _tmp378 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp378 from $t2 to $fp-96
	# _tmp379 = _tmp378 < dealer
	  lw $t0, -96($fp)	# fill _tmp378 to $t0 from $fp-96
	  lw $t1, 8($fp)	# fill dealer to $t1 from $fp+8
	  slt $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp379 from $t2 to $fp-100
	# IfZ _tmp379 Goto _L48
	  lw $t0, -100($fp)	# fill _tmp379 to $t0 from $fp-100
	  beqz $t0, _L48	# branch if _tmp379 is zero 
	# _tmp380 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -104($fp)	# spill _tmp380 from $t2 to $fp-104
	# lose = _tmp380
	  lw $t2, -104($fp)	# fill _tmp380 to $t2 from $fp-104
	  sw $t2, -12($fp)	# spill lose from $t2 to $fp-12
  _L48:
  _L47:
  _L45:
  _L43:
  _L41:
	# _tmp381 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -108($fp)	# spill _tmp381 from $t2 to $fp-108
	# _tmp382 = _tmp381 < win
	  lw $t0, -108($fp)	# fill _tmp381 to $t0 from $fp-108
	  lw $t1, -8($fp)	# fill win to $t1 from $fp-8
	  slt $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp382 from $t2 to $fp-112
	# _tmp383 = _tmp381 == win
	  lw $t0, -108($fp)	# fill _tmp381 to $t0 from $fp-108
	  lw $t1, -8($fp)	# fill win to $t1 from $fp-8
	  seq $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp383 from $t2 to $fp-116
	# _tmp384 = _tmp382 || _tmp383
	  lw $t0, -112($fp)	# fill _tmp382 to $t0 from $fp-112
	  lw $t1, -116($fp)	# fill _tmp383 to $t1 from $fp-116
	  or $t2, $t0, $t1	
	  sw $t2, -120($fp)	# spill _tmp384 from $t2 to $fp-120
	# IfZ _tmp384 Goto _L49
	  lw $t0, -120($fp)	# fill _tmp384 to $t0 from $fp-120
	  beqz $t0, _L49	# branch if _tmp384 is zero 
	# _tmp385 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -124($fp)	# spill _tmp385 from $t2 to $fp-124
	# PushParam _tmp385
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -124($fp)	# fill _tmp385 to $t0 from $fp-124
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp386 = ", you won $"
	  .data			# create string constant marked with label
	  _string34: .asciiz ", you won $"
	  .text
	  la $t2, _string34	# load label
	  sw $t2, -128($fp)	# spill _tmp386 from $t2 to $fp-128
	# PushParam _tmp386
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -128($fp)	# fill _tmp386 to $t0 from $fp-128
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp387 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -132($fp)	# spill _tmp387 from $t2 to $fp-132
	# PushParam _tmp387
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -132($fp)	# fill _tmp387 to $t0 from $fp-132
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp388 = ".\n"
	  .data			# create string constant marked with label
	  _string35: .asciiz ".\n"
	  .text
	  la $t2, _string35	# load label
	  sw $t2, -136($fp)	# spill _tmp388 from $t2 to $fp-136
	# PushParam _tmp388
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -136($fp)	# fill _tmp388 to $t0 from $fp-136
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L50
	  b _L50		# unconditional branch
  _L49:
	# _tmp389 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -140($fp)	# spill _tmp389 from $t2 to $fp-140
	# _tmp390 = _tmp389 < lose
	  lw $t0, -140($fp)	# fill _tmp389 to $t0 from $fp-140
	  lw $t1, -12($fp)	# fill lose to $t1 from $fp-12
	  slt $t2, $t0, $t1	
	  sw $t2, -144($fp)	# spill _tmp390 from $t2 to $fp-144
	# _tmp391 = _tmp389 == lose
	  lw $t0, -140($fp)	# fill _tmp389 to $t0 from $fp-140
	  lw $t1, -12($fp)	# fill lose to $t1 from $fp-12
	  seq $t2, $t0, $t1	
	  sw $t2, -148($fp)	# spill _tmp391 from $t2 to $fp-148
	# _tmp392 = _tmp390 || _tmp391
	  lw $t0, -144($fp)	# fill _tmp390 to $t0 from $fp-144
	  lw $t1, -148($fp)	# fill _tmp391 to $t1 from $fp-148
	  or $t2, $t0, $t1	
	  sw $t2, -152($fp)	# spill _tmp392 from $t2 to $fp-152
	# IfZ _tmp392 Goto _L51
	  lw $t0, -152($fp)	# fill _tmp392 to $t0 from $fp-152
	  beqz $t0, _L51	# branch if _tmp392 is zero 
	# _tmp393 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -156($fp)	# spill _tmp393 from $t2 to $fp-156
	# PushParam _tmp393
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -156($fp)	# fill _tmp393 to $t0 from $fp-156
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp394 = ", you lost $"
	  .data			# create string constant marked with label
	  _string36: .asciiz ", you lost $"
	  .text
	  la $t2, _string36	# load label
	  sw $t2, -160($fp)	# spill _tmp394 from $t2 to $fp-160
	# PushParam _tmp394
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -160($fp)	# fill _tmp394 to $t0 from $fp-160
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp395 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -164($fp)	# spill _tmp395 from $t2 to $fp-164
	# PushParam _tmp395
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -164($fp)	# fill _tmp395 to $t0 from $fp-164
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp396 = ".\n"
	  .data			# create string constant marked with label
	  _string37: .asciiz ".\n"
	  .text
	  la $t2, _string37	# load label
	  sw $t2, -168($fp)	# spill _tmp396 from $t2 to $fp-168
	# PushParam _tmp396
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -168($fp)	# fill _tmp396 to $t0 from $fp-168
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L52
	  b _L52		# unconditional branch
  _L51:
	# _tmp397 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -172($fp)	# spill _tmp397 from $t2 to $fp-172
	# PushParam _tmp397
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -172($fp)	# fill _tmp397 to $t0 from $fp-172
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp398 = ", you push!\n"
	  .data			# create string constant marked with label
	  _string38: .asciiz ", you push!\n"
	  .text
	  la $t2, _string38	# load label
	  sw $t2, -176($fp)	# spill _tmp398 from $t2 to $fp-176
	# PushParam _tmp398
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -176($fp)	# fill _tmp398 to $t0 from $fp-176
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L52:
  _L50:
	# _tmp399 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -180($fp)	# spill _tmp399 from $t2 to $fp-180
	# _tmp400 = win * _tmp399
	  lw $t0, -8($fp)	# fill win to $t0 from $fp-8
	  lw $t1, -180($fp)	# fill _tmp399 to $t1 from $fp-180
	  mul $t2, $t0, $t1	
	  sw $t2, -184($fp)	# spill _tmp400 from $t2 to $fp-184
	# win = _tmp400
	  lw $t2, -184($fp)	# fill _tmp400 to $t2 from $fp-184
	  sw $t2, -8($fp)	# spill win from $t2 to $fp-8
	# _tmp401 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -188($fp)	# spill _tmp401 from $t2 to $fp-188
	# _tmp402 = lose * _tmp401
	  lw $t0, -12($fp)	# fill lose to $t0 from $fp-12
	  lw $t1, -188($fp)	# fill _tmp401 to $t1 from $fp-188
	  mul $t2, $t0, $t1	
	  sw $t2, -192($fp)	# spill _tmp402 from $t2 to $fp-192
	# lose = _tmp402
	  lw $t2, -192($fp)	# fill _tmp402 to $t2 from $fp-192
	  sw $t2, -12($fp)	# spill lose from $t2 to $fp-12
	# _tmp403 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -196($fp)	# spill _tmp403 from $t2 to $fp-196
	# _tmp404 = _tmp403 + win
	  lw $t0, -196($fp)	# fill _tmp403 to $t0 from $fp-196
	  lw $t1, -8($fp)	# fill win to $t1 from $fp-8
	  add $t2, $t0, $t1	
	  sw $t2, -200($fp)	# spill _tmp404 from $t2 to $fp-200
	# _tmp405 = _tmp404 - lose
	  lw $t0, -200($fp)	# fill _tmp404 to $t0 from $fp-200
	  lw $t1, -12($fp)	# fill lose to $t1 from $fp-12
	  sub $t2, $t0, $t1	
	  sw $t2, -204($fp)	# spill _tmp405 from $t2 to $fp-204
	# *(this + 12) = _tmp405
	  lw $t0, -204($fp)	# fill _tmp405 to $t0 from $fp-204
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 12($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Player
	  .data
	  .align 2
	  Player:		# label for class Player vtable
	  .word _Player.Init
	  .word _Player.Hit
	  .word _Player.DoubleDown
	  .word _Player.TakeTurn
	  .word _Player.HasMoney
	  .word _Player.PrintMoney
	  .word _Player.PlaceBet
	  .word _Player.GetTotal
	  .word _Player.Resolve
	  .text
  _Dealer.Init:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp406 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -8($fp)	# spill _tmp406 from $t2 to $fp-8
	# *(this + 24) = _tmp406
	  lw $t0, -8($fp)	# fill _tmp406 to $t0 from $fp-8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 24($t2) 	# store with offset
	# _tmp407 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp407 from $t2 to $fp-12
	# *(this + 4) = _tmp407
	  lw $t0, -12($fp)	# fill _tmp407 to $t0 from $fp-12
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp408 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp408 from $t2 to $fp-16
	# *(this + 20) = _tmp408
	  lw $t0, -16($fp)	# fill _tmp408 to $t0 from $fp-16
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 20($t2) 	# store with offset
	# _tmp409 = "Dealer"
	  .data			# create string constant marked with label
	  _string39: .asciiz "Dealer"
	  .text
	  la $t2, _string39	# load label
	  sw $t2, -20($fp)	# spill _tmp409 from $t2 to $fp-20
	# *(this + 16) = _tmp409
	  lw $t0, -20($fp)	# fill _tmp409 to $t0 from $fp-20
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 16($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Dealer.TakeTurn:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	# _tmp410 = "\n"
	  .data			# create string constant marked with label
	  _string40: .asciiz "\n"
	  .text
	  la $t2, _string40	# load label
	  sw $t2, -8($fp)	# spill _tmp410 from $t2 to $fp-8
	# PushParam _tmp410
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill _tmp410 to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp411 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp411 from $t2 to $fp-12
	# PushParam _tmp411
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp411 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp412 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string41: .asciiz "'s turn.\n"
	  .text
	  la $t2, _string41	# load label
	  sw $t2, -16($fp)	# spill _tmp412 from $t2 to $fp-16
	# PushParam _tmp412
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp412 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L53:
	# _tmp413 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp413 from $t2 to $fp-20
	# _tmp414 = 16
	  li $t2, 16		# load constant value 16 into $t2
	  sw $t2, -24($fp)	# spill _tmp414 from $t2 to $fp-24
	# _tmp415 = _tmp413 < _tmp414
	  lw $t0, -20($fp)	# fill _tmp413 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp414 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp415 from $t2 to $fp-28
	# _tmp416 = _tmp413 == _tmp414
	  lw $t0, -20($fp)	# fill _tmp413 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp414 to $t1 from $fp-24
	  seq $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp416 from $t2 to $fp-32
	# _tmp417 = _tmp415 || _tmp416
	  lw $t0, -28($fp)	# fill _tmp415 to $t0 from $fp-28
	  lw $t1, -32($fp)	# fill _tmp416 to $t1 from $fp-32
	  or $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp417 from $t2 to $fp-36
	# IfZ _tmp417 Goto _L54
	  lw $t0, -36($fp)	# fill _tmp417 to $t0 from $fp-36
	  beqz $t0, _L54	# branch if _tmp417 is zero 
	# _tmp418 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp418 from $t2 to $fp-40
	# _tmp419 = *(_tmp418 + 4)
	  lw $t0, -40($fp)	# fill _tmp418 to $t0 from $fp-40
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp419 from $t2 to $fp-44
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp419
	  lw $t0, -44($fp)	# fill _tmp419 to $t0 from $fp-44
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L53
	  b _L53		# unconditional branch
  _L54:
	# _tmp420 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp420 from $t2 to $fp-48
	# _tmp421 = 21
	  li $t2, 21		# load constant value 21 into $t2
	  sw $t2, -52($fp)	# spill _tmp421 from $t2 to $fp-52
	# _tmp422 = _tmp421 < _tmp420
	  lw $t0, -52($fp)	# fill _tmp421 to $t0 from $fp-52
	  lw $t1, -48($fp)	# fill _tmp420 to $t1 from $fp-48
	  slt $t2, $t0, $t1	
	  sw $t2, -56($fp)	# spill _tmp422 from $t2 to $fp-56
	# IfZ _tmp422 Goto _L55
	  lw $t0, -56($fp)	# fill _tmp422 to $t0 from $fp-56
	  beqz $t0, _L55	# branch if _tmp422 is zero 
	# _tmp423 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -60($fp)	# spill _tmp423 from $t2 to $fp-60
	# PushParam _tmp423
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -60($fp)	# fill _tmp423 to $t0 from $fp-60
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp424 = " busts with the big "
	  .data			# create string constant marked with label
	  _string42: .asciiz " busts with the big "
	  .text
	  la $t2, _string42	# load label
	  sw $t2, -64($fp)	# spill _tmp424 from $t2 to $fp-64
	# PushParam _tmp424
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -64($fp)	# fill _tmp424 to $t0 from $fp-64
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp425 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp425 from $t2 to $fp-68
	# PushParam _tmp425
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -68($fp)	# fill _tmp425 to $t0 from $fp-68
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp426 = "!\n"
	  .data			# create string constant marked with label
	  _string43: .asciiz "!\n"
	  .text
	  la $t2, _string43	# load label
	  sw $t2, -72($fp)	# spill _tmp426 from $t2 to $fp-72
	# PushParam _tmp426
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -72($fp)	# fill _tmp426 to $t0 from $fp-72
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L56
	  b _L56		# unconditional branch
  _L55:
	# _tmp427 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp427 from $t2 to $fp-76
	# PushParam _tmp427
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -76($fp)	# fill _tmp427 to $t0 from $fp-76
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp428 = " stays at "
	  .data			# create string constant marked with label
	  _string44: .asciiz " stays at "
	  .text
	  la $t2, _string44	# load label
	  sw $t2, -80($fp)	# spill _tmp428 from $t2 to $fp-80
	# PushParam _tmp428
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -80($fp)	# fill _tmp428 to $t0 from $fp-80
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp429 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp429 from $t2 to $fp-84
	# PushParam _tmp429
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -84($fp)	# fill _tmp429 to $t0 from $fp-84
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp430 = ".\n"
	  .data			# create string constant marked with label
	  _string45: .asciiz ".\n"
	  .text
	  la $t2, _string45	# load label
	  sw $t2, -88($fp)	# spill _tmp430 from $t2 to $fp-88
	# PushParam _tmp430
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -88($fp)	# fill _tmp430 to $t0 from $fp-88
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L56:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Dealer
	  .data
	  .align 2
	  Dealer:		# label for class Dealer vtable
	  .word _Dealer.Init
	  .word _Player.Hit
	  .word _Player.DoubleDown
	  .word _Dealer.TakeTurn
	  .word _Player.HasMoney
	  .word _Player.PrintMoney
	  .word _Player.PlaceBet
	  .word _Player.GetTotal
	  .word _Player.Resolve
	  .text
  _House.SetupGame:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	# _tmp431 = "\nWelcome to CS143 BlackJack!\n"
	  .data			# create string constant marked with label
	  _string46: .asciiz "\nWelcome to CS143 BlackJack!\n"
	  .text
	  la $t2, _string46	# load label
	  sw $t2, -8($fp)	# spill _tmp431 from $t2 to $fp-8
	# PushParam _tmp431
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill _tmp431 to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp432 = "---------------------------\n"
	  .data			# create string constant marked with label
	  _string47: .asciiz "---------------------------\n"
	  .text
	  la $t2, _string47	# load label
	  sw $t2, -12($fp)	# spill _tmp432 from $t2 to $fp-12
	# PushParam _tmp432
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp432 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp433 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -16($fp)	# spill _tmp433 from $t2 to $fp-16
	# PushParam _tmp433
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp433 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp434 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp434 from $t2 to $fp-20
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp435 = Random
	  la $t2, Random	# load label
	  sw $t2, -24($fp)	# spill _tmp435 from $t2 to $fp-24
	# *(_tmp434) = _tmp435
	  lw $t0, -24($fp)	# fill _tmp435 to $t0 from $fp-24
	  lw $t2, -20($fp)	# fill _tmp434 to $t2 from $fp-20
	  sw $t0, 0($t2) 	# store with offset
	# gRnd = _tmp434
	  lw $t2, -20($fp)	# fill _tmp434 to $t2 from $fp-20
	  sw $t2, 0($gp)	# spill gRnd from $t2 to $gp+0
	# _tmp436 = "Please enter a random number seed: "
	  .data			# create string constant marked with label
	  _string48: .asciiz "Please enter a random number seed: "
	  .text
	  la $t2, _string48	# load label
	  sw $t2, -28($fp)	# spill _tmp436 from $t2 to $fp-28
	# PushParam _tmp436
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# fill _tmp436 to $t0 from $fp-28
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp437 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -32($fp)	# spill _tmp437 from $t2 to $fp-32
	# _tmp438 = *(gRnd)
	  lw $t0, 0($gp)	# fill gRnd to $t0 from $gp+0
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp438 from $t2 to $fp-36
	# _tmp439 = *(_tmp438)
	  lw $t0, -36($fp)	# fill _tmp438 to $t0 from $fp-36
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp439 from $t2 to $fp-40
	# PushParam _tmp437
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -32($fp)	# fill _tmp437 to $t0 from $fp-32
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 0($gp)	# fill gRnd to $t0 from $gp+0
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp439
	  lw $t0, -40($fp)	# fill _tmp439 to $t0 from $fp-40
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp440 = 12
	  li $t2, 12		# load constant value 12 into $t2
	  sw $t2, -44($fp)	# spill _tmp440 from $t2 to $fp-44
	# PushParam _tmp440
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill _tmp440 to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp441 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -48($fp)	# spill _tmp441 from $t2 to $fp-48
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp442 = BJDeck
	  la $t2, BJDeck	# load label
	  sw $t2, -52($fp)	# spill _tmp442 from $t2 to $fp-52
	# *(_tmp441) = _tmp442
	  lw $t0, -52($fp)	# fill _tmp442 to $t0 from $fp-52
	  lw $t2, -48($fp)	# fill _tmp441 to $t2 from $fp-48
	  sw $t0, 0($t2) 	# store with offset
	# *(this + 12) = _tmp441
	  lw $t0, -48($fp)	# fill _tmp441 to $t0 from $fp-48
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 12($t2) 	# store with offset
	# _tmp443 = 28
	  li $t2, 28		# load constant value 28 into $t2
	  sw $t2, -56($fp)	# spill _tmp443 from $t2 to $fp-56
	# PushParam _tmp443
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp443 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp444 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -60($fp)	# spill _tmp444 from $t2 to $fp-60
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp445 = Dealer
	  la $t2, Dealer	# load label
	  sw $t2, -64($fp)	# spill _tmp445 from $t2 to $fp-64
	# *(_tmp444) = _tmp445
	  lw $t0, -64($fp)	# fill _tmp445 to $t0 from $fp-64
	  lw $t2, -60($fp)	# fill _tmp444 to $t2 from $fp-60
	  sw $t0, 0($t2) 	# store with offset
	# *(this + 8) = _tmp444
	  lw $t0, -60($fp)	# fill _tmp444 to $t0 from $fp-60
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# _tmp446 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp446 from $t2 to $fp-68
	# _tmp447 = *(_tmp446)
	  lw $t0, -68($fp)	# fill _tmp446 to $t0 from $fp-68
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp447 from $t2 to $fp-72
	# _tmp448 = *(_tmp447)
	  lw $t0, -72($fp)	# fill _tmp447 to $t0 from $fp-72
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp448 from $t2 to $fp-76
	# PushParam _tmp446
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -68($fp)	# fill _tmp446 to $t0 from $fp-68
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp448
	  lw $t0, -76($fp)	# fill _tmp448 to $t0 from $fp-76
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp449 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp449 from $t2 to $fp-80
	# _tmp450 = *(_tmp449)
	  lw $t0, -80($fp)	# fill _tmp449 to $t0 from $fp-80
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp450 from $t2 to $fp-84
	# _tmp451 = *(_tmp450 + 8)
	  lw $t0, -84($fp)	# fill _tmp450 to $t0 from $fp-84
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp451 from $t2 to $fp-88
	# PushParam _tmp449
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -80($fp)	# fill _tmp449 to $t0 from $fp-80
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp451
	  lw $t0, -88($fp)	# fill _tmp451 to $t0 from $fp-88
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.SetupPlayers:
	# BeginFunc 196
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 196	# decrement sp to make space for locals/temps
	# _tmp452 = "How many players do we have today? "
	  .data			# create string constant marked with label
	  _string49: .asciiz "How many players do we have today? "
	  .text
	  la $t2, _string49	# load label
	  sw $t2, -16($fp)	# spill _tmp452 from $t2 to $fp-16
	# PushParam _tmp452
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp452 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp453 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp453 from $t2 to $fp-20
	# numPlayers = _tmp453
	  lw $t2, -20($fp)	# fill _tmp453 to $t2 from $fp-20
	  sw $t2, -12($fp)	# spill numPlayers from $t2 to $fp-12
	# _tmp454 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -24($fp)	# spill _tmp454 from $t2 to $fp-24
	# _tmp455 = numPlayers < _tmp454
	  lw $t0, -12($fp)	# fill numPlayers to $t0 from $fp-12
	  lw $t1, -24($fp)	# fill _tmp454 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp455 from $t2 to $fp-28
	# IfZ _tmp455 Goto _L57
	  lw $t0, -28($fp)	# fill _tmp455 to $t0 from $fp-28
	  beqz $t0, _L57	# branch if _tmp455 is zero 
	# _tmp456 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string50: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string50	# load label
	  sw $t2, -32($fp)	# spill _tmp456 from $t2 to $fp-32
	# PushParam _tmp456
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -32($fp)	# fill _tmp456 to $t0 from $fp-32
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L57:
	# _tmp457 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -36($fp)	# spill _tmp457 from $t2 to $fp-36
	# _tmp458 = _tmp457 + numPlayers
	  lw $t0, -36($fp)	# fill _tmp457 to $t0 from $fp-36
	  lw $t1, -12($fp)	# fill numPlayers to $t1 from $fp-12
	  add $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp458 from $t2 to $fp-40
	# _tmp459 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -44($fp)	# spill _tmp459 from $t2 to $fp-44
	# _tmp460 = _tmp458 * _tmp459
	  lw $t0, -40($fp)	# fill _tmp458 to $t0 from $fp-40
	  lw $t1, -44($fp)	# fill _tmp459 to $t1 from $fp-44
	  mul $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp460 from $t2 to $fp-48
	# PushParam _tmp460
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -48($fp)	# fill _tmp460 to $t0 from $fp-48
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp461 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -52($fp)	# spill _tmp461 from $t2 to $fp-52
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp461) = numPlayers
	  lw $t0, -12($fp)	# fill numPlayers to $t0 from $fp-12
	  lw $t2, -52($fp)	# fill _tmp461 to $t2 from $fp-52
	  sw $t0, 0($t2) 	# store with offset
	# _tmp462 = _tmp461 + _tmp459
	  lw $t0, -52($fp)	# fill _tmp461 to $t0 from $fp-52
	  lw $t1, -44($fp)	# fill _tmp459 to $t1 from $fp-44
	  add $t2, $t0, $t1	
	  sw $t2, -56($fp)	# spill _tmp462 from $t2 to $fp-56
	# *(this + 4) = _tmp462
	  lw $t0, -56($fp)	# fill _tmp462 to $t0 from $fp-56
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp463 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -60($fp)	# spill _tmp463 from $t2 to $fp-60
	# i = _tmp463
	  lw $t2, -60($fp)	# fill _tmp463 to $t2 from $fp-60
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L58:
	# _tmp464 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp464 from $t2 to $fp-64
	# _tmp465 = *(_tmp464 + -4)
	  lw $t0, -64($fp)	# fill _tmp464 to $t0 from $fp-64
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp465 from $t2 to $fp-68
	# _tmp466 = i < _tmp465
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -68($fp)	# fill _tmp465 to $t1 from $fp-68
	  slt $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp466 from $t2 to $fp-72
	# IfZ _tmp466 Goto _L59
	  lw $t0, -72($fp)	# fill _tmp466 to $t0 from $fp-72
	  beqz $t0, _L59	# branch if _tmp466 is zero 
	# _tmp467 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp467 from $t2 to $fp-76
	# _tmp468 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -80($fp)	# spill _tmp468 from $t2 to $fp-80
	# _tmp469 = i < _tmp468
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -80($fp)	# fill _tmp468 to $t1 from $fp-80
	  slt $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp469 from $t2 to $fp-84
	# _tmp470 = *(_tmp467 + -4)
	  lw $t0, -76($fp)	# fill _tmp467 to $t0 from $fp-76
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp470 from $t2 to $fp-88
	# _tmp471 = i < _tmp470
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -88($fp)	# fill _tmp470 to $t1 from $fp-88
	  slt $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp471 from $t2 to $fp-92
	# _tmp472 = _tmp471 == _tmp468
	  lw $t0, -92($fp)	# fill _tmp471 to $t0 from $fp-92
	  lw $t1, -80($fp)	# fill _tmp468 to $t1 from $fp-80
	  seq $t2, $t0, $t1	
	  sw $t2, -96($fp)	# spill _tmp472 from $t2 to $fp-96
	# _tmp473 = _tmp469 || _tmp472
	  lw $t0, -84($fp)	# fill _tmp469 to $t0 from $fp-84
	  lw $t1, -96($fp)	# fill _tmp472 to $t1 from $fp-96
	  or $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp473 from $t2 to $fp-100
	# IfZ _tmp473 Goto _L60
	  lw $t0, -100($fp)	# fill _tmp473 to $t0 from $fp-100
	  beqz $t0, _L60	# branch if _tmp473 is zero 
	# _tmp474 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string51: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string51	# load label
	  sw $t2, -104($fp)	# spill _tmp474 from $t2 to $fp-104
	# PushParam _tmp474
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -104($fp)	# fill _tmp474 to $t0 from $fp-104
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L60:
	# _tmp475 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -108($fp)	# spill _tmp475 from $t2 to $fp-108
	# _tmp476 = _tmp475 * i
	  lw $t0, -108($fp)	# fill _tmp475 to $t0 from $fp-108
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp476 from $t2 to $fp-112
	# _tmp477 = _tmp467 + _tmp476
	  lw $t0, -76($fp)	# fill _tmp467 to $t0 from $fp-76
	  lw $t1, -112($fp)	# fill _tmp476 to $t1 from $fp-112
	  add $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp477 from $t2 to $fp-116
	# _tmp478 = 28
	  li $t2, 28		# load constant value 28 into $t2
	  sw $t2, -120($fp)	# spill _tmp478 from $t2 to $fp-120
	# PushParam _tmp478
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -120($fp)	# fill _tmp478 to $t0 from $fp-120
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp479 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -124($fp)	# spill _tmp479 from $t2 to $fp-124
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp480 = Player
	  la $t2, Player	# load label
	  sw $t2, -128($fp)	# spill _tmp480 from $t2 to $fp-128
	# *(_tmp479) = _tmp480
	  lw $t0, -128($fp)	# fill _tmp480 to $t0 from $fp-128
	  lw $t2, -124($fp)	# fill _tmp479 to $t2 from $fp-124
	  sw $t0, 0($t2) 	# store with offset
	# *(_tmp477) = _tmp479
	  lw $t0, -124($fp)	# fill _tmp479 to $t0 from $fp-124
	  lw $t2, -116($fp)	# fill _tmp477 to $t2 from $fp-116
	  sw $t0, 0($t2) 	# store with offset
	# _tmp481 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -132($fp)	# spill _tmp481 from $t2 to $fp-132
	# _tmp482 = i + _tmp481
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -132($fp)	# fill _tmp481 to $t1 from $fp-132
	  add $t2, $t0, $t1	
	  sw $t2, -136($fp)	# spill _tmp482 from $t2 to $fp-136
	# _tmp483 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -140($fp)	# spill _tmp483 from $t2 to $fp-140
	# _tmp484 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -144($fp)	# spill _tmp484 from $t2 to $fp-144
	# _tmp485 = i < _tmp484
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -144($fp)	# fill _tmp484 to $t1 from $fp-144
	  slt $t2, $t0, $t1	
	  sw $t2, -148($fp)	# spill _tmp485 from $t2 to $fp-148
	# _tmp486 = *(_tmp483 + -4)
	  lw $t0, -140($fp)	# fill _tmp483 to $t0 from $fp-140
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -152($fp)	# spill _tmp486 from $t2 to $fp-152
	# _tmp487 = i < _tmp486
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -152($fp)	# fill _tmp486 to $t1 from $fp-152
	  slt $t2, $t0, $t1	
	  sw $t2, -156($fp)	# spill _tmp487 from $t2 to $fp-156
	# _tmp488 = _tmp487 == _tmp484
	  lw $t0, -156($fp)	# fill _tmp487 to $t0 from $fp-156
	  lw $t1, -144($fp)	# fill _tmp484 to $t1 from $fp-144
	  seq $t2, $t0, $t1	
	  sw $t2, -160($fp)	# spill _tmp488 from $t2 to $fp-160
	# _tmp489 = _tmp485 || _tmp488
	  lw $t0, -148($fp)	# fill _tmp485 to $t0 from $fp-148
	  lw $t1, -160($fp)	# fill _tmp488 to $t1 from $fp-160
	  or $t2, $t0, $t1	
	  sw $t2, -164($fp)	# spill _tmp489 from $t2 to $fp-164
	# IfZ _tmp489 Goto _L61
	  lw $t0, -164($fp)	# fill _tmp489 to $t0 from $fp-164
	  beqz $t0, _L61	# branch if _tmp489 is zero 
	# _tmp490 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string52: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string52	# load label
	  sw $t2, -168($fp)	# spill _tmp490 from $t2 to $fp-168
	# PushParam _tmp490
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -168($fp)	# fill _tmp490 to $t0 from $fp-168
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L61:
	# _tmp491 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -172($fp)	# spill _tmp491 from $t2 to $fp-172
	# _tmp492 = _tmp491 * i
	  lw $t0, -172($fp)	# fill _tmp491 to $t0 from $fp-172
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -176($fp)	# spill _tmp492 from $t2 to $fp-176
	# _tmp493 = _tmp483 + _tmp492
	  lw $t0, -140($fp)	# fill _tmp483 to $t0 from $fp-140
	  lw $t1, -176($fp)	# fill _tmp492 to $t1 from $fp-176
	  add $t2, $t0, $t1	
	  sw $t2, -180($fp)	# spill _tmp493 from $t2 to $fp-180
	# _tmp494 = *(_tmp493)
	  lw $t0, -180($fp)	# fill _tmp493 to $t0 from $fp-180
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -184($fp)	# spill _tmp494 from $t2 to $fp-184
	# _tmp495 = *(_tmp494)
	  lw $t0, -184($fp)	# fill _tmp494 to $t0 from $fp-184
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -188($fp)	# spill _tmp495 from $t2 to $fp-188
	# _tmp496 = *(_tmp495)
	  lw $t0, -188($fp)	# fill _tmp495 to $t0 from $fp-188
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -192($fp)	# spill _tmp496 from $t2 to $fp-192
	# PushParam _tmp482
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -136($fp)	# fill _tmp482 to $t0 from $fp-136
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp494
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -184($fp)	# fill _tmp494 to $t0 from $fp-184
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp496
	  lw $t0, -192($fp)	# fill _tmp496 to $t0 from $fp-192
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp497 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -196($fp)	# spill _tmp497 from $t2 to $fp-196
	# _tmp498 = i + _tmp497
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -196($fp)	# fill _tmp497 to $t1 from $fp-196
	  add $t2, $t0, $t1	
	  sw $t2, -200($fp)	# spill _tmp498 from $t2 to $fp-200
	# i = _tmp498
	  lw $t2, -200($fp)	# fill _tmp498 to $t2 from $fp-200
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L58
	  b _L58		# unconditional branch
  _L59:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllBets:
	# BeginFunc 148
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 148	# decrement sp to make space for locals/temps
	# _tmp499 = "\nFirst, let's take bets.\n"
	  .data			# create string constant marked with label
	  _string53: .asciiz "\nFirst, let's take bets.\n"
	  .text
	  la $t2, _string53	# load label
	  sw $t2, -12($fp)	# spill _tmp499 from $t2 to $fp-12
	# PushParam _tmp499
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp499 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp500 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp500 from $t2 to $fp-16
	# i = _tmp500
	  lw $t2, -16($fp)	# fill _tmp500 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L62:
	# _tmp501 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp501 from $t2 to $fp-20
	# _tmp502 = *(_tmp501 + -4)
	  lw $t0, -20($fp)	# fill _tmp501 to $t0 from $fp-20
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp502 from $t2 to $fp-24
	# _tmp503 = i < _tmp502
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -24($fp)	# fill _tmp502 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp503 from $t2 to $fp-28
	# IfZ _tmp503 Goto _L63
	  lw $t0, -28($fp)	# fill _tmp503 to $t0 from $fp-28
	  beqz $t0, _L63	# branch if _tmp503 is zero 
	# _tmp504 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp504 from $t2 to $fp-32
	# _tmp505 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -36($fp)	# spill _tmp505 from $t2 to $fp-36
	# _tmp506 = i < _tmp505
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -36($fp)	# fill _tmp505 to $t1 from $fp-36
	  slt $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp506 from $t2 to $fp-40
	# _tmp507 = *(_tmp504 + -4)
	  lw $t0, -32($fp)	# fill _tmp504 to $t0 from $fp-32
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp507 from $t2 to $fp-44
	# _tmp508 = i < _tmp507
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -44($fp)	# fill _tmp507 to $t1 from $fp-44
	  slt $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp508 from $t2 to $fp-48
	# _tmp509 = _tmp508 == _tmp505
	  lw $t0, -48($fp)	# fill _tmp508 to $t0 from $fp-48
	  lw $t1, -36($fp)	# fill _tmp505 to $t1 from $fp-36
	  seq $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp509 from $t2 to $fp-52
	# _tmp510 = _tmp506 || _tmp509
	  lw $t0, -40($fp)	# fill _tmp506 to $t0 from $fp-40
	  lw $t1, -52($fp)	# fill _tmp509 to $t1 from $fp-52
	  or $t2, $t0, $t1	
	  sw $t2, -56($fp)	# spill _tmp510 from $t2 to $fp-56
	# IfZ _tmp510 Goto _L64
	  lw $t0, -56($fp)	# fill _tmp510 to $t0 from $fp-56
	  beqz $t0, _L64	# branch if _tmp510 is zero 
	# _tmp511 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string54: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string54	# load label
	  sw $t2, -60($fp)	# spill _tmp511 from $t2 to $fp-60
	# PushParam _tmp511
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -60($fp)	# fill _tmp511 to $t0 from $fp-60
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L64:
	# _tmp512 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -64($fp)	# spill _tmp512 from $t2 to $fp-64
	# _tmp513 = _tmp512 * i
	  lw $t0, -64($fp)	# fill _tmp512 to $t0 from $fp-64
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp513 from $t2 to $fp-68
	# _tmp514 = _tmp504 + _tmp513
	  lw $t0, -32($fp)	# fill _tmp504 to $t0 from $fp-32
	  lw $t1, -68($fp)	# fill _tmp513 to $t1 from $fp-68
	  add $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp514 from $t2 to $fp-72
	# _tmp515 = *(_tmp514)
	  lw $t0, -72($fp)	# fill _tmp514 to $t0 from $fp-72
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp515 from $t2 to $fp-76
	# _tmp516 = *(_tmp515)
	  lw $t0, -76($fp)	# fill _tmp515 to $t0 from $fp-76
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp516 from $t2 to $fp-80
	# _tmp517 = *(_tmp516 + 16)
	  lw $t0, -80($fp)	# fill _tmp516 to $t0 from $fp-80
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp517 from $t2 to $fp-84
	# PushParam _tmp515
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -76($fp)	# fill _tmp515 to $t0 from $fp-76
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp518 = ACall _tmp517
	  lw $t0, -84($fp)	# fill _tmp517 to $t0 from $fp-84
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -88($fp)	# spill _tmp518 from $t2 to $fp-88
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp518 Goto _L65
	  lw $t0, -88($fp)	# fill _tmp518 to $t0 from $fp-88
	  beqz $t0, _L65	# branch if _tmp518 is zero 
	# _tmp519 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp519 from $t2 to $fp-92
	# _tmp520 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -96($fp)	# spill _tmp520 from $t2 to $fp-96
	# _tmp521 = i < _tmp520
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -96($fp)	# fill _tmp520 to $t1 from $fp-96
	  slt $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp521 from $t2 to $fp-100
	# _tmp522 = *(_tmp519 + -4)
	  lw $t0, -92($fp)	# fill _tmp519 to $t0 from $fp-92
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp522 from $t2 to $fp-104
	# _tmp523 = i < _tmp522
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -104($fp)	# fill _tmp522 to $t1 from $fp-104
	  slt $t2, $t0, $t1	
	  sw $t2, -108($fp)	# spill _tmp523 from $t2 to $fp-108
	# _tmp524 = _tmp523 == _tmp520
	  lw $t0, -108($fp)	# fill _tmp523 to $t0 from $fp-108
	  lw $t1, -96($fp)	# fill _tmp520 to $t1 from $fp-96
	  seq $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp524 from $t2 to $fp-112
	# _tmp525 = _tmp521 || _tmp524
	  lw $t0, -100($fp)	# fill _tmp521 to $t0 from $fp-100
	  lw $t1, -112($fp)	# fill _tmp524 to $t1 from $fp-112
	  or $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp525 from $t2 to $fp-116
	# IfZ _tmp525 Goto _L66
	  lw $t0, -116($fp)	# fill _tmp525 to $t0 from $fp-116
	  beqz $t0, _L66	# branch if _tmp525 is zero 
	# _tmp526 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string55: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string55	# load label
	  sw $t2, -120($fp)	# spill _tmp526 from $t2 to $fp-120
	# PushParam _tmp526
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -120($fp)	# fill _tmp526 to $t0 from $fp-120
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L66:
	# _tmp527 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -124($fp)	# spill _tmp527 from $t2 to $fp-124
	# _tmp528 = _tmp527 * i
	  lw $t0, -124($fp)	# fill _tmp527 to $t0 from $fp-124
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -128($fp)	# spill _tmp528 from $t2 to $fp-128
	# _tmp529 = _tmp519 + _tmp528
	  lw $t0, -92($fp)	# fill _tmp519 to $t0 from $fp-92
	  lw $t1, -128($fp)	# fill _tmp528 to $t1 from $fp-128
	  add $t2, $t0, $t1	
	  sw $t2, -132($fp)	# spill _tmp529 from $t2 to $fp-132
	# _tmp530 = *(_tmp529)
	  lw $t0, -132($fp)	# fill _tmp529 to $t0 from $fp-132
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -136($fp)	# spill _tmp530 from $t2 to $fp-136
	# _tmp531 = *(_tmp530)
	  lw $t0, -136($fp)	# fill _tmp530 to $t0 from $fp-136
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -140($fp)	# spill _tmp531 from $t2 to $fp-140
	# _tmp532 = *(_tmp531 + 24)
	  lw $t0, -140($fp)	# fill _tmp531 to $t0 from $fp-140
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -144($fp)	# spill _tmp532 from $t2 to $fp-144
	# PushParam _tmp530
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -136($fp)	# fill _tmp530 to $t0 from $fp-136
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp532
	  lw $t0, -144($fp)	# fill _tmp532 to $t0 from $fp-144
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L65:
	# _tmp533 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -148($fp)	# spill _tmp533 from $t2 to $fp-148
	# _tmp534 = i + _tmp533
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -148($fp)	# fill _tmp533 to $t1 from $fp-148
	  add $t2, $t0, $t1	
	  sw $t2, -152($fp)	# spill _tmp534 from $t2 to $fp-152
	# i = _tmp534
	  lw $t2, -152($fp)	# fill _tmp534 to $t2 from $fp-152
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L62
	  b _L62		# unconditional branch
  _L63:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllTurns:
	# BeginFunc 148
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 148	# decrement sp to make space for locals/temps
	# _tmp535 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp535 from $t2 to $fp-12
	# i = _tmp535
	  lw $t2, -12($fp)	# fill _tmp535 to $t2 from $fp-12
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L67:
	# _tmp536 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp536 from $t2 to $fp-16
	# _tmp537 = *(_tmp536 + -4)
	  lw $t0, -16($fp)	# fill _tmp536 to $t0 from $fp-16
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp537 from $t2 to $fp-20
	# _tmp538 = i < _tmp537
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -20($fp)	# fill _tmp537 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp538 from $t2 to $fp-24
	# IfZ _tmp538 Goto _L68
	  lw $t0, -24($fp)	# fill _tmp538 to $t0 from $fp-24
	  beqz $t0, _L68	# branch if _tmp538 is zero 
	# _tmp539 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp539 from $t2 to $fp-28
	# _tmp540 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp540 from $t2 to $fp-32
	# _tmp541 = i < _tmp540
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -32($fp)	# fill _tmp540 to $t1 from $fp-32
	  slt $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp541 from $t2 to $fp-36
	# _tmp542 = *(_tmp539 + -4)
	  lw $t0, -28($fp)	# fill _tmp539 to $t0 from $fp-28
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp542 from $t2 to $fp-40
	# _tmp543 = i < _tmp542
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -40($fp)	# fill _tmp542 to $t1 from $fp-40
	  slt $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp543 from $t2 to $fp-44
	# _tmp544 = _tmp543 == _tmp540
	  lw $t0, -44($fp)	# fill _tmp543 to $t0 from $fp-44
	  lw $t1, -32($fp)	# fill _tmp540 to $t1 from $fp-32
	  seq $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp544 from $t2 to $fp-48
	# _tmp545 = _tmp541 || _tmp544
	  lw $t0, -36($fp)	# fill _tmp541 to $t0 from $fp-36
	  lw $t1, -48($fp)	# fill _tmp544 to $t1 from $fp-48
	  or $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp545 from $t2 to $fp-52
	# IfZ _tmp545 Goto _L69
	  lw $t0, -52($fp)	# fill _tmp545 to $t0 from $fp-52
	  beqz $t0, _L69	# branch if _tmp545 is zero 
	# _tmp546 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string56: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string56	# load label
	  sw $t2, -56($fp)	# spill _tmp546 from $t2 to $fp-56
	# PushParam _tmp546
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp546 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L69:
	# _tmp547 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -60($fp)	# spill _tmp547 from $t2 to $fp-60
	# _tmp548 = _tmp547 * i
	  lw $t0, -60($fp)	# fill _tmp547 to $t0 from $fp-60
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp548 from $t2 to $fp-64
	# _tmp549 = _tmp539 + _tmp548
	  lw $t0, -28($fp)	# fill _tmp539 to $t0 from $fp-28
	  lw $t1, -64($fp)	# fill _tmp548 to $t1 from $fp-64
	  add $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp549 from $t2 to $fp-68
	# _tmp550 = *(_tmp549)
	  lw $t0, -68($fp)	# fill _tmp549 to $t0 from $fp-68
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp550 from $t2 to $fp-72
	# _tmp551 = *(_tmp550)
	  lw $t0, -72($fp)	# fill _tmp550 to $t0 from $fp-72
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp551 from $t2 to $fp-76
	# _tmp552 = *(_tmp551 + 16)
	  lw $t0, -76($fp)	# fill _tmp551 to $t0 from $fp-76
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp552 from $t2 to $fp-80
	# PushParam _tmp550
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -72($fp)	# fill _tmp550 to $t0 from $fp-72
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp553 = ACall _tmp552
	  lw $t0, -80($fp)	# fill _tmp552 to $t0 from $fp-80
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -84($fp)	# spill _tmp553 from $t2 to $fp-84
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp553 Goto _L70
	  lw $t0, -84($fp)	# fill _tmp553 to $t0 from $fp-84
	  beqz $t0, _L70	# branch if _tmp553 is zero 
	# _tmp554 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp554 from $t2 to $fp-88
	# _tmp555 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp555 from $t2 to $fp-92
	# _tmp556 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -96($fp)	# spill _tmp556 from $t2 to $fp-96
	# _tmp557 = i < _tmp556
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -96($fp)	# fill _tmp556 to $t1 from $fp-96
	  slt $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp557 from $t2 to $fp-100
	# _tmp558 = *(_tmp555 + -4)
	  lw $t0, -92($fp)	# fill _tmp555 to $t0 from $fp-92
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp558 from $t2 to $fp-104
	# _tmp559 = i < _tmp558
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -104($fp)	# fill _tmp558 to $t1 from $fp-104
	  slt $t2, $t0, $t1	
	  sw $t2, -108($fp)	# spill _tmp559 from $t2 to $fp-108
	# _tmp560 = _tmp559 == _tmp556
	  lw $t0, -108($fp)	# fill _tmp559 to $t0 from $fp-108
	  lw $t1, -96($fp)	# fill _tmp556 to $t1 from $fp-96
	  seq $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp560 from $t2 to $fp-112
	# _tmp561 = _tmp557 || _tmp560
	  lw $t0, -100($fp)	# fill _tmp557 to $t0 from $fp-100
	  lw $t1, -112($fp)	# fill _tmp560 to $t1 from $fp-112
	  or $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp561 from $t2 to $fp-116
	# IfZ _tmp561 Goto _L71
	  lw $t0, -116($fp)	# fill _tmp561 to $t0 from $fp-116
	  beqz $t0, _L71	# branch if _tmp561 is zero 
	# _tmp562 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string57: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string57	# load label
	  sw $t2, -120($fp)	# spill _tmp562 from $t2 to $fp-120
	# PushParam _tmp562
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -120($fp)	# fill _tmp562 to $t0 from $fp-120
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L71:
	# _tmp563 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -124($fp)	# spill _tmp563 from $t2 to $fp-124
	# _tmp564 = _tmp563 * i
	  lw $t0, -124($fp)	# fill _tmp563 to $t0 from $fp-124
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -128($fp)	# spill _tmp564 from $t2 to $fp-128
	# _tmp565 = _tmp555 + _tmp564
	  lw $t0, -92($fp)	# fill _tmp555 to $t0 from $fp-92
	  lw $t1, -128($fp)	# fill _tmp564 to $t1 from $fp-128
	  add $t2, $t0, $t1	
	  sw $t2, -132($fp)	# spill _tmp565 from $t2 to $fp-132
	# _tmp566 = *(_tmp565)
	  lw $t0, -132($fp)	# fill _tmp565 to $t0 from $fp-132
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -136($fp)	# spill _tmp566 from $t2 to $fp-136
	# _tmp567 = *(_tmp566)
	  lw $t0, -136($fp)	# fill _tmp566 to $t0 from $fp-136
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -140($fp)	# spill _tmp567 from $t2 to $fp-140
	# _tmp568 = *(_tmp567 + 12)
	  lw $t0, -140($fp)	# fill _tmp567 to $t0 from $fp-140
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -144($fp)	# spill _tmp568 from $t2 to $fp-144
	# PushParam _tmp554
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -88($fp)	# fill _tmp554 to $t0 from $fp-88
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp566
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -136($fp)	# fill _tmp566 to $t0 from $fp-136
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp568
	  lw $t0, -144($fp)	# fill _tmp568 to $t0 from $fp-144
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L70:
	# _tmp569 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -148($fp)	# spill _tmp569 from $t2 to $fp-148
	# _tmp570 = i + _tmp569
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -148($fp)	# fill _tmp569 to $t1 from $fp-148
	  add $t2, $t0, $t1	
	  sw $t2, -152($fp)	# spill _tmp570 from $t2 to $fp-152
	# i = _tmp570
	  lw $t2, -152($fp)	# fill _tmp570 to $t2 from $fp-152
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L67
	  b _L67		# unconditional branch
  _L68:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.ResolveAllPlayers:
	# BeginFunc 164
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 164	# decrement sp to make space for locals/temps
	# _tmp571 = "\nTime to resolve bets.\n"
	  .data			# create string constant marked with label
	  _string58: .asciiz "\nTime to resolve bets.\n"
	  .text
	  la $t2, _string58	# load label
	  sw $t2, -12($fp)	# spill _tmp571 from $t2 to $fp-12
	# PushParam _tmp571
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp571 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp572 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp572 from $t2 to $fp-16
	# i = _tmp572
	  lw $t2, -16($fp)	# fill _tmp572 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L72:
	# _tmp573 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp573 from $t2 to $fp-20
	# _tmp574 = *(_tmp573 + -4)
	  lw $t0, -20($fp)	# fill _tmp573 to $t0 from $fp-20
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp574 from $t2 to $fp-24
	# _tmp575 = i < _tmp574
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -24($fp)	# fill _tmp574 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp575 from $t2 to $fp-28
	# IfZ _tmp575 Goto _L73
	  lw $t0, -28($fp)	# fill _tmp575 to $t0 from $fp-28
	  beqz $t0, _L73	# branch if _tmp575 is zero 
	# _tmp576 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp576 from $t2 to $fp-32
	# _tmp577 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -36($fp)	# spill _tmp577 from $t2 to $fp-36
	# _tmp578 = i < _tmp577
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -36($fp)	# fill _tmp577 to $t1 from $fp-36
	  slt $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp578 from $t2 to $fp-40
	# _tmp579 = *(_tmp576 + -4)
	  lw $t0, -32($fp)	# fill _tmp576 to $t0 from $fp-32
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp579 from $t2 to $fp-44
	# _tmp580 = i < _tmp579
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -44($fp)	# fill _tmp579 to $t1 from $fp-44
	  slt $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp580 from $t2 to $fp-48
	# _tmp581 = _tmp580 == _tmp577
	  lw $t0, -48($fp)	# fill _tmp580 to $t0 from $fp-48
	  lw $t1, -36($fp)	# fill _tmp577 to $t1 from $fp-36
	  seq $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp581 from $t2 to $fp-52
	# _tmp582 = _tmp578 || _tmp581
	  lw $t0, -40($fp)	# fill _tmp578 to $t0 from $fp-40
	  lw $t1, -52($fp)	# fill _tmp581 to $t1 from $fp-52
	  or $t2, $t0, $t1	
	  sw $t2, -56($fp)	# spill _tmp582 from $t2 to $fp-56
	# IfZ _tmp582 Goto _L74
	  lw $t0, -56($fp)	# fill _tmp582 to $t0 from $fp-56
	  beqz $t0, _L74	# branch if _tmp582 is zero 
	# _tmp583 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string59: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string59	# load label
	  sw $t2, -60($fp)	# spill _tmp583 from $t2 to $fp-60
	# PushParam _tmp583
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -60($fp)	# fill _tmp583 to $t0 from $fp-60
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L74:
	# _tmp584 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -64($fp)	# spill _tmp584 from $t2 to $fp-64
	# _tmp585 = _tmp584 * i
	  lw $t0, -64($fp)	# fill _tmp584 to $t0 from $fp-64
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp585 from $t2 to $fp-68
	# _tmp586 = _tmp576 + _tmp585
	  lw $t0, -32($fp)	# fill _tmp576 to $t0 from $fp-32
	  lw $t1, -68($fp)	# fill _tmp585 to $t1 from $fp-68
	  add $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp586 from $t2 to $fp-72
	# _tmp587 = *(_tmp586)
	  lw $t0, -72($fp)	# fill _tmp586 to $t0 from $fp-72
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp587 from $t2 to $fp-76
	# _tmp588 = *(_tmp587)
	  lw $t0, -76($fp)	# fill _tmp587 to $t0 from $fp-76
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp588 from $t2 to $fp-80
	# _tmp589 = *(_tmp588 + 16)
	  lw $t0, -80($fp)	# fill _tmp588 to $t0 from $fp-80
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp589 from $t2 to $fp-84
	# PushParam _tmp587
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -76($fp)	# fill _tmp587 to $t0 from $fp-76
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp590 = ACall _tmp589
	  lw $t0, -84($fp)	# fill _tmp589 to $t0 from $fp-84
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -88($fp)	# spill _tmp590 from $t2 to $fp-88
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp590 Goto _L75
	  lw $t0, -88($fp)	# fill _tmp590 to $t0 from $fp-88
	  beqz $t0, _L75	# branch if _tmp590 is zero 
	# _tmp591 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp591 from $t2 to $fp-92
	# _tmp592 = *(_tmp591)
	  lw $t0, -92($fp)	# fill _tmp591 to $t0 from $fp-92
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp592 from $t2 to $fp-96
	# _tmp593 = *(_tmp592 + 28)
	  lw $t0, -96($fp)	# fill _tmp592 to $t0 from $fp-96
	  lw $t2, 28($t0) 	# load with offset
	  sw $t2, -100($fp)	# spill _tmp593 from $t2 to $fp-100
	# PushParam _tmp591
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -92($fp)	# fill _tmp591 to $t0 from $fp-92
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp594 = ACall _tmp593
	  lw $t0, -100($fp)	# fill _tmp593 to $t0 from $fp-100
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -104($fp)	# spill _tmp594 from $t2 to $fp-104
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp595 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -108($fp)	# spill _tmp595 from $t2 to $fp-108
	# _tmp596 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -112($fp)	# spill _tmp596 from $t2 to $fp-112
	# _tmp597 = i < _tmp596
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -112($fp)	# fill _tmp596 to $t1 from $fp-112
	  slt $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp597 from $t2 to $fp-116
	# _tmp598 = *(_tmp595 + -4)
	  lw $t0, -108($fp)	# fill _tmp595 to $t0 from $fp-108
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -120($fp)	# spill _tmp598 from $t2 to $fp-120
	# _tmp599 = i < _tmp598
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -120($fp)	# fill _tmp598 to $t1 from $fp-120
	  slt $t2, $t0, $t1	
	  sw $t2, -124($fp)	# spill _tmp599 from $t2 to $fp-124
	# _tmp600 = _tmp599 == _tmp596
	  lw $t0, -124($fp)	# fill _tmp599 to $t0 from $fp-124
	  lw $t1, -112($fp)	# fill _tmp596 to $t1 from $fp-112
	  seq $t2, $t0, $t1	
	  sw $t2, -128($fp)	# spill _tmp600 from $t2 to $fp-128
	# _tmp601 = _tmp597 || _tmp600
	  lw $t0, -116($fp)	# fill _tmp597 to $t0 from $fp-116
	  lw $t1, -128($fp)	# fill _tmp600 to $t1 from $fp-128
	  or $t2, $t0, $t1	
	  sw $t2, -132($fp)	# spill _tmp601 from $t2 to $fp-132
	# IfZ _tmp601 Goto _L76
	  lw $t0, -132($fp)	# fill _tmp601 to $t0 from $fp-132
	  beqz $t0, _L76	# branch if _tmp601 is zero 
	# _tmp602 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string60: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string60	# load label
	  sw $t2, -136($fp)	# spill _tmp602 from $t2 to $fp-136
	# PushParam _tmp602
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -136($fp)	# fill _tmp602 to $t0 from $fp-136
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L76:
	# _tmp603 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -140($fp)	# spill _tmp603 from $t2 to $fp-140
	# _tmp604 = _tmp603 * i
	  lw $t0, -140($fp)	# fill _tmp603 to $t0 from $fp-140
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -144($fp)	# spill _tmp604 from $t2 to $fp-144
	# _tmp605 = _tmp595 + _tmp604
	  lw $t0, -108($fp)	# fill _tmp595 to $t0 from $fp-108
	  lw $t1, -144($fp)	# fill _tmp604 to $t1 from $fp-144
	  add $t2, $t0, $t1	
	  sw $t2, -148($fp)	# spill _tmp605 from $t2 to $fp-148
	# _tmp606 = *(_tmp605)
	  lw $t0, -148($fp)	# fill _tmp605 to $t0 from $fp-148
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -152($fp)	# spill _tmp606 from $t2 to $fp-152
	# _tmp607 = *(_tmp606)
	  lw $t0, -152($fp)	# fill _tmp606 to $t0 from $fp-152
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -156($fp)	# spill _tmp607 from $t2 to $fp-156
	# _tmp608 = *(_tmp607 + 32)
	  lw $t0, -156($fp)	# fill _tmp607 to $t0 from $fp-156
	  lw $t2, 32($t0) 	# load with offset
	  sw $t2, -160($fp)	# spill _tmp608 from $t2 to $fp-160
	# PushParam _tmp594
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -104($fp)	# fill _tmp594 to $t0 from $fp-104
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp606
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -152($fp)	# fill _tmp606 to $t0 from $fp-152
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp608
	  lw $t0, -160($fp)	# fill _tmp608 to $t0 from $fp-160
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L75:
	# _tmp609 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -164($fp)	# spill _tmp609 from $t2 to $fp-164
	# _tmp610 = i + _tmp609
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -164($fp)	# fill _tmp609 to $t1 from $fp-164
	  add $t2, $t0, $t1	
	  sw $t2, -168($fp)	# spill _tmp610 from $t2 to $fp-168
	# i = _tmp610
	  lw $t2, -168($fp)	# fill _tmp610 to $t2 from $fp-168
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L72
	  b _L72		# unconditional branch
  _L73:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PrintAllMoney:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	# _tmp611 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp611 from $t2 to $fp-12
	# i = _tmp611
	  lw $t2, -12($fp)	# fill _tmp611 to $t2 from $fp-12
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L77:
	# _tmp612 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp612 from $t2 to $fp-16
	# _tmp613 = *(_tmp612 + -4)
	  lw $t0, -16($fp)	# fill _tmp612 to $t0 from $fp-16
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp613 from $t2 to $fp-20
	# _tmp614 = i < _tmp613
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -20($fp)	# fill _tmp613 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp614 from $t2 to $fp-24
	# IfZ _tmp614 Goto _L78
	  lw $t0, -24($fp)	# fill _tmp614 to $t0 from $fp-24
	  beqz $t0, _L78	# branch if _tmp614 is zero 
	# _tmp615 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp615 from $t2 to $fp-28
	# _tmp616 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp616 from $t2 to $fp-32
	# _tmp617 = i < _tmp616
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -32($fp)	# fill _tmp616 to $t1 from $fp-32
	  slt $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp617 from $t2 to $fp-36
	# _tmp618 = *(_tmp615 + -4)
	  lw $t0, -28($fp)	# fill _tmp615 to $t0 from $fp-28
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp618 from $t2 to $fp-40
	# _tmp619 = i < _tmp618
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -40($fp)	# fill _tmp618 to $t1 from $fp-40
	  slt $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp619 from $t2 to $fp-44
	# _tmp620 = _tmp619 == _tmp616
	  lw $t0, -44($fp)	# fill _tmp619 to $t0 from $fp-44
	  lw $t1, -32($fp)	# fill _tmp616 to $t1 from $fp-32
	  seq $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp620 from $t2 to $fp-48
	# _tmp621 = _tmp617 || _tmp620
	  lw $t0, -36($fp)	# fill _tmp617 to $t0 from $fp-36
	  lw $t1, -48($fp)	# fill _tmp620 to $t1 from $fp-48
	  or $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp621 from $t2 to $fp-52
	# IfZ _tmp621 Goto _L79
	  lw $t0, -52($fp)	# fill _tmp621 to $t0 from $fp-52
	  beqz $t0, _L79	# branch if _tmp621 is zero 
	# _tmp622 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string61: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string61	# load label
	  sw $t2, -56($fp)	# spill _tmp622 from $t2 to $fp-56
	# PushParam _tmp622
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp622 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L79:
	# _tmp623 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -60($fp)	# spill _tmp623 from $t2 to $fp-60
	# _tmp624 = _tmp623 * i
	  lw $t0, -60($fp)	# fill _tmp623 to $t0 from $fp-60
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp624 from $t2 to $fp-64
	# _tmp625 = _tmp615 + _tmp624
	  lw $t0, -28($fp)	# fill _tmp615 to $t0 from $fp-28
	  lw $t1, -64($fp)	# fill _tmp624 to $t1 from $fp-64
	  add $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp625 from $t2 to $fp-68
	# _tmp626 = *(_tmp625)
	  lw $t0, -68($fp)	# fill _tmp625 to $t0 from $fp-68
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp626 from $t2 to $fp-72
	# _tmp627 = *(_tmp626)
	  lw $t0, -72($fp)	# fill _tmp626 to $t0 from $fp-72
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp627 from $t2 to $fp-76
	# _tmp628 = *(_tmp627 + 20)
	  lw $t0, -76($fp)	# fill _tmp627 to $t0 from $fp-76
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp628 from $t2 to $fp-80
	# PushParam _tmp626
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -72($fp)	# fill _tmp626 to $t0 from $fp-72
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp628
	  lw $t0, -80($fp)	# fill _tmp628 to $t0 from $fp-80
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp629 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -84($fp)	# spill _tmp629 from $t2 to $fp-84
	# _tmp630 = i + _tmp629
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -84($fp)	# fill _tmp629 to $t1 from $fp-84
	  add $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp630 from $t2 to $fp-88
	# i = _tmp630
	  lw $t2, -88($fp)	# fill _tmp630 to $t2 from $fp-88
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L77
	  b _L77		# unconditional branch
  _L78:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PlayOneGame:
	# BeginFunc 112
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 112	# decrement sp to make space for locals/temps
	# _tmp631 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp631 from $t2 to $fp-8
	# _tmp632 = *(_tmp631)
	  lw $t0, -8($fp)	# fill _tmp631 to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp632 from $t2 to $fp-12
	# _tmp633 = *(_tmp632 + 12)
	  lw $t0, -12($fp)	# fill _tmp632 to $t0 from $fp-12
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp633 from $t2 to $fp-16
	# PushParam _tmp631
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill _tmp631 to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp634 = ACall _tmp633
	  lw $t0, -16($fp)	# fill _tmp633 to $t0 from $fp-16
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp634 from $t2 to $fp-20
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp635 = 26
	  li $t2, 26		# load constant value 26 into $t2
	  sw $t2, -24($fp)	# spill _tmp635 from $t2 to $fp-24
	# _tmp636 = _tmp634 < _tmp635
	  lw $t0, -20($fp)	# fill _tmp634 to $t0 from $fp-20
	  lw $t1, -24($fp)	# fill _tmp635 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp636 from $t2 to $fp-28
	# IfZ _tmp636 Goto _L80
	  lw $t0, -28($fp)	# fill _tmp636 to $t0 from $fp-28
	  beqz $t0, _L80	# branch if _tmp636 is zero 
	# _tmp637 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp637 from $t2 to $fp-32
	# _tmp638 = *(_tmp637)
	  lw $t0, -32($fp)	# fill _tmp637 to $t0 from $fp-32
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp638 from $t2 to $fp-36
	# _tmp639 = *(_tmp638 + 8)
	  lw $t0, -36($fp)	# fill _tmp638 to $t0 from $fp-36
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp639 from $t2 to $fp-40
	# PushParam _tmp637
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -32($fp)	# fill _tmp637 to $t0 from $fp-32
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp639
	  lw $t0, -40($fp)	# fill _tmp639 to $t0 from $fp-40
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L80:
	# _tmp640 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp640 from $t2 to $fp-44
	# _tmp641 = *(_tmp640 + 8)
	  lw $t0, -44($fp)	# fill _tmp640 to $t0 from $fp-44
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp641 from $t2 to $fp-48
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp641
	  lw $t0, -48($fp)	# fill _tmp641 to $t0 from $fp-48
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp642 = "\nDealer starts. "
	  .data			# create string constant marked with label
	  _string62: .asciiz "\nDealer starts. "
	  .text
	  la $t2, _string62	# load label
	  sw $t2, -52($fp)	# spill _tmp642 from $t2 to $fp-52
	# PushParam _tmp642
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -52($fp)	# fill _tmp642 to $t0 from $fp-52
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp643 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp643 from $t2 to $fp-56
	# _tmp644 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -60($fp)	# spill _tmp644 from $t2 to $fp-60
	# _tmp645 = *(_tmp644)
	  lw $t0, -60($fp)	# fill _tmp644 to $t0 from $fp-60
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp645 from $t2 to $fp-64
	# _tmp646 = *(_tmp645)
	  lw $t0, -64($fp)	# fill _tmp645 to $t0 from $fp-64
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp646 from $t2 to $fp-68
	# PushParam _tmp643
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp643 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp644
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -60($fp)	# fill _tmp644 to $t0 from $fp-60
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp646
	  lw $t0, -68($fp)	# fill _tmp646 to $t0 from $fp-68
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp647 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp647 from $t2 to $fp-72
	# _tmp648 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp648 from $t2 to $fp-76
	# _tmp649 = *(_tmp648)
	  lw $t0, -76($fp)	# fill _tmp648 to $t0 from $fp-76
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp649 from $t2 to $fp-80
	# _tmp650 = *(_tmp649 + 4)
	  lw $t0, -80($fp)	# fill _tmp649 to $t0 from $fp-80
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp650 from $t2 to $fp-84
	# PushParam _tmp647
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -72($fp)	# fill _tmp647 to $t0 from $fp-72
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp648
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -76($fp)	# fill _tmp648 to $t0 from $fp-76
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp650
	  lw $t0, -84($fp)	# fill _tmp650 to $t0 from $fp-84
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp651 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp651 from $t2 to $fp-88
	# _tmp652 = *(_tmp651 + 12)
	  lw $t0, -88($fp)	# fill _tmp651 to $t0 from $fp-88
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp652 from $t2 to $fp-92
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp652
	  lw $t0, -92($fp)	# fill _tmp652 to $t0 from $fp-92
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp653 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp653 from $t2 to $fp-96
	# _tmp654 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -100($fp)	# spill _tmp654 from $t2 to $fp-100
	# _tmp655 = *(_tmp654)
	  lw $t0, -100($fp)	# fill _tmp654 to $t0 from $fp-100
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp655 from $t2 to $fp-104
	# _tmp656 = *(_tmp655 + 12)
	  lw $t0, -104($fp)	# fill _tmp655 to $t0 from $fp-104
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -108($fp)	# spill _tmp656 from $t2 to $fp-108
	# PushParam _tmp653
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -96($fp)	# fill _tmp653 to $t0 from $fp-96
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp654
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -100($fp)	# fill _tmp654 to $t0 from $fp-100
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp656
	  lw $t0, -108($fp)	# fill _tmp656 to $t0 from $fp-108
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp657 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -112($fp)	# spill _tmp657 from $t2 to $fp-112
	# _tmp658 = *(_tmp657 + 16)
	  lw $t0, -112($fp)	# fill _tmp657 to $t0 from $fp-112
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -116($fp)	# spill _tmp658 from $t2 to $fp-116
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp658
	  lw $t0, -116($fp)	# fill _tmp658 to $t0 from $fp-116
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class House
	  .data
	  .align 2
	  House:		# label for class House vtable
	  .word _House.SetupGame
	  .word _House.SetupPlayers
	  .word _House.TakeAllBets
	  .word _House.TakeAllTurns
	  .word _House.ResolveAllPlayers
	  .word _House.PrintAllMoney
	  .word _House.PlayOneGame
	  .text
  _GetYesOrNo:
	# BeginFunc 32
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 32	# decrement sp to make space for locals/temps
	# PushParam prompt
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill prompt to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp659 = " (y/n) "
	  .data			# create string constant marked with label
	  _string63: .asciiz " (y/n) "
	  .text
	  la $t2, _string63	# load label
	  sw $t2, -12($fp)	# spill _tmp659 from $t2 to $fp-12
	# PushParam _tmp659
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp659 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp660 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -16($fp)	# spill _tmp660 from $t2 to $fp-16
	# answer = _tmp660
	  lw $t2, -16($fp)	# fill _tmp660 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill answer from $t2 to $fp-8
	# _tmp661 = "y"
	  .data			# create string constant marked with label
	  _string64: .asciiz "y"
	  .text
	  la $t2, _string64	# load label
	  sw $t2, -20($fp)	# spill _tmp661 from $t2 to $fp-20
	# PushParam _tmp661
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -20($fp)	# fill _tmp661 to $t0 from $fp-20
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill answer to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp662 = LCall _StringEqual
	  jal _StringEqual   	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -24($fp)	# spill _tmp662 from $t2 to $fp-24
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp663 = "Y"
	  .data			# create string constant marked with label
	  _string65: .asciiz "Y"
	  .text
	  la $t2, _string65	# load label
	  sw $t2, -28($fp)	# spill _tmp663 from $t2 to $fp-28
	# PushParam _tmp663
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# fill _tmp663 to $t0 from $fp-28
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill answer to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp664 = LCall _StringEqual
	  jal _StringEqual   	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -32($fp)	# spill _tmp664 from $t2 to $fp-32
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp665 = _tmp662 || _tmp664
	  lw $t0, -24($fp)	# fill _tmp662 to $t0 from $fp-24
	  lw $t1, -32($fp)	# fill _tmp664 to $t1 from $fp-32
	  or $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp665 from $t2 to $fp-36
	# Return _tmp665
	  lw $t2, -36($fp)	# fill _tmp665 to $t2 from $fp-36
	  move $v0, $t2		# assign return value into $v0
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
	# BeginFunc 76
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 76	# decrement sp to make space for locals/temps
	# _tmp666 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -16($fp)	# spill _tmp666 from $t2 to $fp-16
	# keepPlaying = _tmp666
	  lw $t2, -16($fp)	# fill _tmp666 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill keepPlaying from $t2 to $fp-8
	# _tmp667 = 16
	  li $t2, 16		# load constant value 16 into $t2
	  sw $t2, -20($fp)	# spill _tmp667 from $t2 to $fp-20
	# PushParam _tmp667
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -20($fp)	# fill _tmp667 to $t0 from $fp-20
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp668 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -24($fp)	# spill _tmp668 from $t2 to $fp-24
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp669 = House
	  la $t2, House	# load label
	  sw $t2, -28($fp)	# spill _tmp669 from $t2 to $fp-28
	# *(_tmp668) = _tmp669
	  lw $t0, -28($fp)	# fill _tmp669 to $t0 from $fp-28
	  lw $t2, -24($fp)	# fill _tmp668 to $t2 from $fp-24
	  sw $t0, 0($t2) 	# store with offset
	# house = _tmp668
	  lw $t2, -24($fp)	# fill _tmp668 to $t2 from $fp-24
	  sw $t2, -12($fp)	# spill house from $t2 to $fp-12
	# _tmp670 = *(house)
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp670 from $t2 to $fp-32
	# _tmp671 = *(_tmp670)
	  lw $t0, -32($fp)	# fill _tmp670 to $t0 from $fp-32
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp671 from $t2 to $fp-36
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp671
	  lw $t0, -36($fp)	# fill _tmp671 to $t0 from $fp-36
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp672 = *(house)
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp672 from $t2 to $fp-40
	# _tmp673 = *(_tmp672 + 4)
	  lw $t0, -40($fp)	# fill _tmp672 to $t0 from $fp-40
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp673 from $t2 to $fp-44
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp673
	  lw $t0, -44($fp)	# fill _tmp673 to $t0 from $fp-44
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L81:
	# IfZ keepPlaying Goto _L82
	  lw $t0, -8($fp)	# fill keepPlaying to $t0 from $fp-8
	  beqz $t0, _L82	# branch if keepPlaying is zero 
	# _tmp674 = *(house)
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp674 from $t2 to $fp-48
	# _tmp675 = *(_tmp674 + 24)
	  lw $t0, -48($fp)	# fill _tmp674 to $t0 from $fp-48
	  lw $t2, 24($t0) 	# load with offset
	  sw $t2, -52($fp)	# spill _tmp675 from $t2 to $fp-52
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp675
	  lw $t0, -52($fp)	# fill _tmp675 to $t0 from $fp-52
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp676 = "\nDo you want to play another hand?"
	  .data			# create string constant marked with label
	  _string66: .asciiz "\nDo you want to play another hand?"
	  .text
	  la $t2, _string66	# load label
	  sw $t2, -56($fp)	# spill _tmp676 from $t2 to $fp-56
	# PushParam _tmp676
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp676 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp677 = LCall _GetYesOrNo
	  jal _GetYesOrNo    	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -60($fp)	# spill _tmp677 from $t2 to $fp-60
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# keepPlaying = _tmp677
	  lw $t2, -60($fp)	# fill _tmp677 to $t2 from $fp-60
	  sw $t2, -8($fp)	# spill keepPlaying from $t2 to $fp-8
	# Goto _L81
	  b _L81		# unconditional branch
  _L82:
	# _tmp678 = *(house)
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp678 from $t2 to $fp-64
	# _tmp679 = *(_tmp678 + 20)
	  lw $t0, -64($fp)	# fill _tmp678 to $t0 from $fp-64
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp679 from $t2 to $fp-68
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp679
	  lw $t0, -68($fp)	# fill _tmp679 to $t0 from $fp-68
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp680 = "Thank you for playing...come again soon.\n"
	  .data			# create string constant marked with label
	  _string67: .asciiz "Thank you for playing...come again soon.\n"
	  .text
	  la $t2, _string67	# load label
	  sw $t2, -72($fp)	# spill _tmp680 from $t2 to $fp-72
	# PushParam _tmp680
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -72($fp)	# fill _tmp680 to $t0 from $fp-72
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp681 = "\nCS143 BlackJack Copyright (c) 1999 by Peter Mor..."
	  .data			# create string constant marked with label
	  _string68: .asciiz "\nCS143 BlackJack Copyright (c) 1999 by Peter Mork.\n"
	  .text
	  la $t2, _string68	# load label
	  sw $t2, -76($fp)	# spill _tmp681 from $t2 to $fp-76
	# PushParam _tmp681
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -76($fp)	# fill _tmp681 to $t0 from $fp-76
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp682 = "(2001 mods by jdz)\n"
	  .data			# create string constant marked with label
	  _string69: .asciiz "(2001 mods by jdz)\n"
	  .text
	  la $t2, _string69	# load label
	  sw $t2, -80($fp)	# spill _tmp682 from $t2 to $fp-80
	# PushParam _tmp682
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -80($fp)	# fill _tmp682 to $t0 from $fp-80
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
  _PrintInt:
      subu $sp, $sp, 8	# decrement sp to make space to save ra,fp
      sw $fp, 8($sp)	# save fp
      sw $ra, 4($sp)	# save ra
      addiu $fp, $sp, 8	# set up new fp
      lw $a0, 4($fp)	# fill a to $t0 from $fp+4
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
          lw $t1, 4($fp)        # fill a from $fp+4
      li $t2, 0
          li $v0, 4
      beq $t1, $t2, _PrintBoolFalse
      la $a0, _PrintBoolTrueString
      j _PrintBoolEnd
    _PrintBoolFalse:
    	  la $a0, _PrintBoolFalseString
    _PrintBoolEnd:
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
        lbu  $a2,($a0)
        lbu  $a3,($a1)
        #addiu $a0,$a0,4
        #addiu $a1,$a1,4
        beq $a2,$a3,Lrunt11
  Lrunt13:
        li  $v0,0
        # EndFunc
        # (below handles reaching end of fn body with no explicit return)
          move $sp, $fp         # pop callee frame off stack
          lw $ra, -4($fp)       # restore saved ra
          lw $fp, 0($fp)        # restore saved fp
        j $ra
  Lrunt12:
        lbu  $t0,($a0)
        lbu  $t1,($a1)
        bne  $t0,$t1,Lrunt13
        beqz  $t0,Lrunt10
        addiu $a0,$a0,1
        addiu $a1,$a1,1
        addiu $a2,$a2,-1
  Lrunt11:
        bgez $a2,Lrunt12
  Lrunt10:
        li $v0,1
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
          li $a0, 100
          li $v0, 9
          syscall
          addi $a0, $v0, 0
          li $v0, 8
          li $a1,100 
          syscall
          li $t0,0              # Set index to 0
  Lrunt21:
          addu $t1,$a0,$t0      # Load character at index
          lb $a3,($t1)          # Load character at index
          addi $t0,$t0,1        # Increment index
          bnez $a3,Lrunt21      # Loop until the end of string is reached
          beq $a1,$t0,Lrunt20   # Do not remove \n when string = maxlength
          sb $0,-1($t1)         # Add the terminating character in its place
  Lrunt20:
          addi $v0, $a0, 0
        # EndFunc
        # (below handles reaching end of fn body with no explicit return)
          move $sp, $fp         # pop callee frame off stack
          lw $ra, -4($fp)       # restore saved ra
          lw $fp, 0($fp)        # restore saved fp
          jr $ra                # return from function
