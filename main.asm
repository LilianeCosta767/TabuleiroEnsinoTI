.data

FileName:   .asciiz "/Users/DELL/Downloads/liliane.txt"
res:        .asciiz "0000"

jogar_dado: 
    .ascii  "\n Select \n"
    .ascii  "YES - se você deseja rodar o dado\n"
    .ascii  "NO - se você não quer rodar o dado\n"
    .asciiz "Cancel - para sair do jogo\n"

.text
	# variables
	# $s0 -> player 1's position 
	# $s1 -> player 2's position
	# $t3 -> player 1's temporal variable
	# $t4 -> player 2's temporal variable
	addi $s0, $zero, 0
	addi $s1, $zero, 0
	
	start:
		la $a0, jogar_dado # chama o texto e armazena em $a0 o valor da resposta
		li $v0, 50 # chama o alerta 
		syscall # faz a chamada de fato
		# the return is in a0: 0=yes, 1=no, 2=cancel
		beq $a0, 0,  jogar1  # se for igual a 0 vai pra chamada do dado
		beq $a0, 1, exit  # se for igual a 1 vai sair do jogo
		b exit            # se for igual a 2 vai sair do jogo
	
		# player 01 play the dice
		jogar1: jal dice
		
		# player 1 avance $a0 positions
		add $s0, $s0, $a0
		# add $a0, $s0, $zero # test
		jal checkPosition1
		
		# player 02 play the dice
		la $a0, jogar_dado # chama o texto e armazena em $a0 o valor da resposta
		li $v0, 50 # chama o alerta 
		syscall # faz a chamada de fato
		# the return is in a0: 0=yes, 1=no, 2=cancel
		beq $a0, 0,  jogar2  # se for igual a 0 vai pra chamada do dado
		beq $a0, 1, exit  # se for igual a 1 vai sair do jogo
		b exit            # se for igual a 2 vai sair do jogo
		
		jogar2: jal dice
		
		# player 2 avance $a0 positions
		add $s1, $s1, $a0
		jal checkPosition2
		
		jal gravaArquivo 
		
		j start
	
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
			bne $s6, $zero, is13I
			addi $s0, $s0, 1      # plus with one in $s0
			j returnI
		
			is13I: # function to check if player 1 falls on 13's position
				add $t3, $s0, $zero
			      	bne $t3, 13, isEqualI
		      		subi $s0, $s0, 2
		      		j returnI
			
			isEqualI: # function to check if player 1 falls on the same position than player 2
				add $t3, $s0, $zero  # $t3 receive player 1's position
				add $t4, $s1, $zero  # $t4 receive player 2's position
				bne $t3, $t4, is20I  # checks if they're (not) equal
				subi $s1, $s1, 1     # player 2 back one position
				j returnI
			
			is20I: # function to check if player 1 falls on 20's position
				blt $s0, 20, returnI   # player 1 won!
				jal gravaArquivo
				jal exit
		
			returnI:
				jr $ra # back
		
		checkPosition2:
			# if position is multiple of four shows a message and go on
			div $t0, $s1, 4       # divide by four
			mfhi $s6              # take the rest
			bne $s6, $zero, is13II
			addi $s1, $s1, 1      # plus with one in $s1
		
			is13II: # function to check if player 1 falls on 13's position
				add $t4, $s1, $zero
		      		bne $t4, 13, isEqualII
			      	subi $s1, $s1, 2 
			      	j returnII
		     
			isEqualII: # function to check if player 2 falls on the same position than player 1
				add $t3, $s0, $zero    # $t3 receive player 1's position
				add $t4, $s1, $zero    # $t4 receive player 2's position
				bne $t3, $t4, is20II   # checks if they're (not) equal
				subi $s0, $s0, 1       # player 1 back one position
				j returnII
			
			is20II: # function to check if player 2 falls on 20's position
				blt $s1, 20, returnI   # player 1 won!
				jal gravaArquivo
				jal exit
			
			returnII:
				jr $ra # back
				
		gravaArquivo:
				# before to start again let's do the txt's arquive
				li $a1, 1           # write mode
				li $v0, 13          # system call for open file
				la $a0, FileName    # output file name
				syscall
				add $a0, $zero, $v0 # save the file descriptor
				li $v0, 15          # system call for write to file
				li $t5, 10
				div $s0, $t5
				mflo $t6
				mfhi $t7
				addi $t6, $t6,48
				addi $t7, $t7,48
				sb $t6, res         # put the player 1's position on "res"
				sb $t7, res + 1     # put the player 2's position on "res"
				div $s1, $t5
				mflo $t6
				mfhi $t7
				addi $t6, $t6,48
				addi $t7, $t7,48
				sb $t6, res + 2        # put the player 1's position on "res"
				sb $t7, res + 3     # put the player 2's position on "res"
				la $a1, res	    #  O endereco do buffer de saída
				li $a2, 4
				syscall
				li $v0, 16          # close the arquive
				syscall
				jr $ra
				
				
# idea = tamanho do tabuleiro variavel
