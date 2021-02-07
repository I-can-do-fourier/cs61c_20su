.globl factorial

.data
n: .word 7

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    
    bne a0,x0,12
    addi s0, x0, 1
    jr ra
    

    addi sp, sp, -8
    sw  ra, 4(sp)
    sw  a0, 0(sp)
    
    addi a0, a0 -1
    jal factorial 
    
    lw a0,0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8

    mul s0 s0 a0
    add a0,s0,x0
    jr ra

     
    