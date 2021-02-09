.globl write_matrix2


.text
write_matrix2:

    # Prologue

    addi sp sp -4
    sw ra 0(sp)

    addi sp sp -8
    sw a1 0(sp)
    sw a2 4(sp)



     add a1 a0 x0
     addi a2 x0 1
     jal ra fopen



     addi t2 x0 -1
     bne a0 t2 12
     addi a1 x0 53
     j exit2
     

    lw a1 0(sp)
    lw a2 4(sp)
    addi sp sp 8
   

    
    mul a3 a2 a3
    #addi a3 a3 2#total number of integers
    addi a4 x0 4
    mv a2 a1
    mv a1 a0
    jal ra fwrite

    bge a0 a3 12
    addi a1 x0 54
    j exit2

    jal ra fclose

    beq a0 x0 12
    addi a1 x0 52
    j exit2






    # Epilogue


    
    lw ra 0(sp)
    addi sp sp 4
    ret