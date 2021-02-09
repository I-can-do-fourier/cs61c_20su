.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>






	# =====================================
    # LOAD MATRICES
    # =====================================


    addi sp sp -4
    sw ra 0(sp)
    mv s11 ra


    # Load pretrained m0

    addi sp sp -12
    sw a0 0(sp)
    sw a1 4(sp)
    sw a2 8(sp)
    
    lw a0 4(a1)
    addi a1 x0 128
    addi a2 x0 784
    jal ra read_matrix
    mv t0 a0 #t0: pointer to m0

    lw a0 0(sp)
    lw a1 4(sp)
    lw a2 8(sp)
    addi sp sp 12
    
    #ebreak

    # Load pretrained m1

    addi sp sp -16
    sw a0 0(sp)
    sw a1 4(sp)
    sw a2 8(sp)
    sw t0 12(sp)
    
    lw a0 8(a1)
    addi a1 x0 10
    addi a2 x0 128
    jal ra read_matrix
    mv t1 a0 #t0: pointer to m0

    lw a0 0(sp)
    lw a1 4(sp)
    lw a2 8(sp)
    lw t0 12(sp)
    addi sp sp 16

    #ebreak

    # Load input matrix

    addi sp sp -20
    sw a0 0(sp)
    sw a1 4(sp)
    sw a2 8(sp)
    sw t0 12(sp)
    sw t1 16(sp)
    
    
    lw a0 12(a1)
    addi a1 x0 784
    addi a2 x0 1 
    jal ra read_matrix
    mv t2 a0 #t0: pointer to m0

    lw a0 0(sp)
    lw a1 4(sp)
    lw a2 8(sp)
    lw t0 12(sp)
    lw t1 16(sp)
    addi sp sp 20



    #ebreak


    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)


   #m0*input
    addi sp sp -20
    sw a1 0(sp)
    sw a2 4(sp)
    sw t0 8(sp)
    sw t1 12(sp)
    sw t2 16 (sp)


    addi a0 x0 512
    jal ra malloc
    mv a6 a0
    mv a0 t0
    addi a1 x0 128
    addi a2 x0 784
    mv a3 t2
    addi a4 x0 784
    addi a5 x0 1
    jal ra matmul

    lw a1 0(sp)
    lw a2 4(sp)
    lw t0 8(sp)
    lw t1 12(sp)
    lw t2 16 (sp)
    #ebreak
    addi sp sp 20


 

    addi sp sp -8
    sw a1 0(sp)
    sw a6 4(sp)
    add a0 x0 t0
    addi a0 a0 -8
    jal ra free
    lw a1 0(sp)
    lw a6 4(sp)
    addi sp sp 8
    
    
    
    addi sp sp -8
    sw a1 0(sp)   
    sw a6 4(sp)
    add a0 x0 t2
    addi a0 a0 -8
    jal ra free
    lw a1 0(sp)
    lw a6 4(sp)
    addi sp sp 8
   

   

    #ebreak 
    #relu

    addi sp sp -16
    sw t0 0(sp)
    sw t1 4(sp)
    sw t2 8(sp)
    sw a1 12(sp)

    mv a0 a6
    addi a1 x0 128
    jal ra relu

    lw t0 0(sp)
    lw t1 4(sp)
    lw t2 8(sp)
    lw a1 12(sp)
    addi sp sp 16

   
    
    #ebreak
    #m1*relu
    
    mv a3 a6
    addi sp sp -12
    sw a1 0(sp)
    sw a2 4(sp)
    sw a3 8(sp)
    
    addi a0 x0 40
    jal ra malloc 
    mv a6 a0
    mv a0 t1
    addi a1 x0 10
    addi a2 x0 128
    
    addi a4 x0 128
    addi a5 x0 1
    jal ra matmul

    lw a1 0(sp)
    lw a2 4(sp)
    lw a3 8(sp)
    addi sp sp 12
    
    
    addi sp sp -8
    sw a1 0(sp)
    sw a6 4(sp)
    add a0 x0 t1
    addi a0 a0 -8
    jal ra free
    add a0 x0 a3
    jal ra free
    lw a1 0(sp)
    lw a6 4(sp)
    addi sp sp 8


    #ebreak
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix

    lw a0 16(a1)
    mv a1 a6
    addi a2 x0 10
    addi a3 x0 1

    jal ra write_matrix2 #fuck you guy


    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax

    mv a0 a6
    addi a1 x0 10
    jal ra argmax

    # Print classification
    add a1 x0 a0
    jal ra print_int

    
    add a0 x0 a6
    jal ra free

    # Print newline afterwards for clarity
    
    li a1 '\n'
    jal print_char

    addi sp sp 4
    lw ra 0(sp)
    ret