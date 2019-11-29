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
	li $t2,0
	li $t7, -1 
	lb $s0, ($t0)
	beq $s0, 0, insubstring
	beq $s0, 10, insubstring 
	beq $s0, 44, invalidloop
	beq $s0, 9, skip
	beq $s0, 32, skip
	move $t6, $t0
	j loop
	
skip:
	addi $t0,$t0,1
	j start 
	
loop:
	lb $s0, ($t0)
	beq $s0, 0, next
	beq $s0, 10, next	
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
	j start

substring:
	mul $t2,$t2,$t7
next:
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
	beq $s0, 0, continue1
	beq $s0, 10, continue1
	beq $s0,44, invalidloop
	li $t2,0
	j start

SubprogramB:
	beq $t3,0,finish
	addi $t3,$t3,-1
	lb $s0, ($t4)
	
	addi $t4,$t4,1
	j SubprogramC 
	
continue:
	sw $s1,0($sp)
	j SubprogramB
	
SubprogramC:
	move $t8, $t3
	li $t9, 1
	ble $s0, 57, num
	ble $s0, 84, upper
	ble $s0, 116, lower
	
num:
	sub $s0, $s0, 48
	beq $t3, 0, combine
	li $t9, 26		
	j exp

upper:
	sub $s0, $s0, 55
	beq $t3, 0, combine
	li $t9, 26
	j exp
	
lower:
	sub $s0, $s0, 87
	beq $t3, 0, combine
	li $t9, 26
	j exp

exp:
	
	ble $t8, 1, combine
	mul $t9, $t9, 26
	addi $t8, $t8, -1
	j exp

combine:
	mul $s2, $t9, $s0
	
	add $s1,$s1,$s2
	j continue

finish: 
	jr $ra

print:
	mul $t1,$t1,4
	add $sp, $sp $t1

done:	
	sub $t1, $t1,4
	sub $sp,$sp,4
		
	lw $s7, 0($sp)
	
	beq $s7,-1,invalidprint
	
	li $v0, 1
	lw $a0, 0($sp)
	Syscall

com:
	beq $t1, 0,Exit
	li $v0, 4
	la $a0, comma
	syscall
	j done











