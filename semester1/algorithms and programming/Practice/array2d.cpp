#include <iostream>
using namespace std;

int main()
{
    int a[3][3];
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if (i < j)
            {
                a[i][j] = -1;
            }
            else
            {
                if (i == j)
                {
                    a[i][j] = 0;
                }
                else
                {
                    a[i][j] = 1;
                }
            cout << a[i][j] << "\n";
                
            }
        }
    }
}

// int main()
// {
//     double data[10][10];
//     int ukuran[8] = {2, 4, 6, 8, 10, 11, 14, 18};
//     double berat[8] = {0.167, 0.668, 1.502, 2.670, 4.303, 5.313, 7.650, 13.600};
//     double total = 0;

//     cout << "Jenis pipa || Panjang pipa || berat" << endl;
//     for (int i = 0; i < 5; i++)
//     {
//         cout << "input type of pipe size : ";
//         cin >> data[i][1];
//         cout << "input length : ";
//         cin >> data[i][2];
//     }

//     for (int i = 0; i < 5; i++)
//     {
//         for (int j = 0; j < 8; ++j)
//     {
//         if (data[i][1] == ukuran[j])
//         {
//             data[i][3] = data[i][2] * berat[j];
//             cout << ukuran[j] << " || ";
//             cout << data[i][2] << " || ";
//             cout << data[i][3] << " || ";
//             total += data[i][3];
//         }
//     }
//     }

//     cout << "total berat: " << total;
// }

// int main()
// {
//     double data[10][10];
//     int ukuran[8] = {2, 4, 6, 8, 10, 11, 14, 18};
//     double berat[8] = {0.167, 0.668, 1.502, 2.670, 4.303, 5.313, 7.650, 13.600};
//     double total = 0;

//     cout << "Jenis pipa || Panjang pipa || berat" << endl;
//     for (int i = 0; i < 5; i++)
//     {
//         cout << "input jenis pipa : ";
//         cin >> data[i][1];
//         cout << "panjang pipa : ";
//         cin >> data[i][2];

//         for (int j = 0; j < 8; ++j)
//         {
//             if (data[i][1] == ukuran[j])
//             {
//                 data[i][3] = data[i][2] * berat[j];
//             }
//         }
//     }
//     for (int i = 0; i < 5; i++)
//     {
//         for (int j = 0; j < 8; ++j)
//         {
//             if (data[i][1] == ukuran[j])
//             {
//                 data[i][3] = data[i][2] * berat[j];
//                 cout << ukuran[j] << " || ";
//                 cout << data[i][2] << " || ";
//                 cout << data[i][3] << endl;
//                 total += data[i][3];
//             }
//         }
//     }

//     cout << "total berat: " << total;
// }