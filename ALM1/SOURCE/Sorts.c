#include <stdio.h>
#include <stdlib.h>


#define SIZE 9

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

void BUBBLESORT(int A[]) {
	int i, j, t;
	int k = SIZE - 1;
	for (j = 0; j <= SIZE - 2; j++) {
		for (i = SIZE - 1; i >= j + 1; i--) {
			if (A[i] < A[i - 1]) {
				t = A[i];
				A[i] = A[i - 1];
				A[i - 1] = t;
				k = i + 1;
			}
		}
		j = k;
	}
}

void RIGHTinsertSort(int A[]) {

	int i, j, t, n = SIZE;

	for (j = n - 2; j >= 0; j--) {
		t = A[j];
		i = j + 1;

		while (i <= n - 1 && A[i] < t) {
			A[i - 1] = A[i];
			i = i + 1;
		}

		A[i - 1] = t;
	}
}

void insertSort(int A[]) {

	int i, j, t, n = SIZE;

	for (j = 1; j <= n - 1; j++) {
		t = A[j];
		i = j - 1;

		while (i >= 0 && A[i] > t) {
			A[i + 1] = A[i];
			i = i - 1;
		}

		A[i + 1] = t;
	}
}

void RaddixSort(int A[], int d) {
	int k;

	for (k = 1; k <= d; k++) {
		insertSort(A, k);
	}
}

void Merge(int A[], int p, int q, int r) {
	int n1 = q - p + 1;
	int n2 = r - q;
	int L[10], R[10];
	int i, j, k;
	
	for (i = 0; i <= n1 - 1; i++) {
		L[i] = A[p + i];
	}

	for (j = 0; j <= n2 - 1; j++) {
		R[j] = A[q + 1 + j];
	}

	L[n1] = 999;
	R[n2] = 999;
	i = 0;
	j = 0;

	for (k = p; k <= r; k++){
		if (L[i] <= R[j]) {
			A[k] = L[i];
			i++;
		}
		else {
			A[k] = R[j];
			j++;
		}
	}		
}

void MergeSort(A, p, r) {
	int q;
	if (p < r) {
		q = (p + r) / 2;
		MergeSort(A, p, q);
		MergeSort(A, q + 1, r);	
		Merge(A, p, q, r);
	}
	
}

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


//VYLEPŠENÝ BUBBLESORT
int count = 0;
void bubbleSort(int A[]) {
	int i, j, k = 0;
	int t = 0;

	for (j = 0; j <= SIZE - 2; j++) {
		for (i = SIZE - 1; i >= j + 1; i--) {
			count++;
			if (A[i] < A[i - 1]) {
				t = A[i];
				A[i] = A[i - 1];
				A[i - 1] = t;
				k = i;
			}
		}
		j = k;
	}
}

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
	int array[SIZE] = {5, 8, 0, 4, 1, 2, 6, 9, 3};
	ShakerSort(array);
	printf("Setrizene pole: ");
	for (int i = 0; i < SIZE; i++) {
		printf("%i ", array[i]);
	}
	printf("\n%i\n", count);
	system("pause");
	return 0;
}