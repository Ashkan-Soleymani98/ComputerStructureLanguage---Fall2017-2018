.text
.globl main
main:
	.macro scan_int()
	 	li $v0 , 5
	 	syscall
	.end_macro
	.macro print_int (%x)
		li $v0, 1
		add $a0, $zero, %x
		syscall
	.end_macro
	
	scan_int()
	move $t0 , $v0
	scan_int()
	move $t1 , $v0
	srl $s0 , $t0 , 31
	srl $s1 , $t1 , 31
	xor $s0 , $s0 , $s1 
	nor $s0 , $s0 , $zero # not xor MSBs
	addu $t2 , $t0 , $t1
	srl $s2 , $t2 , 31
	xor $s2 , $s1 , $s2
	and $s0 , $s0 , $s2
	print_int($s0)
