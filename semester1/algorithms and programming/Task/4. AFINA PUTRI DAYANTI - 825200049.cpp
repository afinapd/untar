#include <iostream> // header input output streaming

using namespace std; // a kind of header

void no1()
{
    cout << "=============== NOMOR 1 =============== \n";

    int gaji;
    cout << "input gaji karyawan : ";
    cin >> gaji;

    if (100 <= gaji && gaji <= 500)
    {
        cout << "anda golongan E";
    }
    else if (501 <= gaji && gaji <= 1000)
    {
        cout << "anda golongan D";
    }
    else if (1001 <= gaji && gaji <= 3000)
    {
        cout << "anda golongan C";
    }
    else if (3001 <= gaji && gaji <= 5000)
    {
        cout << "anda golongan B";
    }
    else if (5001 <= gaji && gaji <= 10000)
    {
        cout << "anda golongan A";
    }
    cout << endl
         << endl;
}

void no2()
{
    cout << "=============== NOMOR 2 =============== \n";
    int bil, value, sum, avg;
    sum = 0;
    cout << "berapa bilangan? ";
    cin >> bil;
    for (int i = 1; i <= bil; i++)
    {
        cout << "masukan bilangan ke" << i << " : ";
        cin >> value;
        sum += value;
    }
    avg = sum / bil;
    cout << "jumlah bilangan : " << sum << "\n";
    cout << "rata-rata bilangan : " << avg;
    cout << endl
         << endl;
}

void no3()
{
    cout << "=============== NOMOR 3 =============== \n";
    int bil, tampung1, tampung2, hasil;
    cout << "input : ";
    cin >> bil;
    tampung1 = 1;
    tampung2 = 0;
    hasil = 0;
    for (int i = 1; i <= bil; i++)
    {
        if (i == 2)
        {
            cout << tampung1 << ", ";
            continue;
        }
        hasil = tampung1 + tampung2;
        tampung2 = tampung1;
        tampung1 = hasil;
        cout << hasil << ", ";
    }
    cout << endl
         << endl;
}

void no4()
{
    cout << "=============== NOMOR 4 =============== \n";
    int input;
    cout << "input : ";
    cin >> input;

    for (int i = input; i > 0; i--)
    {
        for (int j = i; j <= input; j++)
        {
            cout << " ";
        }
        for (int j = 0; j < i; j++)
        {
            cout << "*";
        }
        cout << "\n";
    }
    cout << endl;
}

void no5()
{
    cout << "=============== NOMOR 5 =============== \n";
    int input, check;
    cout << "input : ";
    cin >> input;
    check = 0;
    bool bilPrima = true;
    for (int i = 2; i < input; i++)
    {
        if (input % i == 0)
        {
            bilPrima = false;
            break;
        }
    }
    if (bilPrima == true)
    {
        cout << "bilangan prima";
    }
    else
    {
        cout << "bukan bilangan prima";
    }
    cout << endl
         << endl;
}

int main()
{
    no1();
    no2();
    no3();
    no4();
    no5();
}