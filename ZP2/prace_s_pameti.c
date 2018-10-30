#include<stdlib.h>
#include<stdio.h>
#include<string.h>

char* Spojeni_retezcu(char *r1, char *r2) {
	int d1 = strlen(r1);
	int d2 = strlen(r2);
	int i = 0, j = 0;
	char* new = malloc((d1 + d2 + 1) * sizeof(char));

	while (r1[i]) {
		new[i] = r1[i];
		i++;
	}

	while (r2[j]) {
		new[i] = r2[j];
		i++;
		j++;
	}

	new[i + 1] = 0;
	return new;
}

int main() {
	char retezec1[] = "klim", retezec2[] = "atizace";
	int i = 0;
	char* new = Spojeni_retezcu(retezec1, retezec2);

	while (new[i]) {
		printf("%c", new[i]);
		i++;
	}

	printf("\n");
	system("pause");
	return 0;
}