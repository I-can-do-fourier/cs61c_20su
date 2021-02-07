.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:

    # Prologue
    addi sp sp -4
    sw s0 0(sp)

    addi t0 x0 1
    bge a1 t0 loop_start
    addi a1 x0 7
    j exit2


loop_start:

add t1 x0 x0 #count the loop
addi s0 x0 4 #store number 4
add t2 x0 x0 #store the index of the largest element
add t3 x0 x0 #store the largest element
j loop_continue


loop_continue:


#get the address of current element,and load the element
mul  t0 s0 t1
add t0 a0 t0
lw  a2  0(t0) #at this position, if i use a0, it will wrong

sub t0 t3 a2 
bge t0 x0 haha
addi t2 t1 0
addi t3 a2 0
j haha

haha:
    addi a1 a1 -1
    addi t1 t1 1
    bne a1 x0 loop_continue
    j loop_end 





loop_end:
    
    add a0 t2 x0

    # Epilogue

    lw s0 0(sp)
    addi sp sp 4

    ret