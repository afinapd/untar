#include <iostream>
using namespace std;

/*
int main()
{
    cout << "=============== NOMOR 2 =============== \n";
    int matrix[3][3];
    for (int m = 0; m < 3; m++)
    {
        for (int n = 0; n < 3; n++)
        {
            cout << "input number : ";
            cin >> matrix[m][n];
        }
    }
    cout << "\n";
    cout << "matrix of the numbers you entered" << "\n";
    for (int m = 0; m < 3; m++)
    {
        for (int n = 0; n < 3; n++)
        {
            cout << matrix[m][n] << "\t";
        }
        cout << endl;
    }
    cout << "\n";
    cout << "transpose of above matrix" << "\n";
    for (int n = 0; n < 3; n++)
    {
        for (int m = 0; m < 3; m++)
        {
            cout << matrix[m][n] << "\t";
        }
        cout << endl;
    }
}
*/

/*
int main()
{
    cout << "=============== NOMOR 8 =============== \n";
    double varName[10][3];
    double sum = 0;

    for (int i = 0; i < 5; i++)
    {
        cout << "input type of pipe size : ";
        cin >> varName[i][1];
        cout << "input length : ";
        cin >> varName[i][2];

        if (varName[i][1] == 2)
        {
            varName[i][3] = varName[i][2] * 0.167;
        }
        else if (varName[i][1] == 4)
        {
            varName[i][3] = varName[i][2] * 0.668;
        }
        else if (varName[i][1] == 6)
        {
            varName[i][3] = varName[i][2] * 1.502;
        }
        else if (varName[i][1] == 8)
        {
            varName[i][3] = varName[i][2] * 2.670;
        }
        else if (varName[i][1] == 10)
        {
            varName[i][3] = varName[i][2] * 4.303;
        }
        else if (varName[i][1] == 11)
        {
            varName[i][3] = varName[i][2] * 5.313;
        }
        else if (varName[i][1] == 14)
        {
            varName[i][3] = varName[i][2] * 7.650;
        }
        else if (varName[i][1] == 18)
        {
            varName[i][3] = varName[i][2] * 13.600;
        }
        else
        {
            cout << "[ERR] you entered the wrong type";
            return 0;
        }

        sum += varName[i][3];
    }
    cout << "type       length(ft)       weight(lb/ft)" << endl;
    for (int i = 0; i < 5; i++)
    {
        cout << varName[i][1] << "            ";
        cout << varName[i][2] << "            ";
        cout << varName[i][3] << " \n";
    }
    cout << "total : " << sum;
}
*/