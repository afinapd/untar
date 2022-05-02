#include <bits/stdc++.h>
using namespace std;
void count(char input[], int length)
{
    for (int i = 0; i < length; i++)
    {
        if (input[i] == 'a' || input[i] == 'i' || input[i] == 'u' || input[i] == 'e' || input[i] == 'o' || input[i] == 'A' || input[i] == 'I' || input[i] == 'U' || input[i] == 'E' || input[i] == 'O' || input[i] == '1' || input[i] == '2' || input[i] == '3' || input[i] == '4' || input[i] == '5' || input[i] == '6' || input[i] == '7' || input[i] == '8' || input[i] == '9' || input[i] == '0')
        {
            cout << "";
        }
        else
        {
            cout << input[i];
        }
    }
}
int main()
{
    char input[100];
    cout << "Masukan Sebuah Kalimat : ";
    cin.getline(input, sizeof(input));
    int length = strlen(input);
    count(input, length);
    return 0;
}