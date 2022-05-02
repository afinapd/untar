#include <iostream>
#include <iomanip>
#include <fstream>
#include <ctype.h>
using namespace std;

// "=================== No 1 ==================="
// main()
// {
//     char kalimat[100];
//     int i, spasi = 0;
//     cout << "Masukan Sebuah Kalimat : ";
//     cin.getline(kalimat, sizeof(kalimat));

//     for (i = 0; kalimat[i]; i++)
//     {

//         if (isspace(kalimat[i]) || ispunct(kalimat[i]))
//         {
//             spasi++;
//         }
//     }

//     cout << "Jumlah Kata = " << spasi + 1 << "\n\n";
// }

// "=================== No 2 ==================="
// void biner(int bilangan)
// {
//     if (bilangan == 1)
//     {
//         cout << 1;
//         return;
//     }
//     else
//     {
//         biner(bilangan / 2);
//         cout << bilangan % 2;
//     }
// }

// int main()
// {
//     int bilangan;
//     cout << "Konversi Desimal ke Biner" << endl;
//     cout << "Masukan Bilangan Desimal : ";
//     cin >> bilangan;
//     cout << "Binner : ";
//     biner(bilangan);
// }

// "=================== No 3 ==================="
int main()
{
    struct nilai
    {
        float uas, uts, tugas;
        int bobot, j;
        char huruf;
    };

    struct mahasiswa
    {
        char namamhs[20];
        char nim[9];
        nilai hasil;
    };

    mahasiswa mhs[10];

    int n;
    cout << "Masukan jumlah mahasiswa : ";
    cin >> n;

    for (int i = 1; i <= n; i++)
    {
        cout << "Nama mahasiswa ke-" << i << " : ";
        cin >> mhs[i].namamhs;
        cout << "Nim mahasiswa ke-" << i << " : ";
        cin >> mhs[i].nim;
        cout << "Nilai UAS mahasiswa ke-" << i << " : ";
        cin >> mhs[i].hasil.uas;
        cout << "Nilai UTS mahasiswa ke-" << i << " : ";
        cin >> mhs[i].hasil.uts;
        cout << "Nilai tugas mahasiswa ke-" << i << " : ";
        cin >> mhs[i].hasil.tugas;

        mhs[i].hasil.bobot = 0.5 * mhs[i].hasil.uas + 0.3 * mhs[i].hasil.uts + 0.2 * mhs[i].hasil.tugas;

        if (mhs[i].hasil.bobot >= 80)
        {
            mhs[i].hasil.huruf = 'A';
        }
        else if (mhs[i].hasil.bobot >= 70)
        {
            mhs[i].hasil.huruf = 'B';
        }
        else if (mhs[i].hasil.bobot >= 56)
        {
            mhs[i].hasil.huruf = 'C';
        }
        else if (mhs[i].hasil.bobot >= 45)
        {
            mhs[i].hasil.huruf = 'D';
        }
        else
        {
            mhs[i].hasil.huruf = 'E';
        }
    }

    cout << setiosflags(ios::left);
    cout << setw(5) << "No." << setw(10) << "Nim" << setw(10) << "Nama" << setw(10) << "Nilai" << setw(5) << "Huruf" << endl;

    for (int i = 1; i <= n; i++)
    {
        cout << setiosflags(ios::left);
        cout << setw(5) << i << setw(10) << mhs[i].nim << setw(10) << mhs[i].namamhs << setw(10) << mhs[i].hasil.bobot << setw(5) << mhs[i].hasil.huruf << "\n";
    }
}
