#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {


    if(head==0){

          return 0;
    }
    
    node* slow=head;
    node* fast=head;

    while(1){

       fast=fast->next;
       if(fast==0){
          
          return 0;

       }

       fast=fast->next;
       if(fast==0){
          
          return 0;

       }

       slow=slow->next;

       if(slow->value==fast->value){


          return 1;

       }



    }

    
    return 0;
}