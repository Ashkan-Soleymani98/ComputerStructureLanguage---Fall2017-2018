.text 
.globl main
main:
	.macro print_int() #out = $a0
	 	li $v0 , 1
		syscall
		li $v0 , 11
		li $a0 , 32 
		syscall
	.end_macro
	la $t0 , matrix
	la $t1 , length
	lw $t1 , 0($t1)
	subi $sp , $sp , 8
	sw $t0 , 4($sp)
	sw $t1 , 0($sp)
	jal matrixDet
	lw $a0 , 0($sp)
	print_int()
	li $v0, 10         # set command to stop program
    	syscall
.text
.globl matrixDet
matrixDet:
	lw $t0 , 4($sp) #address
	lw $t1 , 0($sp) #length
	mul $t2 , $t1 , $t1 #n^2
	subi $sp , $sp , 4
	sw $ra , 0($sp)
	#matrix to array
	li $s0 , 0
	mul $s6 , $t2 , 4
	sub $sp , $sp , $s6
CopyLoop:
	beq $s0 , $t2 , ExitCopyLoop
	sll $s1 , $s0 , 2
	add $s2 , $s1 , $t0
	lw $s2 , 0($s2)
	mul $s6 , $s0 , 4
	add $s6 , $s6 , $sp
	sw $s2 , 0($s6)
	addi $s0 , $s0 , 1
	j CopyLoop
ExitCopyLoop:
	subi $sp , $sp , 4
	sw $t1 , 0($sp)
	jal det
	lw $v0 , 0($sp)
	lw $ra , 4($sp)
	addi $sp , $sp , 12
	sw $v0 , 0($sp)
	jr $ra
.text
.globl det
det:
	lw $t0 , 0($sp) # $t0 = length
	li $t9 , 1
	bne $t0 , $t9 , Not1
	lw $t1 , 4($sp)
	addi $sp , $sp , 4
	sw $t1 , 0($sp)
	jr $ra
Not1:
	li $t9 , 2
	bne $t0 , $t9 , Not2
	lw $t1 , 4($sp)
	lw $t2 , 8($sp)
	lw $t3 , 12($sp)
	lw $t4 , 16($sp)
	mul $t1 , $t1 , $t4
	mul $t2 , $t2 , $t3
	sub $t1 , $t1 , $t2
	addi $sp , $sp , 16
	sw $t1 , 0($sp)
	jr $ra
Not2:
	li $s0 , 0 #counter
	li $s7 , 0 #sum
	addi $fp , $sp , 4
OuterLoop:
	beq $s0 , $t0 , ExitOuterLoop
	subi $sp , $sp , 12
	sw $s0 , 0($sp)
	sw $s7 , 4($sp)
	sw $ra , 8($sp)
	move $s2 , $t0 # secondCounter
	mul $s3 , $t0 , $t0 # n^2
InnerLoop:
	beq $s2 , $s3 , ExitInnerLoop
	div $s2 , $t0
	mfhi $t8
	beq $t8 , $s0 , NotPush
	mul $t8 , $s2 , 4
	add $t8 , $t8 , $fp
	lw $t8 , 0($t8)
	subi $sp , $sp , 4
	sw $t8 , 0($sp)
NotPush:
	addi $s2 , $s2 , 1
	j InnerLoop
ExitInnerLoop:
	subi $t6 , $t0 , 1
	subi $sp , $sp ,4
	sw $t6 , 0($sp)
	jal det
	lw $v0 , 0($sp)
	lw $s0 , 4($sp)
	lw $s7 , 8($sp)
	lw $ra , 12($sp)
	lw $t0 , 16($sp)
	add $sp , $sp , 16
	
	mul $s1 , $s0 , 4
	add $s1 , $s1 , $fp
	lw $s1 , 0($s1)
	li $t7 , 2
	div $s0 , $t7
	mfhi $t7
	li $t6 , 1
	mul $s1 , $s1 , $v0
	beq $t7 , $t6 , Odd
	add $s7 , $s7 , $s1
	j Exit
Odd:
	sub $s7 , $s7 , $s1
Exit:
	addi $s0 , $s0 , 1
	j OuterLoop
ExitOuterLoop:
	mul $t3 , $t0 , $t0
	mul $t3 , $t3 , 4
	add $sp , $sp , $t3
	sw $s7 , 0($sp)
	jr $ra
.data
	matrix: .word 1 , 2 , 1 , 0 , 1 , 1 , 1 , 0 , 2
	length: .word 3
