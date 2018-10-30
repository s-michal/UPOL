#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>


enum Hash_function{Linear, Quadra, Doubl};

typedef struct
{	int data;
    int used;
}hash_row;

typedef struct N{
    int data;
    struct N *next;
}N;


int linear_hash(int number, int size, int i){

    int index = (number + i) % size;

    return index;
}

int quadra_hash(int number, int size, int i){

    int index = (number + (i * i)) % size;

    return index;
}

int doubl_hash(int number, int size, int i){
    int h1 = number % size;
    int h2 = 1 + (number % (size - 1));

    int index = (h1 + h2 * i) % size;
    return index;
}

hash_row *new_table(hash_row *table, int m){
    int i;


    for (i = 0; i < m; i++){
        table[i].used = 0;
        table[i].data = 0;
    }

    return table;
}

int Search(hash_row *table, int number, int size){

    int i;

    for (i = 0; i < size; i++){
        if (table[i].data == number)
            return 1;
    }

    return 0;

}


int insert(hash_row *table, int number, int size, enum Hash_function type){
    int i = 0; int j;
    int count = 0;

    while(i != size){

        int index;

        switch(type){
            case Linear:
                index = linear_hash(number, size, i);
                break;
            case Quadra:
                index = quadra_hash(number, size, i);
                break;
            case Doubl:
                index = doubl_hash(number, size, i);
                break;
            default:
                printf("Wrong hash function!");
        }

        if (table[index].used == 0){
            table[index].data = number;
            table[index].used = 1;
            break;
        }

        else if (table[index].used == 1 && table[index].data == number){
            return 0;
        }   

        else if (table[index].used == 1){
            i++;
            count++;
        }   

        else if (i == size) break;
    }

        if (i == size) 
            return 0;

        return count;
    
}


N *newN(int number){
    N *new = malloc(sizeof(N));
    new->data = number;
    new->next = NULL;

    return new;
}

int linkSearch(N **table, int number, int size){
    int i = 0;
    int index  = linear_hash(number, size, i);

    if(table[index] == NULL)
        return 0;
    else if (table[index]->data == number)
        return 1;
    else if (table[index]->next == NULL)
        return 0;
    else if (table[index]->next->data == number)
        return 1;
    else
        linkSearch(&table[index]->next, number, size);
}

int linkInsertRec(N *table, int number, int size){

    if(table->data == number)
        return 0;
    if (table->next == NULL) {
        table->next = newN(number);
        return 1;
    }
    else{
        return 1 + linkInsertRec(table->next, number, size);
    }
}

int linkInsert(N **table, int number, int size){
    int i = 0;
    int index  = linear_hash(number, size, i);

    if (table[index] == NULL) {
        table[index] = newN(number);
        return 0;
    }
    else if (table[index]->data == number)
        return 0;
    else if (table[index]->next == NULL) {
        table[index]->next = newN(number);
        return 1;
    }
    else
        return 1 + linkInsertRec(table[index]->next, number, size);
}

int random(int min, int max){
    return min + rand() % max;
}


int main() {

    int n = 1000;
    float avg_lin = 0, avg_quad = 0, avg_doubl = 0, avg_link = 0;


    srand(time(NULL));
    for (int y = 0;  y < n; y++){
    
        int number = random(1000, 10000);
        int m = 0, i, j, k;
        
        for (int x = 10; x < 15; x++){
            if (number <= pow(2, x)){
                m = pow(2, x);
                break;
            }
        }

        hash_row linear[m];
        hash_row quadra[m];
        hash_row doubl[m];

        new_table(linear, m);
        new_table(quadra, m);
        new_table(doubl, m);

        N *retez[m];
        
        for (int i = 0; i < m; i++) {
             retez[i] = NULL;
        }


        float lin_colide = 0;
        float quad_colide = 0;
        float doubl_colide = 0;
        float link_colide = 0;

        for (int j = 0; j < number; j++){
            int num = random(0, 10000);
            lin_colide += insert(linear, num, m, Linear);
            quad_colide += insert(quadra, num, m, Quadra);
            doubl_colide  += insert(doubl, num, m, Doubl);
            link_colide += linkInsert(retez, num, m);
        }     

       avg_lin += lin_colide/ number;
       avg_quad += quad_colide / number;
       avg_doubl += doubl_colide / number;
       avg_link += link_colide / number;

       free(retez);
}

    avg_lin = avg_lin / n;
    avg_doubl = avg_doubl / n;
    avg_quad = avg_quad / n;
    avg_link = avg_link / n;

    printf("Average linear hash: %.2f\n", avg_lin);
    printf("Average quadra hash: %.2f\n", avg_quad);
    printf("Average double hash: %.2f\n", avg_doubl);
    printf("Average link hash: %.2f\n", avg_link);




    return 0;
}