.text
.globl main
main:
	.macro scan_int()
	 	li $v0 , 5
	 	syscall
	.end_macro
	
	scan_int()
	move $t0 , $v0
	la $s1 , res1
	la $s2 , res2
	srl $t1 , $t0 , 3
	sll $t2 , $t0 , 3
	addi $t3 , $zero , 10
	add $t3 , $t3 , $t1
	add $t3 , $t3 , $t2
	sw $t3 , 0($s1)
	srl $t1 , $t0 , 2
	sll $t1 , $t1 , 2
	sub $t1 , $t0 , $t1
	sw $t1 , 0($s2)
.data
	res1: .space 4
	res2: .space 4
	 