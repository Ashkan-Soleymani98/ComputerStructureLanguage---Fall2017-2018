.text 
.globl main
main:
	la $t1 , info
	la $t2 , length
	lw $t2 , 0($t2) # $t2 = length
	move $a0 , $t1
	move $a1 , $t2
	jal sort
	li $v0, 10         # set command to stop program
    	syscall
.text
.globl sort
sort:
	#$a1 = length
	# check length 2 or 1
	li $s0 , 1
	bne $a1 , $s0 , Not1
	jr $ra
Not1:
	li $s0 , 2
	bne $a1 , $s0 , Not2
	lw $s0 , 0($a0)
	lw $s1 , 4($a0)
	blt $s0 , $s1 , Ok
	sw $s1 , 0($a0)
	sw $s0 , 4($a0)
Ok:
	jr $ra
Not2:
	subi $sp , $sp , 12
	sw $a0 , 0($sp)
	sw $a1 , 4($sp)
	sw $ra , 8($sp)
	li $s0 , 2
	div $a1 , $a1 , $s0
	jal sort
	lw $a0 , 0($sp)
	lw $a1 , 4($sp)
	lw $ra , 8($sp)
	li $s0 , 2
	div $s1 , $a1 , $s0
	sub $a1 , $a1 , $s1
	li $s4 , 4
	mul $s6 , $s1 , $s4
	add $a0 , $a0 , $s6
	jal sort
	lw $a0 , 0($sp)
	lw $a1 , 4($sp)
	lw $ra , 8($sp)
	addi $sp , $sp , 12
	li $s0 , 2
	#merge
	li $s4 , 4
	mul $s2 , $a1 , $s4
	sub $sp , $sp , $s2
	div $s1 , $a1 , $s0
	sub $s2 , $a1 , $s1
	move $t0 , $zero #$t0 = i
SortTopLoop:
	beq $t0 , $s1 , ExitSortTopLoop
	move $t7 , $t0 # counter
	mul $t1 , $t0 , $s4
	add $t1 , $a0 , $t1
	lw $t1 , 0($t1)
	li $t2 , 0 # $t2 = j
CompareTopLoop:
	beq $t2 , $s2 , ExitCompareTopLoop
	add $t3 , $t2 , $s1
	mul $t3 , $t3 , $s4
	add $t3 , $a0 , $t3
	lw $t3 , 0($t3)
	blt $t1 , $t3 , NotAdd
	addi $t7 , $t7 , 1
NotAdd:
	addi $t2 , $t2 , 1
	j CompareTopLoop
ExitCompareTopLoop:
	mul $t7 , $t7 , $s4
	add $t7 , $t7 , $sp
	sw $t1 , 0($t7)
	addi $t0 , $t0 , 1
	j SortTopLoop 
ExitSortTopLoop:
	move $t0 , $zero #$t0 = i
SortBottomLoop:
	beq $t0 , $s2 , ExitSortBottomLoop
	move $t7 , $t0
	add $t1 , $s1 , $t0
	mul $t1 , $t1 , $s4
	add $t1 , $a0 , $t1
	lw $t1 , 0($t1)
	li $t2 , 0 # $t2 = j
CompareBottomLoop:
	beq $t2 , $s1 , ExitCompareBottomLoop
	mul $t3 , $t2 , $s4
	add $t3 , $a0 , $t3
	lw $t3 , 0($t3)
	blt $t1 , $t3 , NotAdd2
	beq $t1 , $t3 , NotAdd2
	addi $t7 , $t7 , 1
NotAdd2:
	addi $t2 , $t2 , 1
	j CompareBottomLoop
ExitCompareBottomLoop:
	mul $t7 , $t7 , $s4
	add $t7 , $t7 , $sp
	sw $t1 , 0($t7)
	addi $t0 , $t0 , 1
	j SortBottomLoop
ExitSortBottomLoop:
	
	move $t1 , $zero
CopyToArrayLoop:
	beq $t1 , $a1 , ExitCopyToArrayLoop
	lw $t0 , 0($sp)
	addi $sp , $sp , 4
	mul $t2 , $t1 , $s4
	add $t2 , $t2 , $a0
	sw $t0 , 0($t2)
	addi $t1 , $t1 , 1
	j CopyToArrayLoop
ExitCopyToArrayLoop:
	jr $ra
.data 
	info: .word 1 , 9 , 12 , 7 , 9 , 2 , 3, 6 ,11 , 9 , 9 , 12
	length: .word 12
