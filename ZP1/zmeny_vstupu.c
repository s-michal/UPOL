#include <stdio.h>
#include <stdlib.h>

int main() {
	#define SIZE 10
	char pole[SIZE];
	printf("Zadej maximalne 10 znaku. Pri zadavani mene nez 10 znaku ukonci zadavani teckou.:\n");
	int i;
	int cislo;

	for (i = 0; i < SIZE; i++) {
		scanf_s("%c", &pole[i]);
		getchar();
		if (pole[i] == '.')
		break;
	}

	while (1) {
	printf("\n Zadejte ukol: \n 0) konec \n 1) vypis \n 2) pocet malych pismen \n 3) vypsat jen cislice \n 4) zamenit mala / velka pismena \n");
	scanf_s("%d", &cislo);
	printf("\n");

	switch (cislo) {
	case 0:
		return 0;
		break;
	case 1:
		printf("Vypis znaku: \n ");
		for (int j = 0; j < SIZE && pole[j] != '.'; j++) {
			printf("%c, ", pole[j]);
		}
		printf("\n");
		break;
	case 2:
		i = 0;
		int malepismeno = 0;
		for (int j = 0; j < 10 && pole[j] != '.'; j++) {
			if (pole[j] >= 'a' && pole[j] <= 'z') {
				malepismeno++;
			}
		}
		printf("Pocet malych pismen je: %d \n", malepismeno);
		break;
	case 3:
		printf("Jen cislice: ");
		for (int j = 0; j < 10 && pole[j] != '.'; j++) {
			if (pole[j] >= '0' && pole[j] <= '9') {
				printf("%c, ", pole[j]);
			}
		}
		printf("\n");
		break;
	case 4:
		printf("Zmenene velikosti pismen: ");
		for (int j = 0; j < 10 && pole[j] != '.'; j++) {
			if (pole[j] >= 'a' && pole[j] <= 'z') {
				pole[j] = pole[j] - 32;
			}
			else if (pole[j] >= 'A' && pole[j] <= 'Z') {
				pole[j] = pole[j] + 32;
			}
			printf("%c, ", pole[j]);
		}
		printf("\n");
		break;
	default:
		printf("Spatna hodnota, zkus to znovu. \n");
		printf("\n");
		break;
	}
	}
	return 0;
}