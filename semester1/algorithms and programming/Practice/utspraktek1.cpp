#include <iostream>

using namespace std;

int main()
{
    string namaCaleg[3], pemenang;
    float jumlahSuara[3], persentase[3], totalSuara;
    int jumlahSuaraPemenang = 0;

    for (int i = 0; i < 3; i++)
    {
        cout << "Masukkan Nama Caleg: ";
        cin >> namaCaleg[i];
        cout << "Masukkan Jumlah Suara: ";
        cin >> jumlahSuara[i];
        totalSuara += jumlahSuara[i];
    }

    for (int i = 0; i < 3; i++)
    {
        persentase[i] = (jumlahSuara[i] / totalSuara) * 100;
        if (jumlahSuaraPemenang < jumlahSuara[i])
        {
            jumlahSuaraPemenang = jumlahSuara[i];
        }
    }

    cout << "Kandidat    Jumlah Suara    Persentase\n";

    for (int i = 0; i < 3; i++)
    {
        cout << namaCaleg[i] << "    " << jumlahSuara[i] << "    " << persentase[i] << "%\n";
        if (jumlahSuara[i] == jumlahSuaraPemenang)
        {
            pemenang = namaCaleg[i];
        }
    }

    cout << "Pemenang : " << pemenang;

    return 0;
}