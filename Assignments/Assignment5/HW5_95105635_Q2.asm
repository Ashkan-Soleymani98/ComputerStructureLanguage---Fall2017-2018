.text
.globl main
main :
	 .macro scan_int()
	 	li $v0 , 5
	 	syscall
	 .end_macro
	 .macro print_string(%str)
	 	.data
	 	myLabel : .asciiz %str
	 	.text
	 	la $a0 , myLabel
	 	li $v0 , 4
	 	syscall
	 .end_macro
	 .macro print_string_address(%str)
	 	move $a0 , %str
	 	li $v0 , 4
	 	syscall
	 .end_macro
	 #storing Array
	 la $s0 , Array
	 la $s1 , output0
	 sw $s1 , 0($s0)
	 la $s1 , output1
	 sw $s1 , 4($s0)
	 la $s1 , output2
	 sw $s1 , 8($s0)
	 la $s1 , output3
	 sw $s1 , 12($s0)
	 la $s1 , output4
	 sw $s1 , 16($s0)
	 la $s1 , output5
	 sw $s1 , 20($s0)


	 print_string("Please choose your language:\n0 English\n1 French\n2 Italian\n")
	 scan_int()
	 move $t0 , $v0
	 la $a0 , genderMessage
	 print_string("Please choose your gender:\n0 Male\n1 Female\n")
	 scan_int()
	 move $t1 , $v0
	 sll $t0 , $t0 , 1
	 add $t1 , $t0 , $t1
	 sll $t1 , $t1 , 2
	 add $s0 , $s0 , $t1
	 lw $a0 , 0($s0) 
	 print_string_address($a0)
	 
.data 
	languageMessage : .asciiz "Please choose your language:\n0 English\n1 French\n2 Italian\n"
	genderMessage:  .asciiz "Please choose your gender:\n0 Male\n1 Female\n"
	output0: .asciiz "Hello Sir"
	output1: .asciiz "Hello Madam"
	output2: .asciiz "Bonjour Monsieur"
	output3: .asciiz "Bonjour Madame"
	output4: .asciiz "Salve Signora"
	output5: .asciiz "Salve Signora"
	Array: .word 0 , 0 , 0 , 0 , 0 , 0
	
	
	
	
	
	
	