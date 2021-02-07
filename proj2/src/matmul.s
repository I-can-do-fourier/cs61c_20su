.globl matmul

#.import dot.s

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error checks

    
    addi t0 x0 1
    bge a1 t0 12
    addi a1 x0 5
    j exit2

    bge a2 t0 12
    addi a1 x0 6
    j exit2

    bge a4 t0 12
    addi a1 x0 6
    j exit2

    bge a5 t0 12
    addi a1 x0 6
    j exit2

    bne a2 a4 8
    j Prologue
    addi a1 x0 6
    j exit2


    # Prologue
Prologue:
    addi sp sp -12
    sw s1 0(sp)
    sw s0 4(sp)
    sw ra 8(sp)

    mv s0 a0
    mv s2 a3
    #t0,t1:count the row and columns
    add t0 x0 x0
    add t1 x0 x0

    addi s1 x0 4 #store the 4   
    mul t3 a2 s1#the usage of memory in a row of the first matrix
    mul t4 a5 s1#the usage of memory in a row of the perspective matrix

    j outer_loop_start

outer_loop_start:


    mv t1 x0
    j inner_loop_start

inner_loop_start:


#calculate the position of specific row and columns

#store variables
addi sp sp -28
sw a1 0(sp)
sw a5 4(sp)
sw t0 8(sp)
sw t1 12(sp)
sw t3 16(sp)
sw t4 20(sp)
sw a2 24(sp)

#the position of the row
mul t2 t3 t0
add a0 s0 t2

# the position of the column
mul t2 t1 s1
add a1 s2 t2

mul a3 t4 t0
add a3 a3 a6
add t2 a3 t2#store the perspective position of d

mv a2 a2
addi a3 x0 1
addi a4 a5 0

jal ra dot
sw a0 0(t2)#not wrong

#release variables


lw a1 0(sp)
lw a5 4(sp)
lw t0 8(sp)
lw t1 12(sp)
lw t3 16(sp)
lw t4 20(sp)
lw a2 24(sp)
addi sp sp 28


addi t1 t1 1
blt t1 a5 inner_loop_start
j inner_loop_end


inner_loop_end:

    ebreak
    addi t0 t0 1
    blt t0 a1 outer_loop_start
    j outer_loop_end


outer_loop_end:


    # Epilogue

    lw s1 0(sp)
    lw s0 4(sp)
    lw ra 8(sp)
    addi sp sp 12
    
    ret