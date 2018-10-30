#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
	int data;
	struct Node* left;
	struct Node* right;
	int height;
}Node;

Node* GetNewNode(int data) {
	Node* newNode = malloc(sizeof(Node));
	newNode->data = data;
	newNode->left = NULL;
	newNode->right = NULL;
	return newNode;
}

int height(Node* N) {
	if (N == NULL) {
		return 0;
	}
	else
		return N->height;
}

int getBalance(Node *N)
{
	if (N == NULL)
		return 0;
	return height(N->left) - height(N->right);
}

int max(int a, int b){
	return a < b ? b : a;
}

Node *rightRotate(Node *y) {

	Node *x = y->left;
	Node *t = x->right;

	x->right = y;
	y->left = t;

	y->height = (max(height(y->left), height(y->right))) + 1;
	x->height = (max(height(x->left), height(x->right))) + 1;

	return x;
}

Node *leftRotate(Node *x) {

	Node *y = x->right;
	Node *t = y->left;
	
	y->left = x;
	x->right = t;

	x->height = max(height(x->left), height(x->right)) + 1;
	y->height = max(height(y->left), height(y->right)) + 1;

	return y;
}

Node* Insert(Node* root, int data) {
	int balance = getBalance(root);

	if (root == NULL) {
		root = GetNewNode(data);
	}
	else if (data <= root->data) {
		root->left = Insert(root->left, data);
	}
	else {
		root->right = Insert(root->right, data);
	}

	root->height = 1 + (max(height(root->left), height(root->right)));

	if (balance > 1 && data < root->left->data)
		return rightRotate(root);

	
	if (balance < -1 && data > root->right->data)
		return leftRotate(root);

	
	if (balance > 1 && data > root->left->data)
	{
		root->left = leftRotate(root->left);
		return rightRotate(root);
	}

	if (balance < -1 && data < root->right->data)
	{
		root->right = rightRotate(root->right);
		return leftRotate(root);
	}

	return root;
}
int Search(Node* root, int data) {
	if (root == NULL) {
		return 0;
	}
	else if (root->data == data) {
		return 1;
	}
	else if (data <= root->data) {
		return Search(root->left, data);
	}
	else {
		return Search(root->right, data);
	}
}
int main(void) {
	Node* root;
	root = NULL;
	root = Insert(root, 15);
	root = Insert(root, 10);
	root = Insert(root, 20);
	root = Insert(root, 05);
	root = Insert(root, 30);
	root = Insert(root, 25);
	while (1) {
		int n;
		printf("Enter number to be searched: \n");
		scanf("%d", &n);

		if (Search(root, n) == 1) {
			printf("Found\n");
		}
		else {
			printf("Not Found\n");
		}

	}
	return 0;
}