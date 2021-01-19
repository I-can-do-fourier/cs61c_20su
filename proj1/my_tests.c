
#include <stdio.h>
#include <stdlib.h>
#include "hashtable.h"
#include <string.h>


void link_test();
char* str_append(char*s1,char*s2);

int main(int argc, char const *argv[])
{
    /*int* p1;
    char* p2;

   printf("%d\n",sizeof(p1));
   printf("%d\n",sizeof(p2));
   printf("%d\n",sizeof(char *));

   void *pr;
   void *ar[10];
   pr=ar;
   pr=malloc(sizeof(int*)*10);

   for(int i=0;i<10;i++){

        pr[i]=((void *)0);

   }*/

  
 
  printf("%d\n",sizeof(struct HashBucket));
  
  
  int size=10;
  HashTable *newTable = (HashTable *) malloc(sizeof(HashTable));
  newTable->size = 10;
  newTable->data = calloc(size,sizeof(struct HashBucket *));

  printf("%d\n",sizeof(newTable->data));

  printf("%d\n",!0);
  printf("%d\n",!10);

   char *buff=malloc(sizeof(char)*61);
   //buff="han xinhang is a nerd";
   int length=strlen(buff);
   char *word=malloc(sizeof(char)*(length+1));
   strcpy(word,buff);
   //printf("%s\n",word);

   int count=5;
   while(count>0){

      char *t=malloc(sizeof(char)*61);
     
      count--;
   }

   
   char *ss="hanxinhang@ as39 , //han\n;;'xcj is sb";

   int a=0;

    FILE *fp;
    char* filename = ".\\test_word.txt";
 
    fp = fopen(filename, "r");

    /*char temp[]={'\0'};
    char* output=temp;*/

    char*output =calloc(1,sizeof(char));


    //memset(buff,'\0',61);
    while(a=fscanf(fp,"%61[a-zA-Z]",buff)!=EOF){

      if(a>0){

       printf("%s\n",buff);
       
       output=str_append(output,buff);
       
       

      }

       if(fscanf(fp,"%[^a-zA-Z]",buff)!=EOF){

         output=str_append(output,buff);  
       }
         

       
        
   }

     
    printf("%s",output);



  //link_test();


//   for(int i=0;i<size;i++){

//       struct simpleStruct ss;
//       ss.a=i;
//       ss.b=(char) i;

//       newTable->data[i]= ss;

//   }

    system("pause");

    return 0;
}

char* str_append(char*s1,char*s2){


 char *cat=malloc(strlen(s1)+strlen(s2)+1);

 strcpy(cat,s1);
 strcat(cat,s2);

 free(s1);
 //free(s2);


  return cat;

}



