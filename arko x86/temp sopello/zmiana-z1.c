#include <stdio.h>

extern char* zmiana(char * str);

int main()
 {
  char tab[] = "to jest JAKIS TEKST\0";
  printf("%s \n",zmiana(tab));
  return 0;
 }
