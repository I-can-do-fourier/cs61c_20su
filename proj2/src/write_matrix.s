.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

    # Prologue



    addi sp sp -4
    sw ra, 0(sp)

    mv ra s11
    ret

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
