	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Binky:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	# _tmp0 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -8($fp)	# spill _tmp0 from $t2 to $fp-8
	# _tmp1 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp1 from $t2 to $fp-12
	# _tmp2 = _tmp0 < _tmp1
	  lw $t0, -8($fp)	# fill _tmp0 to $t0 from $fp-8
	  lw $t1, -12($fp)	# fill _tmp1 to $t1 from $fp-12
	  slt $t2, $t0, $t1	
	  sw $t2, -16($fp)	# spill _tmp2 from $t2 to $fp-16
	# _tmp3 = *(c + -4)
	  lw $t0, 12($fp)	# fill c to $t0 from $fp+12
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp3 from $t2 to $fp-20
	# _tmp4 = _tmp0 < _tmp3
	  lw $t0, -8($fp)	# fill _tmp0 to $t0 from $fp-8
	  lw $t1, -20($fp)	# fill _tmp3 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp4 from $t2 to $fp-24
	# _tmp5 = _tmp4 == _tmp1
	  lw $t0, -24($fp)	# fill _tmp4 to $t0 from $fp-24
	  lw $t1, -12($fp)	# fill _tmp1 to $t1 from $fp-12
	  seq $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp5 from $t2 to $fp-28
	# _tmp6 = _tmp2 || _tmp5
	  lw $t0, -16($fp)	# fill _tmp2 to $t0 from $fp-16
	  lw $t1, -28($fp)	# fill _tmp5 to $t1 from $fp-28
	  or $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp6 from $t2 to $fp-32
	# IfZ _tmp6 Goto _L0
	  lw $t0, -32($fp)	# fill _tmp6 to $t0 from $fp-32
	  beqz $t0, _L0	# branch if _tmp6 is zero 
	# _tmp7 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string1	# load label
	  sw $t2, -36($fp)	# spill _tmp7 from $t2 to $fp-36
	# PushParam _tmp7
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -36($fp)	# fill _tmp7 to $t0 from $fp-36
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L0:
	# _tmp8 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -40($fp)	# spill _tmp8 from $t2 to $fp-40
	# _tmp9 = _tmp8 * _tmp0
	  lw $t0, -40($fp)	# fill _tmp8 to $t0 from $fp-40
	  lw $t1, -8($fp)	# fill _tmp0 to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp9 from $t2 to $fp-44
	# _tmp10 = c + _tmp9
	  lw $t0, 12($fp)	# fill c to $t0 from $fp+12
	  lw $t1, -44($fp)	# fill _tmp9 to $t1 from $fp-44
	  add $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp10 from $t2 to $fp-48
	# _tmp11 = *(_tmp10)
	  lw $t0, -48($fp)	# fill _tmp10 to $t0 from $fp-48
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -52($fp)	# spill _tmp11 from $t2 to $fp-52
	# _tmp12 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp12 from $t2 to $fp-56
	# _tmp13 = _tmp11 < _tmp12
	  lw $t0, -52($fp)	# fill _tmp11 to $t0 from $fp-52
	  lw $t1, -56($fp)	# fill _tmp12 to $t1 from $fp-56
	  slt $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp13 from $t2 to $fp-60
	# _tmp14 = *(b + -4)
	  lw $t0, 8($fp)	# fill b to $t0 from $fp+8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp14 from $t2 to $fp-64
	# _tmp15 = _tmp11 < _tmp14
	  lw $t0, -52($fp)	# fill _tmp11 to $t0 from $fp-52
	  lw $t1, -64($fp)	# fill _tmp14 to $t1 from $fp-64
	  slt $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp15 from $t2 to $fp-68
	# _tmp16 = _tmp15 == _tmp12
	  lw $t0, -68($fp)	# fill _tmp15 to $t0 from $fp-68
	  lw $t1, -56($fp)	# fill _tmp12 to $t1 from $fp-56
	  seq $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp16 from $t2 to $fp-72
	# _tmp17 = _tmp13 || _tmp16
	  lw $t0, -60($fp)	# fill _tmp13 to $t0 from $fp-60
	  lw $t1, -72($fp)	# fill _tmp16 to $t1 from $fp-72
	  or $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp17 from $t2 to $fp-76
	# IfZ _tmp17 Goto _L1
	  lw $t0, -76($fp)	# fill _tmp17 to $t0 from $fp-76
	  beqz $t0, _L1	# branch if _tmp17 is zero 
	# _tmp18 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string2	# load label
	  sw $t2, -80($fp)	# spill _tmp18 from $t2 to $fp-80
	# PushParam _tmp18
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -80($fp)	# fill _tmp18 to $t0 from $fp-80
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L1:
	# _tmp19 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -84($fp)	# spill _tmp19 from $t2 to $fp-84
	# _tmp20 = _tmp19 * _tmp11
	  lw $t0, -84($fp)	# fill _tmp19 to $t0 from $fp-84
	  lw $t1, -52($fp)	# fill _tmp11 to $t1 from $fp-52
	  mul $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp20 from $t2 to $fp-88
	# _tmp21 = b + _tmp20
	  lw $t0, 8($fp)	# fill b to $t0 from $fp+8
	  lw $t1, -88($fp)	# fill _tmp20 to $t1 from $fp-88
	  add $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp21 from $t2 to $fp-92
	# _tmp22 = *(_tmp21)
	  lw $t0, -92($fp)	# fill _tmp21 to $t0 from $fp-92
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp22 from $t2 to $fp-96
	# Return _tmp22
	  lw $t2, -96($fp)	# fill _tmp22 to $t2 from $fp-96
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
	# BeginFunc 508
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 508	# decrement sp to make space for locals/temps
	# _tmp23 = 5
	  li $t2, 5		# load constant value 5 into $t2
	  sw $t2, -16($fp)	# spill _tmp23 from $t2 to $fp-16
	# _tmp24 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -20($fp)	# spill _tmp24 from $t2 to $fp-20
	# _tmp25 = _tmp23 < _tmp24
	  lw $t0, -16($fp)	# fill _tmp23 to $t0 from $fp-16
	  lw $t1, -20($fp)	# fill _tmp24 to $t1 from $fp-20
	  slt $t2, $t0, $t1	
	  sw $t2, -24($fp)	# spill _tmp25 from $t2 to $fp-24
	# IfZ _tmp25 Goto _L2
	  lw $t0, -24($fp)	# fill _tmp25 to $t0 from $fp-24
	  beqz $t0, _L2	# branch if _tmp25 is zero 
	# _tmp26 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string3	# load label
	  sw $t2, -28($fp)	# spill _tmp26 from $t2 to $fp-28
	# PushParam _tmp26
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# fill _tmp26 to $t0 from $fp-28
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L2:
	# _tmp27 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -32($fp)	# spill _tmp27 from $t2 to $fp-32
	# _tmp28 = _tmp27 + _tmp23
	  lw $t0, -32($fp)	# fill _tmp27 to $t0 from $fp-32
	  lw $t1, -16($fp)	# fill _tmp23 to $t1 from $fp-16
	  add $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp28 from $t2 to $fp-36
	# _tmp29 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -40($fp)	# spill _tmp29 from $t2 to $fp-40
	# _tmp30 = _tmp28 * _tmp29
	  lw $t0, -36($fp)	# fill _tmp28 to $t0 from $fp-36
	  lw $t1, -40($fp)	# fill _tmp29 to $t1 from $fp-40
	  mul $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp30 from $t2 to $fp-44
	# PushParam _tmp30
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill _tmp30 to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp31 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -48($fp)	# spill _tmp31 from $t2 to $fp-48
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp31) = _tmp23
	  lw $t0, -16($fp)	# fill _tmp23 to $t0 from $fp-16
	  lw $t2, -48($fp)	# fill _tmp31 to $t2 from $fp-48
	  sw $t0, 0($t2) 	# store with offset
	# _tmp32 = _tmp31 + _tmp29
	  lw $t0, -48($fp)	# fill _tmp31 to $t0 from $fp-48
	  lw $t1, -40($fp)	# fill _tmp29 to $t1 from $fp-40
	  add $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp32 from $t2 to $fp-52
	# d = _tmp32
	  lw $t2, -52($fp)	# fill _tmp32 to $t2 from $fp-52
	  sw $t2, -12($fp)	# spill d from $t2 to $fp-12
	# _tmp33 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp33 from $t2 to $fp-56
	# _tmp34 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -60($fp)	# spill _tmp34 from $t2 to $fp-60
	# _tmp35 = _tmp33 < _tmp34
	  lw $t0, -56($fp)	# fill _tmp33 to $t0 from $fp-56
	  lw $t1, -60($fp)	# fill _tmp34 to $t1 from $fp-60
	  slt $t2, $t0, $t1	
	  sw $t2, -64($fp)	# spill _tmp35 from $t2 to $fp-64
	# _tmp36 = *(d + -4)
	  lw $t0, -12($fp)	# fill d to $t0 from $fp-12
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp36 from $t2 to $fp-68
	# _tmp37 = _tmp33 < _tmp36
	  lw $t0, -56($fp)	# fill _tmp33 to $t0 from $fp-56
	  lw $t1, -68($fp)	# fill _tmp36 to $t1 from $fp-68
	  slt $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp37 from $t2 to $fp-72
	# _tmp38 = _tmp37 == _tmp34
	  lw $t0, -72($fp)	# fill _tmp37 to $t0 from $fp-72
	  lw $t1, -60($fp)	# fill _tmp34 to $t1 from $fp-60
	  seq $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp38 from $t2 to $fp-76
	# _tmp39 = _tmp35 || _tmp38
	  lw $t0, -64($fp)	# fill _tmp35 to $t0 from $fp-64
	  lw $t1, -76($fp)	# fill _tmp38 to $t1 from $fp-76
	  or $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp39 from $t2 to $fp-80
	# IfZ _tmp39 Goto _L3
	  lw $t0, -80($fp)	# fill _tmp39 to $t0 from $fp-80
	  beqz $t0, _L3	# branch if _tmp39 is zero 
	# _tmp40 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string4	# load label
	  sw $t2, -84($fp)	# spill _tmp40 from $t2 to $fp-84
	# PushParam _tmp40
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -84($fp)	# fill _tmp40 to $t0 from $fp-84
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L3:
	# _tmp41 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -88($fp)	# spill _tmp41 from $t2 to $fp-88
	# _tmp42 = _tmp41 * _tmp33
	  lw $t0, -88($fp)	# fill _tmp41 to $t0 from $fp-88
	  lw $t1, -56($fp)	# fill _tmp33 to $t1 from $fp-56
	  mul $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp42 from $t2 to $fp-92
	# _tmp43 = d + _tmp42
	  lw $t0, -12($fp)	# fill d to $t0 from $fp-12
	  lw $t1, -92($fp)	# fill _tmp42 to $t1 from $fp-92
	  add $t2, $t0, $t1	
	  sw $t2, -96($fp)	# spill _tmp43 from $t2 to $fp-96
	# _tmp44 = 12
	  li $t2, 12		# load constant value 12 into $t2
	  sw $t2, -100($fp)	# spill _tmp44 from $t2 to $fp-100
	# _tmp45 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -104($fp)	# spill _tmp45 from $t2 to $fp-104
	# _tmp46 = _tmp44 < _tmp45
	  lw $t0, -100($fp)	# fill _tmp44 to $t0 from $fp-100
	  lw $t1, -104($fp)	# fill _tmp45 to $t1 from $fp-104
	  slt $t2, $t0, $t1	
	  sw $t2, -108($fp)	# spill _tmp46 from $t2 to $fp-108
	# IfZ _tmp46 Goto _L4
	  lw $t0, -108($fp)	# fill _tmp46 to $t0 from $fp-108
	  beqz $t0, _L4	# branch if _tmp46 is zero 
	# _tmp47 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string5	# load label
	  sw $t2, -112($fp)	# spill _tmp47 from $t2 to $fp-112
	# PushParam _tmp47
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -112($fp)	# fill _tmp47 to $t0 from $fp-112
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L4:
	# _tmp48 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -116($fp)	# spill _tmp48 from $t2 to $fp-116
	# _tmp49 = _tmp48 + _tmp44
	  lw $t0, -116($fp)	# fill _tmp48 to $t0 from $fp-116
	  lw $t1, -100($fp)	# fill _tmp44 to $t1 from $fp-100
	  add $t2, $t0, $t1	
	  sw $t2, -120($fp)	# spill _tmp49 from $t2 to $fp-120
	# _tmp50 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -124($fp)	# spill _tmp50 from $t2 to $fp-124
	# _tmp51 = _tmp49 * _tmp50
	  lw $t0, -120($fp)	# fill _tmp49 to $t0 from $fp-120
	  lw $t1, -124($fp)	# fill _tmp50 to $t1 from $fp-124
	  mul $t2, $t0, $t1	
	  sw $t2, -128($fp)	# spill _tmp51 from $t2 to $fp-128
	# PushParam _tmp51
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -128($fp)	# fill _tmp51 to $t0 from $fp-128
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp52 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -132($fp)	# spill _tmp52 from $t2 to $fp-132
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp52) = _tmp44
	  lw $t0, -100($fp)	# fill _tmp44 to $t0 from $fp-100
	  lw $t2, -132($fp)	# fill _tmp52 to $t2 from $fp-132
	  sw $t0, 0($t2) 	# store with offset
	# _tmp53 = _tmp52 + _tmp50
	  lw $t0, -132($fp)	# fill _tmp52 to $t0 from $fp-132
	  lw $t1, -124($fp)	# fill _tmp50 to $t1 from $fp-124
	  add $t2, $t0, $t1	
	  sw $t2, -136($fp)	# spill _tmp53 from $t2 to $fp-136
	# *(_tmp43) = _tmp53
	  lw $t0, -136($fp)	# fill _tmp53 to $t0 from $fp-136
	  lw $t2, -96($fp)	# fill _tmp43 to $t2 from $fp-96
	  sw $t0, 0($t2) 	# store with offset
	# _tmp54 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -140($fp)	# spill _tmp54 from $t2 to $fp-140
	# _tmp55 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -144($fp)	# spill _tmp55 from $t2 to $fp-144
	# _tmp56 = _tmp54 < _tmp55
	  lw $t0, -140($fp)	# fill _tmp54 to $t0 from $fp-140
	  lw $t1, -144($fp)	# fill _tmp55 to $t1 from $fp-144
	  slt $t2, $t0, $t1	
	  sw $t2, -148($fp)	# spill _tmp56 from $t2 to $fp-148
	# IfZ _tmp56 Goto _L5
	  lw $t0, -148($fp)	# fill _tmp56 to $t0 from $fp-148
	  beqz $t0, _L5	# branch if _tmp56 is zero 
	# _tmp57 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string6	# load label
	  sw $t2, -152($fp)	# spill _tmp57 from $t2 to $fp-152
	# PushParam _tmp57
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -152($fp)	# fill _tmp57 to $t0 from $fp-152
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L5:
	# _tmp58 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -156($fp)	# spill _tmp58 from $t2 to $fp-156
	# _tmp59 = _tmp58 + _tmp54
	  lw $t0, -156($fp)	# fill _tmp58 to $t0 from $fp-156
	  lw $t1, -140($fp)	# fill _tmp54 to $t1 from $fp-140
	  add $t2, $t0, $t1	
	  sw $t2, -160($fp)	# spill _tmp59 from $t2 to $fp-160
	# _tmp60 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -164($fp)	# spill _tmp60 from $t2 to $fp-164
	# _tmp61 = _tmp59 * _tmp60
	  lw $t0, -160($fp)	# fill _tmp59 to $t0 from $fp-160
	  lw $t1, -164($fp)	# fill _tmp60 to $t1 from $fp-164
	  mul $t2, $t0, $t1	
	  sw $t2, -168($fp)	# spill _tmp61 from $t2 to $fp-168
	# PushParam _tmp61
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -168($fp)	# fill _tmp61 to $t0 from $fp-168
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp62 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -172($fp)	# spill _tmp62 from $t2 to $fp-172
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp62) = _tmp54
	  lw $t0, -140($fp)	# fill _tmp54 to $t0 from $fp-140
	  lw $t2, -172($fp)	# fill _tmp62 to $t2 from $fp-172
	  sw $t0, 0($t2) 	# store with offset
	# _tmp63 = _tmp62 + _tmp60
	  lw $t0, -172($fp)	# fill _tmp62 to $t0 from $fp-172
	  lw $t1, -164($fp)	# fill _tmp60 to $t1 from $fp-164
	  add $t2, $t0, $t1	
	  sw $t2, -176($fp)	# spill _tmp63 from $t2 to $fp-176
	# c = _tmp63
	  lw $t2, -176($fp)	# fill _tmp63 to $t2 from $fp-176
	  sw $t2, -8($fp)	# spill c from $t2 to $fp-8
	# _tmp64 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -180($fp)	# spill _tmp64 from $t2 to $fp-180
	# _tmp65 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -184($fp)	# spill _tmp65 from $t2 to $fp-184
	# _tmp66 = _tmp64 < _tmp65
	  lw $t0, -180($fp)	# fill _tmp64 to $t0 from $fp-180
	  lw $t1, -184($fp)	# fill _tmp65 to $t1 from $fp-184
	  slt $t2, $t0, $t1	
	  sw $t2, -188($fp)	# spill _tmp66 from $t2 to $fp-188
	# _tmp67 = *(c + -4)
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -192($fp)	# spill _tmp67 from $t2 to $fp-192
	# _tmp68 = _tmp64 < _tmp67
	  lw $t0, -180($fp)	# fill _tmp64 to $t0 from $fp-180
	  lw $t1, -192($fp)	# fill _tmp67 to $t1 from $fp-192
	  slt $t2, $t0, $t1	
	  sw $t2, -196($fp)	# spill _tmp68 from $t2 to $fp-196
	# _tmp69 = _tmp68 == _tmp65
	  lw $t0, -196($fp)	# fill _tmp68 to $t0 from $fp-196
	  lw $t1, -184($fp)	# fill _tmp65 to $t1 from $fp-184
	  seq $t2, $t0, $t1	
	  sw $t2, -200($fp)	# spill _tmp69 from $t2 to $fp-200
	# _tmp70 = _tmp66 || _tmp69
	  lw $t0, -188($fp)	# fill _tmp66 to $t0 from $fp-188
	  lw $t1, -200($fp)	# fill _tmp69 to $t1 from $fp-200
	  or $t2, $t0, $t1	
	  sw $t2, -204($fp)	# spill _tmp70 from $t2 to $fp-204
	# IfZ _tmp70 Goto _L6
	  lw $t0, -204($fp)	# fill _tmp70 to $t0 from $fp-204
	  beqz $t0, _L6	# branch if _tmp70 is zero 
	# _tmp71 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string7	# load label
	  sw $t2, -208($fp)	# spill _tmp71 from $t2 to $fp-208
	# PushParam _tmp71
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -208($fp)	# fill _tmp71 to $t0 from $fp-208
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L6:
	# _tmp72 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -212($fp)	# spill _tmp72 from $t2 to $fp-212
	# _tmp73 = _tmp72 * _tmp64
	  lw $t0, -212($fp)	# fill _tmp72 to $t0 from $fp-212
	  lw $t1, -180($fp)	# fill _tmp64 to $t1 from $fp-180
	  mul $t2, $t0, $t1	
	  sw $t2, -216($fp)	# spill _tmp73 from $t2 to $fp-216
	# _tmp74 = c + _tmp73
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t1, -216($fp)	# fill _tmp73 to $t1 from $fp-216
	  add $t2, $t0, $t1	
	  sw $t2, -220($fp)	# spill _tmp74 from $t2 to $fp-220
	# _tmp75 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -224($fp)	# spill _tmp75 from $t2 to $fp-224
	# _tmp76 = 5
	  li $t2, 5		# load constant value 5 into $t2
	  sw $t2, -228($fp)	# spill _tmp76 from $t2 to $fp-228
	# _tmp77 = 3
	  li $t2, 3		# load constant value 3 into $t2
	  sw $t2, -232($fp)	# spill _tmp77 from $t2 to $fp-232
	# _tmp78 = _tmp76 * _tmp77
	  lw $t0, -228($fp)	# fill _tmp76 to $t0 from $fp-228
	  lw $t1, -232($fp)	# fill _tmp77 to $t1 from $fp-232
	  mul $t2, $t0, $t1	
	  sw $t2, -236($fp)	# spill _tmp78 from $t2 to $fp-236
	# _tmp79 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -240($fp)	# spill _tmp79 from $t2 to $fp-240
	# _tmp80 = _tmp78 / _tmp79
	  lw $t0, -236($fp)	# fill _tmp78 to $t0 from $fp-236
	  lw $t1, -240($fp)	# fill _tmp79 to $t1 from $fp-240
	  div $t2, $t0, $t1	
	  sw $t2, -244($fp)	# spill _tmp80 from $t2 to $fp-244
	# _tmp81 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -248($fp)	# spill _tmp81 from $t2 to $fp-248
	# _tmp82 = _tmp80 % _tmp81
	  lw $t0, -244($fp)	# fill _tmp80 to $t0 from $fp-244
	  lw $t1, -248($fp)	# fill _tmp81 to $t1 from $fp-248
	  rem $t2, $t0, $t1	
	  sw $t2, -252($fp)	# spill _tmp82 from $t2 to $fp-252
	# _tmp83 = _tmp75 + _tmp82
	  lw $t0, -224($fp)	# fill _tmp75 to $t0 from $fp-224
	  lw $t1, -252($fp)	# fill _tmp82 to $t1 from $fp-252
	  add $t2, $t0, $t1	
	  sw $t2, -256($fp)	# spill _tmp83 from $t2 to $fp-256
	# *(_tmp74) = _tmp83
	  lw $t0, -256($fp)	# fill _tmp83 to $t0 from $fp-256
	  lw $t2, -220($fp)	# fill _tmp74 to $t2 from $fp-220
	  sw $t0, 0($t2) 	# store with offset
	# _tmp84 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -260($fp)	# spill _tmp84 from $t2 to $fp-260
	# _tmp85 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -264($fp)	# spill _tmp85 from $t2 to $fp-264
	# _tmp86 = _tmp84 < _tmp85
	  lw $t0, -260($fp)	# fill _tmp84 to $t0 from $fp-260
	  lw $t1, -264($fp)	# fill _tmp85 to $t1 from $fp-264
	  slt $t2, $t0, $t1	
	  sw $t2, -268($fp)	# spill _tmp86 from $t2 to $fp-268
	# _tmp87 = *(d + -4)
	  lw $t0, -12($fp)	# fill d to $t0 from $fp-12
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -272($fp)	# spill _tmp87 from $t2 to $fp-272
	# _tmp88 = _tmp84 < _tmp87
	  lw $t0, -260($fp)	# fill _tmp84 to $t0 from $fp-260
	  lw $t1, -272($fp)	# fill _tmp87 to $t1 from $fp-272
	  slt $t2, $t0, $t1	
	  sw $t2, -276($fp)	# spill _tmp88 from $t2 to $fp-276
	# _tmp89 = _tmp88 == _tmp85
	  lw $t0, -276($fp)	# fill _tmp88 to $t0 from $fp-276
	  lw $t1, -264($fp)	# fill _tmp85 to $t1 from $fp-264
	  seq $t2, $t0, $t1	
	  sw $t2, -280($fp)	# spill _tmp89 from $t2 to $fp-280
	# _tmp90 = _tmp86 || _tmp89
	  lw $t0, -268($fp)	# fill _tmp86 to $t0 from $fp-268
	  lw $t1, -280($fp)	# fill _tmp89 to $t1 from $fp-280
	  or $t2, $t0, $t1	
	  sw $t2, -284($fp)	# spill _tmp90 from $t2 to $fp-284
	# IfZ _tmp90 Goto _L7
	  lw $t0, -284($fp)	# fill _tmp90 to $t0 from $fp-284
	  beqz $t0, _L7	# branch if _tmp90 is zero 
	# _tmp91 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string8	# load label
	  sw $t2, -288($fp)	# spill _tmp91 from $t2 to $fp-288
	# PushParam _tmp91
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -288($fp)	# fill _tmp91 to $t0 from $fp-288
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L7:
	# _tmp92 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -292($fp)	# spill _tmp92 from $t2 to $fp-292
	# _tmp93 = _tmp92 * _tmp84
	  lw $t0, -292($fp)	# fill _tmp92 to $t0 from $fp-292
	  lw $t1, -260($fp)	# fill _tmp84 to $t1 from $fp-260
	  mul $t2, $t0, $t1	
	  sw $t2, -296($fp)	# spill _tmp93 from $t2 to $fp-296
	# _tmp94 = d + _tmp93
	  lw $t0, -12($fp)	# fill d to $t0 from $fp-12
	  lw $t1, -296($fp)	# fill _tmp93 to $t1 from $fp-296
	  add $t2, $t0, $t1	
	  sw $t2, -300($fp)	# spill _tmp94 from $t2 to $fp-300
	# _tmp95 = *(_tmp94)
	  lw $t0, -300($fp)	# fill _tmp94 to $t0 from $fp-300
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -304($fp)	# spill _tmp95 from $t2 to $fp-304
	# _tmp96 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -308($fp)	# spill _tmp96 from $t2 to $fp-308
	# _tmp97 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -312($fp)	# spill _tmp97 from $t2 to $fp-312
	# _tmp98 = _tmp96 < _tmp97
	  lw $t0, -308($fp)	# fill _tmp96 to $t0 from $fp-308
	  lw $t1, -312($fp)	# fill _tmp97 to $t1 from $fp-312
	  slt $t2, $t0, $t1	
	  sw $t2, -316($fp)	# spill _tmp98 from $t2 to $fp-316
	# _tmp99 = *(c + -4)
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -320($fp)	# spill _tmp99 from $t2 to $fp-320
	# _tmp100 = _tmp96 < _tmp99
	  lw $t0, -308($fp)	# fill _tmp96 to $t0 from $fp-308
	  lw $t1, -320($fp)	# fill _tmp99 to $t1 from $fp-320
	  slt $t2, $t0, $t1	
	  sw $t2, -324($fp)	# spill _tmp100 from $t2 to $fp-324
	# _tmp101 = _tmp100 == _tmp97
	  lw $t0, -324($fp)	# fill _tmp100 to $t0 from $fp-324
	  lw $t1, -312($fp)	# fill _tmp97 to $t1 from $fp-312
	  seq $t2, $t0, $t1	
	  sw $t2, -328($fp)	# spill _tmp101 from $t2 to $fp-328
	# _tmp102 = _tmp98 || _tmp101
	  lw $t0, -316($fp)	# fill _tmp98 to $t0 from $fp-316
	  lw $t1, -328($fp)	# fill _tmp101 to $t1 from $fp-328
	  or $t2, $t0, $t1	
	  sw $t2, -332($fp)	# spill _tmp102 from $t2 to $fp-332
	# IfZ _tmp102 Goto _L8
	  lw $t0, -332($fp)	# fill _tmp102 to $t0 from $fp-332
	  beqz $t0, _L8	# branch if _tmp102 is zero 
	# _tmp103 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string9	# load label
	  sw $t2, -336($fp)	# spill _tmp103 from $t2 to $fp-336
	# PushParam _tmp103
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -336($fp)	# fill _tmp103 to $t0 from $fp-336
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L8:
	# _tmp104 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -340($fp)	# spill _tmp104 from $t2 to $fp-340
	# _tmp105 = _tmp104 * _tmp96
	  lw $t0, -340($fp)	# fill _tmp104 to $t0 from $fp-340
	  lw $t1, -308($fp)	# fill _tmp96 to $t1 from $fp-308
	  mul $t2, $t0, $t1	
	  sw $t2, -344($fp)	# spill _tmp105 from $t2 to $fp-344
	# _tmp106 = c + _tmp105
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t1, -344($fp)	# fill _tmp105 to $t1 from $fp-344
	  add $t2, $t0, $t1	
	  sw $t2, -348($fp)	# spill _tmp106 from $t2 to $fp-348
	# _tmp107 = *(_tmp106)
	  lw $t0, -348($fp)	# fill _tmp106 to $t0 from $fp-348
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -352($fp)	# spill _tmp107 from $t2 to $fp-352
	# _tmp108 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -356($fp)	# spill _tmp108 from $t2 to $fp-356
	# _tmp109 = _tmp107 < _tmp108
	  lw $t0, -352($fp)	# fill _tmp107 to $t0 from $fp-352
	  lw $t1, -356($fp)	# fill _tmp108 to $t1 from $fp-356
	  slt $t2, $t0, $t1	
	  sw $t2, -360($fp)	# spill _tmp109 from $t2 to $fp-360
	# _tmp110 = *(_tmp95 + -4)
	  lw $t0, -304($fp)	# fill _tmp95 to $t0 from $fp-304
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -364($fp)	# spill _tmp110 from $t2 to $fp-364
	# _tmp111 = _tmp107 < _tmp110
	  lw $t0, -352($fp)	# fill _tmp107 to $t0 from $fp-352
	  lw $t1, -364($fp)	# fill _tmp110 to $t1 from $fp-364
	  slt $t2, $t0, $t1	
	  sw $t2, -368($fp)	# spill _tmp111 from $t2 to $fp-368
	# _tmp112 = _tmp111 == _tmp108
	  lw $t0, -368($fp)	# fill _tmp111 to $t0 from $fp-368
	  lw $t1, -356($fp)	# fill _tmp108 to $t1 from $fp-356
	  seq $t2, $t0, $t1	
	  sw $t2, -372($fp)	# spill _tmp112 from $t2 to $fp-372
	# _tmp113 = _tmp109 || _tmp112
	  lw $t0, -360($fp)	# fill _tmp109 to $t0 from $fp-360
	  lw $t1, -372($fp)	# fill _tmp112 to $t1 from $fp-372
	  or $t2, $t0, $t1	
	  sw $t2, -376($fp)	# spill _tmp113 from $t2 to $fp-376
	# IfZ _tmp113 Goto _L9
	  lw $t0, -376($fp)	# fill _tmp113 to $t0 from $fp-376
	  beqz $t0, _L9	# branch if _tmp113 is zero 
	# _tmp114 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string10	# load label
	  sw $t2, -380($fp)	# spill _tmp114 from $t2 to $fp-380
	# PushParam _tmp114
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -380($fp)	# fill _tmp114 to $t0 from $fp-380
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L9:
	# _tmp115 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -384($fp)	# spill _tmp115 from $t2 to $fp-384
	# _tmp116 = _tmp115 * _tmp107
	  lw $t0, -384($fp)	# fill _tmp115 to $t0 from $fp-384
	  lw $t1, -352($fp)	# fill _tmp107 to $t1 from $fp-352
	  mul $t2, $t0, $t1	
	  sw $t2, -388($fp)	# spill _tmp116 from $t2 to $fp-388
	# _tmp117 = _tmp95 + _tmp116
	  lw $t0, -304($fp)	# fill _tmp95 to $t0 from $fp-304
	  lw $t1, -388($fp)	# fill _tmp116 to $t1 from $fp-388
	  add $t2, $t0, $t1	
	  sw $t2, -392($fp)	# spill _tmp117 from $t2 to $fp-392
	# _tmp118 = 55
	  li $t2, 55		# load constant value 55 into $t2
	  sw $t2, -396($fp)	# spill _tmp118 from $t2 to $fp-396
	# *(_tmp117) = _tmp118
	  lw $t0, -396($fp)	# fill _tmp118 to $t0 from $fp-396
	  lw $t2, -392($fp)	# fill _tmp117 to $t2 from $fp-392
	  sw $t0, 0($t2) 	# store with offset
	# _tmp119 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -400($fp)	# spill _tmp119 from $t2 to $fp-400
	# _tmp120 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -404($fp)	# spill _tmp120 from $t2 to $fp-404
	# _tmp121 = _tmp119 < _tmp120
	  lw $t0, -400($fp)	# fill _tmp119 to $t0 from $fp-400
	  lw $t1, -404($fp)	# fill _tmp120 to $t1 from $fp-404
	  slt $t2, $t0, $t1	
	  sw $t2, -408($fp)	# spill _tmp121 from $t2 to $fp-408
	# _tmp122 = *(c + -4)
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -412($fp)	# spill _tmp122 from $t2 to $fp-412
	# _tmp123 = _tmp119 < _tmp122
	  lw $t0, -400($fp)	# fill _tmp119 to $t0 from $fp-400
	  lw $t1, -412($fp)	# fill _tmp122 to $t1 from $fp-412
	  slt $t2, $t0, $t1	
	  sw $t2, -416($fp)	# spill _tmp123 from $t2 to $fp-416
	# _tmp124 = _tmp123 == _tmp120
	  lw $t0, -416($fp)	# fill _tmp123 to $t0 from $fp-416
	  lw $t1, -404($fp)	# fill _tmp120 to $t1 from $fp-404
	  seq $t2, $t0, $t1	
	  sw $t2, -420($fp)	# spill _tmp124 from $t2 to $fp-420
	# _tmp125 = _tmp121 || _tmp124
	  lw $t0, -408($fp)	# fill _tmp121 to $t0 from $fp-408
	  lw $t1, -420($fp)	# fill _tmp124 to $t1 from $fp-420
	  or $t2, $t0, $t1	
	  sw $t2, -424($fp)	# spill _tmp125 from $t2 to $fp-424
	# IfZ _tmp125 Goto _L10
	  lw $t0, -424($fp)	# fill _tmp125 to $t0 from $fp-424
	  beqz $t0, _L10	# branch if _tmp125 is zero 
	# _tmp126 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string11	# load label
	  sw $t2, -428($fp)	# spill _tmp126 from $t2 to $fp-428
	# PushParam _tmp126
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -428($fp)	# fill _tmp126 to $t0 from $fp-428
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L10:
	# _tmp127 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -432($fp)	# spill _tmp127 from $t2 to $fp-432
	# _tmp128 = _tmp127 * _tmp119
	  lw $t0, -432($fp)	# fill _tmp127 to $t0 from $fp-432
	  lw $t1, -400($fp)	# fill _tmp119 to $t1 from $fp-400
	  mul $t2, $t0, $t1	
	  sw $t2, -436($fp)	# spill _tmp128 from $t2 to $fp-436
	# _tmp129 = c + _tmp128
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  lw $t1, -436($fp)	# fill _tmp128 to $t1 from $fp-436
	  add $t2, $t0, $t1	
	  sw $t2, -440($fp)	# spill _tmp129 from $t2 to $fp-440
	# _tmp130 = *(_tmp129)
	  lw $t0, -440($fp)	# fill _tmp129 to $t0 from $fp-440
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -444($fp)	# spill _tmp130 from $t2 to $fp-444
	# PushParam _tmp130
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -444($fp)	# fill _tmp130 to $t0 from $fp-444
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp131 = " "
	  .data			# create string constant marked with label
	  _string12: .asciiz " "
	  .text
	  la $t2, _string12	# load label
	  sw $t2, -448($fp)	# spill _tmp131 from $t2 to $fp-448
	# PushParam _tmp131
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -448($fp)	# fill _tmp131 to $t0 from $fp-448
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp132 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -452($fp)	# spill _tmp132 from $t2 to $fp-452
	# _tmp133 = 100
	  li $t2, 100		# load constant value 100 into $t2
	  sw $t2, -456($fp)	# spill _tmp133 from $t2 to $fp-456
	# _tmp134 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -460($fp)	# spill _tmp134 from $t2 to $fp-460
	# _tmp135 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -464($fp)	# spill _tmp135 from $t2 to $fp-464
	# _tmp136 = _tmp134 < _tmp135
	  lw $t0, -460($fp)	# fill _tmp134 to $t0 from $fp-460
	  lw $t1, -464($fp)	# fill _tmp135 to $t1 from $fp-464
	  slt $t2, $t0, $t1	
	  sw $t2, -468($fp)	# spill _tmp136 from $t2 to $fp-468
	# _tmp137 = *(d + -4)
	  lw $t0, -12($fp)	# fill d to $t0 from $fp-12
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -472($fp)	# spill _tmp137 from $t2 to $fp-472
	# _tmp138 = _tmp134 < _tmp137
	  lw $t0, -460($fp)	# fill _tmp134 to $t0 from $fp-460
	  lw $t1, -472($fp)	# fill _tmp137 to $t1 from $fp-472
	  slt $t2, $t0, $t1	
	  sw $t2, -476($fp)	# spill _tmp138 from $t2 to $fp-476
	# _tmp139 = _tmp138 == _tmp135
	  lw $t0, -476($fp)	# fill _tmp138 to $t0 from $fp-476
	  lw $t1, -464($fp)	# fill _tmp135 to $t1 from $fp-464
	  seq $t2, $t0, $t1	
	  sw $t2, -480($fp)	# spill _tmp139 from $t2 to $fp-480
	# _tmp140 = _tmp136 || _tmp139
	  lw $t0, -468($fp)	# fill _tmp136 to $t0 from $fp-468
	  lw $t1, -480($fp)	# fill _tmp139 to $t1 from $fp-480
	  or $t2, $t0, $t1	
	  sw $t2, -484($fp)	# spill _tmp140 from $t2 to $fp-484
	# IfZ _tmp140 Goto _L11
	  lw $t0, -484($fp)	# fill _tmp140 to $t0 from $fp-484
	  beqz $t0, _L11	# branch if _tmp140 is zero 
	# _tmp141 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string13: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string13	# load label
	  sw $t2, -488($fp)	# spill _tmp141 from $t2 to $fp-488
	# PushParam _tmp141
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -488($fp)	# fill _tmp141 to $t0 from $fp-488
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L11:
	# _tmp142 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -492($fp)	# spill _tmp142 from $t2 to $fp-492
	# _tmp143 = _tmp142 * _tmp134
	  lw $t0, -492($fp)	# fill _tmp142 to $t0 from $fp-492
	  lw $t1, -460($fp)	# fill _tmp134 to $t1 from $fp-460
	  mul $t2, $t0, $t1	
	  sw $t2, -496($fp)	# spill _tmp143 from $t2 to $fp-496
	# _tmp144 = d + _tmp143
	  lw $t0, -12($fp)	# fill d to $t0 from $fp-12
	  lw $t1, -496($fp)	# fill _tmp143 to $t1 from $fp-496
	  add $t2, $t0, $t1	
	  sw $t2, -500($fp)	# spill _tmp144 from $t2 to $fp-500
	# _tmp145 = *(_tmp144)
	  lw $t0, -500($fp)	# fill _tmp144 to $t0 from $fp-500
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -504($fp)	# spill _tmp145 from $t2 to $fp-504
	# PushParam c
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp145
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -504($fp)	# fill _tmp145 to $t0 from $fp-504
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp133
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -456($fp)	# fill _tmp133 to $t0 from $fp-456
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp146 = LCall _Binky
	  jal _Binky         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -508($fp)	# spill _tmp146 from $t2 to $fp-508
	# PopParams 12
	  add $sp, $sp, 12	# pop params off stack
	# _tmp147 = _tmp132 * _tmp146
	  lw $t0, -452($fp)	# fill _tmp132 to $t0 from $fp-452
	  lw $t1, -508($fp)	# fill _tmp146 to $t1 from $fp-508
	  mul $t2, $t0, $t1	
	  sw $t2, -512($fp)	# spill _tmp147 from $t2 to $fp-512
	# PushParam _tmp147
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -512($fp)	# fill _tmp147 to $t0 from $fp-512
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
