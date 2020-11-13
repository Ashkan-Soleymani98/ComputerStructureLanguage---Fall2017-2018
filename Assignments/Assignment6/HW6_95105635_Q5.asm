.text
.globl main
main :
	sra $s1 , $2 , 31
	xor $2 , $2 , $s1
	sub $2 , $2 , $s1
.data 
	
	
	