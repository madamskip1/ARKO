 #include <stdio.h>
 
 char tab1[256], tab2[256];
 
 int func(char*c1, char*c2);
 
 int main()
 {
   printf("3. porownywanie z wzorcem\n");
   printf("Prosze podac ciag bazowy (bez *, .):\n");
   scanf("%s", tab1);
   printf("Prosze podac wzorzec (MUSI zawierac dokladnie jedno '*', moze zawierac dowolnie wiele '.'):\n");
   scanf("%s", tab2);
   int i = func(tab1, tab2);
   printf("Wynik: %i\n", i);
   if(i)
   {
     printf("(ciagi sa zgodne)\n");
   }
   else
   {
     printf("(ciagi nie sa zgodne)\n");
   }
   //printf("%s\n", tab1);
   //printf("%s\n", tab2);
   return 0;
 }