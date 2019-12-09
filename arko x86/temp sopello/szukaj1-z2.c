#include <stdio.h>

extern int szukaj1(char *str, char *str1);

int main(){
	char tab[] = "to jest JAKIS TEKST\0";
	char tab2[] = "...S\0";
	char tab3[] = "J....\0";
	char tab4[] = "J..I\0";
	char tab5[] = ".\0";
	char tab6[] = "..z\0";
	printf("WZORZEC == %s\n", tab);
	printf("Wyszukiwanie %s we wzorcu = %d\n", tab2, szukaj1(tab, tab2));
	printf("Wyszukiwanie %s we wzorcu = %d\n", tab3, szukaj1(tab, tab3));
	printf("Wyszukiwanie %s we wzorcu = %d\n", tab4, szukaj1(tab, tab4));
	printf("Wyszukiwanie %s we wzorcu = %d\n", tab5, szukaj1(tab, tab5));
	printf("Wyszukiwanie %s we wzorcu = %d\n", tab6, szukaj1(tab, tab6));
	return 0;

}
