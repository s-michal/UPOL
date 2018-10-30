#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int **nasobky_2d(int m, int n) {
	int i, j;
	int **pole2d = malloc(m * sizeof(int *));

	for (i = 0; i < m; i += 1) {
		pole2d[i] = malloc(n * sizeof(int));
	}

	for (j = 0; j < m; j++) {
		for (i = 0; i < n; i++) {
			pole2d[j][i] = i * j;
			return pole2d;
		}
		printf("\n");
	}

	free(pole2d);
}


int nasobky_1d(int m, int n) {
	int i, j;
	int *pole2d = malloc(sizeof(int) * m * n);

	for (j = 0; j < m; j++) {
		for (i = 0; i < n; i++) {
			pole2d[i * n + j] = i * j;
			printf("%i ", pole2d[i * n + j]);

		}
	}

	free(pole2d);
}



int main() {
	int i, j;
	int m = 4;
	int n = 4;
	int **array = nasobky_2d(m, n);

	for (j = 0; j < m; j++) {
		for (i = 0; i < n; i++) {
			array[j][i] = i * j;
			printf("%i ", array[j][i]);
		}
		printf("\n");
	}

	printf("\n");
	nasobky_1d(4, 4);
	system("pause");
	return 0;
}