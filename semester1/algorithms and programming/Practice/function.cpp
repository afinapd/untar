#include <iostream>
#include <cmath>
#include <string>
using namespace std;

// int faktorial(int n)
// {
//     int i, ffakt;
//     ffakt = 1;
//     for (i = 1; i <= n; i++)
//     {
//         ffakt = ffakt * i;
//     }
//     return ffakt;
// }
// int main()
// {
//     int N, fakt;
//     cout << "masukan nilai faktorial : ";
//     cin >> N;
//     fakt = faktorial(N);
//     cout << "hasil = "<<fakt;
// }

// void KelilingLuasVolume(int p, int l, int t, int &luas, int &keliling, int &volume)
// {
//     // int luas, keliling, volume;
//     luas = 2 * (p * l + p * t + l * t);
//     keliling = 4 * (p + l + t);
//     volume = p * l * t;
// }
// int main()
// {
//     int panjang, lebar, tinggi, L, K, V;
//     cout << "panjang : ";
//     cin >> panjang;
//     cout << "lebar : ";
//     cin >> lebar;
//     cout << "tinggi : ";
//     cin >> tinggi;
//     KelilingLuasVolume(panjang, lebar, tinggi, L, K, V);
//     cout << "luas : " << L << "\n";
//     cout << "keliling : " << K << "\n";
//     cout << "volume : " << V << "\n";
// }

// void convertTemperature(int angka, char karakter)
// {
//     int celciusFahrenheit, fahrenheitCelcius;
//     if (karakter == 'F')
//     {
//         celciusFahrenheit = (angka * 9 / 5) + 32;
//         cout << angka << " C = " << celciusFahrenheit << " F";
//     }
//     else if (karakter == 'C')
//     {
//         fahrenheitCelcius = (angka - 32) * 5 / 9;
//         cout << angka << " F = " << fahrenheitCelcius << " C";
//     }
//     else if (karakter != 'F' && karakter != 'C')
//     {
//         cout << "karakter yang kamu input salah";
//     }
// }

// int main()
// {

//     int angkaa;
//     char karakterr;
//     cout << "masukan angka : ";
//     cin >> angkaa;
//     cout << "masukan karakter : ";
//     cin >> karakterr;
//     convertTemperature(angkaa, karakterr);
//     return 0;
// }

// =============================================================================
float LuasPersegi(float s1, float s2, float s3)
{
    float t, luas;
    t = (s1 + s2 + s3) / 2;
    luas = sqrt(t * (t - s1) * (t - s2) * (t - s3));
    return luas;
}

int main()
{
    float a, b, c;

    cout << "masukkan s1: ";
    cin >> a;
    cout << "masukkan s2: ";
    cin >> b;
    cout << "masukkan s3: ";
    cin >> c;

    cout << "luas: " << LuasPersegi(a, b, c);
    return 0;
}
