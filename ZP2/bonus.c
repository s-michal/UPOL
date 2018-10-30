#include <stdio.h>
#include <stdlib.h>


void cnt_to_dat(FILE *input, FILE *output){
	char h;
	int cols, rows, i = 0, j;
	char values[10];

	h = getc(input);

	while(h != '\n'){
		rows = h - '0';
		h = getc(input);
	}

	fprintf(output, "%i\n", rows);

	h = getc(input);

	while(h != '\n'){
		cols = h - '0';
		h = getc(input);
	}

	fprintf(output, "%i\n", cols);

	fgets(values, cols + 2, input);

	for (j = 0; j < rows; j++){

		while(values[i] != '\n'){
			if (values[i] == '1'){
				fprintf(output, "%i ", i);
				i++;	
			}

			else
				i++;
		}
		fprintf(output, "\n");
		fgets(values, cols + 2, input);
		i = 0;	
	}
}

int main() {

	FILE *input = fopen("input.txt", "r");
    FILE *output = fopen("output.txt", "w");

   	cnt_to_dat(input, output);

    fclose(input);
    fclose(output);

	return 0;
}