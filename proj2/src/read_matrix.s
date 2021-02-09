.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
    
    addi sp sp -4
    sw ra 0(sp)
	
    addi sp sp -8
    sw a0 0(sp)
    sw a1 4(sp)

     addi t1 x0 4
     mul a0 a1 a2
     mul a0 a0 t1
     addi a0 a0 8
     jal ra malloc
     mv t0 a0  #store the buffer

    lw a0 0(sp)
    lw a1 4(sp)
    addi sp sp 8 

    addi sp sp -8
    sw a1 0(sp)
    sw a2 4(sp)

     add a1 a0 x0
     add a2 x0 x0
     jal ra fopen

     addi t2 x0 -1
     bne a0 t2 12
     addi a1 x0 50
     j exit2
     

    lw a1 0(sp)
    lw a2 4(sp)
    addi sp sp 8

   
    mul a3 a1 a2
    mul a3 a3 t1
    addi a3 a3 8
    add a1 a0 x0
    add a2 t0 x0
    jal ra fread

    beq a0 a3  12
    addi a1 x0 51
    j exit2

    jal ra fclose

    beq a0 x0 12
    addi a1 x0 52
    j exit2
    
    addi a0 t0 8





    # Epilogue

    lw ra 0(sp)
    addi sp sp 4
    ret 