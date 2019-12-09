 #include <stdio.h>
 
 char tab1[1000000];
 
 int func(char*c1);
 
 int main()
 {
   printf("2. bubblesort\n");
   printf("Prosze podac ciag do posortowania:\n");
   scanf("%s", tab1);
   func(tab1);
   printf("Ciag posortowany: %s\n", tab1);
   return 0;
 }