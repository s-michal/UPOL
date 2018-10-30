#include <stdlib.h>
#include <stdio.h>

#define SIZE 10


int find_simple(int array[], int n) {
	int i;

	for (i = 0; i < SIZE; i++) {
		if (array[i] == n) {
			return 1;
		}
	}
	return 0;
}

int find_zaraz(int array[], int n) {
	int i = 0;
	array[SIZE] = n;

	while (array[i] != n) {
		i++;
	}
		if (i == SIZE) return 0;
		else return 1;
}

int length(int array[]) {
	int i, counter = 0;

	for (i = 0; i < SIZE; i++) {
		counter++;
	}

	return counter;
}


int binary(int array[], int p, int r, int n) {
	
	if (p > r)
		return 0;
	int q = (p + r) / 2;
	if (array[q] > n) {
		return binary(array, p, q - 1, n);
	}
	else if (array[q] < n) {
			return binary(array, q + 1, r, n);
	}
	else if (array[q] == n) {
			return 1;
		}
	
}





int main() {
	int array[SIZE + 1] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	// printf("%i \n", find_simple(array, 20));
	//printf("%i \n", find_zaraz(array, 2));
	printf("%i \n", binary(array, 0, 9, 5));
	system("pause");
	return 0;

}