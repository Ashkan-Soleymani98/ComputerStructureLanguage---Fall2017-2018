.text
.globl main
main :
	.macro scan_int() 
		li $v0 , 5
	 	syscall
	.end_macro
	.macro print_char()
		li $v0 , 11
		syscall
	.end_macro
	.macro print_space()
		li $a0 , 32
		print_char()
	.end_macro
	.macro print_star()
		li $a0 , 42
		print_char()
	.end_macro
	.macro newline()
		li $a0 , 10
		print_char()
	.end_macro
	scan_int()
	move $t1 , $v0 # $t1 = height
	scan_int()
	move $t2 , $v0 # $t2 = base
	li $s1 , 0 # $s1 = i
	li $s2 , 0 # $s2 = j
	move $t3 , $t1 # $t3 = starting spaces each row
	HeightLoop:
		beq $s1 , $t1 , EndHeightLoop
		subi $t3 , $t3 , 1
		li $s2 , 0
		SpaceLoop:
			beq $s2 , $t3 , EndSpaceLoop
			print_space()
			addi $s2 , $s2 , 1
			j SpaceLoop
		EndSpaceLoop:
		li $s2 , 0
		StarLoop:
			beq $s2 , $t2 , EndStarLoop
			print_star()
			addi $s2 , $s2 , 1
			j StarLoop
		EndStarLoop:
		addi $s1 , $s1 , 1
		newline()
		j HeightLoop
	EndHeightLoop:
.data 

	
	
	
	
	
	
	
