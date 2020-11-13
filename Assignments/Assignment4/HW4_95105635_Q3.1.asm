.text
.globl main
main :
	addi $s0, $s0, 1
	sll $t1, $s0, 2
	add $t2, $t9, $t1
	lw $t1, 0($t2)
	sub $t3, $s1, $t1
	nor $s0, $t3, $t3
	
	
