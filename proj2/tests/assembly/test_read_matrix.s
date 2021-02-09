.import ../../src/read_matrix.s
.import ../../src/utils.s

.data
file_path: .asciiz "inputs/test_read_matrix/test_input.bin"

.text
main:
    # Read matrix into memory

    la a0 file_path
    addi a1 x0 4
    addi a2 x0 3

    addi sp sp -8
    sw a1 0(sp)
    sw a2 4(sp)

    jal ra read_matrix

    lw a1 0(sp)
    lw a2 4(sp)
    addi sp sp 8

    # Print out elements of matrix

    jal ra print_int_array


    

    # Terminate the program

    jal exit