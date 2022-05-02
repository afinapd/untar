#include <iostream>
#include <math.h>
#include <array>

using namespace std;

int getJumlahFromArray(int x) {
    float jumlah = 0;
    int array[x];

    for (int i = 0; i < x; i++) {
        cout << "masukkan nilai ke " << i + 1 << ": ";
        cin >> array[i];
        jumlah += array[i];
    }

    return jumlah;
}

int getJumlahVar(int x, float avg) {
    float jumlahVar;
    int array[x];

    cout<<array[2]<<endl;

    for (int i = 0; i < x; i++) {
        jumlahVar += pow(array[i] - avg, 2);
    }

    return jumlahVar;
}

float showAndGetRataRata(int jumlah, int x) {
    float avg = jumlah / x;
    cout << "rata-rata: " << avg << endl;
    return avg;
}

void showVariansiAndDeviasi(int variansi, int deviasi){
    cout << "variansi: " << variansi << endl;
    cout << "deviasi: " << deviasi << endl;
}

void avgVariansiDeviasi(int x) {
    float jumlah = getJumlahFromArray(x);

    float avg = showAndGetRataRata(jumlah, x);

    float variansi = getJumlahVar(x, avg) / 10;
    float deviasi = sqrt(variansi);

    showVariansiAndDeviasi(variansi, deviasi);
}

int main() {
    int x;
    cout << "mau input berapa angka ? : ";
    cin >> x;

    avgVariansiDeviasi(x);
    return 0;
}
