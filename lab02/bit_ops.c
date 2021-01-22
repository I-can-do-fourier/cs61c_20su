#include <stdio.h>
#include "bit_ops.h"

// Return the nth bit of x.
// Assume 0 <= n <= 31
unsigned get_bit(unsigned x,
                 unsigned n) {
    // YOUR CODE HERE
    // Returning -1 is a placeholder (it makes
    // no sense, because get_bit only returns
    // 0 or 1)

    x=x>>n;  //must assign back to x: just "x>>n" is false
    unsigned int temp=1;
    return x&temp;
}
// Set the nth bit of the value of x to v.
// Assume 0 <= n <= 31, and v is 0 or 1
void set_bit(unsigned * x,
             unsigned n,
             unsigned v) {
    // YOUR CODE HERE

    unsigned int temp=1<<n;
    
    *x=temp|*x;  //set the nth bit of *x to 1;


    //create an unsigned int which all the bits are set to 1 except the nth bit;
    temp=0xFFFFFFFE;
    temp=temp|v;
    temp=temp<<n;
    unsigned int power=1<<n;
    temp=temp+power-1;

    //set the nth bit of *x to v;
    *x=temp&(*x);
    
    
}
// Flip the nth bit of the value of x.
// Assume 0 <= n <= 31
void flip_bit(unsigned * x,
              unsigned n) {
    // YOUR CODE HERE

    unsigned int present_value=get_bit(*x,n);

    int temp=~present_value;
    temp=temp&0x00000001;

    temp=temp<<n;

    set_bit(x,n,0);

    *x=*x+temp;


}

