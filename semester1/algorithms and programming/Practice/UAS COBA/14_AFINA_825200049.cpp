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

//         if (kalimat[i] == ' ')
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
//         // biner(1)
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
    ofstream fileOutput("finalResult.txt");
    ifstream fileOutputConsole;
    ifstream fileInput("tableNilai.txt");

    struct nilai
    {
        float uas, uts, tugas;
        int bobot, n1[5], n2[5], j;
        char huruf, o[5], a[5];
    };

    struct mahasiswa
    {
        char namamhs[20];
        char nim[9];
        nilai hasil;
    };

    char nama[50];
    mahasiswa mhs[10];
    nilai hasil;

    hasil.j = 0;
    while (fileInput)
    {
        fileInput >> hasil.n1[hasil.j];
        fileInput >> hasil.o[hasil.j];
        fileInput >> hasil.n2[hasil.j];
        fileInput >> hasil.a[hasil.j];
        hasil.j++;
    }
    fileInput.close();

    int n;
    cout << "Masukan jumlah mahasiswa : ";
    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cout << "Nama mahasiswa ke-" << i + 1 << " : ";
        cin >> mhs[i].namamhs;
        cout << "Nim mahasiswa ke-" << i + 1 << " : ";
        cin >> mhs[i].nim;
        cout << "Nilai UAS mahasiswa ke-" << i + 1 << " : ";
        cin >> mhs[i].hasil.uas;
        cout << "Nilai UTS mahasiswa ke-" << i + 1 << " : ";
        cin >> mhs[i].hasil.uts;
        cout << "Nilai tugas mahasiswa ke-" << i + 1 << " : ";
        cin >> mhs[i].hasil.tugas;

        mhs[i].hasil.bobot = 0.5 * mhs[i].hasil.uas + 0.3 * mhs[i].hasil.uts + 0.2 * mhs[i].hasil.tugas;

        for (int k = 0; k < 5; k++)
        {
            if (mhs[i].hasil.bobot >= hasil.n1[k] && mhs[i].hasil.bobot < hasil.n2[k])
            {
                mhs[i].hasil.huruf = hasil.a[k];
            }
        }
    }

    fileOutput << setiosflags(ios::left);
    fileOutput << setw(5) << "No." << setw(10) << "Nim" << setw(10) << "Nama" << setw(10) << "Nilai" << setw(5) << "Huruf" << endl;

    for (int i = 0; i < n; i++)
    {
        fileOutput << resetiosflags(ios::right);
        fileOutput << setiosflags(ios::left);
        fileOutput << setw(5) << i + 1 << setw(10) << mhs[i].nim << setw(10) << mhs[i].namamhs << setw(10) << mhs[i].hasil.bobot << setw(5) << mhs[i].hasil.huruf << "\n";
    }
    fileOutput.close();

    fileOutputConsole.open("finalResult.txt");
    while (fileOutputConsole)
    {
        fileOutputConsole.getline(nama, sizeof(nama));
        cout << nama << endl;
    }
    fileOutputConsole.close();
}
