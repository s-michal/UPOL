#include<stdlib.h>
#include<stdio.h>

void insert(int A[]) {
	int j, tmp, i, n = 6;
	
	for (j = 1; j <= n; j++) {
		tmp = A[j];
		i = j - 1;

		while (i >= 0 && A[i] > tmp) {
			A[i + 1] = A[i];
			i = i - 1;
		}
		A[i + 1] = tmp;
	}

}

int main() {
	int pole[7] = { 7, 5, 9, 0, 2, 4, 3 };
	int i;
	insert(pole);
	for (i = 0; i < 7; i++) {
		printf("%i, ", pole[i]);
	}
	system("pause");
	return 0;
}