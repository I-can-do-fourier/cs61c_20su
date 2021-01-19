#include "hashtable.h"
#include <stdlib.h>
#include<stdio.h>







/*
 * This creates a new hash table of the specified size and with
 * the given hash function and comparison function.
 */
HashTable *createHashTable(int size, unsigned int (*hashFunction)(void *),
                           int (*equalFunction)(void *, void *)) {
  //int i = 0;
  int i =0;
  HashTable *newTable = (HashTable *) malloc(sizeof(HashTable));
  newTable->size = size;
  newTable->data = malloc(sizeof(struct HashBucket *) * size);
  newTable->num=0;
  for (i = 0; i < size; ++i) {
    newTable->data[i] = NULL;
  }
  newTable->hashFunction = hashFunction;
  newTable->equalFunction = equalFunction;
  return newTable;
}


/*
 * This inserts a key/data pair into a hash table.  To use this
 * to store strings, simply cast the char * to a void * (e.g., to store
 * the string referred to by the declaration char *string, you would
 * call insertData(someHashTable, (void *) string, (void *) string).
 * Because we only need a set data structure for this spell checker,
 * we can use the string as both the key and data.
 */

void insertData(HashTable *table, void *key, void *data) {
  // -- TODO --
  
  // HINT:
  // 1. Find the right hash bucket location with table->hashFunction.
  // 2. Allocate a new hash bucket struct.
  // 3. Append to the linked list or create it if it does not yet exist. 

  table->num=table->num+1;

  unsigned int hashcode=table->hashFunction(key);

  unsigned int position=hashcode%(table->size);

  struct HashBucket *temp;
  temp=malloc(sizeof(struct HashBucket));
  temp->key=key;
  temp->data=data;


  if(table->data[position]==NULL){

        
        temp->next=NULL;
        table->data[position]=temp;

        return;
  }

  temp->next=table->data[position];
  table->data[position]=temp;

  // if(table->num/table->size>=2){
      
      
  //       resize(table);


  // }

}

/*
 * This returns the corresponding data for a given key.
 * It returns NULL if the key is not found. 
 */
void *findData(HashTable *table, void *key) {
  // -- TODO --
  // HINT:
  // 1. Find the right hash bucket with table->hashFunction.
  // 2. Walk the linked list and check for equality with table->equalFunction.

   unsigned int hashcode=table->hashFunction(key);
   unsigned int position=hashcode%(table->size);

   struct HashBucket *temp=table->data[position];

   while(temp!=NULL){

       if(table->equalFunction(key,temp->key)){

              return temp->data;
       }

       temp=temp->next;

   }

   return NULL;

}


void resize(HashTable *table){

     int size_old=table->size;
     table->size=2*table->size;

     struct HashBucket **data_old=table->data;    
     table->data=(struct HashBucket **) malloc(sizeof(struct HashBucket *) * table->size);
     
     for(int i=0;i<size_old;i++){

     insertData(table,data_old[i]->key,data_old[i]->data);


     }



}

 void printHashtable(HashTable *table){

     int size=table->size;
     
     for(int i=0;i<size;i++){

          struct HashBucket *temp=table->data[i];

          while(temp!=NULL){

              printf("%s\n",temp->key);
              temp=temp->next;

          }

     }


}


