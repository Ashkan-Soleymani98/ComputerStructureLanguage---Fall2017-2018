.text 
.globl main
main:
	.macro indexed_add($R1, $R2, $R3)#add R1, ($R2+$R3)
	add $at, $R2, $R3
	lw $at, 0($at)
	add $R1, $R1, $at
	.end_macro
	
	.macro register_indirect_add($R1, $R2)#add $R1, ($R2)
	lw $at, 0($R2)
	add $R1, $R1, $at
	.end_macro
	
	
	.macro direct_address_add($R1, %label)#add $R1, (label of the address)
		.data
	label:
		.word %label
		.text
		la, $at, label
		lw $at, 0($at)
		la $at, ($at)
		lw $at, 0($at)
		add $R1, $R1, $at
	.end_macro
	
	.macro memory_indirect_add($R1, $R2)#add $R1, @($R2)
	lw $at, 0($R2)
	lw $at, 0($at)
	add $R1, $R1, $at
	.end_macro
	
	.macro scaled_add($R1, %int, $R2, $R3, %d)#add $R1, int($R2)[$R3]
		.data
	arguments:
		.word %int, %d
		.text
		la $t1, arguments
		lw $t0, 0($t1)#t0 = %int
		lw $t1, 4($t1)#t1 = %d
		mul $at, $R3, $t1#$at = $R3 * d
		add $at, $at, $R2#$at = ($R3 * d) + $R2
		add $at, $at, $t0#$at = ($R3 * d) + $R2 + int
		lw $at, 0($at)
		add $R1, $R1, $at
	.end_macro
		
	.macro auto_increment_add($R1, $R2, %d)#add $R1, ($R2)+
		.data
	arguments:
		.word %d
		.text
		la $t0, arguments
		lw $t0, 0($t0)#$t0 = d
		lw $at, 0($R2)
		add $R1, $R1, $at
		add $R2, $R2, $t0
	.end_macro
		

	


