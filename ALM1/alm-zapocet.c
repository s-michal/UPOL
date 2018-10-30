#include <stdio.h>
#include <stdlib.h>
#include <time.h>


//BINARNI STROM
typedef struct Node {
	int data;
	struct Node *left;
	struct Node *right;
	struct Node *parent;
	int height;
}Node;

Node *NewNode(int data) {
	Node* newNode = malloc(sizeof(Node));
	newNode->data = data;
	newNode->left = NULL;
	newNode->right = NULL;
	newNode->parent = NULL;
	newNode->height = 0;
	return newNode;
}

int height_new(Node *root) {
	int height_l = 0, height_r = 0;

	if (root->left) {
		height_l = height_new(root->left);
		height_l++;
	}
	if (root->right) {
		height_r = height_new(root->right);
		height_r++;
	}

	if (height_r > height_l)
		return height_r;
	else
		return height_l;
}

int Search(Node *root, int data) {
	if (root == NULL)
		return 0;
	else if (root->data == data)
		return 1;
	else if (data <= root->data)
		return Search(root->left, data);
	else
		return Search(root->right, data);
}

Node *Insert_Bi(Node *root, int data) {
	if (root == NULL)
		root = NewNode(data);

	else if (data < root->data)
		root->left = Insert_Bi(root->left, data);
	else if (data > root->data)
		root->right = Insert_Bi(root->right, data);
	return root;
}


//AVL STROM


int height(Node *root) {
	if (root == NULL) {
		return 0;
	}
	else
		return 1 + root->height;
}

int getBalance(Node *root)
{
	if (root == NULL)
		return 0;
	return height(root->left) - height(root->right);
}

int Max(int a, int b){
	if (a > b) 
		return a;
	else
		return b;
}

Node *rightRotate(Node *y) {

	Node *x = y->left;
	y->left = x->right;
	x->right = y;

	x->parent = y->parent;
	y->parent = x;

	if (x->parent != NULL){
		if (x->parent->left == y) 
			x->parent->left = x;
		else 
			x->parent->right = x;
	}

	y->height = (Max(height(y->left), height(y->right))) + 1;
	x->height = (Max(height(x->left), height(x->right))) + 1;

	return x;
}

Node *leftRotate(Node *x) {

	Node *y = x->right;
	x->right = y->left;
	y->left = x;

	y->parent = x->parent;
	x->parent = y;

	if (y->parent != NULL) {
		if (y->parent->left == x)
			y->parent->left = y;
		else
			y->parent->right = y;
	}

	x->height = Max(height(x->left), height(x->right)) + 1;
	y->height = Max(height(y->left), height(y->right)) + 1;

	return y;
}

Node* update(Node *root, int balance) {
	if (root == NULL)
		return root;
	else {

		if (balance > 1 && getBalance(root->left) >= 0) {
			root = rightRotate(root);
			//update(root->parent, getBalance(root->parent));
		}

		if (balance < -1 && getBalance(root->right) <= 0) {
			root = leftRotate(root);
			//update(root->parent, getBalance(root->parent));
		}


		if (balance > 1 && getBalance(root->left) == -1)
		{
			root->left = leftRotate(root->left);
			root = rightRotate(root);
			//update(root->parent, getBalance(root->parent));
		}

		if (balance < -1 && getBalance(root->right) == 1)
		{
			root->right = rightRotate(root->right);
			root = leftRotate(root);
			//update(root->parent, getBalance(root->parent));
		}
	}
	return root;
}

Node* Insert_AVL(Node* root, int data) {

	if (root == NULL)
		root = NewNode(data);

	else if (data < root->data) {
		if (root->left != NULL)
			root->left = Insert_AVL(root->left, data);
		else {
			root->left = NewNode(data);
			root->left->parent = root;
		}
	}

	else if (data > root->data) {
		if (root->right != NULL)
			root->right = Insert_AVL(root->right, data);
		else {
			root->right = NewNode(data);
			root->right->parent = root;
		}
	}
	root->height = (Max(height(root->left), height(root->right)));
	int balance = getBalance(root);
	root = update(root, balance);
	return root;

}

int print(Node *root) {
	if (root == NULL)
		return 0;
	else {
		printf("%i ", root->data);
		print(root->left);
		print(root->right);
	}
}

void free_tree(Node *root) {
	if (root == NULL) return;
	free_tree(root->left);
	free_tree(root->right);
	free(root);
}




int main() {
	int i, j, k, l, size = 10, number;
	int height_bi[10];
	int height_avl[10];
	int count_bi = 0, count_avl = 0;
	float pomer;

	srand(time(NULL));

	for (i = 0; i < size; i++){
		Node* root_avl;
		Node* root_bi;
		root_bi = NULL;
		root_avl = NULL;
		for (j = 0; j < 10000; j++){
			number = rand() % 10000;
			root_bi = Insert_Bi(root_bi, number);
			root_avl = Insert_AVL(root_avl, number);
		}

		height_bi[i] = 	height_new(root_bi);
		height_avl[i] = height_new(root_avl);
		print(root_avl);
		free_tree(root_avl);
		free_tree(root_bi);
		//printf("\n");
	}

	for (k = 0; k < size; k++){
	count_bi = height_bi[k] + count_bi;
	}

	count_bi = count_bi / size;

	printf("%i ", count_bi);

	for (l = 0; l < size; l++){
	count_avl = height_avl[l] + count_avl;
	}

	count_avl = count_avl / size;
	printf("%i ", count_avl);

	pomer = (float)count_bi / (float)count_avl;

	//printf("%.2f", pomer);


	return 0;
}

