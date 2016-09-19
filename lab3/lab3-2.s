	.data 
	UIN: .word 29	#the sum of UIN is 29
	msg1: .asciiz "Value before run is: "
	msg2: .asciiz "\nValue after run is: "
	.text
	.globl main
	main:
	li $v0, 4	
	la $a0, msg1    
	syscall		#print out Value before run is:
	li $v0, 1	
	lw $a0, UIN	
	syscall		#print out 29
	li $t0, 0	#initialize iterator i
	lw $t1, UIN	
	li $t3, 10	
	loop:
	bge $t0, $t3, exit	
	subi $t1, $t1, 1	#UIN = UIN - 1
	addi $t0, $t0, 1	#i = i+ 1
	j  loop
	
	exit:
	sw $t1, UIN
	li $v0, 4	#Print out value after run is
	la $a0, msg2    
	syscall
	li $v0, 1	
	lw $a0, UIN	#print out value after run
	syscall
	li $v0, 10	
	syscall		#exit
	
