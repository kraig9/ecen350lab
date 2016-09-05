.text               # text section
    .globl main         # call main by MARS
    main:
    addi $t1, $0, 10
    addi $t1, $t1, 10
    addi $t1, $t1, 10
    addi $t1, $t1, 10
    
    addi $t2, $0, 11
    addi $t2, $t2, 11
    add $t3, $t1, $t2   # add two numbers into $t3    
    li $v0, 10
    syscall
