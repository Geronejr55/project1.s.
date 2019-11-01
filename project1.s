.data
   
    userInput: .space 11 
    newLine: .asciiz "\n"
    
.text 

    main: 
    li $v0, 8
    la $a0, userInput
    li $a1, 11
    syscall
