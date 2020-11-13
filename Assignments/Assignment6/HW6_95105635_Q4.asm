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
	.end_macro
	.macro print_number() #out = $a0
		li $t7 , 10
		blt $a0 , 10 , NumericPrint
		addi $a0 , $a0 , 87
		print_char()
		j Exit
		NumericPrint:	
			print_int()
		Exit:
	.end_macro
	.macro print_char()
		li $v0 , 11
		syscall
	.end_macro
	# $t1 = x , $t2 = r
	scan_int()
	move $t1 , $v0
	scan_int()
	move $t2 , $v0
	move $s0 , $t1
	li $s1 , 0 # #s0 = counter
	move $fp , $sp
	RadixLoop:
		blt $s0 , $t2 , EndRadixLoop
		div $s0 , $t2
		mflo $s0
		mfhi $s2 # $s2 = remain
		sw $s2 , 0($sp)
		addi $sp , $sp , -4
		j RadixLoop
	EndRadixLoop:
	sw $s0 , 0($sp)
	PrintLoop:
		blt $fp , $sp , EndPrintLoop
		lw $a0 , 0($sp)
		addi $sp , $sp , 4
		print_number()
		j PrintLoop
	EndPrintLoop:
	move $sp , $fp
.data 
	
	
	
	