
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



