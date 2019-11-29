.data
	data: .space 1001
	output: .asciiz "\n"
	invalid: .asciiz "NaN"
	comma: .asciiz ","
	
.text
main :
	li $v0,8	
	la $a0,data 
	li $a1, 1001	
	syscall
	
	jal SubprogramA
	
continue1:
	j print
	
SubprogramA:
	sub $sp, $sp,4
	sw $a0, 0($sp)
	lw $t0, 0($sp)
	addi $sp,$sp,4
	move $t6, $t0
	
start:
	li $t2,0 #used to check for space or tabs within the input
	li $t7, -1 #used for invaild input
	lb $s0, ($t0) # loads the bit that $t0 is pointing to
	beq $s0, 0, finish
	beq $s0, 9, skip
	beq $s0, 32, skip
	move $t6, $t0
	j loop
	
skip:
	addi $t0,$t0,1
	j start 
	
loop:
	lb $s0, ($t0)
	beq $s0, 0, substring
	beq $s0, 10, substring	
	addi $t0,$t0,1	
	beq $s0, 44, substring
check:
	bgt $t2,0,invalidloop

characters
	beq $s0, 9,  gap
	beq $s0, 32, gap
	ble $s0, 47, invalidloop
	ble $s0, 57, valid
	ble $s0, 64, invalidloop
	ble $s0, 84, valid
	ble $s0, 96, invalidloop
	ble $s0, 116, valid
	bge $s0, 117, invalidloop
	
gap:
	addi $t2,$t2,-1
	j loop

valid:
	addi $t3, $t3,1
	mul $t2,$t2,$t7
	j loop

invalidloop:
	lb $s0, ($t0)
	beq $s0, 0, insubstring
	beq $s0, 10, insubstring 	
	addi $t0,$t0,1	
	beq $s0, 44, insubstring
	addi $t3, $t3,1
	
	j invalidloop

insubstring:
	addi $t1,$t1,1 	
	sub $sp, $sp,4
	
	sw $t7, 0($sp)
	
	move $t6,$t0
	lb $s0, ($t0)
	beq $s0, 0, continue1
	beq $s0, 10, continue1
	beq $s0,44, invalidloop
	li $t3,0
	li $t2,0
	j loop

substring:
	bgt $t2,0,insubstring
	
characters
	bge $t3,5,insubstring
	addi $t1,$t1,1	
	sub $sp, $sp,4
	sw $t6, 0($sp)
	move $t6,$t0
	lw $t4,0($sp)
	li $s1,0 #sets $s1 to 0 
	jal SubprogramB
	lb $s0, ($t0)









