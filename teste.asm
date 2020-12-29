.text
	addi $s0, $zero, 4
	jal check
	j exit
	
	check:
		div $t0, $s0, 4 # divide by four
		mfhi $s1 # take the rest
		bne $s1, $zero, exit
		addi $s0, $s0, 1 # plus with one in $s0
		jr $ra
		
	exit: 
		addi $v0, $zero, 10
		syscall
			