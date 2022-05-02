#include <iostream> // header input output streaming

using namespace std; // a kind of header

int main()
{
    // int bil;
    // cout << "masukan angka sembarang bulat : ";
    // cin >> bil;
    // if (bil % 2 == 1)
    // {
    //     cout << "bilangan " << bil << " tidak habis dibagi 2 \n";
    //     cout << "jadi termasuk bilangan ganjil";
    // }
    // else
    // {
    //     cout << "bilangan " << bil << " habid dibagi 2 \n";
    //     cout << "jadi termasuk bilangan genap";
    // }

    // int nilai;
    // cout << "masukan nilai yang didapat : ";
    // cin >> nilai;
    // if (nilai >= 80)
    // {
    //     cout << "Index = A \n";
    // }
    // else if (nilai >= 68 && nilai < 80)
    // {
    //     cout << "Index = B \n";
    // }
    // else if (nilai >= 56 && nilai < 68)
    // {
    //     cout << "Index = C \n";
    // }
    // else if (nilai >= 45 && nilai < 56)
    // {
    //     cout << "Index = D \n";
    // }
    // else if (nilai < 45)
    // {
    //     cout << "Index = E \n";
    // }

    char tanda;
    cout << "masukan tanda : ";
    cin >> tanda;
    switch (tanda)
    {
    case '-':
        cout << "kurang";
        break;
    case '+':
        cout << "tambah";
        break;
    case '/':
        cout << "bagi";
        break;
    case '*':
        cout << "kali";
        break;
    }
}