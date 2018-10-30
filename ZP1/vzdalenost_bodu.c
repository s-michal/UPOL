#include <stdio.h>
#include <stdlib.h>
#include <math.h>


#define SIZE 4
typedef struct {
	int x;
	int y;
} bod;



double rozdilBodu(bod poleBodu[]) {
	int i, j;
	double vypocet, min = -1;


	for (i = 0; i <= SIZE; i++) {
		for (j = i + 1; j <= SIZE; j++) {
			vypocet = sqrt(pow((poleBodu[i].x - poleBodu[j].x), 2) + (pow((poleBodu[i].y - poleBodu[j].y), 2)));
			if (min <  0) 
				min = vypocet;
					
			else if (vypocet < min) 
				min = vypocet;		
		}
	}
	return min;

}


double main() {
	bod poleBodu[SIZE] = { { 4, 8 },{ -2, 1 },{ 5, 0 },{ 0, -12 } };

	printf("Nejmensi vzdalenost mezi dvema body je: %f \n", rozdilBodu(poleBodu) );
	system("pause");
	return 0;
}