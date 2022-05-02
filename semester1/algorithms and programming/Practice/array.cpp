#include <iostream>
#include <math.h>
#include <array>
using namespace std;

// int main()
// {
//     int a[10];

//     for (int i = 0; i < 6; i++)
//     {
//         a[i] = i * i;
//         cout << a[i] <<endl;
//     }
//     for (int i = 6; i < 10; i++)
//     {
//         a[i] = a[i - 5];
//         cout << a[i]<<endl;
//     }
// }

void jumlah(int x)
{
    // int x;
    int jumlah = 0;
    float jumlahVariansi = 0;
    float avg, variansi, deviasi, var, jumlahVar;

    // cout << "mau input berapa angka ? : ";
    // cin >> x;
    int array[x];
    for (int i = 0; i < x; i++)
    {
        cout << "masukkan nilai ke " << i + 1 << ": ";
        cin >> array[i];
        jumlah += array[i];
        // cout << "jumlah seluruhnya: " << jumlah;
    }
    cout<<array[1]<<endl;
    avg = jumlah / x;
    for (int i = 0; i < x; i++)
    {
        var = pow(array[i] - avg, 2);
        jumlahVar += var;
    }
    variansi = jumlahVar / x;
    deviasi = sqrt(variansi);
    cout << "rata-rata: " << avg << endl;
    cout << "variansi: " << variansi << endl;
    cout << "deviasi: " << deviasi << endl;
}

int main()
{
    int x;
    cout << "mau input berapa angka ? : ";
    cin >> x;
    avgVariansiDeviasi(x);
}