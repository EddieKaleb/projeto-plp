#include <iostream>
#include <string>

using namespace std;
void buildDeck();
void shuffleDeck();
// A 1 2 3 4 5 6 7 8 9 10 J Q K A
struct card {
  string value;
  char naipe;
};

char cards[] = {'A','K','Q','J','T','9','8','7','6','5','4','3','2'};
char naipes[] = {'E','C','P','O'};

card deck[52];
int contCard = 51;

void buildDeck() {
  int k = 0;
  for(int i = 0; i <= 3; i++) {
    for(int j = 0; j <= 12; j++) {
      deck[k].value = cards[j];
      deck[k].naipe = naipes[i];
      k++;
    }
  }
}

void shuffleDeck(){
  int j;
  srand(time(NULL));
  for (int i = 51; i != 0; i--) {
    j = rand() % ( i + 1 );
    swap(deck[i],deck[j]);
  }
}

card getCard(){
  return deck[contCard--];
}

void restartDeck(){
  contCard = 51;
}