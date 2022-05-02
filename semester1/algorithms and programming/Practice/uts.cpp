#include <iostream> // header input output streaming

using namespace std; // a kind of header

// void GajiKotor(){

// }

int main()
{
    string nama[200];
    int gaji, penggajian, hari, gajiHarian, uangTransport, gajiPokok, hasilPenjualan, nilaiTransaksi, gajiBersih, pajak;
    int i = 0;
    int pegawai[200];

    for(int i =0; i<pegawai; i++){
        cout << "input nama : ";
        cin >> nama;
        cout << "input jenis penggajian : ";
        cin >> penggajian;
        switch (penggajian)
        {
        case '1':
            cout << "input hari masuk : ";
            cin >> hari;
            cout << "input gaji harian : ";
            cin >> gajiHarian;
            gaji = hari * gajiHarian;
            break;
        case '2':
            cout << "input gaji pokok : ";
            cin >> gajiPokok;
            cout << "input hari masuk : ";
            cin >> hari;
            cout << "input uang transport : ";
            cin >> uangTransport;
            gaji = gajiPokok + hari * uangTransport;
            break;
        case '3':
            cout << "input gaji pokok : ";
            cin >> gajiPokok;
            cout << "input hasil penjualan : ";
            cin >> hasilPenjualan;
            gaji = gajiPokok + (5 / 100 * hasilPenjualan);
            break;
        case '4':
            cout << "input gaji pokok : ";
            cin >> gajiPokok;
            cout << "input hasil penjualan : ";
            cin >> nilaiTransaksi;
            gaji = gajiPokok + (10 / 100 * nilaiTransaksi);
            break;
        }
    }

    {

        if (gaji <= 1500000)
        {
            pajak = 0;
            gajiBersih = gaji - pajak;
            cout << gajiBersih;
        }
        else if (gaji > 1500000 && gaji <= 10000000)
        {
            pajak = 5 / 100 * gaji;
            gajiBersih = gaji - pajak;
            cout << gajiBersih;
        }
        else if (gaji > 10000000 && gaji <= 25000000)
        {
            pajak = 10 / 100 * gaji;
            gajiBersih = gaji - pajak;
            cout << gajiBersih;
        }
        else
        {
            pajak = 15 / 100 * gaji;
            gajiBersih = gaji - pajak;
            cout << gajiBersih;
        }

        cout << "nama : " << nama;
        cout << "gaji kotor : " << gaji;
        cout << "pajak : " << gaji;
        cout << "gaji bersih : " << gajiBersih;
    }
}