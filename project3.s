
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


