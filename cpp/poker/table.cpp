#include "hands.cpp"

struct player {
  card hand[2];
  int fichas;
};

card cardsTable[5];

int main() {

  buildDeck();
  shuffleDeck();

  return 0;
}