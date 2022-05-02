#include <iostream> // header input output streaming

using namespace std; // a kind of header

int main()
{ // body program
    string angka;
    cout << "1. satu" << endl;
    cout << "2. dua" << endl;
    cout << "3. tiga" << endl;
    cout << "4. empat" << endl;
    cout << "5. lima" << endl;
    cout << "masukan angka = ";
    cin >> angka;

    switch (str2int(angka))
    {
    case str2int("satu"):
        cout << "kamu pilih angka 1";
        break;
    case str2int("2"):
        cout << "kamu pilih angka 2";
        break;
    default:
        cout << "idk";
        break;
    }

    // cout<<"hello world";
    // int panjang, lebar, luas, keliling;

    // cout<<"input panjang = ";
    // cin>>panjang;
    // cout<<"input lebar = ";
    // cin>>lebar;

    // luas = panjang * lebar;
    // keliling = 2 * (panjang + lebar);
    // cout<<"luasnya = "<<luas<<endl;
    // cout<<"kelilingnya = "<<keliling<<endl;

    // if(luas == 200){
    //     cout<<"ini duaratus";
    // } else if (luas > 200){
    //     cout<<"ini bukan dua ratus";
    // } else {
    //     cout<<"idk";
    // }

    /*
    int panjang, lebar, luas, keliling;
    cout<<"masukan panjang = ";
    cin>>panjang;
    cout<<"masukan lebar = ";
    cin>>lebar;
    luas = panjang * lebar;
    keliling = luas + 2;
    cout<<"hasil = "<<luas;
    cout<<"hasil = "<<keliling;
    */

    /*
    double f,c;
    cout<<"masukan celcius = ";
    cin>>c;
    f = (9.0/5.0*c)+32;
    // f1 = (9/5*c)+32;
    cout<<f<<endl;
    */

    /*
    int panjang, lebar, luas;
    cout<<"masukan panjang = ";
    cin>>panjang;
    cout<<"masukan lebar = ";
    cin>>lebar;
    luas = panjang * lebar;
    cout<<"hasil = "<<luas;
    */

    /*
    double hbagi, a1, a2;
    cout<<"masukan angka1 = ";
    cin>>a1;
    cout<<"masukan angka2 = ";
    cin>>a2;
    hbagi = a1 / a2;
    cout<<"hasil = "<<luas;
    */

    /*
    int nimgw;
    char namagw[10];
    cout<<"Hello, NIM kamu berapa?";    // write
    cin>>nimgw;                         // input
    cout<<"Hai, NIM aku"<<nimgw<<endl;  // write

    cout<<"Nama kamu siapa?";           // write
    cin.ignore();
    // cin.getline(namagw,sizeof(namagw));
    cin.getline(namagw,10);             // untuk pakai spasi
    cout<<namagw<<" nama yg bagus"; 
    */
}