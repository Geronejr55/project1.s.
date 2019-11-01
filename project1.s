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

    sort:
    addi $t0, $t0, 1
    bge $s2, 97, low
    bge $s2, 65, up
    bge $s2, 48, num

    iterator:
    addi $t3,$t3, 1
    lb $s2, ($t3)
    j check
    
    low:
    bge $s2, 123 iterator
    sub $s2, $s2, 87
    add $s3, $s3, $s2
    j iterator
