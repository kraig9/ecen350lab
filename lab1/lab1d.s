.text               # text section
    .globl main         # call main by MARS
    main:

addi $t0,$4,0
addi $4,$5,0
addi $5,$t0,0

li $v0, 10
    syscall