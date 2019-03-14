	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _QueueItem.Init:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# *(this + 4) = data
	  lw $t0, 8($fp)	# fill data to $t0 from $fp+8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# *(this + 8) = next
	  lw $t0, 12($fp)	# fill next to $t0 from $fp+12
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# *(next + 12) = this
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($fp)	# fill next to $t2 from $fp+12
	  sw $t0, 12($t2) 	# store with offset
	# *(this + 12) = prev
	  lw $t0, 16($fp)	# fill prev to $t0 from $fp+16
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 12($t2) 	# store with offset
	# *(prev + 8) = this
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($fp)	# fill prev to $t2 from $fp+16
	  sw $t0, 8($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _QueueItem.GetData:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp0 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp0 from $t2 to $fp-8
	# Return _tmp0
	  lw $t2, -8($fp)	# fill _tmp0 to $t2 from $fp-8
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
  _QueueItem.GetNext:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp1 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp1 from $t2 to $fp-8
	# Return _tmp1
	  lw $t2, -8($fp)	# fill _tmp1 to $t2 from $fp-8
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
  _QueueItem.GetPrev:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp2 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -8($fp)	# spill _tmp2 from $t2 to $fp-8
	# Return _tmp2
	  lw $t2, -8($fp)	# fill _tmp2 to $t2 from $fp-8
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
  _QueueItem.SetNext:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# *(this + 8) = n
	  lw $t0, 8($fp)	# fill n to $t0 from $fp+8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 8($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _QueueItem.SetPrev:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# *(this + 12) = p
	  lw $t0, 8($fp)	# fill p to $t0 from $fp+8
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 12($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class QueueItem
	  .data
	  .align 2
	  QueueItem:		# label for class QueueItem vtable
	  .word _QueueItem.Init
	  .word _QueueItem.GetData
	  .word _QueueItem.GetNext
	  .word _QueueItem.GetPrev
	  .word _QueueItem.SetNext
	  .word _QueueItem.SetPrev
	  .text
  _Queue.Init:
	# BeginFunc 36
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 36	# decrement sp to make space for locals/temps
	# _tmp3 = 16
	  li $t2, 16		# load constant value 16 into $t2
	  sw $t2, -8($fp)	# spill _tmp3 from $t2 to $fp-8
	# PushParam _tmp3
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill _tmp3 to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp4 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -12($fp)	# spill _tmp4 from $t2 to $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp5 = QueueItem
	  la $t2, QueueItem	# load label
	  sw $t2, -16($fp)	# spill _tmp5 from $t2 to $fp-16
	# *(_tmp4) = _tmp5
	  lw $t0, -16($fp)	# fill _tmp5 to $t0 from $fp-16
	  lw $t2, -12($fp)	# fill _tmp4 to $t2 from $fp-12
	  sw $t0, 0($t2) 	# store with offset
	# *(this + 4) = _tmp4
	  lw $t0, -12($fp)	# fill _tmp4 to $t0 from $fp-12
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  sw $t0, 4($t2) 	# store with offset
	# _tmp6 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -20($fp)	# spill _tmp6 from $t2 to $fp-20
	# _tmp7 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp7 from $t2 to $fp-24
	# _tmp8 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp8 from $t2 to $fp-28
	# _tmp9 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp9 from $t2 to $fp-32
	# _tmp10 = *(_tmp9)
	  lw $t0, -32($fp)	# fill _tmp9 to $t0 from $fp-32
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -36($fp)	# spill _tmp10 from $t2 to $fp-36
	# _tmp11 = *(_tmp10)
	  lw $t0, -36($fp)	# fill _tmp10 to $t0 from $fp-36
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp11 from $t2 to $fp-40
	# PushParam _tmp8
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# fill _tmp8 to $t0 from $fp-28
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp7
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -24($fp)	# fill _tmp7 to $t0 from $fp-24
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp6
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -20($fp)	# fill _tmp6 to $t0 from $fp-20
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp9
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -32($fp)	# fill _tmp9 to $t0 from $fp-32
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp11
	  lw $t0, -40($fp)	# fill _tmp11 to $t0 from $fp-40
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Queue.EnQueue:
	# BeginFunc 44
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 44	# decrement sp to make space for locals/temps
	# _tmp12 = 16
	  li $t2, 16		# load constant value 16 into $t2
	  sw $t2, -12($fp)	# spill _tmp12 from $t2 to $fp-12
	# PushParam _tmp12
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp12 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp13 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -16($fp)	# spill _tmp13 from $t2 to $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp14 = QueueItem
	  la $t2, QueueItem	# load label
	  sw $t2, -20($fp)	# spill _tmp14 from $t2 to $fp-20
	# *(_tmp13) = _tmp14
	  lw $t0, -20($fp)	# fill _tmp14 to $t0 from $fp-20
	  lw $t2, -16($fp)	# fill _tmp13 to $t2 from $fp-16
	  sw $t0, 0($t2) 	# store with offset
	# temp = _tmp13
	  lw $t2, -16($fp)	# fill _tmp13 to $t2 from $fp-16
	  sw $t2, -8($fp)	# spill temp from $t2 to $fp-8
	# _tmp15 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -24($fp)	# spill _tmp15 from $t2 to $fp-24
	# _tmp16 = *(_tmp15)
	  lw $t0, -24($fp)	# fill _tmp15 to $t0 from $fp-24
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp16 from $t2 to $fp-28
	# _tmp17 = *(_tmp16 + 8)
	  lw $t0, -28($fp)	# fill _tmp16 to $t0 from $fp-28
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp17 from $t2 to $fp-32
	# PushParam _tmp15
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -24($fp)	# fill _tmp15 to $t0 from $fp-24
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp18 = ACall _tmp17
	  lw $t0, -32($fp)	# fill _tmp17 to $t0 from $fp-32
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -36($fp)	# spill _tmp18 from $t2 to $fp-36
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp19 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -40($fp)	# spill _tmp19 from $t2 to $fp-40
	# _tmp20 = *(temp)
	  lw $t0, -8($fp)	# fill temp to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -44($fp)	# spill _tmp20 from $t2 to $fp-44
	# _tmp21 = *(_tmp20)
	  lw $t0, -44($fp)	# fill _tmp20 to $t0 from $fp-44
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp21 from $t2 to $fp-48
	# PushParam _tmp19
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -40($fp)	# fill _tmp19 to $t0 from $fp-40
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp18
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -36($fp)	# fill _tmp18 to $t0 from $fp-36
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill i to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill temp to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp21
	  lw $t0, -48($fp)	# fill _tmp21 to $t0 from $fp-48
	  jalr $t0            	# jump to function
	# PopParams 16
	  add $sp, $sp, 16	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Queue.DeQueue:
	# BeginFunc 132
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 132	# decrement sp to make space for locals/temps
	# _tmp22 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -12($fp)	# spill _tmp22 from $t2 to $fp-12
	# _tmp23 = *(_tmp22)
	  lw $t0, -12($fp)	# fill _tmp22 to $t0 from $fp-12
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -16($fp)	# spill _tmp23 from $t2 to $fp-16
	# _tmp24 = *(_tmp23 + 12)
	  lw $t0, -16($fp)	# fill _tmp23 to $t0 from $fp-16
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -20($fp)	# spill _tmp24 from $t2 to $fp-20
	# PushParam _tmp22
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill _tmp22 to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp25 = ACall _tmp24
	  lw $t0, -20($fp)	# fill _tmp24 to $t0 from $fp-20
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -24($fp)	# spill _tmp25 from $t2 to $fp-24
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp26 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp26 from $t2 to $fp-28
	# _tmp27 = _tmp25 == _tmp26
	  lw $t0, -24($fp)	# fill _tmp25 to $t0 from $fp-24
	  lw $t1, -28($fp)	# fill _tmp26 to $t1 from $fp-28
	  seq $t2, $t0, $t1	
	  sw $t2, -32($fp)	# spill _tmp27 from $t2 to $fp-32
	# IfZ _tmp27 Goto _L0
	  lw $t0, -32($fp)	# fill _tmp27 to $t0 from $fp-32
	  beqz $t0, _L0	# branch if _tmp27 is zero 
	# _tmp28 = "Queue Is Empty"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Queue Is Empty"
	  .text
	  la $t2, _string1	# load label
	  sw $t2, -36($fp)	# spill _tmp28 from $t2 to $fp-36
	# PushParam _tmp28
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -36($fp)	# fill _tmp28 to $t0 from $fp-36
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp29 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -40($fp)	# spill _tmp29 from $t2 to $fp-40
	# Return _tmp29
	  lw $t2, -40($fp)	# fill _tmp29 to $t2 from $fp-40
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# Goto _L1
	  b _L1		# unconditional branch
  _L0:
	# _tmp30 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -48($fp)	# spill _tmp30 from $t2 to $fp-48
	# _tmp31 = *(_tmp30)
	  lw $t0, -48($fp)	# fill _tmp30 to $t0 from $fp-48
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -52($fp)	# spill _tmp31 from $t2 to $fp-52
	# _tmp32 = *(_tmp31 + 12)
	  lw $t0, -52($fp)	# fill _tmp31 to $t0 from $fp-52
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -56($fp)	# spill _tmp32 from $t2 to $fp-56
	# PushParam _tmp30
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -48($fp)	# fill _tmp30 to $t0 from $fp-48
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp33 = ACall _tmp32
	  lw $t0, -56($fp)	# fill _tmp32 to $t0 from $fp-56
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -60($fp)	# spill _tmp33 from $t2 to $fp-60
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# temp = _tmp33
	  lw $t2, -60($fp)	# fill _tmp33 to $t2 from $fp-60
	  sw $t2, -44($fp)	# spill temp from $t2 to $fp-44
	# _tmp34 = *(temp)
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -64($fp)	# spill _tmp34 from $t2 to $fp-64
	# _tmp35 = *(_tmp34 + 4)
	  lw $t0, -64($fp)	# fill _tmp34 to $t0 from $fp-64
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -68($fp)	# spill _tmp35 from $t2 to $fp-68
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp36 = ACall _tmp35
	  lw $t0, -68($fp)	# fill _tmp35 to $t0 from $fp-68
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -72($fp)	# spill _tmp36 from $t2 to $fp-72
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# val = _tmp36
	  lw $t2, -72($fp)	# fill _tmp36 to $t2 from $fp-72
	  sw $t2, -8($fp)	# spill val from $t2 to $fp-8
	# _tmp37 = *(temp)
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -76($fp)	# spill _tmp37 from $t2 to $fp-76
	# _tmp38 = *(_tmp37 + 8)
	  lw $t0, -76($fp)	# fill _tmp37 to $t0 from $fp-76
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -80($fp)	# spill _tmp38 from $t2 to $fp-80
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp39 = ACall _tmp38
	  lw $t0, -80($fp)	# fill _tmp38 to $t0 from $fp-80
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -84($fp)	# spill _tmp39 from $t2 to $fp-84
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp40 = *(temp)
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -88($fp)	# spill _tmp40 from $t2 to $fp-88
	# _tmp41 = *(_tmp40 + 12)
	  lw $t0, -88($fp)	# fill _tmp40 to $t0 from $fp-88
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp41 from $t2 to $fp-92
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp42 = ACall _tmp41
	  lw $t0, -92($fp)	# fill _tmp41 to $t0 from $fp-92
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -96($fp)	# spill _tmp42 from $t2 to $fp-96
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp43 = *(_tmp42)
	  lw $t0, -96($fp)	# fill _tmp42 to $t0 from $fp-96
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -100($fp)	# spill _tmp43 from $t2 to $fp-100
	# _tmp44 = *(_tmp43 + 16)
	  lw $t0, -100($fp)	# fill _tmp43 to $t0 from $fp-100
	  lw $t2, 16($t0) 	# load with offset
	  sw $t2, -104($fp)	# spill _tmp44 from $t2 to $fp-104
	# PushParam _tmp39
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -84($fp)	# fill _tmp39 to $t0 from $fp-84
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp42
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -96($fp)	# fill _tmp42 to $t0 from $fp-96
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp44
	  lw $t0, -104($fp)	# fill _tmp44 to $t0 from $fp-104
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp45 = *(temp)
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -108($fp)	# spill _tmp45 from $t2 to $fp-108
	# _tmp46 = *(_tmp45 + 12)
	  lw $t0, -108($fp)	# fill _tmp45 to $t0 from $fp-108
	  lw $t2, 12($t0) 	# load with offset
	  sw $t2, -112($fp)	# spill _tmp46 from $t2 to $fp-112
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp47 = ACall _tmp46
	  lw $t0, -112($fp)	# fill _tmp46 to $t0 from $fp-112
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -116($fp)	# spill _tmp47 from $t2 to $fp-116
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp48 = *(temp)
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -120($fp)	# spill _tmp48 from $t2 to $fp-120
	# _tmp49 = *(_tmp48 + 8)
	  lw $t0, -120($fp)	# fill _tmp48 to $t0 from $fp-120
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -124($fp)	# spill _tmp49 from $t2 to $fp-124
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -44($fp)	# fill temp to $t0 from $fp-44
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp50 = ACall _tmp49
	  lw $t0, -124($fp)	# fill _tmp49 to $t0 from $fp-124
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -128($fp)	# spill _tmp50 from $t2 to $fp-128
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp51 = *(_tmp50)
	  lw $t0, -128($fp)	# fill _tmp50 to $t0 from $fp-128
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -132($fp)	# spill _tmp51 from $t2 to $fp-132
	# _tmp52 = *(_tmp51 + 20)
	  lw $t0, -132($fp)	# fill _tmp51 to $t0 from $fp-132
	  lw $t2, 20($t0) 	# load with offset
	  sw $t2, -136($fp)	# spill _tmp52 from $t2 to $fp-136
	# PushParam _tmp47
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -116($fp)	# fill _tmp47 to $t0 from $fp-116
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp50
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -128($fp)	# fill _tmp50 to $t0 from $fp-128
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp52
	  lw $t0, -136($fp)	# fill _tmp52 to $t0 from $fp-136
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L1:
	# Return val
	  lw $t2, -8($fp)	# fill val to $t2 from $fp-8
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
	# VTable for class Queue
	  .data
	  .align 2
	  Queue:		# label for class Queue vtable
	  .word _Queue.Init
	  .word _Queue.EnQueue
	  .word _Queue.DeQueue
	  .text
  main:
	# BeginFunc 196
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 196	# decrement sp to make space for locals/temps
	# _tmp53 = 8
	  li $t2, 8		# load constant value 8 into $t2
	  sw $t2, -16($fp)	# spill _tmp53 from $t2 to $fp-16
	# PushParam _tmp53
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -16($fp)	# fill _tmp53 to $t0 from $fp-16
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp54 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -20($fp)	# spill _tmp54 from $t2 to $fp-20
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp55 = Queue
	  la $t2, Queue	# load label
	  sw $t2, -24($fp)	# spill _tmp55 from $t2 to $fp-24
	# *(_tmp54) = _tmp55
	  lw $t0, -24($fp)	# fill _tmp55 to $t0 from $fp-24
	  lw $t2, -20($fp)	# fill _tmp54 to $t2 from $fp-20
	  sw $t0, 0($t2) 	# store with offset
	# q = _tmp54
	  lw $t2, -20($fp)	# fill _tmp54 to $t2 from $fp-20
	  sw $t2, -8($fp)	# spill q from $t2 to $fp-8
	# _tmp56 = *(q)
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -28($fp)	# spill _tmp56 from $t2 to $fp-28
	# _tmp57 = *(_tmp56)
	  lw $t0, -28($fp)	# fill _tmp56 to $t0 from $fp-28
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -32($fp)	# spill _tmp57 from $t2 to $fp-32
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp57
	  lw $t0, -32($fp)	# fill _tmp57 to $t0 from $fp-32
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp58 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -36($fp)	# spill _tmp58 from $t2 to $fp-36
	# i = _tmp58
	  lw $t2, -36($fp)	# fill _tmp58 to $t2 from $fp-36
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
  _L2:
	# _tmp59 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -40($fp)	# spill _tmp59 from $t2 to $fp-40
	# _tmp60 = i == _tmp59
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -40($fp)	# fill _tmp59 to $t1 from $fp-40
	  seq $t2, $t0, $t1	
	  sw $t2, -44($fp)	# spill _tmp60 from $t2 to $fp-44
	# _tmp61 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -48($fp)	# spill _tmp61 from $t2 to $fp-48
	# _tmp62 = _tmp60 == _tmp61
	  lw $t0, -44($fp)	# fill _tmp60 to $t0 from $fp-44
	  lw $t1, -48($fp)	# fill _tmp61 to $t1 from $fp-48
	  seq $t2, $t0, $t1	
	  sw $t2, -52($fp)	# spill _tmp62 from $t2 to $fp-52
	# IfZ _tmp62 Goto _L3
	  lw $t0, -52($fp)	# fill _tmp62 to $t0 from $fp-52
	  beqz $t0, _L3	# branch if _tmp62 is zero 
	# _tmp63 = *(q)
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -56($fp)	# spill _tmp63 from $t2 to $fp-56
	# _tmp64 = *(_tmp63 + 4)
	  lw $t0, -56($fp)	# fill _tmp63 to $t0 from $fp-56
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -60($fp)	# spill _tmp64 from $t2 to $fp-60
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp64
	  lw $t0, -60($fp)	# fill _tmp64 to $t0 from $fp-60
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp65 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -64($fp)	# spill _tmp65 from $t2 to $fp-64
	# _tmp66 = i + _tmp65
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -64($fp)	# fill _tmp65 to $t1 from $fp-64
	  add $t2, $t0, $t1	
	  sw $t2, -68($fp)	# spill _tmp66 from $t2 to $fp-68
	# i = _tmp66
	  lw $t2, -68($fp)	# fill _tmp66 to $t2 from $fp-68
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
	# Goto _L2
	  b _L2		# unconditional branch
  _L3:
	# _tmp67 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -72($fp)	# spill _tmp67 from $t2 to $fp-72
	# i = _tmp67
	  lw $t2, -72($fp)	# fill _tmp67 to $t2 from $fp-72
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
  _L4:
	# _tmp68 = 4
	  li $t2, 4		# load constant value 4 into $t2
	  sw $t2, -76($fp)	# spill _tmp68 from $t2 to $fp-76
	# _tmp69 = i == _tmp68
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -76($fp)	# fill _tmp68 to $t1 from $fp-76
	  seq $t2, $t0, $t1	
	  sw $t2, -80($fp)	# spill _tmp69 from $t2 to $fp-80
	# _tmp70 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -84($fp)	# spill _tmp70 from $t2 to $fp-84
	# _tmp71 = _tmp69 == _tmp70
	  lw $t0, -80($fp)	# fill _tmp69 to $t0 from $fp-80
	  lw $t1, -84($fp)	# fill _tmp70 to $t1 from $fp-84
	  seq $t2, $t0, $t1	
	  sw $t2, -88($fp)	# spill _tmp71 from $t2 to $fp-88
	# IfZ _tmp71 Goto _L5
	  lw $t0, -88($fp)	# fill _tmp71 to $t0 from $fp-88
	  beqz $t0, _L5	# branch if _tmp71 is zero 
	# _tmp72 = *(q)
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -92($fp)	# spill _tmp72 from $t2 to $fp-92
	# _tmp73 = *(_tmp72 + 8)
	  lw $t0, -92($fp)	# fill _tmp72 to $t0 from $fp-92
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -96($fp)	# spill _tmp73 from $t2 to $fp-96
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp74 = ACall _tmp73
	  lw $t0, -96($fp)	# fill _tmp73 to $t0 from $fp-96
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -100($fp)	# spill _tmp74 from $t2 to $fp-100
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp74
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -100($fp)	# fill _tmp74 to $t0 from $fp-100
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp75 = " "
	  .data			# create string constant marked with label
	  _string2: .asciiz " "
	  .text
	  la $t2, _string2	# load label
	  sw $t2, -104($fp)	# spill _tmp75 from $t2 to $fp-104
	# PushParam _tmp75
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -104($fp)	# fill _tmp75 to $t0 from $fp-104
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp76 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -108($fp)	# spill _tmp76 from $t2 to $fp-108
	# _tmp77 = i + _tmp76
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -108($fp)	# fill _tmp76 to $t1 from $fp-108
	  add $t2, $t0, $t1	
	  sw $t2, -112($fp)	# spill _tmp77 from $t2 to $fp-112
	# i = _tmp77
	  lw $t2, -112($fp)	# fill _tmp77 to $t2 from $fp-112
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
	# Goto _L4
	  b _L4		# unconditional branch
  _L5:
	# _tmp78 = "\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "\n"
	  .text
	  la $t2, _string3	# load label
	  sw $t2, -116($fp)	# spill _tmp78 from $t2 to $fp-116
	# PushParam _tmp78
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -116($fp)	# fill _tmp78 to $t0 from $fp-116
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp79 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -120($fp)	# spill _tmp79 from $t2 to $fp-120
	# i = _tmp79
	  lw $t2, -120($fp)	# fill _tmp79 to $t2 from $fp-120
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
  _L6:
	# _tmp80 = 10
	  li $t2, 10		# load constant value 10 into $t2
	  sw $t2, -124($fp)	# spill _tmp80 from $t2 to $fp-124
	# _tmp81 = i == _tmp80
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -124($fp)	# fill _tmp80 to $t1 from $fp-124
	  seq $t2, $t0, $t1	
	  sw $t2, -128($fp)	# spill _tmp81 from $t2 to $fp-128
	# _tmp82 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -132($fp)	# spill _tmp82 from $t2 to $fp-132
	# _tmp83 = _tmp81 == _tmp82
	  lw $t0, -128($fp)	# fill _tmp81 to $t0 from $fp-128
	  lw $t1, -132($fp)	# fill _tmp82 to $t1 from $fp-132
	  seq $t2, $t0, $t1	
	  sw $t2, -136($fp)	# spill _tmp83 from $t2 to $fp-136
	# IfZ _tmp83 Goto _L7
	  lw $t0, -136($fp)	# fill _tmp83 to $t0 from $fp-136
	  beqz $t0, _L7	# branch if _tmp83 is zero 
	# _tmp84 = *(q)
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -140($fp)	# spill _tmp84 from $t2 to $fp-140
	# _tmp85 = *(_tmp84 + 4)
	  lw $t0, -140($fp)	# fill _tmp84 to $t0 from $fp-140
	  lw $t2, 4($t0) 	# load with offset
	  sw $t2, -144($fp)	# spill _tmp85 from $t2 to $fp-144
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp85
	  lw $t0, -144($fp)	# fill _tmp85 to $t0 from $fp-144
	  jalr $t0            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp86 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -148($fp)	# spill _tmp86 from $t2 to $fp-148
	# _tmp87 = i + _tmp86
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -148($fp)	# fill _tmp86 to $t1 from $fp-148
	  add $t2, $t0, $t1	
	  sw $t2, -152($fp)	# spill _tmp87 from $t2 to $fp-152
	# i = _tmp87
	  lw $t2, -152($fp)	# fill _tmp87 to $t2 from $fp-152
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
	# Goto _L6
	  b _L6		# unconditional branch
  _L7:
	# _tmp88 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -156($fp)	# spill _tmp88 from $t2 to $fp-156
	# i = _tmp88
	  lw $t2, -156($fp)	# fill _tmp88 to $t2 from $fp-156
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
  _L8:
	# _tmp89 = 17
	  li $t2, 17		# load constant value 17 into $t2
	  sw $t2, -160($fp)	# spill _tmp89 from $t2 to $fp-160
	# _tmp90 = i == _tmp89
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -160($fp)	# fill _tmp89 to $t1 from $fp-160
	  seq $t2, $t0, $t1	
	  sw $t2, -164($fp)	# spill _tmp90 from $t2 to $fp-164
	# _tmp91 = 0
	  li $t2, 0		# load constant value 0 into $t2
	  sw $t2, -168($fp)	# spill _tmp91 from $t2 to $fp-168
	# _tmp92 = _tmp90 == _tmp91
	  lw $t0, -164($fp)	# fill _tmp90 to $t0 from $fp-164
	  lw $t1, -168($fp)	# fill _tmp91 to $t1 from $fp-168
	  seq $t2, $t0, $t1	
	  sw $t2, -172($fp)	# spill _tmp92 from $t2 to $fp-172
	# IfZ _tmp92 Goto _L9
	  lw $t0, -172($fp)	# fill _tmp92 to $t0 from $fp-172
	  beqz $t0, _L9	# branch if _tmp92 is zero 
	# _tmp93 = *(q)
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  lw $t2, 0($t0) 	# load with offset
	  sw $t2, -176($fp)	# spill _tmp93 from $t2 to $fp-176
	# _tmp94 = *(_tmp93 + 8)
	  lw $t0, -176($fp)	# fill _tmp93 to $t0 from $fp-176
	  lw $t2, 8($t0) 	# load with offset
	  sw $t2, -180($fp)	# spill _tmp94 from $t2 to $fp-180
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill q to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp95 = ACall _tmp94
	  lw $t0, -180($fp)	# fill _tmp94 to $t0 from $fp-180
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  sw $t2, -184($fp)	# spill _tmp95 from $t2 to $fp-184
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp95
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -184($fp)	# fill _tmp95 to $t0 from $fp-184
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp96 = " "
	  .data			# create string constant marked with label
	  _string4: .asciiz " "
	  .text
	  la $t2, _string4	# load label
	  sw $t2, -188($fp)	# spill _tmp96 from $t2 to $fp-188
	# PushParam _tmp96
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -188($fp)	# fill _tmp96 to $t0 from $fp-188
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp97 = 1
	  li $t2, 1		# load constant value 1 into $t2
	  sw $t2, -192($fp)	# spill _tmp97 from $t2 to $fp-192
	# _tmp98 = i + _tmp97
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	  lw $t1, -192($fp)	# fill _tmp97 to $t1 from $fp-192
	  add $t2, $t0, $t1	
	  sw $t2, -196($fp)	# spill _tmp98 from $t2 to $fp-196
	# i = _tmp98
	  lw $t2, -196($fp)	# fill _tmp98 to $t2 from $fp-196
	  sw $t2, -12($fp)	# spill i from $t2 to $fp-12
	# Goto _L8
	  b _L8		# unconditional branch
  _L9:
	# _tmp99 = "\n"
	  .data			# create string constant marked with label
	  _string5: .asciiz "\n"
	  .text
	  la $t2, _string5	# load label
	  sw $t2, -200($fp)	# spill _tmp99 from $t2 to $fp-200
	# PushParam _tmp99
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -200($fp)	# fill _tmp99 to $t0 from $fp-200
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
