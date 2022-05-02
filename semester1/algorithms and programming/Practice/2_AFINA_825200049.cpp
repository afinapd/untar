#include <iostream>
#include <vector>

using namespace std;

// CRUD DATA MAHASISWA

int main()
{
    int selection = 0;
    int input, id, nilaiAngka, countStudents;
    float pass, fail, percentagePass, percentageFail;
    string name, resultInput, nilaiHuruf, status;

    // it's like arraylist. all data is temporarily stored here
    vector<string> dataArray;
    vector<string> statusArray;

    cout << "==============================================\n";
    cout << "\t Program CRUD Data Nilai Mahasiswa \n";
    cout << "==============================================\n";

    do
    {
        // this menu will not stop looping until input number 6
        cout << "\n";
        cout << "1. Input Data Nilai Mahasiswa \n";
        cout << "2. Data Nilai Mahasiswa \n";
        cout << "3. Update Data Nilai Mahasiswa \n";
        cout << "4. Delete Data Nilai Mahasiswa \n";
        cout << "5. Persentase Kelulusan Mahasiswa \n";
        cout << "6. Keluar \n";
        cout << "input angka = ";
        cin >> selection;

        switch (selection)
        {
        case 1:
            cout << "\n";
            cout << "==================== MENU 1 ====================\n";
            cout << "Masukan jumlah mahasiswa : ";
            cin >> input;

            // looping until the number of students
            for (int i = 0; i < input; i++)
            {
                cout << "\n";
                cout << "Nama Mahasiswa : ";
                cin >> name;
                cout << "Nilai UAS (0 - 100): ";
                cin >> nilaiAngka;

                // condition for convert uas value
                if (nilaiAngka <= 20)
                {
                    nilaiHuruf = "E";
                }
                else if (nilaiAngka <= 40)
                {
                    nilaiHuruf = "D";
                }
                else if (nilaiAngka <= 60)
                {
                    nilaiHuruf = "C";
                }
                else if (nilaiAngka <= 80)
                {
                    nilaiHuruf = "B";
                }
                else if (nilaiAngka <= 100)
                {
                    nilaiHuruf = "A";
                }
                else
                {
                    nilaiHuruf = "Tidak terdefinisikan";
                }

                // conditions for determining pass / fail
                if (nilaiHuruf == "A" || nilaiHuruf == "B" || nilaiHuruf == "C")
                {
                    status = "Lulus";
                }
                else
                {
                    status = "Tidak Lulus";
                }
                resultInput = name + "      " + nilaiHuruf + "      " + status;

                // status vector is made separately to determine the percentage
                statusArray.push_back(status);
                dataArray.push_back(resultInput);
            };
            break;

        case 2:
            cout << "\n";
            cout << "==================== MENU 2 ====================\n";
            cout << "Data Mahasiswa \n";
            cout << "id      Nama      Nilai      status \n";

            // looping for display data
            for (int i = 0; i < dataArray.size(); i++)
            {
                cout << i << ".      " << dataArray[i] << endl;
            }
            break;

        case 3:
            cout << "\n";
            cout << "==================== MENU 3 ====================\n";
            cout << "Masukan No. Id Mahasiswa : ";
            cin >> id;

            // This logic case is almost like create data, however the data is not pushed to the vector
            for (int i = 0; i < dataArray.size(); i++)
            {
                if (i == id)
                {
                    cout << "\n";
                    cout << "Nama Mahasiswa Terbaru : ";
                    cin >> name;
                    cout << "Nilai UAS Terbaru(0 - 100): ";
                    cin >> nilaiAngka;

                    if (nilaiAngka <= 20)
                    {
                        nilaiHuruf = "E";
                    }
                    else if (nilaiAngka <= 40)
                    {
                        nilaiHuruf = "D";
                    }
                    else if (nilaiAngka <= 60)
                    {
                        nilaiHuruf = "C";
                    }
                    else if (nilaiAngka <= 80)
                    {
                        nilaiHuruf = "B";
                    }
                    else if (nilaiAngka <= 100)
                    {
                        nilaiHuruf = "A";
                    }
                    else
                    {
                        nilaiHuruf = "Tidak terdefinisikan";
                    }

                    if (nilaiHuruf == "A" || nilaiHuruf == "B" || nilaiHuruf == "C")
                    {
                        status = "Lulus";
                    }
                    else
                    {
                        status = "Tidak Lulus";
                    }
                    resultInput = name + "      " + nilaiHuruf + "      " + status;
                    statusArray[id] = status;
                    dataArray[id] = resultInput;
                    cout << "Data mahasiswa berhasil diedit";
                    cout << "\n";
                }
                else
                {
                    // null
                }
            }
            break;

        case 4:
            cout << "\n";
            cout << "==================== MENU 4 ====================\n";
            cout << "Masukan No. Id Mahasiswa : ";
            cin >> id;

            // looping to find data
            for (int i = 0; i < dataArray.size(); i++)
            {
                // and give condition if the data is found then the data will be deleted
                if (i == id)
                {
                    dataArray.erase(dataArray.begin() + i);
                    statusArray.erase(statusArray.begin() + i);
                    cout << "Data mahasiswa berhasil dihapus";
                    cout << "\n";
                }
                else
                {
                    // null
                }
            }
            break;

        case 5:
            cout << "\n";
            cout << "==================== MENU 5 ====================\n";
            pass = 0;
            fail = 0;

            // looping status for grouping (fail / pass)
            for (int i = 0; i < statusArray.size(); i++)
            {
                if (statusArray[i] == "Lulus")
                {
                    pass += 1;
                }
                else if (statusArray[i] == "Tidak Lulus")
                {
                    fail += 1;
                }
            }

            // logic to find a percentage
            percentagePass = (pass / dataArray.size()) * 100;
            percentageFail = (fail / dataArray.size()) * 100;
            countStudents = dataArray.size();
            cout << "Total mahasiswa : " << countStudents << "\n";
            cout << "Persentase Mahasiswa Lulus : " << percentagePass << "% \n";
            cout << "Persentase Mahasiswa Tidak Lulus : " << percentageFail << "% \n";
            break;
        default:
            return 0;
        }
    } while (selection != 6);
    // return 0;
}

// end