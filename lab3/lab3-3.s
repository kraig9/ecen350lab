	.data
	my_array: .word 0:9	
	.text
	.globl main
	main:
	la $a1, my_array	#load address of the array
	li $t0, 8		#first digit of my UIN is 8
	li $t1, 0		#initialize i
	li $t2, 10		
	
	loop:
	bge $t1, $t2, exit	#branch if greater than
	sw $t0, 0($a1)		#my_array[i] = j
	li $v0, 1		#syscall to print an integer
	lw $a0, 0($a1)	
	syscall	
	addi $a1, $a1, 4	#go to next word address
	addi $t0, $t0, 1	#j++
	addi $t1, $t1, 1	#i++
	j  loop
	
	exit:
	li $v0, 10	#system call for exit
	syscall
