#include <iostream>
using namespace std;

void inputPtr(int *ptr, int n)
{
    for (int i = 0; i < n; i++)
    {
        cout << "Input bilangan ke-" << i + 1 << " : ";
        cin >> *ptr;
        ptr++;
    }
}

int total(int *arr, int n, int &countGenap)
{
    int sumGenap = 0.0;
    for (int i = 0; i < n; i++)
    {
        if (*arr % 2 == 0)
        {
            sumGenap += *arr;
            countGenap++;
        }
        arr++;
    }
    return (sumGenap);
}

int main()
{
    // BESOK BESOK PAKE CPP.SH AJA LAH JIR
    int n, sum, avg, countGenap = 0;
    cout << "Berapa bilangan? : ";
    cin >> n;
    int dataJual[n];
    inputPtr(dataJual, n);
    sum = total(dataJual, n, countGenap);
    avg = sum / countGenap;
    cout << "Total bilangan Genap adalah : " << sum << "\n";
    cout << "Rata-rata bilangan Genap adalah : " << avg;
    return 0;
}