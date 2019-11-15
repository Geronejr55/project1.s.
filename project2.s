.data
data: .space 1001
result: .asciiz "\n"
noValidOutput: .asciiz "Invalid input"

.text
main:
li $v0, 8
la $a0, data
li $a1, 1001
syscall

before:
la $t0,data
add $t0,$t0,$t1
lb $s0, ($t0)
beq $s0, 0, finish
beq $s0, 9, skip
beq $s0, 32, skip
move $t6, $t1
j during

skip:
addi $t1, $t1, 1
j before

during:
li $t7, -1
la $t0,data
add $t0,$t0,$t1
lb $s0, ($t0)
bge $t2, 5, invalid
bge $t3, 1, invalid
addi $t1, $t1, 1
j check

check:
beq $s0, 9, gap
beq $s0, 32, gap
beq $s0, 10, convert
beq $s0, 0, convert
ble $s0, 47, special
ble $s0, 57, integer
ble $s0, 64, special
ble $s0, 84, integer
ble $s0, 96, special
ble $s0, 116, integer
bge $s0, 117, special

special:
j invalid

gap:
addi $t2, $t2, 1
mul $t3, $t3, $t7
j during
