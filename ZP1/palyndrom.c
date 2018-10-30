#include <stdio.h>
#include <stdlib.h>

int main(){	
	int i, j;
	int len;
	
	char word[20];

	scanf("%s", &word);

	len = strlen(word);

	for (i = 0; i < (len - 1) /2; i++){
		for (j = len - 1; j > (len - 1) /2; j--){
			if (word[i] == word[j])
				continue;

			else {
				printf("NE");
				return 0;
			}
		}
	}
	printf("ANO");
	return 1;
}
