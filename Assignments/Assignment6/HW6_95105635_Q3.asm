.text
.globl main
main :
	ori $16 , $0 , 17
	la $19 , v
	addi $19 , $19 , 12
	loop:
		lw $t8 , 0($19) # $t8 = *p
		beq $t8 , $zero , finish
		add $16 , $16 , $t8
		addi $19 , $19 , 1
		j loop
	finish:
	
.data 
	v: .word  , , , , , , , , , 
	
	