#include "util.cpp" 
#include "hand_prob.cpp"

typedef struct {
  string flag;
  card agroupCards[7];
  int quant;
} handStatus;

handStatus verifyThree(card agroup[], int quantCards);
handStatus verifyPair(card agroup[], int quantCards);
handStatus verifyFullHouse(card agroup[], int quantCards);
handStatus verifyFour(card agroup[], int quantCards);
handStatus verifyFlush(card agroup[], int quantCards);
handStatus verifyStraight(card agroup[], int quantCards);
handStatus verifyFullHouse(card agroup[], int quantCards);
handStatus verifyStraightFlush(card agroup[], int quantCards);
handStatus verifyRoyalFlush(card agroup[], int quantCards);

float getPreFlopProb(card pair[], int num_players) {
  string target_hand;
  quickSort(pair,0,1);

  for (int i = 0; i < 2; i++) {
    target_hand += pair[i].value;
  }
  
  if (pair[0].value != pair[1].value) {
    if (pair[0].naipe == pair[1].naipe) {
      target_hand += "s";
    } else {
      target_hand += "o";
    }
  }
  
  float prob = hand_probability(target_hand, num_players);
  cout << target_hand << ": " << prob << "%" << endl;
  return prob;
}

handStatus verifyHand(card handPlayer[],card cTable[], int quantCards){
  card agroup[quantCards];
  agroupCards(handPlayer,cTable, agroup);
  quickSort(agroup,0,quantCards-1);
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  if(quantCards == 2){
    //carta alta
  }else if(quantCards>=5){
    if(status.flag == "null"){status = verifyRoyalFlush(agroup, quantCards);}
    if(status.flag == "null"){status = verifyStraightFlush(agroup, quantCards);}
    if(status.flag == "null"){status = verifyFour(agroup,quantCards);}
    if(status.flag == "null"){status = verifyFullHouse(agroup,quantCards);}
    if(status.flag == "null"){status = verifyFlush(agroup,quantCards);}
    if(status.flag == "null"){status = verifyStraight(agroup,quantCards);}
    if(status.flag == "null"){status = verifyThree(agroup,quantCards);}
    if(status.flag == "null"){status = verifyPair(agroup,quantCards);}
  }
  
   
  // cout<<" "<<verifyThree(agroup,quantCards).agroupCards[2].value<<" ";
  // cout<<verifyPair(agroup,quantCards).flag;
  // cout<<agroup[0].value<<agroup[1].value<<agroup[2].value<<agroup[3].value<<agroup[4].value<<agroup[5].value<<agroup[6].value;
  // cout<<verifyFullHouse(agroup, quantCards).flag;
  // cout<<verifyFour(agroup, quantCards).flag;
  // cout<<verifyFlush(agroup, quantCards).flag;
  // cout<<verifyStraight(agroup, quantCards).flag;
  // cout<<verifyFullHouse(agroup, quantCards).flag;
  return status;
}

handStatus verifyThree(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  for(int i = 2; i < quantCards; i++) {
    if(agroup[i].value==agroup[i-1].value and agroup[i-2].value==agroup[i-1].value){
      status.flag = "IS_THREE";
      status.agroupCards[0] = agroup[i];
      status.agroupCards[1] = agroup[i-1];
      status.agroupCards[2] = agroup[i-2];
      break;
    }
  }
  return status;
}

handStatus verifyStraight(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  int cont = 0;
  int index = 0;

  for(int i = 1; i < quantCards; i++) {
    if(map(agroup[i-1].value)-1 == map(agroup[i].value)){
      cont++;
      if(index == 0){
        status.agroupCards[index] = agroup[i-1];
        index++;
        cont++;
      }
      status.agroupCards[index] = agroup[i];
      index++;
    }else if(cont<5) {
      cont = 0;
      index = 0;
    }
  }
  if(cont >= 5) {
    status.flag = "IS_STRAIGHT";
  }
  return status;
}

void getCardsNaipe(card agroup[],card arr[],int quantCards,char naipe){
  for(int i = 0; i < quantCards; i++) {
    if(agroup[i].naipe == naipe){
      arr[i] = agroup[i];
    }
  }
}

handStatus verifyFlush(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
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
  if(cont[0] >= 5){
    status.flag = "IS_FLUSH";
    getCardsNaipe(agroup,status.agroupCards,quantCards,'E');
  }else if(cont[1] >= 5){
    status.flag = "IS_FLUSH";
    getCardsNaipe(agroup,status.agroupCards,quantCards,'C');
  }else if(cont[2] >= 5){
    status.flag = "IS_FLUSH";
    getCardsNaipe(agroup,status.agroupCards,quantCards,'P');
  }else if(cont[3] >= 5){
    status.flag = "IS_FLUSH";
    getCardsNaipe(agroup,status.agroupCards,quantCards,'O');
  } 
  return status;
}

void getPair(card *agroup, int quantCards){
    for(int i = 1; i < quantCards; i++) {
        if(agroup[i].value==agroup[i-1].value){
          shift(agroup,i,quantCards-1);
          shift(agroup,i-1,quantCards-2);
          break;
        }
    }
}

handStatus verifyPair(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  card copy[7];
  copyArrayCards(agroup,copy,7);
  getPair(copy, quantCards);
  if(copy[quantCards-1].value == copy[quantCards-2].value){
    status.flag = "IS_ONE_PAIR";
    status.agroupCards[0] = copy[quantCards-1];
    status.agroupCards[1] = copy[quantCards-2];
    getPair(copy, quantCards-2);
    if(quantCards >= 4 && copy[quantCards-3].value == copy[quantCards-4].value){
      status.flag = "IS_TWO_PAIR";
      status.agroupCards[2] = copy[quantCards-3];
      status.agroupCards[3] = copy[quantCards-4];
    }
  }
  return status;
}

void getThree(card *agroup, int quantCards){
  for(int i = 2; i < quantCards; i++) {
    if(agroup[i].value==agroup[i-1].value and agroup[i-2].value==agroup[i-1].value){
      shift(agroup,i,quantCards-1);
      shift(agroup,i-1,quantCards-2);
      shift(agroup,i-2,quantCards-3);
      break;
    }
  }
}

handStatus verifyFullHouse(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  card copy[7];
  copyArrayCards(agroup,copy,7);
  getThree(copy, quantCards);
  if(copy[quantCards-1].value == copy[quantCards-2].value and copy[quantCards-2].value==copy[quantCards-3].value){
    status.agroupCards[0] = copy[quantCards-1];
    status.agroupCards[1] = copy[quantCards-2];
    status.agroupCards[2] = copy[quantCards-3];
    handStatus vTwo = verifyPair(copy, quantCards-3);
    if(vTwo.flag == "IS_ONE_PAIR"){
      status.flag = "IS_FULL_HOUSE";
      status.agroupCards[2] = vTwo.agroupCards[0];
      status.agroupCards[3] = vTwo.agroupCards[1];
      status.agroupCards[4] = vTwo.agroupCards[2];
    }
  }
  return status;
}



handStatus verifyFour(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  for(int i = 3; i < quantCards; i++) {
    if(agroup[i].value==agroup[i-1].value and agroup[i-2].value==agroup[i-1].value and agroup[i-2].value==agroup[i-3].value){
      status.flag = "IS_FOUR";
      status.agroupCards[0] = agroup[i];
      status.agroupCards[1] = agroup[i-1];
      status.agroupCards[2] = agroup[i-2];
      status.agroupCards[3] = agroup[i-3];
      break;
    }
  }
  return status;
}

handStatus verifyStraightFlush(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  int cont = 0;
  int index = 0;
  for(int i = 1; i < quantCards; i++) {
    if(map(agroup[i-1].value)-1 == map(agroup[i].value) && agroup[i-1].naipe == agroup[i].naipe){
      cont++;
      if(index == 0){
        status.agroupCards[index] = agroup[i-1];
        index++;
        cont++;
      }
      status.agroupCards[index] = agroup[i];
      index++;
    }else if(cont<5) {
      cont = 0;
      index = 0;
    }
  }
  if(cont >= 5) {
    status.flag = "IS_STRAIGHT_FLUSH";
  }
  return status;
}

handStatus verifyRoyalFlush(card agroup[], int quantCards){
  handStatus status;
  status.flag = "null";
  status.quant = quantCards;
  handStatus veri = verifyStraightFlush(agroup,quantCards);
  if(veri.flag == "IS_STRAIGHT_FLUSH" && veri.agroupCards[0].value=='A'){
    status.flag = "IS_ROYAL_FLUSH";
    copyArrayCards(veri.agroupCards,status.agroupCards,5);
  }
  return status;
}