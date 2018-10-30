#include <stdio.h>
#include <stdlib.h>

# define SIZE 6

typedef struct _node
{ 
	int data;
	struct _node *next;
	
}node;

node *pridej(node *kam, int d){
	node *new = malloc(sizeof(node));
	new->data = d;
	new->next = kam;
	return new;
}

void tisk_seznamu (node *seznam){

	while(seznam){
		printf("%i ", seznam->data);
		seznam  = seznam->next;
	}
}

void smaz(node *seznam){
	while(seznam){
		node *tmp = seznam;
		free(seznam);
		seznam = tmp->next;
	}
}

/*1) kopie seznamu

2) odstranění prvku ze seznamu

3) vrátit ukazatel na n-tý node od konce*/

node *copy(node *seznam){

	node *kopie = malloc(SIZE * sizeof(node));
	int i;

	for (i = 0; i < SIZE; i++){
		*(kopie + i) = *(seznam + i);
	}

	return kopie;
}


node *smaz_prvek(node **seznam, int prvek){
	int i;
	node *new = *seznam;
	if (new->data == prvek){
		*seznam = new->next;
		return new;
	}

	for (i = 0; i < SIZE; i++){
		if(new->next->data == prvek){
			new->next = new->next->next;
			break;
		}
		else{
			new = new->next;
		}
	}
	return new;

}

int main() {
int i;
int a;

node *seznam = 0;
node *kopie = 0;

for (i = 0; i < SIZE; i ++){
	seznam = pridej(seznam, i);
}

for (i = 0; i < SIZE; i ++){
	kopie = pridej(kopie, i);
}


kopie = copy(seznam);

tisk_seznamu(seznam);
printf("\n");
tisk_seznamu(kopie);
smaz_prvek(&seznam, 3);
printf("\n");
tisk_seznamu(seznam);
printf("\n");




return 0;
}