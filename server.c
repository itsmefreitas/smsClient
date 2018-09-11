#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
        FILE *fp;
        char readbuf[80];

        /* Create the FIFO if it does not exist */
        umask(0);
        mknod(argv[1], S_IFIFO|0666, 0);

        if (argc != 2) {
            
            printf("USAGE: handler [string]\n");
            exit(1);
        }
    
        while(1)
        {
                fp = fopen(argv[1], "r");
                fgets(readbuf, 80, fp);
                printf("%s\n", readbuf);
                fclose(fp);
        }

        return(0);
}