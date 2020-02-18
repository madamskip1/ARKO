////////////////////////////
//
//  Rysowanie funkcji kwadratowej, funkcja przybliżana odcinkami równej długości 
//  (dx^2+dy^2=S=const. Nie dx=const.) (interaktywnie ustawiany skok S i parametry funkcji)
//  
//  Adamski Maciej, 300184
//
////////////////////////////
#include <stdio.h>
#include <allegro.h>
#include "quadratic.h"


void drawAxes(BITMAP *);
void drawQuadratic(BITMAP *, BITMAP *, int, int, double, double, double, double);
void drawParams(BITMAP *, int, double, double, double, double);
void printStart();


int main()
{

    printStart();

    double A, B, C, S;

    A = 1.0;
    B = 0.0;
    C = 0.0;
    S = 0.0;
    double scale = 1.0;
    int size = 800;

    scale *= size / 2;
    int toChange = 0;

    allegro_init();
    set_window_title("Quadratic Function");
    install_keyboard();
    set_gfx_mode(GFX_AUTODETECT_WINDOWED, size, size, 0, 0);

    BITMAP * bitmap = create_bitmap(size, size);

    if(!bitmap)
        return -1;

    drawQuadratic(bitmap, screen, scale, toChange, A, B, C, S);

    while(!key[KEY_ESC])
    {
        drawQuadratic(bitmap, screen, scale, toChange, A, B, C, S);
        readkey();
        if(key[KEY_DOWN])
        {
            toChange++;
            if(toChange > 3)
                toChange = 0;
        }
        else if(key[KEY_UP])
        {
            toChange--;
            if(toChange < 0)
                toChange = 3;
        }
        else if(key[KEY_LEFT])
        {
            if (toChange == 0)
            {
                A -= 0.25;
                if (A < -5)
                    A = -5;
            }
            else if (toChange == 1)
            {
                B -= 0.25;
                if (B < -5)
                    B = -5;
            }
            else if (toChange == 2)
            {
                C -= 0.25;
                if (C < -5)
                    C = -5;
            }
            else 
            {
                S -= 0.0025;
                if (S < 0)
                    S = 0;
            }
        }
        else if (key[KEY_RIGHT])
        {
            if (toChange == 0)
            {
                A += 0.25;
                if (A > 5)
                    A = 5;
            }
            else if (toChange == 1)
            {
                B += 0.25;
                if (B > 5)
                    B = 5;
            }
            else if (toChange == 2)
            {
                C += 0.25;
                if (C > 5)
                    C = 5;
            }
            else 
            {
                S += 0.0025;
                if (S > 0.1)
                    S = 0.1;
            }
        }
    }

    destroy_bitmap(bitmap);
    allegro_exit();

    printf("\n%s\n", "// Koniec programu");
    return 0;
}

void drawAxes(BITMAP * bitmap)
{
    // Main axis
    hline(bitmap, 0, (bitmap->h / 2), bitmap->w, makecol(0, 137, 242));
    vline(bitmap, (bitmap->w / 2), 0, bitmap->h, makecol(0, 137, 242));

    // Auxilary X-axis
    hline(bitmap, 0, (bitmap->h / 4), bitmap->w, makecol(84, 177, 247));
    hline(bitmap, 0, (bitmap->h * 3 / 4), bitmap->w, makecol(84, 177, 247));

    // Auxilary Y-axis
    vline(bitmap, (bitmap->w / 4), 0, bitmap->h, makecol(84, 177, 247));
    vline(bitmap, (bitmap->w * 3 / 4), 0, bitmap->h, makecol(84, 177, 247));
}

void drawQuadratic(BITMAP * bitmap, BITMAP * screen, int scale, int toChange, double A, double B, double C, double S)
{
    clear_to_color(bitmap, makecol(0, 0, 0));
    drawAxes(bitmap);
    quadratic(bitmap->line, bitmap->w, scale, A, B, C, S * S);
    drawParams(bitmap, toChange, A, B, C, S);
    textout_ex(bitmap, font, "Adamski Maciej", (bitmap->w - 200), (bitmap->h - 20), makecol(255, 255, 255), -1);

    blit(bitmap, screen, 0, 0, 0, 0, bitmap->w, bitmap->h);
}

void drawParams(BITMAP * bitmap, int toChange, double A, double B, double C, double S)
{
    char Achar[sizeof(A)];
    sprintf(Achar, "%f", A);
    textout_ex(bitmap, font, "A = ", 10, 10, makecol(255, 255, 255), -1);
    textout_ex(bitmap, font, Achar, 45, 10, (toChange == 0 ? makecol(220,20,60): makecol(255, 255, 255)), -1);

    char Bchar[sizeof(B)];
    sprintf(Bchar, "%f", B);
    textout_ex(bitmap, font, "B = ", 10, 20, makecol(255, 255, 255), -1);
    textout_ex(bitmap, font, Bchar, 45, 20, (toChange == 1 ? makecol(220,20,60): makecol(255, 255, 255)), -1);

    char Cchar[sizeof(C)];
    sprintf(Cchar, "%f", C);
    textout_ex(bitmap, font, "C = ", 10, 30, makecol(255, 255, 255), -1);
    textout_ex(bitmap, font, Cchar, 45, 30, (toChange == 2 ? makecol(220,20,60): makecol(255, 255, 255)), -1);

    char Schar[sizeof(S)];
    sprintf(Schar, "%f", S);
    textout_ex(bitmap, font, "S = ", 10, 40, makecol(255, 255, 255), -1);
    textout_ex(bitmap, font, Schar, 45, 40, (toChange == 3 ? makecol(220,20,60): makecol(255, 255, 255)), -1);
}


void printStart()
{
    printf("%s\n", "/========================================\\");
    printf("%s\n", "/=              Adamski Maciej          =\\");
    printf("%s\n", "/=                  ARKO                =\\");
    printf("%s\n", "/=           Funkcja kwadratowa         =\\");
    printf("%s\n", "/========================================\\");
    printf("\n");
    printf("%s\n", "By zwiekszyc lub zmniejszyc parametr uzyj strzalek \"LEWO\", \"PRAWO\"");
    printf("%s\n", "By wybrac inny parametr uzyj strzalek \"LEWO\", \"PRAWO\"");
}