	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Matrix.Init:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Matrix.Set:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Matrix.Get:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Matrix.PrintMatrix:
	# BeginFunc 68
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 68	# decrement sp to make space for locals/temps
	# _tmp0 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp0 from $t2 to $fp-16
	# i = _tmp0
	  lw $t2, -16($fp)	# fill _tmp0 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L0:
	# _tmp1 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -20($fp)	# spill _tmp1 from $t2 to $fp-20
	# _tmp2 = i < _tmp1
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -20($fp)	# fill _tmp1 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp2 from $t2 to $fp-24
	# IfZ _tmp2 Goto _L1
	  lw $t0, -24($fp)	# fill _tmp2 to $t0 from $fp-24
	  beqz $t0, _L1	# branch if _tmp2 is zero 
	# _tmp3 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -28($fp)	# spill _tmp3 from $t2 to $fp-28
	# j = _tmp3
	  lw $t2, -28($fp)	# fill _tmp3 to $t2 from $fp-28
	  sw $t2, -12($fp)	# spill j from $t2 to $fp-12
  _L2:
	# _tmp4 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -32($fp)	# spill _tmp4 from $t2 to $fp-32
	# _tmp5 = j < _tmp4
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -32($fp)	# fill _tmp4 to $t1 from $fp-32
	  slt $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp5 from $t2 to $fp-36
	# IfZ _tmp5 Goto _L3
	  lw $t0, -36($fp)	# fill _tmp5 to $t0 from $fp-36
	  beqz $t0, _L3	# branch if _tmp5 is zero 
	# _tmp6 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp6 from $t2 to $fp-40
	# _tmp7 = *(_tmp6 + 8)
	  lw $t0, -40($fp)	# fill _tmp6 to $t0 from $fp-40
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp7 from $t2 to $fp-44
	# PushParam j
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp8 = ACall _tmp7
	  lw $t0, -44($fp)	# fill _tmp7 to $t0 from $fp-44
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -48($fp)	# spill _tmp8 from $t2 to $fp-48
	# PopParams 12
	  add $sp, $sp, 12	# pop params off stack
	# PushParam _tmp8
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -48($fp)	# fill _tmp8 to $t0 from $fp-48
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp9 = "\t"
	  .data			# create string constant marked with label
	  _string1: .asciiz "\t"
	  .text
	  la $t2, _string1	# load label
	  sw $t2, -52($fp)	# spill _tmp9 from $t2 to $fp-52
	# PushParam _tmp9
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -52($fp)	# fill _tmp9 to $t0 from $fp-52
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp10 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -56($fp)	# spill _tmp10 from $t2 to $fp-56
	# _tmp11 = j + _tmp10
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -56($fp)	# fill _tmp10 to $t1 from $fp-56
	  add $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp11 from $t2 to $fp-60
	# j = _tmp11
	  lw $t2, -60($fp)	# fill _tmp11 to $t2 from $fp-60
	  sw $t2, -12($fp)	# spill j from $t2 to $fp-12
	# Goto _L2
	  b _L2		# unconditional branch
  _L3:
	# _tmp12 = "\n"
	  .data			# create string constant marked with label
	  _string2: .asciiz "\n"
	  .text
	  la $t2, _string2	# load label
	  sw $t2, -64($fp)	# spill _tmp12 from $t2 to $fp-64
	# PushParam _tmp12
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -64($fp)	# fill _tmp12 to $t0 from $fp-64
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp13 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -68($fp)	# spill _tmp13 from $t2 to $fp-68
	# _tmp14 = i + _tmp13
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -68($fp)	# fill _tmp13 to $t1 from $fp-68
	  add $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp14 from $t2 to $fp-72
	# i = _tmp14
	  lw $t2, -72($fp)	# fill _tmp14 to $t2 from $fp-72
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L0
	  b _L0		# unconditional branch
  _L1:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Matrix.SeedMatrix:
	# BeginFunc 180
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 180	# decrement sp to make space for locals/temps
	# _tmp15 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp15 from $t2 to $fp-16
	# i = _tmp15
	  lw $t2, -16($fp)	# fill _tmp15 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L4:
	# _tmp16 = 5
	  li $t2, 5		# load constant value 5 into $t2
	  sw $t2, -20($fp)	# spill _tmp16 from $t2 to $fp-20
	# _tmp17 = i < _tmp16
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -20($fp)	# fill _tmp16 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp17 from $t2 to $fp-24
	# IfZ _tmp17 Goto _L5
	  lw $t0, -24($fp)	# fill _tmp17 to $t0 from $fp-24
	  beqz $t0, _L5	# branch if _tmp17 is zero 
	# _tmp18 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -28($fp)	# spill _tmp18 from $t2 to $fp-28
	# j = _tmp18
	  lw $t2, -28($fp)	# fill _tmp18 to $t2 from $fp-28
	  sw $t2, -12($fp)	# spill j from $t2 to $fp-12
  _L6:
	# _tmp19 = 5
	  li $t2, 5		# load constant value 5 into $t2
	  sw $t2, -32($fp)	# spill _tmp19 from $t2 to $fp-32
	# _tmp20 = j < _tmp19
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -32($fp)	# fill _tmp19 to $t1 from $fp-32
	  slt $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp20 from $t2 to $fp-36
	# IfZ _tmp20 Goto _L7
	  lw $t0, -36($fp)	# fill _tmp20 to $t0 from $fp-36
	  beqz $t0, _L7	# branch if _tmp20 is zero 
	# _tmp21 = i + j
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -12($fp)	# fill j to $t1 from $fp-12
	  add $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp21 from $t2 to $fp-40
	# _tmp22 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp22 from $t2 to $fp-44
	# _tmp23 = *(_tmp22 + 4)
	  lw $t0, -44($fp)	# fill _tmp22 to $t0 from $fp-44
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp23 from $t2 to $fp-48
	# PushParam _tmp21
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -40($fp)	# fill _tmp21 to $t0 from $fp-40
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam j
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp23
	  lw $t0, -48($fp)	# fill _tmp23 to $t0 from $fp-48
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# _tmp24 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -52($fp)	# spill _tmp24 from $t2 to $fp-52
	# _tmp25 = j + _tmp24
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -52($fp)	# fill _tmp24 to $t1 from $fp-52
	  add $t2, $t0, $t1	
	  sw $t2, -56($fp)	# spill _tmp25 from $t2 to $fp-56
	# j = _tmp25
	  lw $t2, -56($fp)	# fill _tmp25 to $t2 from $fp-56
	  sw $t2, -12($fp)	# spill j from $t2 to $fp-12
	# Goto _L6
	  b _L6		# unconditional branch
  _L7:
	# _tmp26 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -60($fp)	# spill _tmp26 from $t2 to $fp-60
	# _tmp27 = i + _tmp26
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -60($fp)	# fill _tmp26 to $t1 from $fp-60
	  add $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp27 from $t2 to $fp-64
	# i = _tmp27
	  lw $t2, -64($fp)	# fill _tmp27 to $t2 from $fp-64
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L4
	  b _L4		# unconditional branch
  _L5:
	# _tmp28 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -68($fp)	# spill _tmp28 from $t2 to $fp-68
	# _tmp29 = 3
	  li $t2, 3		# load constant value 3 into $t2
	  sw $t2, -72($fp)	# spill _tmp29 from $t2 to $fp-72
	# _tmp30 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -76($fp)	# spill _tmp30 from $t2 to $fp-76
	# _tmp31 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp31 from $t2 to $fp-80
	# _tmp32 = *(_tmp31 + 4)
	  lw $t0, -80($fp)	# fill _tmp31 to $t0 from $fp-80
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp32 from $t2 to $fp-84
	# PushParam _tmp30
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -76($fp)	# fill _tmp30 to $t0 from $fp-76
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp29
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -72($fp)	# fill _tmp29 to $t0 from $fp-72
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp28
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -68($fp)	# fill _tmp28 to $t0 from $fp-68
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp32
	  lw $t0, -84($fp)	# fill _tmp32 to $t0 from $fp-84
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# _tmp33 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -88($fp)	# spill _tmp33 from $t2 to $fp-88
	# _tmp34 = 6
	  li $t2, 6		# load constant value 6 into $t2
	  sw $t2, -92($fp)	# spill _tmp34 from $t2 to $fp-92
	# _tmp35 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -96($fp)	# spill _tmp35 from $t2 to $fp-96
	# _tmp36 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -100($fp)	# spill _tmp36 from $t2 to $fp-100
	# _tmp37 = *(_tmp36 + 4)
	  lw $t0, -100($fp)	# fill _tmp36 to $t0 from $fp-100
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp37 from $t2 to $fp-104
	# PushParam _tmp35
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -96($fp)	# fill _tmp35 to $t0 from $fp-96
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp34
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -92($fp)	# fill _tmp34 to $t0 from $fp-92
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp33
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -88($fp)	# fill _tmp33 to $t0 from $fp-88
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp37
	  lw $t0, -104($fp)	# fill _tmp37 to $t0 from $fp-104
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# _tmp38 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -108($fp)	# spill _tmp38 from $t2 to $fp-108
	# _tmp39 = 3
	  li $t2, 3		# load constant value 3 into $t2
	  sw $t2, -112($fp)	# spill _tmp39 from $t2 to $fp-112
	# _tmp40 = 5
	  li $t2, 5		# load constant value 5 into $t2
	  sw $t2, -116($fp)	# spill _tmp40 from $t2 to $fp-116
	# _tmp41 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -120($fp)	# spill _tmp41 from $t2 to $fp-120
	# _tmp42 = *(_tmp41 + 4)
	  lw $t0, -120($fp)	# fill _tmp41 to $t0 from $fp-120
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -124($fp)	# spill _tmp42 from $t2 to $fp-124
	# PushParam _tmp40
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -116($fp)	# fill _tmp40 to $t0 from $fp-116
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp39
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -112($fp)	# fill _tmp39 to $t0 from $fp-112
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp38
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -108($fp)	# fill _tmp38 to $t0 from $fp-108
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp42
	  lw $t0, -124($fp)	# fill _tmp42 to $t0 from $fp-124
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# _tmp43 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -128($fp)	# spill _tmp43 from $t2 to $fp-128
	# _tmp44 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -132($fp)	# spill _tmp44 from $t2 to $fp-132
	# _tmp45 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -136($fp)	# spill _tmp45 from $t2 to $fp-136
	# _tmp46 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -140($fp)	# spill _tmp46 from $t2 to $fp-140
	# _tmp47 = *(_tmp46 + 4)
	  lw $t0, -140($fp)	# fill _tmp46 to $t0 from $fp-140
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -144($fp)	# spill _tmp47 from $t2 to $fp-144
	# PushParam _tmp45
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -136($fp)	# fill _tmp45 to $t0 from $fp-136
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp44
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -132($fp)	# fill _tmp44 to $t0 from $fp-132
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp43
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -128($fp)	# fill _tmp43 to $t0 from $fp-128
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp47
	  lw $t0, -144($fp)	# fill _tmp47 to $t0 from $fp-144
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# _tmp48 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -148($fp)	# spill _tmp48 from $t2 to $fp-148
	# _tmp49 = 6
	  li $t2, 6		# load constant value 6 into $t2
	  sw $t2, -152($fp)	# spill _tmp49 from $t2 to $fp-152
	# _tmp50 = 3
	  li $t2, 3		# load constant value 3 into $t2
	  sw $t2, -156($fp)	# spill _tmp50 from $t2 to $fp-156
	# _tmp51 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -160($fp)	# spill _tmp51 from $t2 to $fp-160
	# _tmp52 = *(_tmp51 + 4)
	  lw $t0, -160($fp)	# fill _tmp51 to $t0 from $fp-160
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -164($fp)	# spill _tmp52 from $t2 to $fp-164
	# PushParam _tmp50
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -156($fp)	# fill _tmp50 to $t0 from $fp-156
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp49
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -152($fp)	# fill _tmp49 to $t0 from $fp-152
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp48
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -148($fp)	# fill _tmp48 to $t0 from $fp-148
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp52
	  lw $t0, -164($fp)	# fill _tmp52 to $t0 from $fp-164
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# _tmp53 = 7
	  li $t2, 7		# load constant value 7 into $t2
	  sw $t2, -168($fp)	# spill _tmp53 from $t2 to $fp-168
	# _tmp54 = 7
	  li $t2, 7		# load constant value 7 into $t2
	  sw $t2, -172($fp)	# spill _tmp54 from $t2 to $fp-172
	# _tmp55 = 7
	  li $t2, 7		# load constant value 7 into $t2
	  sw $t2, -176($fp)	# spill _tmp55 from $t2 to $fp-176
	# _tmp56 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -180($fp)	# spill _tmp56 from $t2 to $fp-180
	# _tmp57 = *(_tmp56 + 4)
	  lw $t0, -180($fp)	# fill _tmp56 to $t0 from $fp-180
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -184($fp)	# spill _tmp57 from $t2 to $fp-184
	# PushParam _tmp55
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -176($fp)	# fill _tmp55 to $t0 from $fp-176
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp54
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -172($fp)	# fill _tmp54 to $t0 from $fp-172
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp53
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -168($fp)	# fill _tmp53 to $t0 from $fp-168
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp57
	  lw $t0, -184($fp)	# fill _tmp57 to $t0 from $fp-184
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Matrix
	  .data
	  .align 2
	  Matrix:		# label for class Matrix vtable
	  .word _Matrix.Init
	  .word _Matrix.Set
	  .word _Matrix.Get
	  .word _Matrix.PrintMatrix
	  .word _Matrix.SeedMatrix
	  .text
  _DenseMatrix.Init:
	# BeginFunc 284
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 284	# decrement sp to make space for locals/temps
	# _tmp58 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -16($fp)	# spill _tmp58 from $t2 to $fp-16
	# _tmp59 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -20($fp)	# spill _tmp59 from $t2 to $fp-20
	# _tmp60 = _tmp58 < _tmp59
	  lw $t0, -16($fp)	# fill _tmp58 to $t0 from $fp-16
	  lw $t1, -20($fp)	# fill _tmp59 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp60 from $t2 to $fp-24
	# IfZ _tmp60 Goto _L8
	  lw $t0, -24($fp)	# fill _tmp60 to $t0 from $fp-24
	  beqz $t0, _L8	# branch if _tmp60 is zero 
	# _tmp61 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string3	# load label
	  sw $t2, -28($fp)	# spill _tmp61 from $t2 to $fp-28
	# PushParam _tmp61
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# fill _tmp61 to $t0 from $fp-28
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L8:
	# _tmp62 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -32($fp)	# spill _tmp62 from $t2 to $fp-32
	# _tmp63 = _tmp62 + _tmp58
	  lw $t0, -32($fp)	# fill _tmp62 to $t0 from $fp-32
	  lw $t1, -16($fp)	# fill _tmp58 to $t1 from $fp-16
	  add $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp63 from $t2 to $fp-36
	# _tmp64 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -40($fp)	# spill _tmp64 from $t2 to $fp-40
	# _tmp65 = _tmp63 * _tmp64
	  lw $t0, -36($fp)	# fill _tmp63 to $t0 from $fp-36
	  lw $t1, -40($fp)	# fill _tmp64 to $t1 from $fp-40
	  mul $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp65 from $t2 to $fp-44
	# PushParam _tmp65
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill _tmp65 to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp66 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -48($fp)	# spill _tmp66 from $t2 to $fp-48
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp66) = _tmp58
	  lw $t0, -16($fp)	# fill _tmp58 to $t0 from $fp-16
	  lw $t2, -48($fp)	# fill _tmp66 to $t2 from $fp-48
	  sw $t0, 0($t2) 	# store with offset
	# _tmp67 = _tmp66 + _tmp64
	  lw $t0, -48($fp)	# fill _tmp66 to $t0 from $fp-48
	  lw $t1, -40($fp)	# fill _tmp64 to $t1 from $fp-40
	  add $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp67 from $t2 to $fp-52
	# *(this + 4) = _tmp67
	  lw $t0, -52($fp)	# fill _tmp67 to $t0 from $fp-52
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp68 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp68 from $t2 to $fp-56
	# i = _tmp68
	  lw $t2, -56($fp)	# fill _tmp68 to $t2 from $fp-56
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L9:
	# _tmp69 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -60($fp)	# spill _tmp69 from $t2 to $fp-60
	# _tmp70 = i < _tmp69
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -60($fp)	# fill _tmp69 to $t1 from $fp-60
	  slt $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp70 from $t2 to $fp-64
	# IfZ _tmp70 Goto _L10
	  lw $t0, -64($fp)	# fill _tmp70 to $t0 from $fp-64
	  beqz $t0, _L10	# branch if _tmp70 is zero 
	# _tmp71 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp71 from $t2 to $fp-68
	# _tmp72 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -72($fp)	# spill _tmp72 from $t2 to $fp-72
	# _tmp73 = i < _tmp72
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -72($fp)	# fill _tmp72 to $t1 from $fp-72
	  slt $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp73 from $t2 to $fp-76
	# _tmp74 = *(_tmp71 + -4)
	  lw $t0, -68($fp)	# fill _tmp71 to $t0 from $fp-68
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp74 from $t2 to $fp-80
	# _tmp75 = i < _tmp74
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -80($fp)	# fill _tmp74 to $t1 from $fp-80
	  slt $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp75 from $t2 to $fp-84
	# _tmp76 = _tmp75 == _tmp72
	  lw $t0, -84($fp)	# fill _tmp75 to $t0 from $fp-84
	  lw $t1, -72($fp)	# fill _tmp72 to $t1 from $fp-72
	  seq $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp76 from $t2 to $fp-88
	# _tmp77 = _tmp73 || _tmp76
	  lw $t0, -76($fp)	# fill _tmp73 to $t0 from $fp-76
	  lw $t1, -88($fp)	# fill _tmp76 to $t1 from $fp-88
	  or $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp77 from $t2 to $fp-92
	# IfZ _tmp77 Goto _L11
	  lw $t0, -92($fp)	# fill _tmp77 to $t0 from $fp-92
	  beqz $t0, _L11	# branch if _tmp77 is zero 
	# _tmp78 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string4	# load label
	  sw $t2, -96($fp)	# spill _tmp78 from $t2 to $fp-96
	# PushParam _tmp78
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -96($fp)	# fill _tmp78 to $t0 from $fp-96
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L11:
	# _tmp79 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -100($fp)	# spill _tmp79 from $t2 to $fp-100
	# _tmp80 = _tmp79 * i
	  lw $t0, -100($fp)	# fill _tmp79 to $t0 from $fp-100
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -104($fp)	# spill _tmp80 from $t2 to $fp-104
	# _tmp81 = _tmp71 + _tmp80
	  lw $t0, -68($fp)	# fill _tmp71 to $t0 from $fp-68
	  lw $t1, -104($fp)	# fill _tmp80 to $t1 from $fp-104
	  add $t2, $t0, $t1	
	  sw $t2, -108($fp)	# spill _tmp81 from $t2 to $fp-108
	# _tmp82 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -112($fp)	# spill _tmp82 from $t2 to $fp-112
	# _tmp83 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -116($fp)	# spill _tmp83 from $t2 to $fp-116
	# _tmp84 = _tmp82 < _tmp83
	  lw $t0, -112($fp)	# fill _tmp82 to $t0 from $fp-112
	  lw $t1, -116($fp)	# fill _tmp83 to $t1 from $fp-116
	  slt $t2, $t0, $t1	
	  sw $t2, -120($fp)	# spill _tmp84 from $t2 to $fp-120
	# IfZ _tmp84 Goto _L12
	  lw $t0, -120($fp)	# fill _tmp84 to $t0 from $fp-120
	  beqz $t0, _L12	# branch if _tmp84 is zero 
	# _tmp85 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string5	# load label
	  sw $t2, -124($fp)	# spill _tmp85 from $t2 to $fp-124
	# PushParam _tmp85
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -124($fp)	# fill _tmp85 to $t0 from $fp-124
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L12:
	# _tmp86 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -128($fp)	# spill _tmp86 from $t2 to $fp-128
	# _tmp87 = _tmp86 + _tmp82
	  lw $t0, -128($fp)	# fill _tmp86 to $t0 from $fp-128
	  lw $t1, -112($fp)	# fill _tmp82 to $t1 from $fp-112
	  add $t2, $t0, $t1	
	  sw $t2, -132($fp)	# spill _tmp87 from $t2 to $fp-132
	# _tmp88 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -136($fp)	# spill _tmp88 from $t2 to $fp-136
	# _tmp89 = _tmp87 * _tmp88
	  lw $t0, -132($fp)	# fill _tmp87 to $t0 from $fp-132
	  lw $t1, -136($fp)	# fill _tmp88 to $t1 from $fp-136
	  mul $t2, $t0, $t1	
	  sw $t2, -140($fp)	# spill _tmp89 from $t2 to $fp-140
	# PushParam _tmp89
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -140($fp)	# fill _tmp89 to $t0 from $fp-140
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp90 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -144($fp)	# spill _tmp90 from $t2 to $fp-144
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp90) = _tmp82
	  lw $t0, -112($fp)	# fill _tmp82 to $t0 from $fp-112
	  lw $t2, -144($fp)	# fill _tmp90 to $t2 from $fp-144
	  sw $t0, 0($t2) 	# store with offset
	# _tmp91 = _tmp90 + _tmp88
	  lw $t0, -144($fp)	# fill _tmp90 to $t0 from $fp-144
	  lw $t1, -136($fp)	# fill _tmp88 to $t1 from $fp-136
	  add $t2, $t0, $t1	
	  sw $t2, -148($fp)	# spill _tmp91 from $t2 to $fp-148
	# *(_tmp81) = _tmp91
	  lw $t0, -148($fp)	# fill _tmp91 to $t0 from $fp-148
	  lw $t2, -108($fp)	# fill _tmp81 to $t2 from $fp-108
	  sw $t0, 0($t2) 	# store with offset
	# _tmp92 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -152($fp)	# spill _tmp92 from $t2 to $fp-152
	# _tmp93 = i + _tmp92
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -152($fp)	# fill _tmp92 to $t1 from $fp-152
	  add $t2, $t0, $t1	
	  sw $t2, -156($fp)	# spill _tmp93 from $t2 to $fp-156
	# i = _tmp93
	  lw $t2, -156($fp)	# fill _tmp93 to $t2 from $fp-156
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L9
	  b _L9		# unconditional branch
  _L10:
	# _tmp94 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -160($fp)	# spill _tmp94 from $t2 to $fp-160
	# i = _tmp94
	  lw $t2, -160($fp)	# fill _tmp94 to $t2 from $fp-160
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L13:
	# _tmp95 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -164($fp)	# spill _tmp95 from $t2 to $fp-164
	# _tmp96 = i < _tmp95
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -164($fp)	# fill _tmp95 to $t1 from $fp-164
	  slt $t2, $t0, $t1	
	  sw $t2, -168($fp)	# spill _tmp96 from $t2 to $fp-168
	# IfZ _tmp96 Goto _L14
	  lw $t0, -168($fp)	# fill _tmp96 to $t0 from $fp-168
	  beqz $t0, _L14	# branch if _tmp96 is zero 
	# _tmp97 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -172($fp)	# spill _tmp97 from $t2 to $fp-172
	# j = _tmp97
	  lw $t2, -172($fp)	# fill _tmp97 to $t2 from $fp-172
	  sw $t2, -12($fp)	# spill j from $t2 to $fp-12
  _L15:
	# _tmp98 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -176($fp)	# spill _tmp98 from $t2 to $fp-176
	# _tmp99 = j < _tmp98
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -176($fp)	# fill _tmp98 to $t1 from $fp-176
	  slt $t2, $t0, $t1	
	  sw $t2, -180($fp)	# spill _tmp99 from $t2 to $fp-180
	# IfZ _tmp99 Goto _L16
	  lw $t0, -180($fp)	# fill _tmp99 to $t0 from $fp-180
	  beqz $t0, _L16	# branch if _tmp99 is zero 
	# _tmp100 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -184($fp)	# spill _tmp100 from $t2 to $fp-184
	# _tmp101 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -188($fp)	# spill _tmp101 from $t2 to $fp-188
	# _tmp102 = i < _tmp101
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -188($fp)	# fill _tmp101 to $t1 from $fp-188
	  slt $t2, $t0, $t1	
	  sw $t2, -192($fp)	# spill _tmp102 from $t2 to $fp-192
	# _tmp103 = *(_tmp100 + -4)
	  lw $t0, -184($fp)	# fill _tmp100 to $t0 from $fp-184
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -196($fp)	# spill _tmp103 from $t2 to $fp-196
	# _tmp104 = i < _tmp103
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -196($fp)	# fill _tmp103 to $t1 from $fp-196
	  slt $t2, $t0, $t1	
	  sw $t2, -200($fp)	# spill _tmp104 from $t2 to $fp-200
	# _tmp105 = _tmp104 == _tmp101
	  lw $t0, -200($fp)	# fill _tmp104 to $t0 from $fp-200
	  lw $t1, -188($fp)	# fill _tmp101 to $t1 from $fp-188
	  seq $t2, $t0, $t1	
	  sw $t2, -204($fp)	# spill _tmp105 from $t2 to $fp-204
	# _tmp106 = _tmp102 || _tmp105
	  lw $t0, -192($fp)	# fill _tmp102 to $t0 from $fp-192
	  lw $t1, -204($fp)	# fill _tmp105 to $t1 from $fp-204
	  or $t2, $t0, $t1	
	  sw $t2, -208($fp)	# spill _tmp106 from $t2 to $fp-208
	# IfZ _tmp106 Goto _L17
	  lw $t0, -208($fp)	# fill _tmp106 to $t0 from $fp-208
	  beqz $t0, _L17	# branch if _tmp106 is zero 
	# _tmp107 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string6	# load label
	  sw $t2, -212($fp)	# spill _tmp107 from $t2 to $fp-212
	# PushParam _tmp107
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -212($fp)	# fill _tmp107 to $t0 from $fp-212
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L17:
	# _tmp108 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -216($fp)	# spill _tmp108 from $t2 to $fp-216
	# _tmp109 = _tmp108 * i
	  lw $t0, -216($fp)	# fill _tmp108 to $t0 from $fp-216
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -220($fp)	# spill _tmp109 from $t2 to $fp-220
	# _tmp110 = _tmp100 + _tmp109
	  lw $t0, -184($fp)	# fill _tmp100 to $t0 from $fp-184
	  lw $t1, -220($fp)	# fill _tmp109 to $t1 from $fp-220
	  add $t2, $t0, $t1	
	  sw $t2, -224($fp)	# spill _tmp110 from $t2 to $fp-224
	# _tmp111 = *(_tmp110)
	  lw $t0, -224($fp)	# fill _tmp110 to $t0 from $fp-224
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -228($fp)	# spill _tmp111 from $t2 to $fp-228
	# _tmp112 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -232($fp)	# spill _tmp112 from $t2 to $fp-232
	# _tmp113 = j < _tmp112
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -232($fp)	# fill _tmp112 to $t1 from $fp-232
	  slt $t2, $t0, $t1	
	  sw $t2, -236($fp)	# spill _tmp113 from $t2 to $fp-236
	# _tmp114 = *(_tmp111 + -4)
	  lw $t0, -228($fp)	# fill _tmp111 to $t0 from $fp-228
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -240($fp)	# spill _tmp114 from $t2 to $fp-240
	# _tmp115 = j < _tmp114
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -240($fp)	# fill _tmp114 to $t1 from $fp-240
	  slt $t2, $t0, $t1	
	  sw $t2, -244($fp)	# spill _tmp115 from $t2 to $fp-244
	# _tmp116 = _tmp115 == _tmp112
	  lw $t0, -244($fp)	# fill _tmp115 to $t0 from $fp-244
	  lw $t1, -232($fp)	# fill _tmp112 to $t1 from $fp-232
	  seq $t2, $t0, $t1	
	  sw $t2, -248($fp)	# spill _tmp116 from $t2 to $fp-248
	# _tmp117 = _tmp113 || _tmp116
	  lw $t0, -236($fp)	# fill _tmp113 to $t0 from $fp-236
	  lw $t1, -248($fp)	# fill _tmp116 to $t1 from $fp-248
	  or $t2, $t0, $t1	
	  sw $t2, -252($fp)	# spill _tmp117 from $t2 to $fp-252
	# IfZ _tmp117 Goto _L18
	  lw $t0, -252($fp)	# fill _tmp117 to $t0 from $fp-252
	  beqz $t0, _L18	# branch if _tmp117 is zero 
	# _tmp118 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string7	# load label
	  sw $t2, -256($fp)	# spill _tmp118 from $t2 to $fp-256
	# PushParam _tmp118
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -256($fp)	# fill _tmp118 to $t0 from $fp-256
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L18:
	# _tmp119 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -260($fp)	# spill _tmp119 from $t2 to $fp-260
	# _tmp120 = _tmp119 * j
	  lw $t0, -260($fp)	# fill _tmp119 to $t0 from $fp-260
	  lw $t1, -12($fp)	# fill j to $t1 from $fp-12
	  mul $t2, $t0, $t1	
	  sw $t2, -264($fp)	# spill _tmp120 from $t2 to $fp-264
	# _tmp121 = _tmp111 + _tmp120
	  lw $t0, -228($fp)	# fill _tmp111 to $t0 from $fp-228
	  lw $t1, -264($fp)	# fill _tmp120 to $t1 from $fp-264
	  add $t2, $t0, $t1	
	  sw $t2, -268($fp)	# spill _tmp121 from $t2 to $fp-268
	# _tmp122 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -272($fp)	# spill _tmp122 from $t2 to $fp-272
	# *(_tmp121) = _tmp122
	  lw $t0, -272($fp)	# fill _tmp122 to $t0 from $fp-272
	  lw $t2, -268($fp)	# fill _tmp121 to $t2 from $fp-268
	  sw $t0, 0($t2) 	# store with offset
	# _tmp123 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -276($fp)	# spill _tmp123 from $t2 to $fp-276
	# _tmp124 = j + _tmp123
	  lw $t0, -12($fp)	# fill j to $t0 from $fp-12
	  lw $t1, -276($fp)	# fill _tmp123 to $t1 from $fp-276
	  add $t2, $t0, $t1	
	  sw $t2, -280($fp)	# spill _tmp124 from $t2 to $fp-280
	# j = _tmp124
	  lw $t2, -280($fp)	# fill _tmp124 to $t2 from $fp-280
	  sw $t2, -12($fp)	# spill j from $t2 to $fp-12
	# Goto _L15
	  b _L15		# unconditional branch
  _L16:
	# _tmp125 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -284($fp)	# spill _tmp125 from $t2 to $fp-284
	# _tmp126 = i + _tmp125
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -284($fp)	# fill _tmp125 to $t1 from $fp-284
	  add $t2, $t0, $t1	
	  sw $t2, -288($fp)	# spill _tmp126 from $t2 to $fp-288
	# i = _tmp126
	  lw $t2, -288($fp)	# fill _tmp126 to $t2 from $fp-288
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
  _DenseMatrix.Set:
	# BeginFunc 88
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 88	# decrement sp to make space for locals/temps
	# _tmp127 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp127 from $t2 to $fp-8
	# _tmp128 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp128 from $t2 to $fp-12
	# _tmp129 = x < _tmp128
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -12($fp)	# fill _tmp128 to $t1 from $fp-12
	  slt $t2, $t0, $t1	
	  sw $t2, -16($fp)	# spill _tmp129 from $t2 to $fp-16
	# _tmp130 = *(_tmp127 + -4)
	  lw $t0, -8($fp)	# fill _tmp127 to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp130 from $t2 to $fp-20
	# _tmp131 = x < _tmp130
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -20($fp)	# fill _tmp130 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp131 from $t2 to $fp-24
	# _tmp132 = _tmp131 == _tmp128
	  lw $t0, -24($fp)	# fill _tmp131 to $t0 from $fp-24
	  lw $t1, -12($fp)	# fill _tmp128 to $t1 from $fp-12
	  seq $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp132 from $t2 to $fp-28
	# _tmp133 = _tmp129 || _tmp132
	  lw $t0, -16($fp)	# fill _tmp129 to $t0 from $fp-16
	  lw $t1, -28($fp)	# fill _tmp132 to $t1 from $fp-28
	  or $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp133 from $t2 to $fp-32
	# IfZ _tmp133 Goto _L19
	  lw $t0, -32($fp)	# fill _tmp133 to $t0 from $fp-32
	  beqz $t0, _L19	# branch if _tmp133 is zero 
	# _tmp134 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string8	# load label
	  sw $t2, -36($fp)	# spill _tmp134 from $t2 to $fp-36
	# PushParam _tmp134
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -36($fp)	# fill _tmp134 to $t0 from $fp-36
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L19:
	# _tmp135 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -40($fp)	# spill _tmp135 from $t2 to $fp-40
	# _tmp136 = _tmp135 * x
	  lw $t0, -40($fp)	# fill _tmp135 to $t0 from $fp-40
	  lw $t1, 8($fp)	# fill x to $t1 from $fp+8
	  mul $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp136 from $t2 to $fp-44
	# _tmp137 = _tmp127 + _tmp136
	  lw $t0, -8($fp)	# fill _tmp127 to $t0 from $fp-8
	  lw $t1, -44($fp)	# fill _tmp136 to $t1 from $fp-44
	  add $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp137 from $t2 to $fp-48
	# _tmp138 = *(_tmp137)
	  lw $t0, -48($fp)	# fill _tmp137 to $t0 from $fp-48
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -52($fp)	# spill _tmp138 from $t2 to $fp-52
	# _tmp139 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp139 from $t2 to $fp-56
	# _tmp140 = y < _tmp139
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  lw $t1, -56($fp)	# fill _tmp139 to $t1 from $fp-56
	  slt $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp140 from $t2 to $fp-60
	# _tmp141 = *(_tmp138 + -4)
	  lw $t0, -52($fp)	# fill _tmp138 to $t0 from $fp-52
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp141 from $t2 to $fp-64
	# _tmp142 = y < _tmp141
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  lw $t1, -64($fp)	# fill _tmp141 to $t1 from $fp-64
	  slt $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp142 from $t2 to $fp-68
	# _tmp143 = _tmp142 == _tmp139
	  lw $t0, -68($fp)	# fill _tmp142 to $t0 from $fp-68
	  lw $t1, -56($fp)	# fill _tmp139 to $t1 from $fp-56
	  seq $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp143 from $t2 to $fp-72
	# _tmp144 = _tmp140 || _tmp143
	  lw $t0, -60($fp)	# fill _tmp140 to $t0 from $fp-60
	  lw $t1, -72($fp)	# fill _tmp143 to $t1 from $fp-72
	  or $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp144 from $t2 to $fp-76
	# IfZ _tmp144 Goto _L20
	  lw $t0, -76($fp)	# fill _tmp144 to $t0 from $fp-76
	  beqz $t0, _L20	# branch if _tmp144 is zero 
	# _tmp145 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string9	# load label
	  sw $t2, -80($fp)	# spill _tmp145 from $t2 to $fp-80
	# PushParam _tmp145
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -80($fp)	# fill _tmp145 to $t0 from $fp-80
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L20:
	# _tmp146 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -84($fp)	# spill _tmp146 from $t2 to $fp-84
	# _tmp147 = _tmp146 * y
	  lw $t0, -84($fp)	# fill _tmp146 to $t0 from $fp-84
	  lw $t1, 12($fp)	# fill y to $t1 from $fp+12
	  mul $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp147 from $t2 to $fp-88
	# _tmp148 = _tmp138 + _tmp147
	  lw $t0, -52($fp)	# fill _tmp138 to $t0 from $fp-52
	  lw $t1, -88($fp)	# fill _tmp147 to $t1 from $fp-88
	  add $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp148 from $t2 to $fp-92
	# *(_tmp148) = value
	  lw $t0, 16($fp)	# fill value to $t0 from $fp+16
	  lw $t2, -92($fp)	# fill _tmp148 to $t2 from $fp-92
	  sw $t0, 0($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _DenseMatrix.Get:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	# _tmp149 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp149 from $t2 to $fp-8
	# _tmp150 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp150 from $t2 to $fp-12
	# _tmp151 = x < _tmp150
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -12($fp)	# fill _tmp150 to $t1 from $fp-12
	  slt $t2, $t0, $t1	
	  sw $t2, -16($fp)	# spill _tmp151 from $t2 to $fp-16
	# _tmp152 = *(_tmp149 + -4)
	  lw $t0, -8($fp)	# fill _tmp149 to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp152 from $t2 to $fp-20
	# _tmp153 = x < _tmp152
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -20($fp)	# fill _tmp152 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp153 from $t2 to $fp-24
	# _tmp154 = _tmp153 == _tmp150
	  lw $t0, -24($fp)	# fill _tmp153 to $t0 from $fp-24
	  lw $t1, -12($fp)	# fill _tmp150 to $t1 from $fp-12
	  seq $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp154 from $t2 to $fp-28
	# _tmp155 = _tmp151 || _tmp154
	  lw $t0, -16($fp)	# fill _tmp151 to $t0 from $fp-16
	  lw $t1, -28($fp)	# fill _tmp154 to $t1 from $fp-28
	  or $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp155 from $t2 to $fp-32
	# IfZ _tmp155 Goto _L21
	  lw $t0, -32($fp)	# fill _tmp155 to $t0 from $fp-32
	  beqz $t0, _L21	# branch if _tmp155 is zero 
	# _tmp156 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string10	# load label
	  sw $t2, -36($fp)	# spill _tmp156 from $t2 to $fp-36
	# PushParam _tmp156
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -36($fp)	# fill _tmp156 to $t0 from $fp-36
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L21:
	# _tmp157 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -40($fp)	# spill _tmp157 from $t2 to $fp-40
	# _tmp158 = _tmp157 * x
	  lw $t0, -40($fp)	# fill _tmp157 to $t0 from $fp-40
	  lw $t1, 8($fp)	# fill x to $t1 from $fp+8
	  mul $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp158 from $t2 to $fp-44
	# _tmp159 = _tmp149 + _tmp158
	  lw $t0, -8($fp)	# fill _tmp149 to $t0 from $fp-8
	  lw $t1, -44($fp)	# fill _tmp158 to $t1 from $fp-44
	  add $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp159 from $t2 to $fp-48
	# _tmp160 = *(_tmp159)
	  lw $t0, -48($fp)	# fill _tmp159 to $t0 from $fp-48
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -52($fp)	# spill _tmp160 from $t2 to $fp-52
	# _tmp161 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp161 from $t2 to $fp-56
	# _tmp162 = y < _tmp161
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  lw $t1, -56($fp)	# fill _tmp161 to $t1 from $fp-56
	  slt $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp162 from $t2 to $fp-60
	# _tmp163 = *(_tmp160 + -4)
	  lw $t0, -52($fp)	# fill _tmp160 to $t0 from $fp-52
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp163 from $t2 to $fp-64
	# _tmp164 = y < _tmp163
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  lw $t1, -64($fp)	# fill _tmp163 to $t1 from $fp-64
	  slt $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp164 from $t2 to $fp-68
	# _tmp165 = _tmp164 == _tmp161
	  lw $t0, -68($fp)	# fill _tmp164 to $t0 from $fp-68
	  lw $t1, -56($fp)	# fill _tmp161 to $t1 from $fp-56
	  seq $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp165 from $t2 to $fp-72
	# _tmp166 = _tmp162 || _tmp165
	  lw $t0, -60($fp)	# fill _tmp162 to $t0 from $fp-60
	  lw $t1, -72($fp)	# fill _tmp165 to $t1 from $fp-72
	  or $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp166 from $t2 to $fp-76
	# IfZ _tmp166 Goto _L22
	  lw $t0, -76($fp)	# fill _tmp166 to $t0 from $fp-76
	  beqz $t0, _L22	# branch if _tmp166 is zero 
	# _tmp167 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string11	# load label
	  sw $t2, -80($fp)	# spill _tmp167 from $t2 to $fp-80
	# PushParam _tmp167
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -80($fp)	# fill _tmp167 to $t0 from $fp-80
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L22:
	# _tmp168 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -84($fp)	# spill _tmp168 from $t2 to $fp-84
	# _tmp169 = _tmp168 * y
	  lw $t0, -84($fp)	# fill _tmp168 to $t0 from $fp-84
	  lw $t1, 12($fp)	# fill y to $t1 from $fp+12
	  mul $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp169 from $t2 to $fp-88
	# _tmp170 = _tmp160 + _tmp169
	  lw $t0, -52($fp)	# fill _tmp160 to $t0 from $fp-52
	  lw $t1, -88($fp)	# fill _tmp169 to $t1 from $fp-88
	  add $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp170 from $t2 to $fp-92
	# _tmp171 = *(_tmp170)
	  lw $t0, -92($fp)	# fill _tmp170 to $t0 from $fp-92
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp171 from $t2 to $fp-96
	# Return _tmp171
	  lw $t2, -96($fp)	# fill _tmp171 to $t2 from $fp-96
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
	# VTable for class DenseMatrix
	  .data
	  .align 2
	  DenseMatrix:		# label for class DenseMatrix vtable
	  .word _DenseMatrix.Init
	  .word _DenseMatrix.Set
	  .word _DenseMatrix.Get
	  .word _Matrix.PrintMatrix
	  .word _Matrix.SeedMatrix
	  .text
  _SparseItem.Init:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# *(this + 4) = d
	  lw $t0, 8($fp)	# fill d to $t0 from $fp+8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# *(this + 8) = y
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# *(this + 12) = next
	  lw $t0, 16($fp)	# fill next to $t0 from $fp+16
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 12($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _SparseItem.GetNext:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp172 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp172 from $t2 to $fp-8
	# Return _tmp172
	  lw $t2, -8($fp)	# fill _tmp172 to $t2 from $fp-8
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
  _SparseItem.GetY:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp173 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp173 from $t2 to $fp-8
	# Return _tmp173
	  lw $t2, -8($fp)	# fill _tmp173 to $t2 from $fp-8
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
  _SparseItem.GetData:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp174 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp174 from $t2 to $fp-8
	# Return _tmp174
	  lw $t2, -8($fp)	# fill _tmp174 to $t2 from $fp-8
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
  _SparseItem.SetData:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# *(this + 4) = val
	  lw $t0, 8($fp)	# fill val to $t0 from $fp+8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class SparseItem
	  .data
	  .align 2
	  SparseItem:		# label for class SparseItem vtable
	  .word _SparseItem.Init
	  .word _SparseItem.GetNext
	  .word _SparseItem.GetY
	  .word _SparseItem.GetData
	  .word _SparseItem.SetData
	  .text
  _SparseMatrix.Init:
	# BeginFunc 112
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 112	# decrement sp to make space for locals/temps
	# _tmp175 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -12($fp)	# spill _tmp175 from $t2 to $fp-12
	# _tmp176 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp176 from $t2 to $fp-16
	# _tmp177 = _tmp175 < _tmp176
	  lw $t0, -12($fp)	# fill _tmp175 to $t0 from $fp-12
	  lw $t1, -16($fp)	# fill _tmp176 to $t1 from $fp-16
	  slt $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp177 from $t2 to $fp-20
	# IfZ _tmp177 Goto _L23
	  lw $t0, -20($fp)	# fill _tmp177 to $t0 from $fp-20
	  beqz $t0, _L23	# branch if _tmp177 is zero 
	# _tmp178 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string12: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string12	# load label
	  sw $t2, -24($fp)	# spill _tmp178 from $t2 to $fp-24
	# PushParam _tmp178
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -24($fp)	# fill _tmp178 to $t0 from $fp-24
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L23:
	# _tmp179 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -28($fp)	# spill _tmp179 from $t2 to $fp-28
	# _tmp180 = _tmp179 + _tmp175
	  lw $t0, -28($fp)	# fill _tmp179 to $t0 from $fp-28
	  lw $t1, -12($fp)	# fill _tmp175 to $t1 from $fp-12
	  add $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp180 from $t2 to $fp-32
	# _tmp181 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -36($fp)	# spill _tmp181 from $t2 to $fp-36
	# _tmp182 = _tmp180 * _tmp181
	  lw $t0, -32($fp)	# fill _tmp180 to $t0 from $fp-32
	  lw $t1, -36($fp)	# fill _tmp181 to $t1 from $fp-36
	  mul $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp182 from $t2 to $fp-40
	# PushParam _tmp182
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -40($fp)	# fill _tmp182 to $t0 from $fp-40
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp183 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -44($fp)	# spill _tmp183 from $t2 to $fp-44
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp183) = _tmp175
	  lw $t0, -12($fp)	# fill _tmp175 to $t0 from $fp-12
	  lw $t2, -44($fp)	# fill _tmp183 to $t2 from $fp-44
	  sw $t0, 0($t2) 	# store with offset
	# _tmp184 = _tmp183 + _tmp181
	  lw $t0, -44($fp)	# fill _tmp183 to $t0 from $fp-44
	  lw $t1, -36($fp)	# fill _tmp181 to $t1 from $fp-36
	  add $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp184 from $t2 to $fp-48
	# *(this + 4) = _tmp184
	  lw $t0, -48($fp)	# fill _tmp184 to $t0 from $fp-48
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp185 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -52($fp)	# spill _tmp185 from $t2 to $fp-52
	# i = _tmp185
	  lw $t2, -52($fp)	# fill _tmp185 to $t2 from $fp-52
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L24:
	# _tmp186 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -56($fp)	# spill _tmp186 from $t2 to $fp-56
	# _tmp187 = i < _tmp186
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -56($fp)	# fill _tmp186 to $t1 from $fp-56
	  slt $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp187 from $t2 to $fp-60
	# IfZ _tmp187 Goto _L25
	  lw $t0, -60($fp)	# fill _tmp187 to $t0 from $fp-60
	  beqz $t0, _L25	# branch if _tmp187 is zero 
	# _tmp188 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp188 from $t2 to $fp-64
	# _tmp189 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -68($fp)	# spill _tmp189 from $t2 to $fp-68
	# _tmp190 = i < _tmp189
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -68($fp)	# fill _tmp189 to $t1 from $fp-68
	  slt $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp190 from $t2 to $fp-72
	# _tmp191 = *(_tmp188 + -4)
	  lw $t0, -64($fp)	# fill _tmp188 to $t0 from $fp-64
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp191 from $t2 to $fp-76
	# _tmp192 = i < _tmp191
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -76($fp)	# fill _tmp191 to $t1 from $fp-76
	  slt $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp192 from $t2 to $fp-80
	# _tmp193 = _tmp192 == _tmp189
	  lw $t0, -80($fp)	# fill _tmp192 to $t0 from $fp-80
	  lw $t1, -68($fp)	# fill _tmp189 to $t1 from $fp-68
	  seq $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp193 from $t2 to $fp-84
	# _tmp194 = _tmp190 || _tmp193
	  lw $t0, -72($fp)	# fill _tmp190 to $t0 from $fp-72
	  lw $t1, -84($fp)	# fill _tmp193 to $t1 from $fp-84
	  or $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp194 from $t2 to $fp-88
	# IfZ _tmp194 Goto _L26
	  lw $t0, -88($fp)	# fill _tmp194 to $t0 from $fp-88
	  beqz $t0, _L26	# branch if _tmp194 is zero 
	# _tmp195 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string13: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string13	# load label
	  sw $t2, -92($fp)	# spill _tmp195 from $t2 to $fp-92
	# PushParam _tmp195
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -92($fp)	# fill _tmp195 to $t0 from $fp-92
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L26:
	# _tmp196 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -96($fp)	# spill _tmp196 from $t2 to $fp-96
	# _tmp197 = _tmp196 * i
	  lw $t0, -96($fp)	# fill _tmp196 to $t0 from $fp-96
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp197 from $t2 to $fp-100
	# _tmp198 = _tmp188 + _tmp197
	  lw $t0, -64($fp)	# fill _tmp188 to $t0 from $fp-64
	  lw $t1, -100($fp)	# fill _tmp197 to $t1 from $fp-100
	  add $t2, $t0, $t1	
	  sw $t2, -104($fp)	# spill _tmp198 from $t2 to $fp-104
	# _tmp199 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -108($fp)	# spill _tmp199 from $t2 to $fp-108
	# *(_tmp198) = _tmp199
	  lw $t0, -108($fp)	# fill _tmp199 to $t0 from $fp-108
	  lw $t2, -104($fp)	# fill _tmp198 to $t2 from $fp-104
	  sw $t0, 0($t2) 	# store with offset
	# _tmp200 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -112($fp)	# spill _tmp200 from $t2 to $fp-112
	# _tmp201 = i + _tmp200
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -112($fp)	# fill _tmp200 to $t1 from $fp-112
	  add $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp201 from $t2 to $fp-116
	# i = _tmp201
	  lw $t2, -116($fp)	# fill _tmp201 to $t2 from $fp-116
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L24
	  b _L24		# unconditional branch
  _L25:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _SparseMatrix.Find:
	# BeginFunc 100
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 100	# decrement sp to make space for locals/temps
	# _tmp202 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp202 from $t2 to $fp-12
	# _tmp203 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp203 from $t2 to $fp-16
	# _tmp204 = x < _tmp203
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -16($fp)	# fill _tmp203 to $t1 from $fp-16
	  slt $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp204 from $t2 to $fp-20
	# _tmp205 = *(_tmp202 + -4)
	  lw $t0, -12($fp)	# fill _tmp202 to $t0 from $fp-12
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp205 from $t2 to $fp-24
	# _tmp206 = x < _tmp205
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -24($fp)	# fill _tmp205 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp206 from $t2 to $fp-28
	# _tmp207 = _tmp206 == _tmp203
	  lw $t0, -28($fp)	# fill _tmp206 to $t0 from $fp-28
	  lw $t1, -16($fp)	# fill _tmp203 to $t1 from $fp-16
	  seq $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp207 from $t2 to $fp-32
	# _tmp208 = _tmp204 || _tmp207
	  lw $t0, -20($fp)	# fill _tmp204 to $t0 from $fp-20
	  lw $t1, -32($fp)	# fill _tmp207 to $t1 from $fp-32
	  or $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp208 from $t2 to $fp-36
	# IfZ _tmp208 Goto _L27
	  lw $t0, -36($fp)	# fill _tmp208 to $t0 from $fp-36
	  beqz $t0, _L27	# branch if _tmp208 is zero 
	# _tmp209 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string14: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string14	# load label
	  sw $t2, -40($fp)	# spill _tmp209 from $t2 to $fp-40
	# PushParam _tmp209
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -40($fp)	# fill _tmp209 to $t0 from $fp-40
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L27:
	# _tmp210 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -44($fp)	# spill _tmp210 from $t2 to $fp-44
	# _tmp211 = _tmp210 * x
	  lw $t0, -44($fp)	# fill _tmp210 to $t0 from $fp-44
	  lw $t1, 8($fp)	# fill x to $t1 from $fp+8
	  mul $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp211 from $t2 to $fp-48
	# _tmp212 = _tmp202 + _tmp211
	  lw $t0, -12($fp)	# fill _tmp202 to $t0 from $fp-12
	  lw $t1, -48($fp)	# fill _tmp211 to $t1 from $fp-48
	  add $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp212 from $t2 to $fp-52
	# _tmp213 = *(_tmp212)
	  lw $t0, -52($fp)	# fill _tmp212 to $t0 from $fp-52
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -56($fp)	# spill _tmp213 from $t2 to $fp-56
	# elem = _tmp213
	  lw $t2, -56($fp)	# fill _tmp213 to $t2 from $fp-56
	  sw $t2, -8($fp)	# spill elem from $t2 to $fp-8
  _L28:
	# _tmp214 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -60($fp)	# spill _tmp214 from $t2 to $fp-60
	# _tmp215 = elem == _tmp214
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t1, -60($fp)	# fill _tmp214 to $t1 from $fp-60
	  seq $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp215 from $t2 to $fp-64
	# _tmp216 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -68($fp)	# spill _tmp216 from $t2 to $fp-68
	# _tmp217 = _tmp215 == _tmp216
	  lw $t0, -64($fp)	# fill _tmp215 to $t0 from $fp-64
	  lw $t1, -68($fp)	# fill _tmp216 to $t1 from $fp-68
	  seq $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp217 from $t2 to $fp-72
	# IfZ _tmp217 Goto _L29
	  lw $t0, -72($fp)	# fill _tmp217 to $t0 from $fp-72
	  beqz $t0, _L29	# branch if _tmp217 is zero 
	# _tmp218 = *(elem)
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp218 from $t2 to $fp-76
	# _tmp219 = *(_tmp218 + 8)
	  lw $t0, -76($fp)	# fill _tmp218 to $t0 from $fp-76
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp219 from $t2 to $fp-80
	# PushParam elem
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp220 = ACall _tmp219
	  lw $t0, -80($fp)	# fill _tmp219 to $t0 from $fp-80
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -84($fp)	# spill _tmp220 from $t2 to $fp-84
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp221 = _tmp220 == y
	  lw $t0, -84($fp)	# fill _tmp220 to $t0 from $fp-84
	  lw $t1, 12($fp)	# fill y to $t1 from $fp+12
	  seq $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp221 from $t2 to $fp-88
	# IfZ _tmp221 Goto _L30
	  lw $t0, -88($fp)	# fill _tmp221 to $t0 from $fp-88
	  beqz $t0, _L30	# branch if _tmp221 is zero 
	# Return elem
	  lw $t2, -8($fp)	# fill elem to $t2 from $fp-8
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L30:
	# _tmp222 = *(elem)
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp222 from $t2 to $fp-92
	# _tmp223 = *(_tmp222 + 4)
	  lw $t0, -92($fp)	# fill _tmp222 to $t0 from $fp-92
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp223 from $t2 to $fp-96
	# PushParam elem
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp224 = ACall _tmp223
	  lw $t0, -96($fp)	# fill _tmp223 to $t0 from $fp-96
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -100($fp)	# spill _tmp224 from $t2 to $fp-100
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# elem = _tmp224
	  lw $t2, -100($fp)	# fill _tmp224 to $t2 from $fp-100
	  sw $t2, -8($fp)	# spill elem from $t2 to $fp-8
	# Goto _L28
	  b _L28		# unconditional branch
  _L29:
	# _tmp225 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -104($fp)	# spill _tmp225 from $t2 to $fp-104
	# Return _tmp225
	  lw $t2, -104($fp)	# fill _tmp225 to $t2 from $fp-104
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
  _SparseMatrix.Set:
	# BeginFunc 152
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 152	# decrement sp to make space for locals/temps
	# _tmp226 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp226 from $t2 to $fp-12
	# _tmp227 = *(_tmp226 + 20)
	  lw $t0, -12($fp)	# fill _tmp226 to $t0 from $fp-12
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp227 from $t2 to $fp-16
	# PushParam y
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam x
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp228 = ACall _tmp227
	  lw $t0, -16($fp)	# fill _tmp227 to $t0 from $fp-16
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp228 from $t2 to $fp-20
	# PopParams 12
	  add $sp, $sp, 12	# pop params off stack
	# elem = _tmp228
	  lw $t2, -20($fp)	# fill _tmp228 to $t2 from $fp-20
	  sw $t2, -8($fp)	# spill elem from $t2 to $fp-8
	# _tmp229 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -24($fp)	# spill _tmp229 from $t2 to $fp-24
	# _tmp230 = elem == _tmp229
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t1, -24($fp)	# fill _tmp229 to $t1 from $fp-24
	  seq $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp230 from $t2 to $fp-28
	# _tmp231 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp231 from $t2 to $fp-32
	# _tmp232 = _tmp230 == _tmp231
	  lw $t0, -28($fp)	# fill _tmp230 to $t0 from $fp-28
	  lw $t1, -32($fp)	# fill _tmp231 to $t1 from $fp-32
	  seq $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp232 from $t2 to $fp-36
	# IfZ _tmp232 Goto _L31
	  lw $t0, -36($fp)	# fill _tmp232 to $t0 from $fp-36
	  beqz $t0, _L31	# branch if _tmp232 is zero 
	# _tmp233 = *(elem)
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp233 from $t2 to $fp-40
	# _tmp234 = *(_tmp233 + 16)
	  lw $t0, -40($fp)	# fill _tmp233 to $t0 from $fp-40
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp234 from $t2 to $fp-44
	# PushParam value
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 16($fp)	# fill value to $t0 from $fp+16
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam elem
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp234
	  lw $t0, -44($fp)	# fill _tmp234 to $t0 from $fp-44
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L32
	  b _L32		# unconditional branch
  _L31:
	# _tmp235 = 16
	  li $t2, 16		# load constant value 16 into $t2
	  sw $t2, -48($fp)	# spill _tmp235 from $t2 to $fp-48
	# PushParam _tmp235
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -48($fp)	# fill _tmp235 to $t0 from $fp-48
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp236 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -52($fp)	# spill _tmp236 from $t2 to $fp-52
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp237 = SparseItem
	  la $t2, SparseItem	# load label
	  sw $t2, -56($fp)	# spill _tmp237 from $t2 to $fp-56
	# *(_tmp236) = _tmp237
	  lw $t0, -56($fp)	# fill _tmp237 to $t0 from $fp-56
	  lw $t2, -52($fp)	# fill _tmp236 to $t2 from $fp-52
	  sw $t0, 0($t2) 	# store with offset
	# elem = _tmp236
	  lw $t2, -52($fp)	# fill _tmp236 to $t2 from $fp-52
	  sw $t2, -8($fp)	# spill elem from $t2 to $fp-8
	# _tmp238 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -60($fp)	# spill _tmp238 from $t2 to $fp-60
	# _tmp239 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -64($fp)	# spill _tmp239 from $t2 to $fp-64
	# _tmp240 = x < _tmp239
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -64($fp)	# fill _tmp239 to $t1 from $fp-64
	  slt $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp240 from $t2 to $fp-68
	# _tmp241 = *(_tmp238 + -4)
	  lw $t0, -60($fp)	# fill _tmp238 to $t0 from $fp-60
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp241 from $t2 to $fp-72
	# _tmp242 = x < _tmp241
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -72($fp)	# fill _tmp241 to $t1 from $fp-72
	  slt $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp242 from $t2 to $fp-76
	# _tmp243 = _tmp242 == _tmp239
	  lw $t0, -76($fp)	# fill _tmp242 to $t0 from $fp-76
	  lw $t1, -64($fp)	# fill _tmp239 to $t1 from $fp-64
	  seq $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp243 from $t2 to $fp-80
	# _tmp244 = _tmp240 || _tmp243
	  lw $t0, -68($fp)	# fill _tmp240 to $t0 from $fp-68
	  lw $t1, -80($fp)	# fill _tmp243 to $t1 from $fp-80
	  or $t2, $t0, $t1	
	  sw $t2, -84($fp)	# spill _tmp244 from $t2 to $fp-84
	# IfZ _tmp244 Goto _L33
	  lw $t0, -84($fp)	# fill _tmp244 to $t0 from $fp-84
	  beqz $t0, _L33	# branch if _tmp244 is zero 
	# _tmp245 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string15: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string15	# load label
	  sw $t2, -88($fp)	# spill _tmp245 from $t2 to $fp-88
	# PushParam _tmp245
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -88($fp)	# fill _tmp245 to $t0 from $fp-88
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L33:
	# _tmp246 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -92($fp)	# spill _tmp246 from $t2 to $fp-92
	# _tmp247 = _tmp246 * x
	  lw $t0, -92($fp)	# fill _tmp246 to $t0 from $fp-92
	  lw $t1, 8($fp)	# fill x to $t1 from $fp+8
	  mul $t2, $t0, $t1	
	  sw $t2, -96($fp)	# spill _tmp247 from $t2 to $fp-96
	# _tmp248 = _tmp238 + _tmp247
	  lw $t0, -60($fp)	# fill _tmp238 to $t0 from $fp-60
	  lw $t1, -96($fp)	# fill _tmp247 to $t1 from $fp-96
	  add $t2, $t0, $t1	
	  sw $t2, -100($fp)	# spill _tmp248 from $t2 to $fp-100
	# _tmp249 = *(_tmp248)
	  lw $t0, -100($fp)	# fill _tmp248 to $t0 from $fp-100
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp249 from $t2 to $fp-104
	# _tmp250 = *(elem)
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -108($fp)	# spill _tmp250 from $t2 to $fp-108
	# _tmp251 = *(_tmp250)
	  lw $t0, -108($fp)	# fill _tmp250 to $t0 from $fp-108
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -112($fp)	# spill _tmp251 from $t2 to $fp-112
	# PushParam _tmp249
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -104($fp)	# fill _tmp249 to $t0 from $fp-104
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam y
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam value
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 16($fp)	# fill value to $t0 from $fp+16
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam elem
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp251
	  lw $t0, -112($fp)	# fill _tmp251 to $t0 from $fp-112
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# _tmp252 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -116($fp)	# spill _tmp252 from $t2 to $fp-116
	# _tmp253 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -120($fp)	# spill _tmp253 from $t2 to $fp-120
	# _tmp254 = x < _tmp253
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -120($fp)	# fill _tmp253 to $t1 from $fp-120
	  slt $t2, $t0, $t1	
	  sw $t2, -124($fp)	# spill _tmp254 from $t2 to $fp-124
	# _tmp255 = *(_tmp252 + -4)
	  lw $t0, -116($fp)	# fill _tmp252 to $t0 from $fp-116
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -128($fp)	# spill _tmp255 from $t2 to $fp-128
	# _tmp256 = x < _tmp255
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  lw $t1, -128($fp)	# fill _tmp255 to $t1 from $fp-128
	  slt $t2, $t0, $t1	
	  sw $t2, -132($fp)	# spill _tmp256 from $t2 to $fp-132
	# _tmp257 = _tmp256 == _tmp253
	  lw $t0, -132($fp)	# fill _tmp256 to $t0 from $fp-132
	  lw $t1, -120($fp)	# fill _tmp253 to $t1 from $fp-120
	  seq $t2, $t0, $t1	
	  sw $t2, -136($fp)	# spill _tmp257 from $t2 to $fp-136
	# _tmp258 = _tmp254 || _tmp257
	  lw $t0, -124($fp)	# fill _tmp254 to $t0 from $fp-124
	  lw $t1, -136($fp)	# fill _tmp257 to $t1 from $fp-136
	  or $t2, $t0, $t1	
	  sw $t2, -140($fp)	# spill _tmp258 from $t2 to $fp-140
	# IfZ _tmp258 Goto _L34
	  lw $t0, -140($fp)	# fill _tmp258 to $t0 from $fp-140
	  beqz $t0, _L34	# branch if _tmp258 is zero 
	# _tmp259 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string16: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string16	# load label
	  sw $t2, -144($fp)	# spill _tmp259 from $t2 to $fp-144
	# PushParam _tmp259
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -144($fp)	# fill _tmp259 to $t0 from $fp-144
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L34:
	# _tmp260 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -148($fp)	# spill _tmp260 from $t2 to $fp-148
	# _tmp261 = _tmp260 * x
	  lw $t0, -148($fp)	# fill _tmp260 to $t0 from $fp-148
	  lw $t1, 8($fp)	# fill x to $t1 from $fp+8
	  mul $t2, $t0, $t1	
	  sw $t2, -152($fp)	# spill _tmp261 from $t2 to $fp-152
	# _tmp262 = _tmp252 + _tmp261
	  lw $t0, -116($fp)	# fill _tmp252 to $t0 from $fp-116
	  lw $t1, -152($fp)	# fill _tmp261 to $t1 from $fp-152
	  add $t2, $t0, $t1	
	  sw $t2, -156($fp)	# spill _tmp262 from $t2 to $fp-156
	# *(_tmp262) = elem
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t2, -156($fp)	# fill _tmp262 to $t2 from $fp-156
	  sw $t0, 0($t2) 	# store with offset
  _L32:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _SparseMatrix.Get:
	# BeginFunc 48
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 48	# decrement sp to make space for locals/temps
	# _tmp263 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp263 from $t2 to $fp-12
	# _tmp264 = *(_tmp263 + 20)
	  lw $t0, -12($fp)	# fill _tmp263 to $t0 from $fp-12
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp264 from $t2 to $fp-16
	# PushParam y
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 12($fp)	# fill y to $t0 from $fp+12
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam x
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill x to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp265 = ACall _tmp264
	  lw $t0, -16($fp)	# fill _tmp264 to $t0 from $fp-16
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp265 from $t2 to $fp-20
	# PopParams 12
	  add $sp, $sp, 12	# pop params off stack
	# elem = _tmp265
	  lw $t2, -20($fp)	# fill _tmp265 to $t2 from $fp-20
	  sw $t2, -8($fp)	# spill elem from $t2 to $fp-8
	# _tmp266 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -24($fp)	# spill _tmp266 from $t2 to $fp-24
	# _tmp267 = elem == _tmp266
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t1, -24($fp)	# fill _tmp266 to $t1 from $fp-24
	  seq $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp267 from $t2 to $fp-28
	# _tmp268 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -32($fp)	# spill _tmp268 from $t2 to $fp-32
	# _tmp269 = _tmp267 == _tmp268
	  lw $t0, -28($fp)	# fill _tmp267 to $t0 from $fp-28
	  lw $t1, -32($fp)	# fill _tmp268 to $t1 from $fp-32
	  seq $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp269 from $t2 to $fp-36
	# IfZ _tmp269 Goto _L35
	  lw $t0, -36($fp)	# fill _tmp269 to $t0 from $fp-36
	  beqz $t0, _L35	# branch if _tmp269 is zero 
	# _tmp270 = *(elem)
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp270 from $t2 to $fp-40
	# _tmp271 = *(_tmp270 + 12)
	  lw $t0, -40($fp)	# fill _tmp270 to $t0 from $fp-40
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp271 from $t2 to $fp-44
	# PushParam elem
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill elem to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp272 = ACall _tmp271
	  lw $t0, -44($fp)	# fill _tmp271 to $t0 from $fp-44
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -48($fp)	# spill _tmp272 from $t2 to $fp-48
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Return _tmp272
	  lw $t2, -48($fp)	# fill _tmp272 to $t2 from $fp-48
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# Goto _L36
	  b _L36		# unconditional branch
  _L35:
	# _tmp273 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -52($fp)	# spill _tmp273 from $t2 to $fp-52
	# Return _tmp273
	  lw $t2, -52($fp)	# fill _tmp273 to $t2 from $fp-52
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L36:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class SparseMatrix
	  .data
	  .align 2
	  SparseMatrix:		# label for class SparseMatrix vtable
	  .word _SparseMatrix.Init
	  .word _SparseMatrix.Set
	  .word _SparseMatrix.Get
	  .word _Matrix.PrintMatrix
	  .word _Matrix.SeedMatrix
	  .word _SparseMatrix.Find
	  .text
  main:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	# _tmp274 = "Dense Rep \n"
	  .data			# create string constant marked with label
	  _string17: .asciiz "Dense Rep \n"
	  .text
	  la $t2, _string17	# load label
	  sw $t2, -12($fp)	# spill _tmp274 from $t2 to $fp-12
	# PushParam _tmp274
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp274 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp275 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -16($fp)	# spill _tmp275 from $t2 to $fp-16
	# PushParam _tmp275
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp275 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp276 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp276 from $t2 to $fp-20
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp277 = DenseMatrix
	  la $t2, DenseMatrix	# load label
	  sw $t2, -24($fp)	# spill _tmp277 from $t2 to $fp-24
	# *(_tmp276) = _tmp277
	  lw $t0, -24($fp)	# fill _tmp277 to $t0 from $fp-24
	  lw $t2, -20($fp)	# fill _tmp276 to $t2 from $fp-20
	  sw $t0, 0($t2) 	# store with offset
	# m = _tmp276
	  lw $t2, -20($fp)	# fill _tmp276 to $t2 from $fp-20
	  sw $t2, -8($fp)	# spill m from $t2 to $fp-8
	# _tmp278 = *(m)
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp278 from $t2 to $fp-28
	# _tmp279 = *(_tmp278)
	  lw $t0, -28($fp)	# fill _tmp278 to $t0 from $fp-28
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp279 from $t2 to $fp-32
	# PushParam m
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp279
	  lw $t0, -32($fp)	# fill _tmp279 to $t0 from $fp-32
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp280 = *(m)
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp280 from $t2 to $fp-36
	# _tmp281 = *(_tmp280 + 16)
	  lw $t0, -36($fp)	# fill _tmp280 to $t0 from $fp-36
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp281 from $t2 to $fp-40
	# PushParam m
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp281
	  lw $t0, -40($fp)	# fill _tmp281 to $t0 from $fp-40
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp282 = *(m)
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp282 from $t2 to $fp-44
	# _tmp283 = *(_tmp282 + 12)
	  lw $t0, -44($fp)	# fill _tmp282 to $t0 from $fp-44
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp283 from $t2 to $fp-48
	# PushParam m
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp283
	  lw $t0, -48($fp)	# fill _tmp283 to $t0 from $fp-48
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp284 = "Sparse Rep \n"
	  .data			# create string constant marked with label
	  _string18: .asciiz "Sparse Rep \n"
	  .text
	  la $t2, _string18	# load label
	  sw $t2, -52($fp)	# spill _tmp284 from $t2 to $fp-52
	# PushParam _tmp284
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -52($fp)	# fill _tmp284 to $t0 from $fp-52
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp285 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -56($fp)	# spill _tmp285 from $t2 to $fp-56
	# PushParam _tmp285
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -56($fp)	# fill _tmp285 to $t0 from $fp-56
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp286 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -60($fp)	# spill _tmp286 from $t2 to $fp-60
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp287 = SparseMatrix
	  la $t2, SparseMatrix	# load label
	  sw $t2, -64($fp)	# spill _tmp287 from $t2 to $fp-64
	# *(_tmp286) = _tmp287
	  lw $t0, -64($fp)	# fill _tmp287 to $t0 from $fp-64
	  lw $t2, -60($fp)	# fill _tmp286 to $t2 from $fp-60
	  sw $t0, 0($t2) 	# store with offset
	# m = _tmp286
	  lw $t2, -60($fp)	# fill _tmp286 to $t2 from $fp-60
	  sw $t2, -8($fp)	# spill m from $t2 to $fp-8
	# _tmp288 = *(m)
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp288 from $t2 to $fp-68
	# _tmp289 = *(_tmp288)
	  lw $t0, -68($fp)	# fill _tmp288 to $t0 from $fp-68
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -72($fp)	# spill _tmp289 from $t2 to $fp-72
	# PushParam m
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp289
	  lw $t0, -72($fp)	# fill _tmp289 to $t0 from $fp-72
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp290 = *(m)
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp290 from $t2 to $fp-76
	# _tmp291 = *(_tmp290 + 16)
	  lw $t0, -76($fp)	# fill _tmp290 to $t0 from $fp-76
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp291 from $t2 to $fp-80
	# PushParam m
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp291
	  lw $t0, -80($fp)	# fill _tmp291 to $t0 from $fp-80
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp292 = *(m)
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -84($fp)	# spill _tmp292 from $t2 to $fp-84
	# _tmp293 = *(_tmp292 + 12)
	  lw $t0, -84($fp)	# fill _tmp292 to $t0 from $fp-84
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp293 from $t2 to $fp-88
	# PushParam m
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill m to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp293
	  lw $t0, -88($fp)	# fill _tmp293 to $t0 from $fp-88
	  jalr $t0            	# jump to function
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
