	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Wild:
	# BeginFunc 80
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 80	# decrement sp to make space for locals/temps
	# _tmp0 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -12($fp)	# spill _tmp0 from $t2 to $fp-12
	# i = _tmp0
	  lw $t2, -12($fp)	# fill _tmp0 to $t2 from $fp-12
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L0:
	# _tmp1 = *(names + -4)
	  lw $t0, 4($fp)	# fill names to $t0 from $fp+4
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp1 from $t2 to $fp-16
	# _tmp2 = i < _tmp1
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -16($fp)	# fill _tmp1 to $t1 from $fp-16
	  slt $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp2 from $t2 to $fp-20
	# IfZ _tmp2 Goto _L1
	  lw $t0, -20($fp)	# fill _tmp2 to $t0 from $fp-20
	  beqz $t0, _L1	# branch if _tmp2 is zero 
	# _tmp3 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -24($fp)	# spill _tmp3 from $t2 to $fp-24
	# _tmp4 = i < _tmp3
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -24($fp)	# fill _tmp3 to $t1 from $fp-24
	  slt $t2, $t0, $t1	
	  sw $t2, -28($fp)	# spill _tmp4 from $t2 to $fp-28
	# _tmp5 = *(names + -4)
	  lw $t0, 4($fp)	# fill names to $t0 from $fp+4
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp5 from $t2 to $fp-32
	# _tmp6 = i < _tmp5
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -32($fp)	# fill _tmp5 to $t1 from $fp-32
	  slt $t2, $t0, $t1	
	  sw $t2, -36($fp)	# spill _tmp6 from $t2 to $fp-36
	# _tmp7 = _tmp6 == _tmp3
	  lw $t0, -36($fp)	# fill _tmp6 to $t0 from $fp-36
	  lw $t1, -24($fp)	# fill _tmp3 to $t1 from $fp-24
	  seq $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp7 from $t2 to $fp-40
	# _tmp8 = _tmp4 || _tmp7
	  lw $t0, -28($fp)	# fill _tmp4 to $t0 from $fp-28
	  lw $t1, -40($fp)	# fill _tmp7 to $t1 from $fp-40
	  or $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp8 from $t2 to $fp-44
	# IfZ _tmp8 Goto _L2
	  lw $t0, -44($fp)	# fill _tmp8 to $t0 from $fp-44
	  beqz $t0, _L2	# branch if _tmp8 is zero 
	# _tmp9 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string1	# load label
	  sw $t2, -48($fp)	# spill _tmp9 from $t2 to $fp-48
	# PushParam _tmp9
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -48($fp)	# fill _tmp9 to $t0 from $fp-48
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L2:
	# _tmp10 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -52($fp)	# spill _tmp10 from $t2 to $fp-52
	# _tmp11 = _tmp10 * i
	  lw $t0, -52($fp)	# fill _tmp10 to $t0 from $fp-52
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	  sw $t2, -56($fp)	# spill _tmp11 from $t2 to $fp-56
	# _tmp12 = names + _tmp11
	  lw $t0, 4($fp)	# fill names to $t0 from $fp+4
	  lw $t1, -56($fp)	# fill _tmp11 to $t1 from $fp-56
	  add $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp12 from $t2 to $fp-60
	# _tmp13 = *(_tmp12)
	  lw $t0, -60($fp)	# fill _tmp12 to $t0 from $fp-60
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp13 from $t2 to $fp-64
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill answer to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp13
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -64($fp)	# fill _tmp13 to $t0 from $fp-64
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp14 = LCall _StringEqual
	  jal _StringEqual   	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -68($fp)	# spill _tmp14 from $t2 to $fp-68
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# IfZ _tmp14 Goto _L3
	  lw $t0, -68($fp)	# fill _tmp14 to $t0 from $fp-68
	  beqz $t0, _L3	# branch if _tmp14 is zero 
	# _tmp15 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -72($fp)	# spill _tmp15 from $t2 to $fp-72
	# Return _tmp15
	  lw $t2, -72($fp)	# fill _tmp15 to $t2 from $fp-72
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L3:
	# _tmp16 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -76($fp)	# spill _tmp16 from $t2 to $fp-76
	# _tmp17 = i + _tmp16
	  lw $t0, -8($fp)	# fill i to $t0 from $fp-8
	  lw $t1, -76($fp)	# fill _tmp16 to $t1 from $fp-76
	  add $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp17 from $t2 to $fp-80
	# i = _tmp17
	  lw $t2, -80($fp)	# fill _tmp17 to $t2 from $fp-80
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
	# Goto _L0
	  b _L0		# unconditional branch
  _L1:
	# _tmp18 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -84($fp)	# spill _tmp18 from $t2 to $fp-84
	# Return _tmp18
	  lw $t2, -84($fp)	# fill _tmp18 to $t2 from $fp-84
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
	# BeginFunc 212
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 212	# decrement sp to make space for locals/temps
	# _tmp19 = 3
	  li $t2, 3		# load constant value 3 into $t2
	  sw $t2, -12($fp)	# spill _tmp19 from $t2 to $fp-12
	# _tmp20 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -16($fp)	# spill _tmp20 from $t2 to $fp-16
	# _tmp21 = _tmp19 < _tmp20
	  lw $t0, -12($fp)	# fill _tmp19 to $t0 from $fp-12
	  lw $t1, -16($fp)	# fill _tmp20 to $t1 from $fp-16
	  slt $t2, $t0, $t1	
	  sw $t2, -20($fp)	# spill _tmp21 from $t2 to $fp-20
	# IfZ _tmp21 Goto _L4
	  lw $t0, -20($fp)	# fill _tmp21 to $t0 from $fp-20
	  beqz $t0, _L4	# branch if _tmp21 is zero 
	# _tmp22 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t2, _string2	# load label
	  sw $t2, -24($fp)	# spill _tmp22 from $t2 to $fp-24
	# PushParam _tmp22
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -24($fp)	# fill _tmp22 to $t0 from $fp-24
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L4:
	# _tmp23 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -28($fp)	# spill _tmp23 from $t2 to $fp-28
	# _tmp24 = _tmp23 + _tmp19
	  lw $t0, -28($fp)	# fill _tmp23 to $t0 from $fp-28
	  lw $t1, -12($fp)	# fill _tmp19 to $t1 from $fp-12
	  add $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp24 from $t2 to $fp-32
	# _tmp25 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -36($fp)	# spill _tmp25 from $t2 to $fp-36
	# _tmp26 = _tmp24 * _tmp25
	  lw $t0, -32($fp)	# fill _tmp24 to $t0 from $fp-32
	  lw $t1, -36($fp)	# fill _tmp25 to $t1 from $fp-36
	  mul $t2, $t0, $t1	
	  sw $t2, -40($fp)	# spill _tmp26 from $t2 to $fp-40
	# PushParam _tmp26
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -40($fp)	# fill _tmp26 to $t0 from $fp-40
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp27 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -44($fp)	# spill _tmp27 from $t2 to $fp-44
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp27) = _tmp19
	  lw $t0, -12($fp)	# fill _tmp19 to $t0 from $fp-12
	  lw $t2, -44($fp)	# fill _tmp27 to $t2 from $fp-44
	  sw $t0, 0($t2) 	# store with offset
	# _tmp28 = _tmp27 + _tmp25
	  lw $t0, -44($fp)	# fill _tmp27 to $t0 from $fp-44
	  lw $t1, -36($fp)	# fill _tmp25 to $t1 from $fp-36
	  add $t2, $t0, $t1	
	  sw $t2, -48($fp)	# spill _tmp28 from $t2 to $fp-48
	# names = _tmp28
	  lw $t2, -48($fp)	# fill _tmp28 to $t2 from $fp-48
	  sw $t2, -8($fp)	# spill names from $t2 to $fp-8
	# _tmp29 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -52($fp)	# spill _tmp29 from $t2 to $fp-52
	# _tmp30 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -56($fp)	# spill _tmp30 from $t2 to $fp-56
	# _tmp31 = _tmp29 < _tmp30
	  lw $t0, -52($fp)	# fill _tmp29 to $t0 from $fp-52
	  lw $t1, -56($fp)	# fill _tmp30 to $t1 from $fp-56
	  slt $t2, $t0, $t1	
	  sw $t2, -60($fp)	# spill _tmp31 from $t2 to $fp-60
	# _tmp32 = *(names + -4)
	  lw $t0, -8($fp)	# fill names to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp32 from $t2 to $fp-64
	# _tmp33 = _tmp29 < _tmp32
	  lw $t0, -52($fp)	# fill _tmp29 to $t0 from $fp-52
	  lw $t1, -64($fp)	# fill _tmp32 to $t1 from $fp-64
	  slt $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp33 from $t2 to $fp-68
	# _tmp34 = _tmp33 == _tmp30
	  lw $t0, -68($fp)	# fill _tmp33 to $t0 from $fp-68
	  lw $t1, -56($fp)	# fill _tmp30 to $t1 from $fp-56
	  seq $t2, $t0, $t1	
	  sw $t2, -72($fp)	# spill _tmp34 from $t2 to $fp-72
	# _tmp35 = _tmp31 || _tmp34
	  lw $t0, -60($fp)	# fill _tmp31 to $t0 from $fp-60
	  lw $t1, -72($fp)	# fill _tmp34 to $t1 from $fp-72
	  or $t2, $t0, $t1	
	  sw $t2, -76($fp)	# spill _tmp35 from $t2 to $fp-76
	# IfZ _tmp35 Goto _L5
	  lw $t0, -76($fp)	# fill _tmp35 to $t0 from $fp-76
	  beqz $t0, _L5	# branch if _tmp35 is zero 
	# _tmp36 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string3	# load label
	  sw $t2, -80($fp)	# spill _tmp36 from $t2 to $fp-80
	# PushParam _tmp36
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -80($fp)	# fill _tmp36 to $t0 from $fp-80
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L5:
	# _tmp37 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -84($fp)	# spill _tmp37 from $t2 to $fp-84
	# _tmp38 = _tmp37 * _tmp29
	  lw $t0, -84($fp)	# fill _tmp37 to $t0 from $fp-84
	  lw $t1, -52($fp)	# fill _tmp29 to $t1 from $fp-52
	  mul $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp38 from $t2 to $fp-88
	# _tmp39 = names + _tmp38
	  lw $t0, -8($fp)	# fill names to $t0 from $fp-8
	  lw $t1, -88($fp)	# fill _tmp38 to $t1 from $fp-88
	  add $t2, $t0, $t1	
	  sw $t2, -92($fp)	# spill _tmp39 from $t2 to $fp-92
	# _tmp40 = "Satish"
	  .data			# create string constant marked with label
	  _string4: .asciiz "Satish"
	  .text
	  la $t2, _string4	# load label
	  sw $t2, -96($fp)	# spill _tmp40 from $t2 to $fp-96
	# *(_tmp39) = _tmp40
	  lw $t0, -96($fp)	# fill _tmp40 to $t0 from $fp-96
	  lw $t2, -92($fp)	# fill _tmp39 to $t2 from $fp-92
	  sw $t0, 0($t2) 	# store with offset
	# _tmp41 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -100($fp)	# spill _tmp41 from $t2 to $fp-100
	# _tmp42 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -104($fp)	# spill _tmp42 from $t2 to $fp-104
	# _tmp43 = _tmp41 < _tmp42
	  lw $t0, -100($fp)	# fill _tmp41 to $t0 from $fp-100
	  lw $t1, -104($fp)	# fill _tmp42 to $t1 from $fp-104
	  slt $t2, $t0, $t1	
	  sw $t2, -108($fp)	# spill _tmp43 from $t2 to $fp-108
	# _tmp44 = *(names + -4)
	  lw $t0, -8($fp)	# fill names to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -112($fp)	# spill _tmp44 from $t2 to $fp-112
	# _tmp45 = _tmp41 < _tmp44
	  lw $t0, -100($fp)	# fill _tmp41 to $t0 from $fp-100
	  lw $t1, -112($fp)	# fill _tmp44 to $t1 from $fp-112
	  slt $t2, $t0, $t1	
	  sw $t2, -116($fp)	# spill _tmp45 from $t2 to $fp-116
	# _tmp46 = _tmp45 == _tmp42
	  lw $t0, -116($fp)	# fill _tmp45 to $t0 from $fp-116
	  lw $t1, -104($fp)	# fill _tmp42 to $t1 from $fp-104
	  seq $t2, $t0, $t1	
	  sw $t2, -120($fp)	# spill _tmp46 from $t2 to $fp-120
	# _tmp47 = _tmp43 || _tmp46
	  lw $t0, -108($fp)	# fill _tmp43 to $t0 from $fp-108
	  lw $t1, -120($fp)	# fill _tmp46 to $t1 from $fp-120
	  or $t2, $t0, $t1	
	  sw $t2, -124($fp)	# spill _tmp47 from $t2 to $fp-124
	# IfZ _tmp47 Goto _L6
	  lw $t0, -124($fp)	# fill _tmp47 to $t0 from $fp-124
	  beqz $t0, _L6	# branch if _tmp47 is zero 
	# _tmp48 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string5	# load label
	  sw $t2, -128($fp)	# spill _tmp48 from $t2 to $fp-128
	# PushParam _tmp48
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -128($fp)	# fill _tmp48 to $t0 from $fp-128
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L6:
	# _tmp49 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -132($fp)	# spill _tmp49 from $t2 to $fp-132
	# _tmp50 = _tmp49 * _tmp41
	  lw $t0, -132($fp)	# fill _tmp49 to $t0 from $fp-132
	  lw $t1, -100($fp)	# fill _tmp41 to $t1 from $fp-100
	  mul $t2, $t0, $t1	
	  sw $t2, -136($fp)	# spill _tmp50 from $t2 to $fp-136
	# _tmp51 = names + _tmp50
	  lw $t0, -8($fp)	# fill names to $t0 from $fp-8
	  lw $t1, -136($fp)	# fill _tmp50 to $t1 from $fp-136
	  add $t2, $t0, $t1	
	  sw $t2, -140($fp)	# spill _tmp51 from $t2 to $fp-140
	# _tmp52 = "Chun"
	  .data			# create string constant marked with label
	  _string6: .asciiz "Chun"
	  .text
	  la $t2, _string6	# load label
	  sw $t2, -144($fp)	# spill _tmp52 from $t2 to $fp-144
	# *(_tmp51) = _tmp52
	  lw $t0, -144($fp)	# fill _tmp52 to $t0 from $fp-144
	  lw $t2, -140($fp)	# fill _tmp51 to $t2 from $fp-140
	  sw $t0, 0($t2) 	# store with offset
	# _tmp53 = 2
	  li $t2, 2		# load constant value 2 into $t2
	  sw $t2, -148($fp)	# spill _tmp53 from $t2 to $fp-148
	# _tmp54 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -152($fp)	# spill _tmp54 from $t2 to $fp-152
	# _tmp55 = _tmp53 < _tmp54
	  lw $t0, -148($fp)	# fill _tmp53 to $t0 from $fp-148
	  lw $t1, -152($fp)	# fill _tmp54 to $t1 from $fp-152
	  slt $t2, $t0, $t1	
	  sw $t2, -156($fp)	# spill _tmp55 from $t2 to $fp-156
	# _tmp56 = *(names + -4)
	  lw $t0, -8($fp)	# fill names to $t0 from $fp-8
	  lw $t2, -4($t0) 	# load with offset
	  sw $t2, -160($fp)	# spill _tmp56 from $t2 to $fp-160
	# _tmp57 = _tmp53 < _tmp56
	  lw $t0, -148($fp)	# fill _tmp53 to $t0 from $fp-148
	  lw $t1, -160($fp)	# fill _tmp56 to $t1 from $fp-160
	  slt $t2, $t0, $t1	
	  sw $t2, -164($fp)	# spill _tmp57 from $t2 to $fp-164
	# _tmp58 = _tmp57 == _tmp54
	  lw $t0, -164($fp)	# fill _tmp57 to $t0 from $fp-164
	  lw $t1, -152($fp)	# fill _tmp54 to $t1 from $fp-152
	  seq $t2, $t0, $t1	
	  sw $t2, -168($fp)	# spill _tmp58 from $t2 to $fp-168
	# _tmp59 = _tmp55 || _tmp58
	  lw $t0, -156($fp)	# fill _tmp55 to $t0 from $fp-156
	  lw $t1, -168($fp)	# fill _tmp58 to $t1 from $fp-168
	  or $t2, $t0, $t1	
	  sw $t2, -172($fp)	# spill _tmp59 from $t2 to $fp-172
	# IfZ _tmp59 Goto _L7
	  lw $t0, -172($fp)	# fill _tmp59 to $t0 from $fp-172
	  beqz $t0, _L7	# branch if _tmp59 is zero 
	# _tmp60 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t2, _string7	# load label
	  sw $t2, -176($fp)	# spill _tmp60 from $t2 to $fp-176
	# PushParam _tmp60
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -176($fp)	# fill _tmp60 to $t0 from $fp-176
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L7:
	# _tmp61 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -180($fp)	# spill _tmp61 from $t2 to $fp-180
	# _tmp62 = _tmp61 * _tmp53
	  lw $t0, -180($fp)	# fill _tmp61 to $t0 from $fp-180
	  lw $t1, -148($fp)	# fill _tmp53 to $t1 from $fp-148
	  mul $t2, $t0, $t1	
	  sw $t2, -184($fp)	# spill _tmp62 from $t2 to $fp-184
	# _tmp63 = names + _tmp62
	  lw $t0, -8($fp)	# fill names to $t0 from $fp-8
	  lw $t1, -184($fp)	# fill _tmp62 to $t1 from $fp-184
	  add $t2, $t0, $t1	
	  sw $t2, -188($fp)	# spill _tmp63 from $t2 to $fp-188
	# _tmp64 = "Supriya"
	  .data			# create string constant marked with label
	  _string8: .asciiz "Supriya"
	  .text
	  la $t2, _string8	# load label
	  sw $t2, -192($fp)	# spill _tmp64 from $t2 to $fp-192
	# *(_tmp63) = _tmp64
	  lw $t0, -192($fp)	# fill _tmp64 to $t0 from $fp-192
	  lw $t2, -188($fp)	# fill _tmp63 to $t2 from $fp-188
	  sw $t0, 0($t2) 	# store with offset
  _L8:
	# _tmp65 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -196($fp)	# spill _tmp65 from $t2 to $fp-196
	# IfZ _tmp65 Goto _L9
	  lw $t0, -196($fp)	# fill _tmp65 to $t0 from $fp-196
	  beqz $t0, _L9	# branch if _tmp65 is zero 
	# _tmp66 = "\nWho is your favorite EECS483 staff member? "
	  .data			# create string constant marked with label
	  _string9: .asciiz "\nWho is your favorite EECS483 staff member? "
	  .text
	  la $t2, _string9	# load label
	  sw $t2, -200($fp)	# spill _tmp66 from $t2 to $fp-200
	# PushParam _tmp66
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -200($fp)	# fill _tmp66 to $t0 from $fp-200
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp67 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -204($fp)	# spill _tmp67 from $t2 to $fp-204
	# PushParam _tmp67
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -204($fp)	# fill _tmp67 to $t0 from $fp-204
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam names
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill names to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp68 = LCall _Wild
	  jal _Wild          	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -208($fp)	# spill _tmp68 from $t2 to $fp-208
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# IfZ _tmp68 Goto _L10
	  lw $t0, -208($fp)	# fill _tmp68 to $t0 from $fp-208
	  beqz $t0, _L10	# branch if _tmp68 is zero 
	# _tmp69 = "You just earned 1000 bonus points!\n"
	  .data			# create string constant marked with label
	  _string10: .asciiz "You just earned 1000 bonus points!\n"
	  .text
	  la $t2, _string10	# load label
	  sw $t2, -212($fp)	# spill _tmp69 from $t2 to $fp-212
	# PushParam _tmp69
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -212($fp)	# fill _tmp69 to $t0 from $fp-212
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L9
	  b _L9		# unconditional branch
  _L10:
	# _tmp70 = "That's not a good way to make points. Try again!\..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "That's not a good way to make points. Try again!\n"
	  .text
	  la $t2, _string11	# load label
	  sw $t2, -216($fp)	# spill _tmp70 from $t2 to $fp-216
	# PushParam _tmp70
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -216($fp)	# fill _tmp70 to $t0 from $fp-216
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L8
	  b _L8		# unconditional branch
  _L9:
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
