.text
	addi $s0, $zero, 20
	addi $s1, $zero, 20
	jal is20
	j exit
	
	is20: # function to check if player 2 falls on 20's position
		add $t4, $s1, $zero # $t4 receive player 2's position
		beq $t4, 20, exit   # player 2 won!
		
	exit: 
		addi $v0, $zero, 10
		syscall
			
