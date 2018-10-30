#include <stdio.h>
#include <stdlib.h>


/*FUNKCE PRO R S A T */
int is_reflexive(int **relation, int X){
	int j, i;
	for (i = 0; i < X; i++){
		for(j = i; j < X; j++){
			if (relation[i][j] == 1) break;
				return 0;
		}
	}
	return 1;
}

int is_symetrical(int **relation, int X){
	int j, i;

	for (i = 0; i < X; i++){
		for (j = 0; j < X; j++){
			if (j == i) continue;
			else if (relation[i][j] == relation[j][i]) continue;
			else return 0;
		}
	}
	return 1;
}

int is_antisymetrical(int **relation, int X){
	int j, i;

	for (i = 0; i < X; i++){
		for (j = 0; j < X; j++){
			if (j == i) continue;
			else if (relation[i][j] == 1 && relation[i][j] == relation[j][i])
			return 0;
		}	
	}
	return 1;
}

int is_transitiv(int **relation, int X){
	int j, i, k;

	for (i = 0; i < X; i++){
		for (j = 0; j < X; j++){
			if (relation[i][j] == 1){
				for (k = 0; k < X; k++){
					if (relation[j][k]== 1 && relation[i][k] != 1) return 0;
				}
			}
		}
	}
	return 1;
}


int **new_relation(int X){
	int j, k;

	int **relation = malloc(X * sizeof(int));

	for (j = 0; j < X; j++){
		relation[j] = malloc(X * sizeof(int));
		for (k = 0; k < X; k++){
			relation[j][k] = 0;
		}
	}

	return relation;
}

int **copy(int **relation, int X){
	int i, j;

	int **m_relation = malloc(X * sizeof(int*));

	for (i = 0; i < X; i++){
		m_relation[i] = malloc(X * sizeof(int));
		for (j = 0; j < X; j++){
			m_relation[i][j] = relation[i][j];
		}
	}
	return m_relation;
}


int **trans_closure(int **relation, int X){
	int j, i, k;

	int **m_relation = copy(relation, X);
	int result = is_transitiv(relation, X);

	if (result == 1) 
		return m_relation;
	
	else {
		for (i = 0; i < X; i++){
			for (j = 0; j < X; j++){
				if (relation[i][j] == 1){
					for (k = 0; k < X; k++){
						if (relation[j][k] == 1 && relation[i][k] != 1){ 
							m_relation[i][k] = 1;
						}
					}
				}
			}
		}
	}
	return m_relation;
}



/*FUNKCE PRO VYPSANI RELACE A JEJICH VLASTNOSTI*/

void print_relation(int **relation, int X){

	int j, i;
	for (i = 0; i < X; i++){
		for(j = 0; j < X; j++){
			printf("%i ", relation[i][j]);
		}
		printf("\n");	
	}
}

void print(int **relace, int X){

	if (is_reflexive(relace, X) == 1) printf("Relace je reflexivni\n");
	else printf("Relace neni reflexivni \n");
	
	if (is_symetrical(relace, X) == 1) printf("Relace je symetricka \n");
	else printf("Relace neni symetricka \n");
	
	if (is_antisymetrical(relace, X) == 1) printf("Relace je antisymetricka \n");
	else printf("Relace neni antisymetricka \n");
	
	if (is_transitiv(relace, X) == 1) printf("Relace je tranzitivni \n");
	else printf("Relace neni tranzitivni \n");
}

int main(){
	int i, j;
	int X;
	/*int X = 3;
	

	int relation[3][3] ={{1, 0, 0},{0, 1, 1},{1, 1, 1}};
	
	print(relation, X);*/


	int **relace;
	int **uzaver;

	while(1){

	printf("Choose universum: ");
	scanf("%i", &X);
	relace = new_relation(X);
	printf("******************* \n");
	printf("Current matrice state: \n");
	print_relation(relace, X);

	printf("\n");
	printf("Enter values for rows, 1 or 0: \n");
	for (i = 0; i < X; i++){
		for (j = 0; j < X; j++){
			int temp;
			printf("m = %i n = %i \n", i+1, j+1);
			scanf("%i", &temp);
			while (temp != 1 && temp != 0){
				printf("Invalid number, try again \n");
				scanf("%i", &temp);
				}
		
				relace[i][j] = temp;
			}
			printf("******************* \n");
			printf("Current matrice state:\n");
			print_relation(relace, X);
			printf("\n");
		}
	
	print(relace, X);
	uzaver = trans_closure(relace, X);
	print_relation(uzaver, X);
	printf("\n");
	free(relace);
}


	
	return 0;
}