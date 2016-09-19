.data
msg1:	.word 0:24
.text
.globl main
main:
        li $v0, 8
        la $a0, msg1
        la $a1, 100
        syscall
        addi $s0, $zero, 99
recursion:
	addi $s2, $s2, 1
	lb $t0, ($a0)
	li $t1, 'a'		
        blt $t0, $t1, nomod
        li $t1, 'z'		
        bgt $t0, $t1, nomod
        beq $s0, $s2, end
        j recursion
nomod:
	j recursion
increment:
	
end:
	li $v0, 10
	syscall     