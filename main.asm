.data
	vec: .word 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
.text
	# variables
	# $t0 -> player 1's position 
	# $t1 -> player 2's position
	addi $s0, $zero, 0
	addi $s1, $zero, 0
	

	# player 01 play the dice
	jal dice
		
	# player 1 avance $a0 positions
	add $s0, $s0, $a0
	jal checkPosition1
		
	# player 02 play the dice
	jal dice
		
	# player 2 avance $a0 positions
	add $s1, $s1, $a0
	jal checkPosition2
	
	
	# functions
	exit:
		addi $v0, $zero, 10
		syscall
			
	
	dice:
		addi $v0, $zero, 42 # take a random number
		addi $a1, $zero, 6 # lenght
		# include a number between zero and ten excluding ten
		syscall # generate the random number 
		addi $a0, $a0, 1 # increment one one random number (excluding the zero)
		addi $v0, $zero, 1
		syscall # print it
		jr $ra
		
	checkPosition1:
		# if position is multiple of four shows a message and go on
		div $t0, $s0, 4 # divide by four
		mfhi $s6 # take the rest
		bne $s6, $zero, is13
		addi $s0, $s0, 1 # plus with one in $s0
		
		is13: 
		
		
		return: jr $ra
		
	checkPosition2:
		# if position is multiple of four shows a message and go on
		div $t0, $s1, 4 # divide by four
		mfhi $s6 # take the rest
		bne $s6, $zero, return
		addi $s1, $s1, 1 # plus with one in $s1
		return: jr $ra