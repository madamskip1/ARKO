#include <stdio.h>

extern int szukaj2(char *str, char *str1);

int main(){
	
	char tab[] = "to jest JAKIS TEKST\0";
	char tab2[] = "to*Sz\0";
	char tab3[] = "*\0";
	char tab4[] = "to*\0";
	char tab5[] = "*ST\0";
	char tab6[] = "to*IS\0";
	printf("CIAG BAZOWY : %s\n", tab);
	printf("Wynik szukania %s w bazowym = %d \n",tab2, szukaj2(tab, tab2));
	printf("Wynik szukania %s w bazowym = %d \n",tab3, szukaj2(tab, tab3));
	printf("Wynik szukania %s w bazowym = %d \n",tab4, szukaj2(tab, tab4));
	printf("Wynik szukania %s w bazowym = %d \n",tab5, szukaj2(tab, tab5));
	printf("Wynik szukania %s w bazowym = %d \n",tab6, szukaj2(tab, tab6));
	return 0;

}
