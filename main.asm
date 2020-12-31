.data
	vec: .word 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
.text
	# variables
	# $s0 -> player 1's position 
	# $s1 -> player 2's position
	# $t3 -> player 1's temporal variable
	# $t4 -> player 2's temporal variable
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
		addi $a1, $zero, 6  # lenght
		# include a number between zero and ten excluding ten
		syscall          # generate the random number 
		addi $a0, $a0, 1 # increment one one random number (excluding the zero)
		addi $v0, $zero, 1
		syscall          # print it
		jr $ra
		
	checkPosition1:
		# if position is multiple of four shows a message and go on
		div $t0, $s0, 4      # divide by four
		mfhi $s6             # take the rest
		bne $s6, $zero, is13
		addi $s0, $s0, 1      # plus with one in $s0
		
		is13: # function to check if player 1 falls on 13's position
			add $t3, $s0, $zero
		      	bne $t3, 13, isEqual
		      	subi $s0, $s0, 2 
			
		isEqual: # function to check if player 1 falls on the same position than player 2
			add $t3, $s0, $zero  # $t3 receive player 1's position
			add $t4, $s1, $zero  # $t4 receive player 2's position
			bne $t3, $t4, is20 # checks if they're (not) equal
			subi $s0, $s0, 1     # player 1 back one position
		
		is20: # function to check if player 1 falls on 20's position
			beq $s1, 20, exit   # player 1 won!
		
		return: jr $ra
		
	checkPosition2:
		# if position is multiple of four shows a message and go on
		div $t0, $s1, 4      # divide by four
		mfhi $s6             # take the rest
		bne $s6, $zero, is13 
		addi $s1, $s1, 1     # plus with one in $s1
		
		is13: # function to check if player 1 falls on 13's position
			add $t4, $s1, $zero
		      	bne $t4, 13, isEqual
		      	subi $s1, $s1, 2 
		     
		isEqual: # function to check if player 2 falls on the same position than player 1
			add $t3, $s0, $zero  # $t3 receive player 1's position
			add $t4, $s1, $zero  # $t4 receive player 2's position
			bne $t3, $t4, is20   # checks if they're (not) equal
			subi $s1, $s1, 1     # player 2 back one position
			
		is20: # function to check if player 2 falls on 20's position
			beq $s1, 20, exit   # player 2 won!
			
		return: jr $ra