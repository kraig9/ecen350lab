funca:
la $t0, n
lw $s0, 0($t0)
addi $s2,$zero,1
sub $s1, $s1, $s1
loop:
sll $t0, $s1, 31
slt $t1, $t0, $zero
bne $t1, $zero, skip
add $s1, $s1, $s2
skip:
add $s2, $s2, 1
beq $s2, $s0,done
j loop
done:
addi $v0, $s1, 0
jr $ra

.data
n: .word 11
