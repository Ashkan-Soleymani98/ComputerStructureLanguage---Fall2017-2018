.text
.globl main
main:
	.macro scan_int()
	 	li $v0 , 5
	 	syscall
	.end_macro
	.macro linear(%a , %x , %b)
		add $s0 , $zero , %a
		add $s1 , $zero , %x
		add $s2 , $zero , %b
		mult $s0 , $s1
		mflo $s0
		add $s0 , $s0 , $s2
		move $s1 , $zero
		move $s2 , $zero
	.end_macro
	
	# output = $s7 input = x , a , b , c
	scan_int()
	move $t0 , $v0
	scan_int()
	move $t1 , $v0
	scan_int()
	move $t2 , $v0
	scan_int()
	move $t3 , $v0
	linear($t1 , $t0 , $t2)
	move $s1 , $s0
	mult $t0 , $t0
	mflo $s2
	mult $t3 , $s2
	mflo $s7
	add $s7 , $s7 , $s1
	mult $t0 , $s2
	mflo $s2
	move $t6 , $s2
	linear($t1 , $t0 , $t2)
	mult $t6 , $s0
	mflo $s0
	add $s7 , $s7 , $s0
	
	.macro print_int (%x)
		li $v0, 1
		add $a0, $zero, %x
		syscall
	.end_macro
	print_int($s7)
	
	
	