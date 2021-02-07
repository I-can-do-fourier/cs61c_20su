.globl relu


.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    # Prologue

  addi sp sp -4
  sw s0 0(sp)


  addi t0 x0 1
  bge a1 t0 loop_start
  addi a1 x0 8
  j exit2


loop_start:
    
add t2 x0 x0 #count the loop
addi s0 x0 4 #store number 4
j loop_continue



loop_continue:


#get the address of current element,and load the element
mul  t0 s0 t2
add t0 a0 t0
lw  t1  0(t0)

#if the element < 0, convert it to 0
bge t1 x0 8
sw  x0 0(t0)

addi a1 a1 -1
addi t2 t2 1
bne a1 x0 loop_continue
j loop_end 




loop_end:


    # Epilogue
      
      lw s0 0(sp)
      addi sp sp 4
      ret