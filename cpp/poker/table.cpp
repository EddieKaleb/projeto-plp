#include "util.cpp"

struct player {
  card hand[2];
};

card cardsTable[5];




int verifyPair(card handPlayer[],card cTable[], int quantCards){
  card agroup[quantCards];
  agroupCards(handPlayer,cTable, agroup);
  quickSort(agroup,0,quantCards-1);

  int verify = 0;
  for(int i = 1; i < quantCards; i++) {
    if(agroup[i].value==agroup[i-1].value){
      verify = 1;
    }
  }
  return verify;
}

int verifyTrinca(card handPlayer[],card cTable[], int quantCards){
  card agroup[quantCards];
  agroupCards(handPlayer,cTable, agroup);
  quickSort(agroup,0,quantCards-1);

  int verify = 0;
  for(int i = 2; i < quantCards; i++) {
    if(agroup[i].value==agroup[i-1].value and agroup[i-2].value==agroup[i-1].value){
      verify = 1;
    }
  }
  return verify;
}


int main() {

  buildDeck();


  player play1;
  play1.hand[0].value = "J";
  play1.hand[1].value = "7";
  play1.hand[0].naipe = 'E';
  play1.hand[1].naipe = 'E';

  cardsTable[0].value = "J";
  cardsTable[0].naipe = 'E';
  cardsTable[1].value = "6";
  cardsTable[1].naipe = 'E';
  cardsTable[2].value = "5";
  cardsTable[2].naipe = 'E';
  cardsTable[3].value = "5";
  cardsTable[3].naipe = 'E';
  cardsTable[4].value = "5";
  cardsTable[4].naipe = 'E';

  cout << verifyTrinca(play1.hand,cardsTable,7) << endl;
  cout << verifyPair(play1.hand,cardsTable,7) << endl;


  return 0;
}