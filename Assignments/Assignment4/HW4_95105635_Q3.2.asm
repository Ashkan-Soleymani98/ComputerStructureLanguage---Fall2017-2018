.text
.globl main
main :
	sll $t1, $t1, 2
	add $t1, $t1, $t9
	lw $t1, 0($t1) #t1 = C[3]
	sll $t2, $s1, 2
	add $t2, $t2, $t8 
	lw $t2, 0($t2)#t2 = B[g++]
	addi $s1, $s1, 1 # g++
	and $t1, $t1, $t2 
	sll $t1, $t1, 2
	add $t1, $t1, $t7
	lw $t1, 0($t1) # t1 = A[B[g++] & C[3]]
	add $s0, $s1, $t1
	
	
	