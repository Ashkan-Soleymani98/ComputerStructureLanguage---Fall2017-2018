.text
.globl main

main:
	# initializing a , b
	li $s0 , -5
	li $s1 , -4
	# producing |a| , |b|
	sra $t0 , $s0 , 31
	sra $t1 , $s1 , 31
	nor $t2 , $s0 , $s0 
	nor $t3 , $s1 , $s1 
	addi $t2 , $t2 , 1
	addi $t3 , $t3 , 1
	and $t2 , $t2 , $t0
	and $t3 , $t3 , $t1
		# indicating sign of the product
		xor $t4 , $t0 , $t1
		sra $t4 , $t4 , 31 
	nor $t0 , $t0 , $t0
	nor $t1 , $t1 , $t1
	and $s0 , $s0 , $t0
	and $s1 , $s1 , $t1
	or $s0 , $s0 , $t2
	or $s1 , $s1 , $t3
	# mult
	multu $s0 , $s1
	mflo $t0 
	mfhi $t1
	nor $t2 , $t0 , $t0
	nor $t3 , $t1 , $t1
	addi $t2 , $t2 , 1
	bne $t2 , $zero , NoCarry
	addi $t3 , $t3 , 1
	NoCarry:
	and $t2 , $t2 , $t4
	and $t3 , $t3 , $t4
	nor $t4 , $t4 , $t4
	and $t0 , $t0 , $t4
	and $t1 , $t1 , $t4
	or $t0 , $t0 , $t2
	or $t1 , $t1 , $t3
	
