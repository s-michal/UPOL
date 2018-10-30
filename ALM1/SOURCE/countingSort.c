#include <stdio.h>
#include <stdlib.h>


#define SIZE 7

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

	for (j = size; j >=0  j--) {
		t = A[j];
		i = j - 1;

		while (i >= 0 && A[i] > t) {
			A[i + 1] = A[i];
			i = i - 1;
		}

		A[i + 1] = t;
	}
}
int y;
void bubbleSort(int A[]) {
	int i, j = 0, k = 0, temp;

	while (j < SIZE - 1 && A[j] <= A[j + 1])
	{
		j++;
		k++;
	}

	for (j = 0; j <= SIZE - 2; j++) {

		for (i = SIZE - 1; i >= j + 1; i--) {
			if (A[i] < A[i - 1]) {
				
				temp = A[i];
				A[i] = A[i - 1];
				A[i - 1] = temp;
			}
		}
		k++;
		if (k == SIZE - 1) break;
	}
	printf("\n%d\n", j);
}

void BubbleSort(int A[]) {
	int i, j, temp;

	for (j = 0; j <= SIZE - 2; j++) {

		for (i = SIZE - 1; i >= j + 1; i--) {
			if (A[i] < A[i - 1]) {
				y++;
				temp = A[i];
				A[i] = A[i - 1];
				A[i - 1] = temp;
			}
		}
	}
	printf("\n%d\n", j);
}

void swap(int A[], int i, int j) {
	int temp;
	temp = A[i];
	A[i] = A[j];
	A[j] = temp;

}

void shakerSort(int A[]) {
	int i, j, k, temp, p;
	int n = SIZE;

	for (j = 0; j < n;) {

		p = 0;
		for (i = n - 1; i > j; i--) {

			if (A[i] < A[i - 1]) {
				swap(A, i, i - 1);
				p = 1;
			}
		}
		n--;
		if (p == 0)
			break;

		p = 0;
		for (k = j + 1; k < n; k++) {
			if (A[k] > A[k + 1]) {
				swap(A, k, k + 1);
				p = 1;
			}
		}
		i++;
		if (p == 0)
			break;
	}
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


void countingSort(int A[], int B[]) {
	int k = 10, C[11], i, j;

	for (i = 0; i <= k; i++) {
		C[i] = 0;
	}
	
	for (j = 0; j <= SIZE - 1; j++) {
		C[A[j]] = C[A[j]] + 1;
	}

	for (i = 1; i <= k; i++) {
		C[i] = C[i] + C[i - 1];
	}

	for (j = SIZE - 1; j >= 0; j--) {
		B[C[A[j]] - 1] = A[j];
		C[A[j]] = C[A[j]] - 1;
	}
}



/*int main() {
	int input[SIZE] = { 4, 8, 0, 6, 9, 8, 4 };
	int output[SIZE];
	countingSort(input, output);
	for (int i = 0; i < SIZE; i++) {
		printf("%i ", output[i]);
	}
	system("pause");
	return 0;
}*/

int main() {
	int input[SIZE] = {1, 2, 3, 4, 5, 6, 0};
	shakerSort(input);
	for (int i = 0; i < SIZE; i++) {
		printf("%i ", input[i]);
	}

	system("pause");
	return 0;
}