// ========================= NO 2 =========================
#include <iostream>
using namespace std;

int function(int num)
{
    if (num <= 0)
    {
        return 0;
    }
    else
    {
        return function(num - 1) + 2;
    }
}
int main()
{
    int num;
    cout << "enter numbers : ";
    cin >> num;
    int res = function(num);
    cout << "result : " << res;
}