#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void compress(FILE *input, FILE *output) {

    char current, previous;
    unsigned char x = 1;

    fread(&previous, 1, 1, input);

    while(fread(&current, 1, 1, input)){
        if (previous == current && x < 255){
            x++;
        }

        else {
            fwrite(&previous, 1, 1, output);
            fwrite(&x, 1, 1, output);
            previous = current;
            x = 1;
        }
    }

    fwrite(&previous, 1, 1, output);
    fwrite(&x, 1, 1, output);
}

void decompress(FILE *input, FILE *output) {

    char character;
    unsigned char occurency;

    fread(&character, 1, 1, output);

    while (fread(&occurency, sizeof(unsigned char), 1, output)) {
        for (int i = 0; i < occurency; i++) {
            fwrite(&character, 1, 1, input);
        }

        fread(&character, 1, 1, output);
    }
}


int main(int args, char *argv[])
{
    FILE *input = fopen(argv[2], "r+b");
    FILE *output = fopen(argv[3], "w+b");

    if (strcmp("e", argv[1]) == 0){
        compress(input, output);
    }

    else if (strcmp("d", argv[1]) == 0){
        decompress(output, input);
    }
    

    fclose(input);
    fclose(output);
    return 0;
}


