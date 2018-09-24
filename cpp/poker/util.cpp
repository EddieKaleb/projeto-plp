#include "deck.cpp"

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

int map(string value){
    string cards[] = {"A","K","Q","J","10","9","8","7","6","5","4","3","2"};
    int numValue[] = {1,2,3,4,5,6,7,8,9,10,11,12,13};
    for(int i = 0; i <= 12; i++){
        if(cards[i] == value){
            return numValue[i];
        }
    }
    return 0;
}

int compareTo(string value, string pivot){
    return map(value) <= map(pivot);
}

void swap(card* a, card* b) { 
  card t = *a; 
  *a = *b; 
  *b = t; 
} 

int partition (card arr[], int low, int high) { 
  string pivot = arr[high].value; 
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