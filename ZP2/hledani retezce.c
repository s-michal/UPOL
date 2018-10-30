#include <stdlib.h>
#include <stdio.h>

void empty(char *array, int size) {
    int i;
    for (i = 0; i < size; i++) {
        array[i] = 0;
    }
}

char take_one(FILE *input, char *first, int size) {
    int i = 0;
    char ch;
    empty(first, size);

    while (1) {
        ch = getc(input);
        if (ch == '\n' || ch == EOF) {
            break;
        }
        else {
            first[i] = ch;
            i++;
        }
    }
    return ch;
}

int length(char *symbols) {
    int j = 0;

    while (symbols[j] != 0) {
        j++;
    }

    return j;
}

int compare(char *searched, char* first, char *ascii, int size) {

    int i, j, k, l;
    int len, pom = 0;
    char test[100];

    for (l = 0; first[l] != 0; l++) {
        test[l] = first[l];
    }
    test[l] = 0;

    empty(ascii, 128);
    len = length(searched);

    for (i = 0; searched[i] != 0; i++) {
        for (j = 0; test[j] != 0; j++) {
            if (searched[i] == test[j]) {
                ascii[test[j]] += 1;
                test[j] = '\\';
                break;
            }
        }
        if (test[j] == 0) return 0;
    }

    for (k = 0; k < 128; k++) {
        if (ascii[k] != 0)
            pom = pom + ascii[k];
    }

    if (pom == len) {
        return 1;
    }

    else
        return 0;
}


int main() {
    int j = 0, result;
    int size = 99;
    char first[100];
    char ascii[128];
    char searched[20];
    char ch = 0;
    FILE *input = fopen("linux.words", "r");

    printf("Zadejte retezec: ");
    printf("\n");

    scanf("%s", &searched);

    while (ch != EOF) {
        ch = take_one(input, first, size);
        result = compare(searched, first, ascii, size);

        if (result) {
            while (first[j] != 0) {
                printf("%c", first[j]);
                j++;
            }
            j = 0;
            printf("\n");
        }
    }

    fclose(input);
    return 0;

}