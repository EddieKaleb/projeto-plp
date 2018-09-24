#include <iostream>
#include <fstream>

using namespace std;

int main() {
    ifstream ip("../data/hands.csv");

    if (!ip.is_open())
        cout << "ERROR: file open" << '\n';

    string cards;
    string players;

    while (ip.good()) {
        getline(ip, cards,',');
        getline(ip, players,'\n');
        cout << "Card: " << cards << " " << players << endl;
    }
    return 0;
}
