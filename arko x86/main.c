#include <stdio.h>

extern char *remnth(char *s,int n);

int main()
{   
char txt[] = "some example text\0";
char dupa[] = "qwertyuiopasd\0";

printf("orginal = %s\n",txt);
printf("after = %s\n",remnth(txt,3));

printf("\n\norginal = %s\n",dupa);
printf("after = %s\n",remnth(dupa,5));

 return 0;
}