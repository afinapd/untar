#include <iostream>
#include <math.h>
using namespace std;

void BilanganGanjil(int firstNum, int secondNum)
{
    while (firstNum <= secondNum)
    {
        if (firstNum % 2 != 0)
        {
            cout << firstNum << " ";
        }
        firstNum++;
    }
}

void JumlahBilanganGenap(int firstNum, int secondNum)
{
    int jumlahBilanganGenap = 0;
    while (firstNum <= secondNum)
    {
        if (firstNum % 2 == 0)
        {
            cout << firstNum << " + ";
            jumlahBilanganGenap += firstNum;
        }
        firstNum++;
    }
    cout << "\n";
    cout << " = " << jumlahBilanganGenap;
}

void Kuadrat(int firstNum, int secondNum)
{
    while (firstNum <= secondNum)
    {
        cout << pow(firstNum, 2) << " ";
        firstNum++;
    }
}

int main()
{
    int firstNum, secondNum, bil;
    cout << "firstNum : ";
    cin >> firstNum;
    cout << "secondNum : ";
    cin >> secondNum;

    cout << "Bilangan Ganjil : ";
    BilanganGanjil(firstNum, secondNum);

    cout << "\n";

    cout << "Jumlah Bilangan Genap : ";
    JumlahBilanganGenap(firstNum, secondNum);

    cout << "\n";

    cout << "Kuadrat: ";
    Kuadrat(firstNum, secondNum);
}