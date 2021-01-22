#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"
#include "bit_ops.h"

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */

   uint16_t input=(*reg)^(*reg>>2)^(*reg>>3)^(*reg>>5);

   *reg=(*reg>>1)|(input<<15);



}

