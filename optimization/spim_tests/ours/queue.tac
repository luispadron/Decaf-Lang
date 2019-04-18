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
	  lw $zero, 4($fp)	# fill this to $zero from $fp+4
	  lw $zero, 8($fp)	# fill data to $zero from $fp+8
	  lw $zero, 12($fp)	# fill next to $zero from $fp+12
	  lw $zero, 16($fp)	# fill prev to $zero from $fp+16
	# *(this + 4) = data
	  lw $v0, 8($fp)	# fill data to $v0 from $fp+8
	  lw $v1, 4($fp)	# fill this to $v1 from $fp+4
	  sw $v0, 4($v1) 	# store with offset
	# *(this + 8) = next
	  lw $v0, 12($fp)	# fill next to $v0 from $fp+12
	  lw $v1, 4($fp)	# fill this to $v1 from $fp+4
	  sw $v0, 8($v1) 	# store with offset
	# *(next + 12) = this
	  lw $v0, 4($fp)	# fill this to $v0 from $fp+4
	  lw $v1, 12($fp)	# fill next to $v1 from $fp+12
	  sw $v0, 12($v1) 	# store with offset
	# *(this + 12) = prev
	  lw $v0, 16($fp)	# fill prev to $v0 from $fp+16
	  lw $v1, 4($fp)	# fill this to $v1 from $fp+4
	  sw $v0, 12($v1) 	# store with offset
	# *(prev + 8) = this
	  lw $v0, 4($fp)	# fill this to $v0 from $fp+4
	  lw $v1, 16($fp)	# fill prev to $v1 from $fp+16
	  sw $v0, 8($v1) 	# store with offset
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
	  lw $zero, 4($fp)	# fill this to $zero from $fp+4
	# _tmp0 = *(this + 4)
	  lw $v0, 4($fp)	# fill this to $v0 from $fp+4
	  lw $t0, 4($v0) 	# load with offset
	# Return _tmp0
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
  _QueueItem.GetNext:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	  lw $zero, 4($fp)	# fill this to $zero from $fp+4
	# _tmp1 = *(this + 8)
	  lw $v0, 4($fp)	# fill this to $v0 from $fp+4
	  lw $t0, 8($v0) 	# load with offset
	# Return _tmp1
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
  _QueueItem.GetPrev:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	  lw $zero, 4($fp)	# fill this to $zero from $fp+4
	# _tmp2 = *(this + 12)
	  lw $v0, 4($fp)	# fill this to $v0 from $fp+4
	  lw $t0, 12($v0) 	# load with offset
	# Return _tmp2
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
  _QueueItem.SetNext:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  lw $zero, 4($fp)	# fill this to $zero from $fp+4
	  lw $zero, 8($fp)	# fill n to $zero from $fp+8
	# *(this + 8) = n
	  lw $v0, 8($fp)	# fill n to $v0 from $fp+8
	  lw $v1, 4($fp)	# fill this to $v1 from $fp+4
	  sw $v0, 8($v1) 	# store with offset
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
	  lw $zero, 4($fp)	# fill this to $zero from $fp+4
	  lw $zero, 8($fp)	# fill p to $zero from $fp+8
	# *(this + 12) = p
	  lw $v0, 8($fp)	# fill p to $v0 from $fp+8
	  lw $v1, 4($fp)	# fill this to $v1 from $fp+4
	  sw $v0, 12($v1) 	# store with offset
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
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp3 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# PushParam _tmp3
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp4 = LCall _Alloc
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp5 = QueueItem
	  la $t0, QueueItem	# load label
	# *(_tmp4) = _tmp5
	  sw $t0, 0($t1) 	# store with offset
	# *(this + 4) = _tmp4
	  sw $t1, 4($t2) 	# store with offset
	# _tmp6 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp7 = *(this + 4)
	  lw $t3, 4($t2) 	# load with offset
	# _tmp8 = *(this + 4)
	  lw $t2, 4($t2) 	# load with offset
	# _tmp9 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp10 = *(_tmp9)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp11 = *(_tmp10)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp8
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp7
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# PushParam _tmp6
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam _tmp9
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp11
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
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill i to $t4 from $fp+8
	# _tmp12 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# PushParam _tmp12
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp13 = LCall _Alloc
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill i from $t4 to $fp+8
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill i to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp14 = QueueItem
	  la $t0, QueueItem	# load label
	# *(_tmp13) = _tmp14
	  sw $t0, 0($t1) 	# store with offset
	# temp = _tmp13
	  move $t3, $t1	# copy regs
	# _tmp15 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp16 = *(_tmp15)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp17 = *(_tmp16 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam _tmp15
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp18 = ACall _tmp17
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill i from $t4 to $fp+8
	  sw $t3, -8($fp)	# spill temp from $t3 to $fp-8
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill i to $t4 from $fp+8
	  lw $t3, -8($fp)	# fill temp to $t3 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp19 = *(this + 4)
	  lw $t2, 4($t2) 	# load with offset
	# _tmp20 = *(temp)
	  lw $t1, 0($t3) 	# load with offset
	# _tmp21 = *(_tmp20)
	  lw $t1, 0($t1) 	# load with offset
	# PushParam _tmp19
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp18
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# ACall _tmp21
	  jalr $t1            	# jump to function
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
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp22 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp23 = *(_tmp22)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp24 = *(_tmp23 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam _tmp22
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp25 = ACall _tmp24
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp26 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp27 = _tmp25 == _tmp26
	  seq $t0, $t0, $t1	
	# IfZ _tmp27 Goto _L0
	  beqz $t0, _L0	# branch if _tmp27 is zero 
	# _tmp28 = "Queue Is Empty"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Queue Is Empty"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp28
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp29 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp29
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# Goto _L1
	  b _L1		# unconditional branch
  _L0:
	# _tmp30 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp31 = *(_tmp30)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp32 = *(_tmp31 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam _tmp30
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp33 = ACall _tmp32
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# temp = _tmp33
	  move $t4, $t0	# copy regs
	# _tmp34 = *(temp)
	  lw $t0, 0($t4) 	# load with offset
	# _tmp35 = *(_tmp34 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# _tmp36 = ACall _tmp35
	  sw $t4, -44($fp)	# spill temp from $t4 to $fp-44
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t4, -44($fp)	# fill temp to $t4 from $fp-44
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# val = _tmp36
	  move $t5, $t0	# copy regs
	# _tmp37 = *(temp)
	  lw $t0, 0($t4) 	# load with offset
	# _tmp38 = *(_tmp37 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# _tmp39 = ACall _tmp38
	  sw $t5, -8($fp)	# spill val from $t5 to $fp-8
	  sw $t4, -44($fp)	# spill temp from $t4 to $fp-44
	  jalr $t0            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  lw $t5, -8($fp)	# fill val to $t5 from $fp-8
	  lw $t4, -44($fp)	# fill temp to $t4 from $fp-44
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp40 = *(temp)
	  lw $t0, 0($t4) 	# load with offset
	# _tmp41 = *(_tmp40 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# _tmp42 = ACall _tmp41
	  sw $t5, -8($fp)	# spill val from $t5 to $fp-8
	  sw $t4, -44($fp)	# spill temp from $t4 to $fp-44
	  sw $t2, -84($fp)	# spill _tmp39 from $t2 to $fp-84
	  jalr $t0            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t5, -8($fp)	# fill val to $t5 from $fp-8
	  lw $t4, -44($fp)	# fill temp to $t4 from $fp-44
	  lw $t2, -84($fp)	# fill _tmp39 to $t2 from $fp-84
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp43 = *(_tmp42)
	  lw $t3, 0($t1) 	# load with offset
	# _tmp44 = *(_tmp43 + 16)
	  lw $t0, 16($t3) 	# load with offset
	# PushParam _tmp39
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp42
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp44
	  sw $t5, -8($fp)	# spill val from $t5 to $fp-8
	  sw $t4, -44($fp)	# spill temp from $t4 to $fp-44
	  jalr $t0            	# jump to function
	  lw $t5, -8($fp)	# fill val to $t5 from $fp-8
	  lw $t4, -44($fp)	# fill temp to $t4 from $fp-44
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp45 = *(temp)
	  lw $t0, 0($t4) 	# load with offset
	# _tmp46 = *(_tmp45 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# _tmp47 = ACall _tmp46
	  sw $t5, -8($fp)	# spill val from $t5 to $fp-8
	  sw $t4, -44($fp)	# spill temp from $t4 to $fp-44
	  jalr $t0            	# jump to function
	  move $t3, $v0		# copy function return value from $v0
	  lw $t5, -8($fp)	# fill val to $t5 from $fp-8
	  lw $t4, -44($fp)	# fill temp to $t4 from $fp-44
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp48 = *(temp)
	  lw $t0, 0($t4) 	# load with offset
	# _tmp49 = *(_tmp48 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam temp
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# _tmp50 = ACall _tmp49
	  sw $t5, -8($fp)	# spill val from $t5 to $fp-8
	  sw $t3, -116($fp)	# spill _tmp47 from $t3 to $fp-116
	  jalr $t0            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t5, -8($fp)	# fill val to $t5 from $fp-8
	  lw $t3, -116($fp)	# fill _tmp47 to $t3 from $fp-116
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp51 = *(_tmp50)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp52 = *(_tmp51 + 20)
	  lw $t2, 20($t0) 	# load with offset
	# PushParam _tmp47
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# PushParam _tmp50
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp52
	  sw $t5, -8($fp)	# spill val from $t5 to $fp-8
	  jalr $t2            	# jump to function
	  lw $t5, -8($fp)	# fill val to $t5 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L1:
	# Return val
	  move $v0, $t5		# assign return value into $v0
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
	  li $t0, 8		# load constant value 8 into $t0
	# PushParam _tmp53
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp54 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp55 = Queue
	  la $t0, Queue	# load label
	# *(_tmp54) = _tmp55
	  sw $t0, 0($t1) 	# store with offset
	# q = _tmp54
	  move $t1, $t1	# copy regs
	# _tmp56 = *(q)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp57 = *(_tmp56)
	  lw $t2, 0($t2) 	# load with offset
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp57
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  jalr $t2            	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp58 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# i = _tmp58
	  move $t0, $t2	# copy regs
  _L2:
	# _tmp59 = 10
	  li $t2, 10		# load constant value 10 into $t2
	# _tmp60 = i == _tmp59
	  seq $t3, $t0, $t2	
	# _tmp61 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp62 = _tmp60 == _tmp61
	  seq $t2, $t3, $t2	
	# IfZ _tmp62 Goto _L3
	  beqz $t2, _L3	# branch if _tmp62 is zero 
	# _tmp63 = *(q)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp64 = *(_tmp63 + 4)
	  lw $t2, 4($t2) 	# load with offset
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp64
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jalr $t2            	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp65 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp66 = i + _tmp65
	  add $t2, $t0, $t2	
	# i = _tmp66
	  move $t0, $t2	# copy regs
	# Goto _L2
	  b _L2		# unconditional branch
  _L3:
	# _tmp67 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# i = _tmp67
	  move $t0, $t2	# copy regs
  _L4:
	# _tmp68 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp69 = i == _tmp68
	  seq $t3, $t0, $t2	
	# _tmp70 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp71 = _tmp69 == _tmp70
	  seq $t2, $t3, $t2	
	# IfZ _tmp71 Goto _L5
	  beqz $t2, _L5	# branch if _tmp71 is zero 
	# _tmp72 = *(q)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp73 = *(_tmp72 + 8)
	  lw $t2, 8($t2) 	# load with offset
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp74 = ACall _tmp73
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jalr $t2            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp74
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jal _PrintInt      	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp75 = " "
	  .data			# create string constant marked with label
	  _string2: .asciiz " "
	  .text
	  la $t2, _string2	# load label
	# PushParam _tmp75
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp76 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp77 = i + _tmp76
	  add $t2, $t0, $t2	
	# i = _tmp77
	  move $t0, $t2	# copy regs
	# Goto _L4
	  b _L4		# unconditional branch
  _L5:
	# _tmp78 = "\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "\n"
	  .text
	  la $t2, _string3	# load label
	# PushParam _tmp78
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp79 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# i = _tmp79
	  move $t0, $t2	# copy regs
  _L6:
	# _tmp80 = 10
	  li $t2, 10		# load constant value 10 into $t2
	# _tmp81 = i == _tmp80
	  seq $t3, $t0, $t2	
	# _tmp82 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp83 = _tmp81 == _tmp82
	  seq $t2, $t3, $t2	
	# IfZ _tmp83 Goto _L7
	  beqz $t2, _L7	# branch if _tmp83 is zero 
	# _tmp84 = *(q)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp85 = *(_tmp84 + 4)
	  lw $t2, 4($t2) 	# load with offset
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp85
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jalr $t2            	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp86 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp87 = i + _tmp86
	  add $t2, $t0, $t2	
	# i = _tmp87
	  move $t0, $t2	# copy regs
	# Goto _L6
	  b _L6		# unconditional branch
  _L7:
	# _tmp88 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# i = _tmp88
	  move $t0, $t2	# copy regs
  _L8:
	# _tmp89 = 17
	  li $t2, 17		# load constant value 17 into $t2
	# _tmp90 = i == _tmp89
	  seq $t3, $t0, $t2	
	# _tmp91 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp92 = _tmp90 == _tmp91
	  seq $t2, $t3, $t2	
	# IfZ _tmp92 Goto _L9
	  beqz $t2, _L9	# branch if _tmp92 is zero 
	# _tmp93 = *(q)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp94 = *(_tmp93 + 8)
	  lw $t2, 8($t2) 	# load with offset
	# PushParam q
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp95 = ACall _tmp94
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jalr $t2            	# jump to function
	  move $t2, $v0		# copy function return value from $v0
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp95
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jal _PrintInt      	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp96 = " "
	  .data			# create string constant marked with label
	  _string4: .asciiz " "
	  .text
	  la $t2, _string4	# load label
	# PushParam _tmp96
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t1, -8($fp)	# spill q from $t1 to $fp-8
	  sw $t0, -12($fp)	# spill i from $t0 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t1, -8($fp)	# fill q to $t1 from $fp-8
	  lw $t0, -12($fp)	# fill i to $t0 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp97 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp98 = i + _tmp97
	  add $t2, $t0, $t2	
	# i = _tmp98
	  move $t0, $t2	# copy regs
	# Goto _L8
	  b _L8		# unconditional branch
  _L9:
	# _tmp99 = "\n"
	  .data			# create string constant marked with label
	  _string5: .asciiz "\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp99
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
