#include <stdio.h>
#include <stdlib.h>

#define SIZE 8


void swap(int A[], int i, int j) {
	int temp;
	temp = A[i];
	A[i] = A[j];
	A[j] = temp;

}
int c = 0;

int partition(int A[], int p, int r) {
	int x, j, temp, i = 0;

	x = A[r];
	i = p - 1;
	for (j = p; j <= r - 1; j++) {
		c++;
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
}


int main() {
	int array[SIZE] = {5, 5, 5, 1, 2, 4, 6, 7 };
	quickSort(array, 0, 7);
	printf("Pocet porovnani je: %i \n", c);
	printf("Setrizene pole: ");
	for (int i = 0; i < SIZE; i++) {
		printf("%i ", array[i]);
	}
	system("pause");
	return 0;
}