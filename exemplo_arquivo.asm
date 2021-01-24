.data
FileName:   .asciiz "/home/andrelumesi/opt/file.txt"
res:        .asciiz "1804"

.text
	# Aritmetica necessaria para colocar
	# sb  $t0, res
	# sb  $t0, res+1
    #Abrir Arquivo
    li      $a1,1                   # write mode (O_WRONLY)
    li      $v0,13                  # system call for open file
    la      $a0,FileName            # output file name
    syscall                         # open a file (descriptor returned in $v0)
    #Escrever Arquivo
    add     $a0, $zero, $v0         # save the file descriptor
    li      $v0,15                  # system call for write to file
    la      $a1,res                 # address of buffer from which to write
    li      $a2,4                  # hardcoded buffer length
    syscall
	 #Fechar Arquivo
    li      $v0,16                  # close
    syscall

    li      $v0,10
    syscall
