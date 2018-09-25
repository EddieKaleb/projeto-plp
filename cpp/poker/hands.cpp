#include "util.cpp"


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