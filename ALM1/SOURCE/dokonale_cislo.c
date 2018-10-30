#include<stdlib.h>
#include<stdio.h>

int dokonale(int cislo) {
	int soucet = 0, delitel = cislo - 1;

	while (delitel != 0) {
		if (cislo % delitel == 0) {
			soucet = soucet + delitel;
		}
		delitel--;
	}
	return soucet;
}

int main() {
	int cislo, vysledek;

	printf("Zadejte prosim cislo: ");
	scanf_s("%d", &cislo);

	vysledek = dokonale(cislo);

	if (vysledek == cislo) {
		printf("Vami zadane cislo je dokonale cislo.\n");
	}
	else {
		printf("Vami zadane cislo neni dokonale cislo.\n");
	}

	 system("pause");
	return 0;
}