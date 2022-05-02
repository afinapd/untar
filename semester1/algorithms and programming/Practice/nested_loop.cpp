#include <iostream> // header input output streaming

using namespace std; // a kind of header

int main()
{
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
}