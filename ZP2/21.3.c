#include <stdio.h>
#include <stdlib.h>


int soucet(FILE *soubor){
	char h;
	int count = 0;


	h = getc(soubor);
	
	while(h != EOF){
		count = temp + count;
		h = getc(soubor);
	}

	return count;
}


int main() {
  
	FILE *file; 
	char hey;	
	scanf("%c", &hey);
	while(hey != '+'){
	scanf("%c", &hey);
	}	
	file = fopen("21.3.c","rt4");
  	printf("%i\n",soucet(file));

	return 0;
}