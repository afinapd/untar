#include <iostream>
#include <math.h>
#include <array>

#include <string.h>
using namespace std;

// int main()
// {
//     char huruf[20];
//     char pindah[20];
//     cout << "Masukkan Sembarang Kota = ";
//     cin>>huruf;
//     /* Proses */
//     strcpy(pindah, huruf);
//     cout << "Pemindahannya = " << pindah;
// }

// void Duplicate(char s[], int n)
// {
//     char str[] = "";
//     int i = 0;
//     while (i < n)
//     {
//         strcat(str, s);
//         i++;
//     }
//     cout<<str;
// }

int main()
{
    string S[]={""};
    int N;
    string str[]={""};
    int i = 0;

    cout << "input string : ";
    cin >> S;
    cout << "mau diduplicate berapa kali? : ";
    cin >> N;
    while (i <N)
    {
        strcat(str, S);
        i++;
    }
    cout << str;
    // Duplicate(S, N);
}

// void Reverse(string& str)
// {
//     int n = str.length();
//     for (int i = 0; i < n / 2; i++)
//         swap(str[i], str[n - i - 1]);
// }

// int main()
// {
//     string str;
//     cout<<"input string : ";
//     cin>>str;
//     Reverse(str);
//     cout << str;
// }

// void Reverse(string &str)
// {
//     reverse(str.begin(), str.end());
// }

// int main()
// {
//     string str;
//     cout << "input string : ";
//     cin >> str;
//     Reverse(str);
//     cout << str;
// }