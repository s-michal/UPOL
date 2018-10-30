#include <stdio.h>
#include <stdlib.h>
typedef struct Node {
	int data;
	struct Node *left;
	struct Node *right;
}Node;

Node *GetNewNode(int data) {
	Node* newNode = malloc(sizeof(Node));
	newNode->data = data;
	newNode->left = NULL;
	newNode->right = NULL;
	return newNode;
}
Node *Insert(Node *root, int data) {
	if (root == NULL) {
		root = GetNewNode(data);
	}
	else if (data <= root->data) {
		root->left = Insert(root->left, data);
	}
	else {
		root->right = Insert(root->right, data);
	}
	return root;
}
int Search(Node *root, int data) {
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

Node *DeleteNode(Node *u){

	Node* v, w;

	if (u->left == NULL)
		return u->right;
	if (u->right == NULL)
		return u->left;

	v = u->right;
	if (v->left == NULL){
		u->data = v->data;
		u->right = v->right;
		return u;
	}
	w = v->left;

	while (w->left != NULL){
		v = w;
		w = w->left;

		u->data = w->data;
		v->right = w->right;
		return u;
	}

}

Node *delete(Node *root, int data){

	if (root == NULL)
		return 0;
	if (root->data = data){
		root = DeleteNode(root);
		return 1;
	}
	if (data < root->data){
		if (root->left == NULL)
			return 0;
		if (root->left->data == data){
			root->left = DeleteNode(root->left);
			return 1;
		}
		delete(root->left, data);
	}
	else if (root->right == NULL)
		return 0;
	if (root->right->data == data){
		root->right = DeleteNode(root->right);
		return 1;	
	}
	delete(root->right, data);
}


int main() {
	Node* root;
	root = NULL;
	root = Insert(root, 15);
	root = Insert(root, 10);
	root = Insert(root, 20);
	root = Insert(root, 05);
	root = Insert(root, 30);
	root = Insert(root, 25);
	while (1) {
		int n = 50;

		if (Search(root, n) == 1) {
			printf("Found\n");
		}
		else {
			printf("Not Found\n");
		}
		
	}
	return 0;
}