//Author: Gabrielius Gintalas
//Date: 08/30/23
//File Function: Runs the C++ output and calls the Assembly function
//Program name: Assignment 01 - Las Vegas


#include <cstdio>
#include <iostream>

using namespace std;

extern "C" double lasvegas();

int main(){
    cout << "Welcome to Trip Advisor by Gabrielius Gintalas." << endl;
    cout << "We help you plan your trip." << endl;  
    double traveltime = lasvegas();
    cout << "The main module received this number " << traveltime << " will keep it for a while." << endl;
    cout << "A zero will be sent to your operating system." << endl;
    cout << "Goodbye. Have a great trip." << endl;
    

    return 0;
}   