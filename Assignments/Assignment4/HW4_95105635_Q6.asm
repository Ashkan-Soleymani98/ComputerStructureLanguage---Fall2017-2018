.text
.globl our_label

our_label:
	
	la $s0, word
	lw $t8, 0($s0)
	# ascii : 'a' - 'A' = 32
	li $t9, 32
	sub $t8, $t8, $t9
	lui $t9, 32
	sub $t8, $t8, $t9
	sw $t8, 0($s0)

.data
	word : .ascii "java"