#include <iostream>
#include <vector>

using namespace std;

int main() {
    int n;
    std::cout << "Input angka : " ;
    cin >> n;

    int total = 0;
    for (int i = 0; i < to_string(n).size(); ++i) {
        string number = "1";
        for (int j = 0; j < i; ++j) {
            number += "0";
        }
        int current_number = n / (1 * stoi(number)) % 10;
        total += current_number;
        cout << current_number << " ";
    }
    
    cout <<"n"<< "total : "<<total << endl;
    return 0;
}