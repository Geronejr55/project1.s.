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
