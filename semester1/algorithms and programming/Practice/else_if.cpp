#include <iostream> // header input output streaming

using namespace std; // a kind of header

int main()
{ // body program
    int hp = 100;
    int pilihan1, pilihan2, pilihan3, pilihan4;

    cout << "apakah kamu ingin menjadi pokemon trainer \n";
    cout << "1. yes \n";
    cout << "2. no \n";
    cout << "masukan pilihan kamu (1/2): ";
    cin >> pilihan1;
    if (pilihan1 == 1)
    {
        cout << "hebat ! pilih pokeman starter kamu \n";
        cout << "1. squirtle \n";
        cout << "2. charmander \n";
        cout << "3. bulbasaur \n";
        cout << "masukan pilihan kamu (1/2/3): ";
        cin >> pilihan2;
        if (pilihan2 == 1)
        {
            cout << "kamu pilih squirtle";
            cout << "squirtle type apa \n";
            cout << "1. air \n";
            cout << "2. daun \n";
            cout << "3. batu \n";
            cout << "4. listrik \n";
            cout << "masukan pilihan kamu (1/2/3/4): ";
            cin >> pilihan3;
            if (pilihan3 == 1)
            {
                cout << "yap kamu benar";
            }
            else
            {
                cout << "ah bodoh \n";
                hp = hp - 20;
                cout << "HP kamu sekarang " << hp;
            }
        }
        else if (pilihan2 == 2)
        {
            cout << "kamu pilih charmander";
        }
        else if (pilihan2 == 3)
        {
            cout << "kamu pilih bulbasaur";
        }
    }
    else
    {
        cout << "yah kamu cupu \n";
        hp = hp - 20;
        cout << "HP kamu sekarang " << hp;
    }
}