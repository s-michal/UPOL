#include <stdio.h>
#include <stdlib.h>


#define p 3

/*int partition(int A[], int p, int r) {
	int x, j, temp, i = 0;

	x = A[r];
	i = p - 1;
	for (j = p; j <= r - 1; j++) {
		if (A[j] <= x) {
			i = i + 1;
			swap(A, i, j);
		}
	}
	
	swap(A, i + 1, r);
	return i + 1;
}

void quickSort(int A[], int p, int r) {
	int q;
	if (p < r) {
		q = partition(A, p, r);
		quickSort(A, p, q - 1);
		quickSort(A, q + 1, r);
	}
}*/

typedef enum
{	TRUE,
	FALSE
}bool;

typedef struct Node {
	int *values;
	struct Node *parent;
	struct Node **pointers;
	int size;
	bool leaf;
}Node;


Node *alloc_space() {
	Node* newNode = malloc(sizeof(Node));
	newNode->values = malloc((p + 1) * sizeof(int));
	newNode->pointers = malloc((p + 1) * sizeof(Node));
	newNode->parent = NULL;
	newNode->size = 0;
	newNode->leaf = TRUE;
	return newNode;
}


Node *split(Node *root){
	if (root->parent == NULL){
		int middle = p/2;
		int i;
		int right_i = 0;
		Node *new = alloc_space();
		Node *left = alloc_space();	
		Node *right = alloc_space();
		left->parent = new;
		right->parent = new;
		new->pointers[0] = left;
		new->pointers[1] = right;
		
		for (i = 0; i < root->size; i++){
			if (i < middle){
				left->values[i] = root->values[i];
				if (!root->leaf){
				left->pointers[i] = root->pointers[i];
				left->leaf = FALSE;
			}
				left->size += 1;	
			}

			else if (i == middle){
				new->values[0] = root->values[i];
				left->pointers[i] = root->pointers[i];	
				if (!root->leaf){
					left->pointers[i] = root->pointers[i];
					right->pointers[0] = root->pointers[i + 1];
					right->leaf = FALSE;
				}
				new->size += 1;
			}

			else {
				right->values[right_i] = root->values[i];
				if (!root->leaf){
					right->pointers[right_i + 1] = root->pointers[i + 1];
				}
				right->size += 1;
				right_i++;
			}
		}	
	}
	free(root);
}


/*void insert(Node **root; int data){
	if (size < p)
}*/

int main() {
	Node *root = alloc_space();
	return 0;
}