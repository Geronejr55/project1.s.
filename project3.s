
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
	#beq $s0, 0, finish



