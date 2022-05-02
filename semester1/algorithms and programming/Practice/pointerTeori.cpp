#include <iostream>
using namespace std;

int main()
{
    int x, y, z, *ptr;
    x = 25;
    y = 50;
    z = 75;

    ptr = &x;
    cout << "ptr : " << ptr << "\n";
    cout << "* : " << *ptr << "\n";
    *ptr += 10;
    cout << "ptr : " << ptr << "\n";
    cout << "* : " << *ptr << "\n";
    ptr = &y;
    cout << "ptr : " << ptr << "\n";
    cout << "* : " << *ptr << "\n";
    *ptr += 5;
    cout << "ptr : " << ptr << "\n";
    cout << "* : " << *ptr << "\n";
    ptr = &y;
    cout << "ptr : " << ptr << "\n";
    cout << "* : " << *ptr << "\n";
    *ptr += 2;
    cout << "ptr : " << x << "\n";
    cout << "* : " << y << "\n";
    cout << "* : " << z << "\n";
}