#include<stdio.h>
#include"deck.cpp"


struct player {
  card hand[2];
  int chips;
  char role;
  float preFlopProb;
};

int numDigits(int num){
    int digits = 1;
    int aux = 10;
    while((num / aux) >= 1){
        digits++;
        aux = aux * 10;
    }
    return digits;
}

void topBorder(){
    printf("%c", 218);
    
    for(int i = 0; i < 90; i++){
        printf("%c", 196);
    }
    printf("%c\n",191);
}

void bottomBorder(){
    printf("%c", 192);
    
    for(int i = 0; i < 90; i++){
        printf("%c", 196);
    }
    printf("%c\n",217);

}

void lateralBorder(int n){
    for(int i = 0; i < n; i++){
        printf("%c", 179);
        for(int j = 0; j < 90; j++){
            printf(" ");
        }
        printf("%c\n", 179);
    }

}

void spaces(int n){
    for(int j = 0; j < n; j++){
            printf(" ");
    }
}

void centralSpaces(){
    spaces(64);
}

void centralCardSpaces(){
    spaces(40);
}

void lateralSpaces(){
    spaces(3);
}

void cardTop(){
    printf("%c", 218);  
    for(int j = 0; j < 3; j++){
        printf("%c", 196);
    }
    printf("%c",191);
}

void cardTop(int n){
    for(int i = 0; i < n; i++){
        cardTop();
    }
}

void cardLateral(){
    printf("%c", 179);
        for(int j = 0; j < 3; j++){
            printf(" ");
        }
    printf("%c", 179);
    
}

void cardLateral(int n){
    for(int i = 0; i < n; i++){
        cardLateral();
    }   
}

void cardLateral(char c){   
    printf("%c", 179);
    
    if(c == 'T'){
    printf("10 ", c);      
    }else{
        printf("%c  ", c);
    }
    printf("%c", 179);  
}

void cardBottom(){
    printf("%c", 192);  
        for(int j = 0; j < 3; j++){
            printf("%c", 196);
        }
        printf("%c", 217);

}

void cardBottom(int n){
    for(int i = 0; i < n; i++){
        cardBottom();
    }
}

void centralCard(player p){
    printf("%c", 179);

    centralCardSpaces();
    cardTop(2);
    centralCardSpaces();

    printf("%c\n", 179);

    printf("%c", 179);

    centralCardSpaces();
    cardLateral(p.hand[0].value);
    cardLateral(p.hand[1].value);
    centralCardSpaces();

    printf("%c\n", 179);

    printf("%c", 179);

    centralCardSpaces();
    cardLateral(p.hand[0].naipe);
    cardLateral(p.hand[1].naipe);
    centralCardSpaces();

    printf("%c\n", 179);

    printf("%c", 179);

    centralCardSpaces();
    cardBottom(2);
    centralCardSpaces();

    printf("%c\n", 179);
}


void cardsLateral(player p1, player p2){//card c1, card c2, card c3, card c4){
    printf("%c", 179);
    lateralSpaces();
    cardTop(2);
    centralSpaces();
    cardTop(2);
    lateralSpaces();
    printf("%c\n", 179);

    printf("%c", 179);
    lateralSpaces(); 
    cardLateral(p1.hand[0].value);
    cardLateral(p1.hand[1].value);
    centralSpaces();
    cardLateral(p2.hand[0].value);
    cardLateral(p2.hand[1].value);
    lateralSpaces();
    printf("%c\n", 179);

    printf("%c", 179);
    lateralSpaces(); 
    cardLateral(p1.hand[0].naipe);
    cardLateral(p1.hand[1].naipe);
    centralSpaces();
    cardLateral(p2.hand[0].naipe);
    cardLateral(p1.hand[1].naipe);
    lateralSpaces();
    printf("%c\n", 179);

    printf("%c", 179);
    lateralSpaces();
    cardBottom(2);
    centralSpaces();
    cardBottom(2);
    lateralSpaces();
    printf("%c\n", 179);
}

void flopTurnRiver(card c1, card c2, card c3, card c4, card c5){
    printf("%c", 179);
    spaces(30);
    cardTop(3);
    spaces(2);
    cardTop();
    spaces(2);
    cardTop();
    spaces(31);
    printf("%c\n", 179);

    printf("%c", 179);
    spaces(30);
    cardLateral(c1.value);
    cardLateral(c2.value);
    cardLateral(c3.value);
    spaces(2);
    cardLateral(c4.value);
    spaces(2);
    cardLateral(c5.value);
    spaces(31);
    printf("%c\n", 179);

    printf("%c", 179);
    spaces(30);
    cardLateral(c1.naipe);
    cardLateral(c2.naipe);
    cardLateral(c3.naipe);
    spaces(2);
    cardLateral(c4.naipe);
    spaces(2);
    cardLateral(c5.naipe);
    spaces(31);
    printf("%c\n", 179);

    printf("%c", 179);
    spaces(30);
    cardBottom(3);
    spaces(2);
    cardBottom();
    spaces(2);
    cardBottom();
    spaces(31);
    printf("%c\n", 179);

}

void printCentralPlayer(player p, int numPlayer){
    printf("%c", 179);
    spaces(40);
    printf("Player %d", numPlayer);
    spaces(42);
    printf("%c\n", 179);
    
    int digits = numDigits(p.chips);
    printf("%c", 179);
    spaces(40);
    printf("Chips: %d", p.chips);
    spaces(43 - digits);
    printf("%c\n", 179);
}

void printLateralPlayers(player p1, int numPlayer1, player p2, int numPlayer2){
    printf("%c", 179);
    lateralSpaces();
    printf("Player %d", numPlayer1);
    spaces(68);
    printf("Player %d", numPlayer2);
    lateralSpaces();
    printf("%c\n", 179);

    printf("%c", 179);
    lateralSpaces();
    printf("Chips: %d", p1.chips);
    spaces(70 - numDigits(p1.chips) - numDigits(p2.chips));
    printf("Chips: %d", p2.chips);
    lateralSpaces();
    printf("%c\n", 179);
}

void printTable(){

   
    card c1;
    c1.value = 'K';
    c1.naipe = 'P';
    card c2;
    c2.value = 'Q';
    c2.naipe = 'C';
    card c3;
    c3.value = 'J';
    c3.naipe = 'O';
    card c4;
    c4.value = ' ';
    c4.naipe = ' ';
    card c5;
    c5.value = ' ';
    c5.naipe = ' ';

    player p1;
    p1.hand[0] = c1;
    p1.hand[1] = c5;
    p1.chips = 500;

    topBorder();
    centralCard(p1);
    printCentralPlayer(p1, 4);
    cardsLateral(p1, p1);
    printLateralPlayers(p1, 3, p1, 5);
    
    flopTurnRiver(c1, c2, c3, c4, c5);
    
    cardsLateral(p1, p1);
    printLateralPlayers(p1, 2, p1, 6);

    printCentralPlayer(p1, 1);
    centralCard(p1);
    bottomBorder();   
}



int main(){
    printTable();
}







/*
    +------------------------------------------------------------------------------------------+
    ¦                                                                                          ¦
    ¦                                                                                          ¦
    ¦   +---++---+                                                                             ¦
    ¦   ¦8 C¦¦3 P¦                                                                             ¦
    ¦   ¦   ¦¦   ¦                                                                             ¦
    ¦   +---++---+                                                                             ¦
    ¦                                                                                          ¦
    ¦   +---++---+                                                                             ¦
    ¦   ¦8 O¦¦3 E¦                                                                             ¦
    ¦   ¦   ¦¦   ¦                                                                             ¦
    ¦   +---++---+                                                                             ¦
    ¦                                                                                          ¦
    +------------------------------------------------------------------------------------------+ 
   
    +------------------------------------------------------------------------------------------+
    ¦                                                                                          ¦
    ¦                                                                                          ¦
    ¦   +---++---+                                                                             ¦
    ¦   ¦8 C¦¦3 P¦                                                                             ¦
    ¦   ¦   ¦¦   ¦                                                                             ¦
    ¦   +---++---+                                                                             ¦
    ¦                                                                                          ¦
    ¦   +---++---+                                                                             ¦
    ¦   ¦8 O¦¦3 E¦                                                                             ¦
    ¦   ¦   ¦¦   ¦                                                                             ¦
    ¦   +---++---+                                                                             ¦
    ¦                                                                                          ¦
    ¦                                                                                          ¦
    +------------------------------------------------------------------------------------------+
   
    ¦ = 179
    + = 192
    - = 196
    + = 191
    + = 217
    + = 218
    + = 201
	- = 205
	+ = 187
	¦ = 186
	+ = 188
	+ = 200
    +---++---+
    ¦8  ¦¦3  ¦
    ¦   ¦¦   ¦
    +---++---+
    +---++---+
    ¦8  ¦¦3  ¦
    ¦O  ¦¦E  ¦
    +---++---+


    +---++---+
    ¦8  ¦¦3  ¦
    ¦   ¦¦   ¦
    +---++---+


*/