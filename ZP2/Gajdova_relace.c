#include <stdio.h>
#include <stdlib.h>


//VLASTNOSTI R S A T

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

//POMOCNA FUNKCE PRO KOPIROVANI RELACE

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

//TRANZITIVNI UZAVER

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
