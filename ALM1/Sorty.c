#include <stdio.h>
#include <stdlib.h>


#define SIZE 8

void selectSort(int A[]) {
	int iMin, j, n = SIZE - 1, t, i;

	for (j = 0; j <= n; j++) {
		iMin = j;

		for (i = j; i <= n; i++) {
			if (A[i] < A[iMin])
				iMin = i;
		}
		t = A[j];
		A[j] = A[iMin];
		A[iMin] = t;

	}
}

void insertSort(int A[]) {

	int i, j, t, size = SIZE - 1;

	for (j = size; j >= A[0]; j--) {
		t = A[j];
		i = j - 1;

		while (i >= 0 && A[i] > t) {
			A[i + 1] = A[i];
			i = i - 1;
		}

		A[i + 1] = t;
	}
}

/*void bubbleSort(int A[]) {
int i, j, t;
for (j = 0; j < SIZE - 1; j++) {
for (i = 0; i < SIZE - i - 1; i++) {
if (A[j + 1] < A[j]) {
t = A[i + 1];
A[i + 1] = A[i];
A[i] = t;

}
}
}
}*/

void bubbleSort(int * array) {

	for (int i = 0; i < SIZE - 1; i++) {

		for (int j = 0; j < SIZE - i - 1; j++) {

			if (array[j + 1] < array[j]) {

				int tmp = array[j + 1];

				array[j + 1] = array[j];

				array[j] = tmp;
			}

		}

	}
}

void swap(int A[], int i, int j) {
	int temp;
	temp = A[i];
	A[i] = A[j];
	A[j] = temp;

}


int partition(int A[], int p, int r) {
	int x, j, temp, i = 0;
	int c = 0;

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
	printf("%i \n", c);
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
	int array[SIZE] = { 1, 9, 8, 0, 2, 6, 7, 3 };
	quickSort(array, 0, 7);
	for (int i = 0; i < SIZE; i++) {
		printf("%i ", array[i]);
	}
	system("pause");
	return 0;
}