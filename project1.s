.data
   
    userInput: .space 11 
    newLine: .asciiz "\n"
    
.text 

    main: 
    li $v0, 8
    la $a0, userInput
    li $a1, 11
    syscall

    load_input:
    move $t3, $a0
    lb $s2, ($t3)

    check:
    beq $t0, 10, print
