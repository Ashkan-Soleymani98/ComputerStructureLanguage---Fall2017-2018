.text
.globl our_label

our_label:
	la $s0, x
	lw $t0, 0($s0)
	# 75 = 15 * 5 = (16 - 1) * (4 + 1)
	sll $t1, $t0, 4
	sub $t0, $t1, $t0
	sll $t1, $t0, 2
	add $t0, $t0, $t1
	
	sw $t0, 0($s0)

.data
	x: .word 4