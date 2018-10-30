#include <stdio.h>
#include <stdlib.h>

#define SIZE 9

void ShakerSort(int A[]) {
	int i, j, k;
	int t = 0;

	for (j = 0; j <= SIZE / 2; j++) {

		for (i = SIZE - 1 - j; i >= j + 1; i--) {
			if (A[i] < A[i - 1]) {
				t = A[i];
				A[i] = A[i - 1];
				A[i - 1] = t;
			}
		}

		for (k = j + 1; k <= i - 1; k++) {
			if (A[k] > A[k + 1]) {
				t = A[k];
				A[k] = A[k + 1];
				A[k + 1] = t;
			}
		}
	}
}

void SHAKERSORT(int A[]) {
	int i, j, k, t, s;

	for (j = 0; j <= SIZE / 2; j++) {

		for (i = SIZE - 1 - j; i >= j + 1; i--) {
			if (A[i] < A[i - 1]) {
				t = A[i];
				A[i] = A[i - 1];
				A[i - 1] = t;
			}
		}

		for(k = j + 1; k <= SIZE - 2 - j; k++){
			if (A[k] > A[k + 1]) {
				s = A[k];
				A[k] = A[k + 1];
				A[k + 1] = s;
			}
		}
	}
}

int Partition(int A[], int p, int r) {
	int q = A[r];
	int i = p - 1;
	for (int j = p; j < r; j++) {
		if (A[j] <= q) {
			i++;
			int t = A[i];
			A[i] = A[j];
			A[j] = t;
		}
	}
	int t = A[i + 1];
	A[i + 1] = q;
	A[r] = t;

	return i + 1;
}

void QuickSort(int A[], int p, int r) {
	if (p < r) {
		int q = Partition(A, p, r);
		QuickSort(A, p, q - 1);
		QuickSort(A, q + 1, r);
	}
}


int main() {
	int array[SIZE] = { 5, 8, 0, 4, 1, 2, 6, 9, 3 };
	QuickSort(array, 0, SIZE - 1);
	printf("Setrizene pole: ");
	for (int i = 0; i < SIZE; i++) {
		printf("%d ", array[i]);
	}
	system("pause");
	return 0;
}