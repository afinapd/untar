#include <iostream> // header input output streaming

using namespace std; // a kind of header

int main(){
    int n, fact;
    cout<<"masukan nilai faktorial = ";
    cin>>n;
    fact =1;
    for(int i =1;i<=n;i++){
        cout<<i<<" * ";
        fact = fact * i;
    }

    cout<<"\n"<<"hasil faktorial = "<<fact;
}