#include <iostream>
#include <ctype.h>
namespace std;

void main()
{
    char kalimat[100];
    int i, spasi = 0;
    cout << "Nama : Mochammad Robby Wibawa" << endl;
    cout << "NIM  : TI111010" << endl
         << endl
         << endl;
    cout << "Masukan Kalimat anda : ";
    cin.getline(kalimat, sizeof(kalimat));
    cout << "" << endl
         << endl;
    cout << "kata yang anda masukkan adalah: \n";

    for (i = 0; kalimat[i]; i++)
    {
        if (isspace(kalimat[i]) || ispunct(kalimat[i]))
        {
            spasi++;
        }
        cout << kalimat[i];
    }
    cout << endl
         << endl
         << endl;

    for (i = 0; kalimat[i]; i++)
    {
        if (isspace(kalimat[i]) || ispunct(kalimat[i]))
        {
            spasi++;
        }
    }
    cout << "dalam kalimat terdapat  " << spasi + 1 << " kata"
         << "\n\n";
}