.text
.globl main
main:
	.macro scan_string(%ad)
		li $v0,8 #take in input
         	la $a0, %ad #load byte space into address
         	li $a1, 28 # allot the byte space for string
         	syscall
	.end_macro
		

	.macro print_string(%str)
	 	.data
	 	myLabel : .asciiz %str
	 	.text
	 	la $a0 , myLabel
	 	li $v0 , 4
	 	syscall
	.end_macro
	
	.macro print_string_address(%str)
	 	move $a0 , %str
	 	li $v0 , 4
	 	syscall
	.end_macro
	
	.macro scan_int($arg)
		li $v0, 5
		syscall
		add $arg, $zero, $v0
	.end_macro
	
	.macro scan_char($arg)
		li $v0 , 12
		syscall
		move $arg , $v0
	.end_macro
	
	
	scan_string(key)
	scan_int($t2)
	li $v0 , 8
	la $a0 , message
	addi $a1 , $t2 , 1
	addi $t2 , $t2 , 1
	syscall
	la $t0 , key
	la $t1 , message
	move $s0 , $zero
	Loop:
		beq $s0 , $t2 , ExitLoop
		add $t3 , $s0 , $t1
		lb $t4 , 0($t3)
		bgt $t4 , 122 , Exit
		blt $t4 , 97 , Exit
		subi $t4 , $t4 , 97
		add $t4 , $t4 , $t0
		lb $t4 , 0($t4)
		sb $t4 , 0($t3)
		Exit:
		addi $s0 , $s0 , 1
		j Loop
	ExitLoop:
	
	print_string_address($t0)
	print_string_address($t1)
.data
	key: .space 28
	message: .space 152
	

	
	
	
	
