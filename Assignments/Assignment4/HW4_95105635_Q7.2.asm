.text
.globl our_label

our_label:
	#initializing data#
	li $s1, 15
	li $s2, 25
	# c = (a - b) >> 31 -> indicates that a > b or a <= b 
	sub $s3, $s1, $s2
	srl $s2, $s3, 31
	# extending MSB
	nor $s2, $s2, $s2
	addi $s2, $s2, 1
	##
	and $s3, $s3, $s2
	sub $s3, $s1, $s3
	
	
	
