#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int fc(int *c, int d) {

	*c = *c + 5;
	return *c;
}

int porovnej(char *t1, char *t2) {
	int i, j;
	int size_1 = strlen(t1);
	int size_2 = strlen(t2);

	if (size_1 < size_2) {
		return -1;
	}

	for (i = 0; i <= 0; i++) {
		if (+(*t1 + i) < +(*t2 + i)) {
			return -1;
		}
		else if (+(*t1 + i) == +(*t2 + i)) {
			return 0;
		}
		else
			return 1;
	}
}

//int main() {

	/*int a = 10;
	int b = a;

	fc(&a, b);
	printf("%i \n", a);

	int pole[] = { 4, 2, 3, 4, 5, 6 };
	int *ptr = pole;

	printf("%i \n", +(*ptr + 5));
	printf("%i \n", sizeof(pole) / sizeof(pole[0]));*/



/*	printf("%i \n", porovnej(&"hoj", &"ahoj"));
	system("pause");
	return 0;
}
*/

//+(pointer + i) == pole[i]

int porovnani(char *t1, char *t2) {

	while (*t1 || *t2) {
		if (*t1 < *t2) return -1;
		else if (*t1 > *t2) return 1;

		t1++;
		t2++;
	}
	return 0;
}

/*int main() {
	
	char t1[] = "ahoj";
	char t2[] = "abcde";

	printf("%i \n", porovnani(t1, t2));

	return 0;
}*/

int main() {
	char str[] = "Ahoj!";
	char *pom = str;

	while (*pom != '\0') {
		printf("%c\n", *pom);
		pom++;
	}
	printf("Délka øetìzce je %i.\n", pom - str);
	system("pause");
	return 0;
}