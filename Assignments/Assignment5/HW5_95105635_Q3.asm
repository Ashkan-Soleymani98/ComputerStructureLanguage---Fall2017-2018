.text
.globl main
main:
	#print 
	la $a0 , a
	li $v0 , 4
	syscall
	#scan a
	li $v0 , 5
	syscall
	move $t0 , $v0
	#print 
	la $a0 , b
	li $v0 , 4
	syscall
	#scan b
	li $v0 , 5
	syscall 
	move $t1 , $v0
	#print 
	la $a0 , char
	li $v0 , 4
	syscall
	#scan char
	li $v0 , 12
	syscall
	add $t2 , $t0 , $t1
	sub $t3 , $t0 , $t1
	move $t0 , $v0
	subi $t0 , $t0 , 43
	sll $t0 , $t0 , 30
	sra $t0 , $t0 , 31
	and $t3 , $t3 , $t0
	nor $t0 , $t0 , $zero
	and $t2 , $t2 , $t0
	or $a0 , $t2 , $t3
	li $v0 , 1
	syscall
.data
	a: .asciiz "please enter a\n"
	b: .asciiz "please enter b\n"
	char: .asciiz "please enter function(+/-)\n" 