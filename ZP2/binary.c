#include <stdlib.h>
#include <stdio.h>


void num_to_bin(int *help, int number){
	int s = number, i = 0;

	while(s > 0){
		help[i] = s % 2;
		s = s / 2;
		i++;
	}
}

int main(){
	int number = 10;
	int *help = malloc(10 * sizeof(int));

	num_to_bin(help, number);

	for (int i = 9; i >= 0; i--){
		printf("%i ", help[i]);
	}
}