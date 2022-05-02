// ========================= NO 1 =========================
// PLS RUN IN CPP.SH
// I didn't know No.1 only works in cpp.sh
#include <iostream>
#include <string.h>
#include <iomanip>
using namespace std;

char *inverting(char kalimatAwal[], char *balik[])
{

    char *result = *balik;
    int sizeKalimatAwal = strlen(kalimatAwal);
    int counter = 0;
    for (int i = sizeKalimatAwal - 1; i >= 0; i--)
    {

        result[counter] = kalimatAwal[i];
        counter++;
    }

    return result;
}

void comparison(char kalimat1[], char kalimat2[])
{
    if (strcmp(kalimat1, kalimat2) == 0)
        cout << "TRUE";
    else
        cout << "FALSE";
}

int main()
{
    char *balik[100], kalimatAwal[100];
    cout << "enter the word : ";
    cin.getline(kalimatAwal, sizeof(kalimatAwal));
    char *resultReserve = inverting(kalimatAwal, balik);
    cout << "reserve: " << resultReserve;
    cout << endl;
    cout << "compare :  ";
    comparison(kalimatAwal, resultReserve);
}
