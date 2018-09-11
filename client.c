#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
        FILE *fp;

        if ( argc != 3 ) {
                printf("USAGE: handler [string] fifoclient [string]\n");
                exit(1);
        }

        if((fp = fopen(argv[1], "w")) == NULL) {
                perror("fopen");
                exit(1);
        }

        fputs(argv[2], fp);

        fclose(fp);
        return(0);
}