.text 
.globl main
main:
	.macro scan_int() #in = $v0
		li $v0 , 5 
		syscall
	.end_macro
	.macro print_int() #out = $a0
	 	li $v0 , 1
		syscall
		li $v0 , 11
		li $a0 , 32 
		syscall
	.end_macro
	scan_int()
	move $a0 , $v0
	jal phi
	move $a0 , $v0
	print_int()
	li $v0, 10         # set command to stop program
    	syscall
.text
.globl phi
phi:
	subi $sp , $sp , 4
	sw $ra , 0($sp)
	li $t0 , 2
	li $t1 , 1
	addi $t2 , $zero , 1
Loop:
	beq $a0 , $t0 , ExitLoop
	move $a1 , $t0
	jal gcd
	bne $v0 , $t1 , L2
	addi $t2 , $t2 , 1
L2:
	addi $t0 , $t0 , 1
	j Loop
ExitLoop:
	move $v0 , $t2
	lw $ra , 0($sp)
	addi $sp , $sp , 4
	jr $ra
.text
.globl gcd
gcd:
	bne $a1 , $zero , L1
	move $v0 , $a0
	jr $ra
L1:
	subi $sp , $sp , 8
	sw $ra , 4($sp)
	sw $a0 , 0($sp)
	div $a0 , $a1
	move $a0 , $a1
	mfhi $a1
	jal gcd
	lw $ra , 4($sp)
	lw $a0 , 0($sp)
	addi $sp , $sp , 8
	jr $ra
	
	
