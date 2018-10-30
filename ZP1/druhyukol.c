#include <stdio.h>
#include <stdlib.h>
#include <math.h>


typedef struct {
	int citatel;
	int jmenovatel;
} zlomek;

zlomek gcd(zlomek);
zlomek soucet(zlomek, zlomek);
zlomek rozdil(zlomek, zlomek);
zlomek soucin(zlomek, zlomek);
zlomek podil(zlomek, zlomek);
zlomek mocneni(zlomek, unsigned int);

zlomek gcd(zlomek vysledek) {
	zlomek zkraceny;

	int a = abs(vysledek.citatel);
	int b = abs(vysledek.jmenovatel);
	int gcd = 0;

	int c = a % b;

	while (c > 0)
	{
		a = b;
		b = c;
		c = a % b;
	}
	gcd = b;

	zkraceny.citatel = vysledek.citatel / gcd;
	zkraceny.jmenovatel = vysledek.jmenovatel / gcd;

	if (zkraceny.citatel < 0 && zkraceny.jmenovatel < 0) {
		zkraceny.citatel = abs(zkraceny.citatel);
		zkraceny.jmenovatel = abs(zkraceny.jmenovatel);
	}

	return zkraceny;
}

zlomek soucin(zlomek zlomek1, zlomek zlomek2) {
	zlomek vypocet;
	zlomek error = { 0, 0 };

	if (zlomek1.jmenovatel == 0 || zlomek2.jmenovatel == 0) {
		return error;
	}

	else if (zlomek1.jmenovatel < 0 || zlomek2.jmenovatel < 0) {
		vypocet.citatel = (zlomek1.citatel * zlomek2.citatel) * -1;
		vypocet.jmenovatel = (zlomek1.jmenovatel * zlomek2.jmenovatel) * -1;
		return gcd(vypocet);
	}

	else {
		vypocet.citatel = zlomek1.citatel * zlomek2.citatel;
		vypocet.jmenovatel = zlomek1.jmenovatel * zlomek2.jmenovatel;
		return gcd(vypocet);
	}

	
}

zlomek soucet(zlomek zlomek1, zlomek zlomek2) {
	zlomek vypocet;
	zlomek error = { 0, 0 };

	if (zlomek1.jmenovatel == 0 || zlomek2.jmenovatel == 0) {
		return error;
	}

	else if (zlomek1.jmenovatel < 0 || zlomek2.jmenovatel < 0) {
		vypocet.citatel = ((zlomek1.citatel * zlomek2.jmenovatel) + (zlomek2.citatel * zlomek1.jmenovatel)) * -1;
		vypocet.jmenovatel = (zlomek1.jmenovatel * zlomek2.jmenovatel) * -1;
		return gcd(vypocet);
	}

	else {
		vypocet.citatel = (zlomek1.citatel * zlomek2.jmenovatel) + (zlomek2.citatel * zlomek1.jmenovatel);
		vypocet.jmenovatel = zlomek1.jmenovatel * zlomek2.jmenovatel;
		return gcd(vypocet);
	}
	

}

zlomek podil(zlomek zlomek1, zlomek zlomek2) {
	zlomek vypocet;
	zlomek error = { 0, 0 };

	if (zlomek1.jmenovatel == 0 || zlomek2.citatel == 0 || zlomek2.jmenovatel == 0) {
		return error;
	}

	else if (zlomek1.jmenovatel < 0 || zlomek2.citatel < 0) {
		vypocet.citatel = (zlomek1.citatel * zlomek2.jmenovatel) * -1;
		vypocet.jmenovatel = (zlomek2.citatel * zlomek1.jmenovatel) * -1;
		return gcd(vypocet);
	}


	else {
		vypocet.citatel = zlomek1.citatel * zlomek2.jmenovatel;
		vypocet.jmenovatel = zlomek2.citatel * zlomek1.jmenovatel;
		return gcd(vypocet);
	}
	

}

zlomek rozdil(zlomek zlomek1, zlomek zlomek2) {
	zlomek vypocet;
	zlomek error = { 0, 0 };

	if (zlomek1.jmenovatel == 0 || zlomek2.jmenovatel == 0) {
		return error;
	}

	else if (zlomek1.jmenovatel < 0 || zlomek2.jmenovatel < 0) {
		vypocet.citatel = ((zlomek1.citatel * zlomek2.jmenovatel) - (zlomek2.citatel * zlomek1.jmenovatel)) * -1;
		vypocet.jmenovatel = (zlomek1.jmenovatel * zlomek2.jmenovatel) * -1;
		return gcd(vypocet);
	}

	else {
		vypocet.citatel = (zlomek1.citatel * zlomek2.jmenovatel) - (zlomek2.citatel * zlomek1.jmenovatel);
		vypocet.jmenovatel = zlomek1.jmenovatel * zlomek2.jmenovatel;
		return gcd(vypocet);
	}


}

zlomek mocneni(zlomek zlomek1, unsigned int mocnina) {
	zlomek vypocet;
	zlomek error = { 0, 0 };



	if (zlomek1.jmenovatel == 0) {
		return error;
	}
	
	else if (zlomek1.jmenovatel < 0) {
		vypocet.citatel = pow(zlomek1.citatel, mocnina) * -1;
		vypocet.jmenovatel = pow(zlomek1.jmenovatel, mocnina) * -1;
		return gcd(vypocet);
	}

	else {
		vypocet.citatel = pow(zlomek1.citatel, mocnina);
		vypocet.jmenovatel = pow(zlomek1.jmenovatel, mocnina);
		return gcd(vypocet);
	}
	
}


