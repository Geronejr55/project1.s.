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
