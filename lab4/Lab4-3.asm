        .data
        msg1: .asciiz "Enter the number\n"
        msg:  .asciiz "The product is "
        .text
        .globl main
        main:
        la $a0, msg1        #load address of msg1 into $a0
        jal prompt_read
        la $a0, msg
        jal print_prompt
        add $t0, $v0, $0
        jal save
        move $a0, $v0
        li $v0, 1
        syscall
        li $v0, 10
        syscall
        
        #do n*(n-1)*...*1 recursively by first putting them to the stack one by one
        save:
        addi $sp, $sp, -8
        sw $t0, 4($sp)
        sw $ra, 0($sp)
        subi $t0, $t0, 1
        beq $t0, 0, endsave
        jal save
        
        rec_mul:
        lw $t0, 4($sp)
        add $a1, $t0, $0
        add $a0, $v0, $0
        jal my_mul
        lw $ra, 0($sp)
        addi $sp, $sp, 8
        jr $ra
        
        
        endsave:
        li $v0, 1
        j rec_mul
        #recursive function ends
        	
        # multiplication function starts
        my_mul:                 #multiply $a0 with $a1
        #does not handle negative $a1!
        #Note: This is an inefficient way to multipy!
        addi $sp, $sp, -4   #make room for $s0 on the stack
        sw $s0, 0($sp)      #push $s0

        add $s0, $a1, $0   #set $s0 equal to $a1
        add $v0, $0, $0    #set $v0 to 0
        mult_loop:
        beq $s0, $0, mult_eol

        add $v0, $v0, $a0
        addi $s0, $s0, -1
        j mult_loop

        mult_eol:
        lw $s0, 0($sp)      #pop $s0
        addi $sp,$sp,4		#adjust $sp
        jr $ra
        # multiplication function finishes
        
 	#do not need to save any additional value
        read_input:
        li $v0, 5
        syscall
        jr $ra
        
        #need to save the value of $v0 before executing
        print_prompt:
        addi $sp, $sp, -4
        sw $v0, 0($sp)
        li $v0, 4
        syscall
        lw $v0, 0($sp)
        addi $sp, $sp, 4
        jr $ra
        
        #need to save the value of $ra before executing
        prompt_read:
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        jal print_prompt
        jal read_input
        lw $ra, 0($sp)
        jr $ra
        
