        .data
        msg1:	.word 0:24
        .text
        .globl main
        main:
        li $v0, 8		#syscall for read_str
        la $a0, msg1		#load address of msg1 to store string
        li $a1, 100		#msg1 is 100 bytes
        syscall
        addi $s0, $zero, 99
        loop:
        addi  $s2, $s2, 1
        lb $t0, 0($a0)
        li $t1, 'a'		#get value of 'a'
        blt $t0, $t1, nomodify #do nothing if letter is less than 'a'
        li $t1, 'z'		#get value of 'z'
        bgt $t0, $t1, nomodify #do nothing if letter is greater than 'z'
        nomodify:
        addi $a0, $a0, 1
        bne $s0, $s2, loop
        add $a0, $zero, $s1
        li $v0, 1		#syscall for print_str
        syscall
	li $v0, 10            # system call for exit
	syscall                 # we are out of here.
