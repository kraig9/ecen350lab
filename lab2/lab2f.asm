        .data
        alphabettable:	.ascii "abcdefghijklmnopqrstuvwxyz"
        .text
        .globl main
        main:
        li $v0, 5		#syscall for read_int
        syscall
        add $t1, $v0, $0	#store the input into $s1
        la $a1, alphabettable	#store the table address into $a1
        add $a1, $a1, $t1
        li $t0, '\0'		#
        sb $t0, 0($a1)		#
        la $a0, alphabettable
        li $v0, 4		#syscall for print_str
        syscall
	li   $v0, 10            # system call for exit
	syscall                 # we are out of here.
