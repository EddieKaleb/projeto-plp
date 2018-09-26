#include "util.cpp"

typedef struct {
  string flag;
  card agroupCards[7];
  int quant;
} handStatus;


handStatus verifyHand(card handPlayer[],card cTable[], int quantCards){
  card agroup[quantCards];
  agroupCards(handPlayer,cTable, agroup);
  quickSort(agroup,0,quantCards-1);
  if(quantCards == 0){
    //carta alta
  }
}

handStatus verifyPair(card agroup[], int quantCards){
  string flag = NULL;
  for(int i = 1; i < quantCards; i++) {
    if(agroup[i].value==agroup[i-1].value){
      flag = "IS_ONE_PAIR";
    }
  }
  handStatus status;
  status.flag = flag;
  status.quant = quantCards;
  copyArrayCards(agroup, status.agroupCards, quantCards);
  return status;
}

handStatus verifyThree(card agroup[], int quantCards){
  string flag = NULL;
  for(int i = 2; i < quantCards; i++) {
    if(agroup[i].value==agroup[i-1].value and agroup[i-2].value==agroup[i-1].value){
      string flag = "IS_THREE";
    }
  }
  handStatus status;
  status.flag = flag;
  status.quant = quantCards;
  copyArrayCards(agroup, status.agroupCards, quantCards);
  return status;
}

handStatus verifyStraight(card agroup[], int quantCards){
  string flag = NULL;
  int cont = 0;
  for(int i = 1; i < quantCards; i++) {
    if(agroup[i-1].value == agroup[i].value-1){
      cont++;
    }else if(cont<5) {
      cont = 0;
    }
  }
  if(cont >= 5) {
    flag = "IS_STRAIGHT";
  }
  handStatus status;
  status.flag = flag;
  status.quant = quantCards;
  copyArrayCards(agroup, status.agroupCards, quantCards);
  return status;
}

handStatus verifyFlush(card agroup[], int quantCards){
  string flag = NULL;
  int cont[] = {0,0,0,0};
  for(int i = 0; i < quantCards; i++) {
    if(agroup[i].naipe == 'E'){
      cont[0]++;
    }else if(agroup[i].naipe == 'C'){
      cont[1]++;
    }else if(agroup[i].naipe == 'P'){
      cont[2]++;
    }else if(agroup[i].naipe == 'O'){
      cont[3]++;
    }
  }
  if(cont[0] >= 5 || cont[1] >= 5 || cont[2] >= 5 || cont[3] >= 5) {
    flag = "IS_FLUSH";
  }
  handStatus status;
  status.flag = flag;
  status.quant = quantCards;
  copyArrayCards(agroup, status.agroupCards, quantCards);
  return status;
}