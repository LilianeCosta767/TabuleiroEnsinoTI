.text
	addi $s0, $zero, 4
	addi $s1, $zero, 4
	jal isEqual
	j exit
	
	isEqual: # function to check if player 1 falls on the same position than player 2
		add $t3, $s0, $zero  # $t3 receive player 1's position
		add $t4, $s1, $zero  # $t4 receive player 1's position
		bne $t3, $t4, exit # checks if they're (not) equal
		subi $s0, $s0, 1     # player 1 back one position0, 1 # plus with one in $s0
		jr $ra
		
	exit: 
		addi $v0, $zero, 10
		syscall
			
