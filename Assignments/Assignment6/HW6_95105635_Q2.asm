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
	#allocate stack
	scan_int()
	li $t2 , -4
	move $s0 , $v0 # $s0 = n
	mul $t1 , $s0 , $t2
	add $sp , $sp , $t1
	li $t1 , 0 # $t1 = i
	li $t2 , 4
	InputLoop:
		beq $s0 , $t1 , InputExit
		scan_int()
		mul $t3 , $t2 , $t1
		add $t3 , $t3 , $sp
		sw $v0 , 0($t3)
		addi $t1 , $t1 , 1
		j InputLoop
	InputExit:
	
	li $t1 , 0 #$t1 = i
	li $t2 , 4
	SortLoop:
		subi $s7 , $s0 , 1 
		beq $s7 , $t1 , SortExit
		mul $s1 , $t1 , $t2
		add $s1 , $s1 , $sp
		lw $t4 , 0($s1) # $t4 = array[i]
		addi $s2 , $t1 , 1
		mul $s2 , $s2 , $t2
		add $s2 , $s2 , $sp
		lw $t5 , 0($s2) # $t5 = array[i]
		addi $t1 , $t1 , 1
		blt $t5 , $t4 , swap
		j SortLoop
		swap:
			sw $t4 , 0($s2)
			sw $t5 , 0($s1)
			li $t1 , 0
			j SortLoop	
	SortExit:
	
	li $t1 , 0 #$t1 = i
	li $t2 , 4
	PrintLoop:
		beq $s0 , $t1 , PrintExit
		mul $s1 , $t1 , $t2
		add $s1 , $s1 , $sp
		lw $a0 , 0($s1)
		print_int()
		addi $t1 , $t1 , 1
		j PrintLoop
	PrintExit:
	mul $t1 , $t1 , $t2
	add $sp , $sp , $t1	
.data 

	
	
	
	