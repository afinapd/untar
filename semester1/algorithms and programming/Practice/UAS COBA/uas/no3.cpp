// ========================= NO 3 =========================
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <string.h>
using namespace std;

int readRecurr(int number, int multiplier, int index)
{
    int newNum = number + multiplier;
    cout << newNum << " ";
    if (index <= 2)
    {
        readRecurr(newNum, multiplier, index + 1);
    }
    return 0;
}

int openFile()
{
    int container[6] = {};
    fstream newfile;
    newfile.open("input.txt", ios::in);
    if (newfile.is_open())
    {
        string line;
        int i = 0;
        while (getline(newfile, line))
        {
            if (i > 0)
            {
                cout << line << " ";
            }
            container[i] = stoi(line);
            i++;
        }
        newfile.close();
    }
    readRecurr(container[5], 12, 1);
    return 0;
}

int main()
{
    openFile();
    return 0;
}