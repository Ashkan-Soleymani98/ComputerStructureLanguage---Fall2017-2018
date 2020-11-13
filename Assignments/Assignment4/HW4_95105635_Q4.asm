.text
.globl our_label

our_label:
	#preparing the given data of the problem
	addiu $sp, $sp, 80
	li $t0, 1
	sw $t0, 4($sp)
	li $t0, 2
	sw $t0, 8($sp)
	li $t0, 3
	sw $t0, 16($sp)
	
	#Loading data from stack!
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 16($sp)
	
	#swap x , y (s1 , s2) with xor algorithm
	xor $s1, $s1, $s2
	xor $s2, $s1, $s2
	xor $s1, $s1, $s2
	
	#swap z , y (s1 , s3) with xor algorithm
	xor $s1, $s1, $s3
	xor $s3, $s1, $s3
	xor $s1, $s1, $s3
	
	