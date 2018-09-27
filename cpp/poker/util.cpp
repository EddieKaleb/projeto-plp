#include "deck.cpp"


void copyArrayCards(card current[], card* target, int quantCards){
  for(int i = 0; i < quantCards; i++){
    target[i] = current[i];
  }
}

void agroupCards(card handPlayer[],card cTable[], card *agroup){
  for(int i =0; i<=6; i++){
    if(i<2){
      agroup[i].value = handPlayer[i].value;
      agroup[i].naipe = handPlayer[i].naipe;
    }else{
      agroup[i].value = cTable[i-2].value;
      agroup[i].naipe = cTable[i-2].naipe;
    }
  }
}

void shift(card* arr,int posIni, int posFin){
  for(int i = posIni; i<posFin;i++){
    swap(arr[i],arr[i+1]);
  }
}

int map(char value){
    char cards[] = {'2','3','4','5','6','7','8','9','T','J','Q','K','A'};
    for(int i = 0; i <= 12; i++){
        if(cards[i] == value){
            return i+2;
        }
    }
    return 0;
}

int compareTo(char value, char pivot){
    return map(value) >= map(pivot);
}

void swap(card* a, card* b) { 
  card t = *a; 
  *a = *b; 
  *b = t; 
} 

int partition (card arr[], int low, int high) { 
  char pivot = arr[high].value; 
  int i = (low - 1);  
  for (int j = low; j <= high- 1; j++) { 
    if (compareTo(arr[j].value, pivot)) { 
      i++;
      swap(&arr[i], &arr[j]); 
    } 
  } 
  swap(&arr[i + 1], &arr[high]); 
  return (i + 1); 
} 
void quickSort(card arr[], int low, int high) { 
  if (low < high) { 
    int pi = partition(arr, low, high); 
    quickSort(arr, low, pi - 1); 
    quickSort(arr, pi + 1, high); 
  } 
} 