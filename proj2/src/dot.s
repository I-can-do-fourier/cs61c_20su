.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:

    # Prologue

    addi sp sp -8
    sw s0 0(sp)
    sw s1 4(sp)

    #exam the length and the strides

    addi t0 x0 1
    bge a2 t0 12
    addi a1 x0 5
    j exit2

    bge a3 t0 12
    addi a1 x0 6
    j exit2

    bge a4 t0 loop_start
    addi a1 x0 6
    j exit2


loop_start:

add t1 x0 x0 #count the loop
add s0 x0 x0
addi s1 x0 4

loop_continue:

#calculate the address of the elements
mul t3 a3 t1
mul t4 a4 t1
mul t3 t3 s1
mul t4 t4 s1
add t3 a0 t3
add t4 a1 t4

#load the elements
lw t3 0(t3)
lw t4 0(t4)

mul t3 t3 t4 #dot
add s0 s0 t3

addi a2 a2 -1
addi t1 t1 1
bne a2 x0 loop_continue
j loop_end 

loop_end:


    add a0 s0 x0

    # Epilogue
    lw s1 4(sp)
    lw s0 0(sp)
    addi sp sp 8
    ret