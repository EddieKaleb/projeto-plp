#include "deck.cpp"

int main() {

  buildDeck();

  for(int i = 0; i <= 3; i++) {
    for(int j = 0; j <= 12; j++) {
      cout << deck[i][j].value << " " << deck[i][j].naipe << " ";
    }
    cout << endl;
  }

  return 0;
}