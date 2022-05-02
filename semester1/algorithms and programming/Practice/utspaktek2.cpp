#include <iostream>
#include <math.h> 
using namespace std;

void FaktorKekuatanAngin(float V, float T, float &W){
    float Vpangkat;

    Vpangkat = pow(V, 0.16);
    W = 35.74 + 0.6215 * T - 35.75 * Vpangkat + 0.425 * T * Vpangkat;
}

float InputanUser(){
    float V, T, W;

    cout<<"Input kecepatan angin : ";
    cin>>V;
    cout<<"Input suhu : ";
    cin>>T;

    FaktorKekuatanAngin(V, T, W);
    return W;
    
}

int main()
{
    float hasil;
    
    hasil = InputanUser();
    cout<<"Hasil : " << hasil;
}