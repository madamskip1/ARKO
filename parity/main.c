#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "function.h"

int main(int argc, char *argv[])
{
    char *pointerText = (char*)0;
    if(argc < 2)
        return -1;

    pointerText = malloc(strlen(argv[1]+1));
    if(pointerText == NULL)
        return -1;

    strcpy(pointerText, argv[1]);
    function(pointerText);
    printf("%s\n%s\n", argv[1], pointerText);

    free(pointerText);


    return 0;
}