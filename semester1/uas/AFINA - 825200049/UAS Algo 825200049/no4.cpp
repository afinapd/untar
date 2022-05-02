// ========================= NO 4 =========================
#include <cstddef>
#include <iostream>
#include <string>
#include <list>

using namespace std;

class Node
{
public:
    int curah;
    int suhuMax;
    int suhuLow;
    int suhuAvg;
    Node *next;
};

void print_list(Node *n)
{
    while (n != NULL)
    {
        cout << n->curah << " CURAH"
             << "\n";
        cout << n->suhuMax << " SUHU MAX"
             << "\n";
        cout << n->suhuLow << " SUHU LOW"
             << "\n";
        cout << n->suhuAvg << " SUHU AVG"
             << "\n";
        n = n->next;
    }
}

void countTotalandAverage(Node *n)
{
    int total = 0;
    int average = 0;
    while (n != NULL)
    {
        total = total + n->curah;
        n = n->next;
    }

    average = total / 12;

    cout << "Total Curah Hujan: " << total << endl;
    cout << "Rata Rata Curah Hujan: " << average << endl;
}

Node *listClimate()
{
    Node *januari = NULL;
    Node *februari = NULL;
    Node *maret = NULL;
    Node *april = NULL;
    Node *mei = NULL;
    Node *juni = NULL;
    Node *juli = NULL;
    Node *agustus = NULL;
    Node *september = NULL;
    Node *oktober = NULL;
    Node *november = NULL;
    Node *desember = NULL;

    januari = new Node();
    februari = new Node();
    maret = new Node();
    april = new Node();
    mei = new Node();
    juni = new Node();
    juli = new Node();
    agustus = new Node();
    september = new Node();
    oktober = new Node();
    november = new Node();
    desember = new Node();

    cout << "Januari" << endl;
    cout << "Masukkan Curah: ";
    cin >> januari->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> januari->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> januari->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> januari->suhuAvg;
    januari->next = februari;

    cout << "Februari" << endl;
    cout << "Masukkan Curah: ";
    cin >> februari->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> februari->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> februari->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> februari->suhuAvg;
    februari->next = maret;

    cout << "Maret" << endl;
    cout << "Masukkan Curah: ";
    cin >> maret->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> maret->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> maret->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> maret->suhuAvg;
    maret->next = april;

    cout << "April" << endl;
    cout << "Masukkan Curah: ";
    cin >> april->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> april->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> april->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> april->suhuAvg;
    april->next = mei;

    cout << "Mei" << endl;
    cout << "Masukkan Curah: ";
    cin >> mei->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> mei->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> mei->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> mei->suhuAvg;
    mei->next = juni;

    cout << "Juni" << endl;
    cout << "Masukkan Curah: ";
    cin >> juni->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> juni->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> juni->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> juni->suhuAvg;
    juni->next = juli;

    cout << "Juli" << endl;
    cout << "Masukkan Curah: ";
    cin >> juli->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> juli->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> juli->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> juli->suhuAvg;
    juli->next = agustus;

    cout << "Agustus" << endl;
    cout << "Masukkan Curah: ";
    cin >> agustus->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> agustus->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> agustus->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> agustus->suhuAvg;
    agustus->next = september;

    cout << "September" << endl;
    cout << "Masukkan Curah: ";
    cin >> september->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> september->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> september->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> september->suhuAvg;
    september->next = oktober;

    cout << "Oktober" << endl;
    cout << "Masukkan Curah: ";
    cin >> oktober->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> oktober->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> oktober->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> oktober->suhuAvg;
    oktober->next = november;

    cout << "November" << endl;
    cout << "Masukkan Curah: ";
    cin >> november->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> november->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> november->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> november->suhuAvg;
    november->next = desember;

    cout << "Desember" << endl;
    cout << "Masukkan Curah: ";
    cin >> desember->curah;
    cout << "Masukkan Suhu Maksimal: ";
    cin >> desember->suhuMax;
    cout << "Masukkan Suhu Low: ";
    cin >> desember->suhuLow;
    cout << "Masukkan suhu rata-rata: ";
    cin >> desember->suhuAvg;
    desember->next = NULL;

    return januari;
}

int main()
{
    Node *listSuhu = listClimate();
    cout << endl;
    countTotalandAverage(listSuhu);
    print_list(listSuhu);
}