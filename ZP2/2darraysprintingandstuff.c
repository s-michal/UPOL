#include <stdio.h>
#include <stdlib.h>


void print_relation(int *array, int m){

	int i, j;
	for (i = 0; i < m; i++){
		for (j = 0; j < m; j++){
			printf("%d ", (array[i * m + j]));
		}
		printf("\n");
	}
}


int is_reflexive(int *relation, int m){
	int j, i;
	for (i = 0; i < m; i++){
		for(j = i; j < m; j++){
			if ((relation[i * m + j]) == 1) break;
				return 0;
		}
	}
	return 1;
}

int is_symetrical(int *relation, int m){
	int j, i;

	for (i = 0; i < m; i++){
		for (j = 0; j < m; j++){
			if (j == i) continue;
			else if ((relation[i * m + j]) == (relation[j * m + i])) continue;
			else return 0;
		}
	}
	return 1;
}

int is_antisymetrical(int *relation, int m){
	int j, i;

	for (i = 0; i < m; i++){
		for (j = 0; j < m; j++){
			if (j == i) continue;
			else if ((relation[i * m + j]) == 1 && 
				(relation[i * m + j]) == (relation[j * m + i]))
			return 0;
		}	
	}
	return 1;
}

int is_transitiv(int *relation, int m){
	int j, i, k;

	for (i = 0; i < m; i++){
		for (j = 0; j < m; j++){
			if ((relation[i * m + j]) == 1){
				for (k = 0; k < m; k++){
					if ((relation[j * m + k])== 1 &&
					 (relation[i * m + k]) != 1)
					  return 0;
				}
			}
		}
	}
	return 1;
}

int *copy(int *relation, int m){
	int i, j;

	int *m_relation = malloc(m * m * sizeof(int));

	for (i = 0; i < m; i++) {
		for (j = 0; j < m; j++) {
			m_relation[i * m + j] = relation[i * m + j];
		}
	}
	return m_relation;
}

int *trans_closure(int *relation, int m){
	int j, i, k;

	int *m_relation = copy(relation, m);
	int result = is_transitiv((int *) relation, m);

	if (result == 1) 
		return m_relation;

	else {
		for (i = 0; i < m; i++){
			for (j = 0; j < m; j++){
				if ((m_relation[i * m + j]) == 1){
					for (k = 0; k < m; k++){
						if ((m_relation[j * m + k]) == 1 &&
					 	(m_relation[i * m + k]) != 1)
							(m_relation[i * m + k]) = 1;
					  
					}
				}
			}	
		}
		return m_relation;
	}
}


void print(int *relation, int m){

	if ((is_reflexive((int *)relation, m) == 1 )) printf("Relace je reflexivni\n");
	else printf("Relace neni reflexivni \n");
	
	if ((is_symetrical((int *)relation, m) == 1 )) printf("Relace je symetricka \n");
	else printf("Relace neni symetricka \n");
	
	if ((is_antisymetrical((int *)relation, m) == 1 )) printf("Relace je antisymetricka \n");
	else printf("Relace neni antisymetricka \n");
	
	if ((is_transitiv((int *)relation, m) == 1 )) printf("Relace je tranzitivni \n");
	else printf("Relace neni tranzitivni \n");
}


int main(){

	int m = 3;

	int relation[3][3] =
	{{1, 1, 0},
	 {0, 0, 1}, 
	 {0, 0, 1}};


	 int druha[3][3] =
	{{1, 0, 0},
	 {0, 1, 0}, 
	 {0, 0, 1}};

	int *closure;

	print_relation((int *) relation, m);
	printf("\n");
	print((int *) relation, m);
	printf("\n");
	closure = trans_closure((int *) relation, m);
	print_relation(closure, m);

	printf("\n");
	print_relation((int *) druha, m);
	printf("\n");
	print((int *) druha, m);
	printf("\n");
	closure = trans_closure((int *) druha, m);
	print_relation(closure, m);


	return 0;
}