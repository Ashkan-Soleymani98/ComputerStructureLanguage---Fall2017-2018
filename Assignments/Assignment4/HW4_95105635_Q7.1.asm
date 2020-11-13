.text
.globl our_label

our_label:
	#initializing data#
	li $s1, 5
	li $s2, 7
	# a Xor b = a'b + ab'
	# Not a = a Nor a
	nor $s3, $s1, $s1
	and $s3, $s3, $s2
	nor $s2, $s2, $s2
	and $s2, $s1, $s2
	or $s3, $s3, $s2
