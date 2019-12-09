#include <stdio.h>

extern char *dop(char *s,int n);

int main(int argc, char *argv[])
{   
int n;
if(argc>2)
{
    n=atoi(argv[2]);
    if(n<0 || n>9)
    {
        printf("BLAD! to nie jest cyfra!\n");
        exit(0);
    }
    printf("wejscie =%s\n",argv[1]);
    printf("wyjscie =%s\n",dop(argv[1],n));
}
else
{
    printf("BLAD, ZLE ARGUMENTY!\n");
}

 return 0;
}
