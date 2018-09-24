#include <iostream>
#include <string>

using namespace std;

// A 1 2 3 4 5 6 7 8 9 10 J Q K A

struct card {
  string value;
  char naipe;
};

string cards[] = {"A","K","Q","J","10","9","8","7","6","5","4","3","2"};
char naipes[] = {'E','C','P','O'};

int main() {

  card deck[4][13];

  for(int i = 0; i <= 3; i++) {
    for(int j = 0; j <= 12; j++) {
      deck[i][j].value = cards[j];
      deck[i][j].naipe = naipes[i];
    }
  }

  for(int i = 0; i <= 3; i++) {
    for(int j = 0; j <= 12; j++) {
      cout << deck[i][j].value << " " << deck[i][j].naipe << " ";
    }
    cout << endl;
  }

  return 0;
};

