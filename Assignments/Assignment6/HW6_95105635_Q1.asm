.text
.globl main
main :
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
	.macro print_combined() #out $a0 , $a1
		li $v0 , 1
		syscall
		move $a0 , $a1
		syscall
		li $v0 , 11
		li $a0 , 32 
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
	.macro scan_char()
		li $v0 , 12
		syscall
	.end_macro
	# $t1 = a  , $t2 = b , $t3 = char
	scan_int()
	move $t1 , $v0 
	scan_int()
	move $t2 , $v0
	scan_char()
	subi $t3 , $v0 , 37
	la $t4 , JumpTable
	li $s0 , 4
	mul $t3 , $t3 , $s0
	add $t3 , $t3 , $t4
	lw $t0 , 0($t3)
	jr $t0
	
	Plus:	
		add $a0 , $t1 , $t2
		print_int()
		j Exit
	Minus:
		sub $a0 , $t1 , $t2
		print_int()
		j Exit
	Times:
		mult $t1 , $t2
		mfhi $a0
		beq $a0 , $zero , label 
		mflo $a1
		print_combined()
		j Exit
		label :
			mflo $a0
			print_int()
			j Exit
	Division:
		div $t1 , $t2
		mflo $a0
		print_int()
		j Exit
	Remain:
		div $t1 , $t2
		mfhi $a0
		print_int()
		j Exit
	Error:
		print_string("Wrong input! Try better next time!!:)")
	Exit:
.data 
	JumpTable: .word Remain , Error , Error , Error , Error , Times , Plus , Error , Minus , Error ,  Division 
	# 37: % , 42: * , 43: + , 45: - , 47: /
	
	
	
	
