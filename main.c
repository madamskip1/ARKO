#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "remnth.h"


int main(int argc, char *argv[])
{
    char *pointerText =(char*)0;
    if(argc < 2)
        return -1;

    pointerText = malloc(strlen(argv[2] +1));
    if (pointerText == NULL)
        return -1;

    strcpy(pointerText, argv[2]);
    int n = atoi(argv[1]);
    remnth(pointerText, n);
    printf("%s\n""%s\n", argv[2], pointerText);
    printf("%d", n);

    free(pointerText);
    return 0;
}