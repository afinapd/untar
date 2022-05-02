#include <iostream>
#include <math.h> 
using namespace std;

float hitungKekuatanAngin(float angin, float suhu) {
    return 35.74 + 0.6215 * suhu - 35.75 * angin + 0.425 * suhu * angin;
}

float getAngin() {
    float angin;

    cout << "Masukan kecepatan angin: ";
    cin >> angin;

    return pow(angin, 0.16);
}

float getSuhu() {
    float suhu;

    cout << "Masukan suhu: ";
    cin >> suhu;

    return suhu;
}

int main() {
    float angin = getAngin();
    float suhu = getSuhu();

    cout << "Hasil : " << hitungKekuatanAngin(angin, suhu);
    return 0;
}