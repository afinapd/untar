#include <iostream> // header input output streaming

using namespace std; // a kind of header

int main()
{
    int var, in1, in2;
    var = 0;
    for (in1 = 1; in1 < 5; in1++)
    {
        for (in2 = 3; in2 <= 6; in2++)
        {
            var = var + 1;
            // cout << var<<endl;
        }
        cout << var<<endl;
    }

    // int week, input, sum, avg;
    // week = 7;
    // sum = 0;
    // avg = 0;
    // for (int i = 0; i < week; i++)
    // {
    //     cout << "input penjualan : ";
    //     cin >> input;
    //     sum += input;
    // }
    // avg = sum / week;
    // cout << sum << "\n";
    // cout << avg;

    // double n, count, total, rata, pembagi;
    // int nilai;
    // cout << "brp mau looping : ";
    // cin >> n;
    // count = 1;
    // total = 0;
    // pembagi = 0;
    // while (count <= n)
    // {
    //     cout << "masukan nilai : ";
    //     cin >> nilai;
    //     if (nilai % 2 == 0)
    //     {
    //         total = total + nilai;
    //         pembagi = pembagi + 1;
    //     }
    //     count = count + 1;
    // }
    // rata = total / pembagi;
    // cout << "total : " <<total << "\n";
    // cout << "rata rata : "<<rata << "\n";

    // int bil, count, sum, avg, looping;
    // cout << "masukan bilangan : ";
    // cin >> bil;
    // count = 0;
    // looping = 1;
    // sum = 0;

    // for (int t = 0; t < 10; t++)
    // {
    //     int random_x;
    //     random_x = 1 + rand() % 100;
    //     cout << "\nRandom X = " << random_x;
    // }

    // int random, bil;
    // random = 1 + rand() % 100;
    // cout << random << "\n";
    // for (int i = 0; i < 10; i++)
    // {
    //     cout <<"\n" <<"masukan bilangan : ";
    //     cin >> bil;
    //     if (bil < x)
    //     {
    //         cout << "Tebakan anda terlalu kecil. Coba lagi";
    //     }
    //     else if (bil > x)
    //     {
    //         cout << "Tebakan anda terlalu besar. Coba lagi";
    //     }
    //     else
    //     {
    //         cout << "Selamat, tebakan anda benar";
    //     }
    // }

    // while(looping<=bil){
    //     if(looping % 2 ==0){
    //         count+=1;
    //         cout<<looping<<endl;
    //         sum+=looping;
    //     }
    // }

    // soal sub 3.2 no 3
    // if (bil % 2 == 0)
    // {
    //     for (int i = 1; i <= bil; i++)
    //     {
    //         if (i % 2 == 0)
    //         {
    //             count += 1;
    //             cout << i;
    //             sum += i;
    //         }
    //     }
    // }
    // else
    // {
    //     return 0;
    // }

    // avg = sum / count;
    // cout << count << endl;
    // cout << sum << endl;
    // cout << avg;

    //  int a, b, c, sum;
    // a = 5;
    // for(int i=0; i<a; i++){
    //     sum=pow(i,2);
    //     cout<<sum<<"\n";
    // }

    // int baju, celana, topi, diskon, harga, jumlah, harga_setelah_diskon;
    // int harga_baju = 30000;
    // int harga_celana = 45000;
    // int harga_topi = 15000;

    // cout<<"input baju : ";
    // cin>>baju;
    // cout<<"input celana : ";
    // cin>>celana;
    // cout<<"input topi : ";
    // cin>>topi;
    // jumlah = baju+celana+topi;
    // harga = (harga_baju*baju) + (harga_celana*celana)+(harga_topi*topi);
    // if(jumlah<10) {
    //     diskon = harga*10/100;
    // } else if (jumlah<=20) {
    //     diskon = harga*20 / 100;
    // } else {
    //     diskon =harga* 30 / 100;
    // }

    // harga_setelah_diskon = harga - diskon;
    // cout<<"jumlah ="<<jumlah;
    // cout<<"diskon ="<<diskon;
    // cout<<"total ="<<harga_setelah_diskon;
    // return 0;
}