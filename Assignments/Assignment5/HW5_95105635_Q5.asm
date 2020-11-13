.text
.globl main
main:
	lw $t0 , 4($16) # load B.array
	sw $t0 , 0($16) # store B.pointer
	lw $t0 , 0($16) # load B.pointer
	lw $t0 , 0($t0) # load *B.pointer
	lw $t1 , 4($16) # load B.array
	sw $t0 , 0($t1) # store B.array[0]
	sw $16 , 16($16) # store B.ff
	
	
	 
	
	
	
	
	
	
	
	
	
	
	
.data