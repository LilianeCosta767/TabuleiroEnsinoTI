dado:
	addi $v0, $zero, 42 # take a random number
	addi $a1, $zero, 6 # lenght

	# include a number between zero and ten excluding ten
	syscall # generate the random number 

	addi $a0, $a0, 1 # increment one one random number (excluding the zero)

	addi $v0, $zero, 1
	syscall # print it

	# other way to print the random number
	#li $v0, 1
	#syscall

	