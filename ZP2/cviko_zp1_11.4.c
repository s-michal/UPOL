#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char insert(FILE *input, char *symbols){
	int i  = 0;

	char h = getc(input);

    while (h != '\n' && h != EOF){        
     symbols[i] = h;       
     h = getc(input); 
     i++;     
 }
 	symbols[i] = 0;

 	return h;
}

int length(char *symbols){
	int j = 0;

	while (symbols[j] != 0){
		j++;
	}

	return j;	
}

char *copy_array(char *symbols){
	int i = 0;
	
	int size = length(symbols);

	char *new = malloc(size * sizeof(char));

	while (symbols[i] != 0){
		new[i] = symbols[i];
		i++;
	}

	return new;
}

char compare(FILE *input, char *symbols, char *searched){
	int i = 0, j = 0, x = 0;

	int h = 1;

	char help = insert(input, symbols);
	char *copy = copy_array(symbols);

	while(searched[i] != 0){
		while(copy[j] != 0){
			if(searched[i] == copy[j]){
				copy[j] = '\\';
				i++;
				break;
			}
				
			else
				j++;
		}

		if (copy[j] == 0)
			h = 0;

	}	
		if (h == 1){

			while(symbols[x] != 0){
			printf("%c", symbols[x]);
			x++;
		}

		printf("\n");
	}

	free(copy);
	return help;
}



int main(){
	int i = 0;
	FILE *input = fopen("linux.words", "r");
	char symbols[30];
	char searched[30];

	scanf("%c", &searched);
	
	while(1){
		char help = compare(input, symbols, searched);
		if (help == EOF)
			break;
	}

	
	fclose(input);
	return 0;
}