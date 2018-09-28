#include<cstdio>
#include "deck.cpp"

struct player {
  card hand[2];
  int chips;
  int lastBet;
  char role;
  float preFlopProb; // 2 cartas
  float flopToTurnProb; // 5 cartas
  float turnToRiverProb; // 6 cartas 
  float riverToShowDownProb; // 7 cartas
  bool showCards;
  bool active;
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
    printf("┌");
    
    for(int i = 0; i < 90; i++){
        printf("─");
    }

    printf("┐\n");
}

void bottomBorder(){
    printf("└");
    
    for(int i = 0; i < 12; i++){
        printf("─");
    }
    printf("┴");
    for(int i = 0; i < 77; i++){
        printf("─");
    }

    printf("┘\n");

}

void lateralBorder(int n){
    for(int i = 0; i < n; i++){
        printf("│");
        for(int j = 0; j < 90; j++){
            printf(" ");
        }

        printf("│\n");
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
    printf("┌");
    for(int j = 0; j < 3; j++){
        printf("─");
    }

    printf("┐");
}

void cardTop(int n){
    for(int i = 0; i < n; i++){
        cardTop();
    }
}

void cardLateral(){
    printf("│");
        for(int j = 0; j < 3; j++){
            printf(" ");
        }

    printf("│");
    
}

void cardLateral(int n){
    for(int i = 0; i < n; i++){
        cardLateral();
    }   
}

void cardLateral(char c){
    printf("│");
    
    if(c == 'T'){
        printf("10 ");      
    }else{
        printf("%c  ", c);
    }

    printf("│");  
}

void cardBottom(){
    printf("└");  
    for(int j = 0; j < 3; j++){
        printf("─");
    }

    printf("┘");

}

void cardBottom(int n){
    for(int i = 0; i < n; i++){
        cardBottom();
    }
}

void centralCard(player p){      
    printf("│");

    centralCardSpaces();
    cardTop(2);
    centralCardSpaces();
       
    printf("│\n");
         
    printf("│");

    centralCardSpaces();
    char value1 = ' ';
    char value2 = ' ';
    if(p.showCards){
        value1 = p.hand[0].value;
        value2 = p.hand[1].value;
    }
    cardLateral(value1);
    cardLateral(value2);
    centralCardSpaces();
;     
    printf("│\n");     
   
    printf("│");

    centralCardSpaces();
    char naipe1 = ' ';
    char naipe2 = ' ';
    if(p.showCards){
        naipe1 = p.hand[0].naipe;
        naipe2 = p.hand[1].naipe;
    }
    cardLateral(naipe1);
    cardLateral(naipe2);
    centralCardSpaces();
  
    printf("│\n");     
     
    printf("│");

    centralCardSpaces();
    cardBottom(2);
    centralCardSpaces();
     
    printf("│\n");
}

void centralCardWithProb(player p, float prob){
    printf("│");

    centralCardSpaces();
    cardTop(2);
    centralCardSpaces();
       
    printf("│\n");

    printf("│");     
    
    centralCardSpaces();
    cardLateral(p.hand[0].value);
    cardLateral(p.hand[1].value);
    centralCardSpaces();
;     
    printf("│\n");

    printf("├");

    for(int i = 0; i < 12; i++)
        printf("─");
    printf("┐");

    
    spaces(27);
    cardLateral(p.hand[0].naipe);
    cardLateral(p.hand[1].naipe);
    centralCardSpaces();

    printf("│\n");

    printf("│");
    char c = '%';
    printf(" WIN: %.1f", prob);
    printf("%c", c);
    if(numDigits(prob) >= 1){
        spaces(3 - numDigits(prob));
    }
    printf("│");

    spaces(27);
    cardBottom(2);
    centralCardSpaces();

    printf("│\n");
}


void cardsLateral(player p1, player p2){
    printf("│");
    lateralSpaces();
    cardTop(2);
    centralSpaces();
    cardTop(2);
    lateralSpaces();
    printf("│\n");

    printf("│");
    lateralSpaces();
    char value1 = ' ';
    char value2 = ' ';
    if(p1.showCards){
        value1 = p1.hand[0].value;
        value2 = p1.hand[1].value;
    }
    cardLateral(value1);
    cardLateral(value2);
    centralSpaces();

    value1 = ' ';
    value2 = ' ';
    if(p2.showCards){
        value1 = p2.hand[0].value;
        value2 = p2.hand[1].value;
    }
    cardLateral(value1);
    cardLateral(value2);
    lateralSpaces();
    printf("│\n");

    printf("│");
    lateralSpaces();
    char naipe1 = ' ';
    char naipe2 = ' ';
    if(p1.showCards){
        naipe1 = p1.hand[0].naipe;
        naipe2 = p1.hand[1].naipe;
    }
    cardLateral(naipe1);
    cardLateral(naipe2);

    centralSpaces();

    naipe1 = ' ';
    naipe2 = ' ';
    if(p2.showCards){
        naipe1 = p2.hand[0].naipe;
        naipe2 = p2.hand[1].naipe;
    }
    cardLateral(naipe1);
    cardLateral(naipe2);
    lateralSpaces();
    printf("│\n");

    printf("│");
    lateralSpaces();
    cardBottom(2);
    centralSpaces();
    cardBottom(2);
    lateralSpaces();
    printf("│\n");
}

void flopTurnRiver(card cards[]){
    printf("│");
    spaces(30);
    cardTop(3);
    spaces(2);
    cardTop();
    spaces(2);
    cardTop();
    spaces(31);
    printf("│\n");

    printf("│");
    spaces(30);
    cardLateral(cards[0].value);
    cardLateral(cards[1].value);
    cardLateral(cards[2].value);
    spaces(2);
    cardLateral(cards[3].value);
    spaces(2);
    cardLateral(cards[4].value);
    spaces(31);
    printf("│\n");

    printf("│");
    spaces(30);
    cardLateral(cards[0].naipe);
    cardLateral(cards[1].naipe);
    cardLateral(cards[2].naipe);
    spaces(2);
    cardLateral(cards[3].naipe);
    spaces(2);
    cardLateral(cards[4].naipe);
    spaces(31);
    printf("│\n");

    printf("│");
    spaces(30);
    cardBottom(3);
    spaces(2);
    cardBottom();
    spaces(2);
    cardBottom();
    spaces(31);
    printf("│\n");

}

void printCentralPlayer(player p, int numPlayer, int actualPlayer){
    printf("│");
    spaces(39);
    int numSpaces = 42;
    if(!p.active)
        printf("X");
    else if(numPlayer == actualPlayer){
        printf("*");
    }else
        spaces(1);
    printf("Player %d", numPlayer);
    
    if(p.role != 'C'){
        printf("(%c)", p.role);
        numSpaces = numSpaces - 3;
    }
    spaces(numSpaces);
    printf("│\n");

    int digits = numDigits(p.chips);
    printf("│");
    spaces(40);
    printf("Chips: %d", p.chips);
    spaces(43 - digits);
    printf("│\n");
}

void printLateralPlayers(player p1, int numPlayer1, player p2, int numPlayer2, int actualPlayer){
    printf("│");
    if(!p1.active){
        spaces(2);
        printf("X");
    }else if(numPlayer1 == actualPlayer){
        spaces(2);
        printf("*");
    }else
        lateralSpaces();
    printf("Player %d", numPlayer1);
    int numSpaces = 65;
    if(p1.role != 'C'){
        printf("(%c)", p1.role);
        numSpaces = numSpaces - 3;
    }
    spaces(numSpaces);
    if(p2.role != 'C'){
        printf("(%c)", p2.role);
    }else{
        spaces(3);
    }
    printf("Player %d", numPlayer2);
    if(!p2.active){
        printf("X");
        spaces(2);
    }else if(numPlayer2 == actualPlayer){
        printf("*");
        spaces(2);
    }else
        lateralSpaces();
    printf("│\n");

    printf("│");
    lateralSpaces();
    printf("Chips: %d", p1.chips);
    spaces(70 - numDigits(p1.chips) - numDigits(p2.chips));
    printf("Chips: %d", p2.chips);
    lateralSpaces();
    printf("│\n");
}

void printPot(int pot){
    printf("│");
    spaces(40);
    printf("Pot: %d", pot);
    spaces(45 - numDigits(pot));
    printf("│\n");
}

void printTable(player players[], card cards[], int pot, int actualPlayer){
    topBorder();
    centralCard(players[3]);
    printCentralPlayer(players[3], 4, actualPlayer + 1);
    cardsLateral(players[2], players[4]);
    printLateralPlayers(players[2], 3, players[4], 5, actualPlayer + 1);

    flopTurnRiver(cards);
    printPot(pot);

    cardsLateral(players[1], players[5]);
    printLateralPlayers(players[1], 2, players[5], 6, actualPlayer + 1);

    printCentralPlayer(players[0], 1, actualPlayer + 1);
    float prob = 0;
    if(cards[0].value == ' '){
        prob = players[0].preFlopProb;
    }else if(cards[3].value == ' '){
        prob = players[0].flopToTurnProb;
    }else if(cards[4].value == ' '){
        prob = players[0].turnToRiverProb;
    }else{
        prob = players[0].riverToShowDownProb;
    }
    centralCardWithProb(players[0], prob);
    bottomBorder();
}

/*
    ╔══════════════════════════════════════════════════════════════════════════════════════════╗
    ║                                                                                          ║
    ║                                                                                          ║
    ║   ╔═══╗╔═══╗                                                                             ║
    ║   ║8 C║║3 P║                                                                             ║
    ║   ║   ║║   ║                                                                             ║
    ║   ╚═══╝╚═══╝                                                                             ║
    ║                                                                                          ║
    ║   ┌───┐┌───┐                                                                             ║
    ║   │8 O││3 E│                                                                             ║
    ║   │   ││   │                                                                             ║
    ║   └───┘└───┘                                                                             ║
    ║                                                                                          ║
    ╚══════════════════════════════════════════════════════════════════════════════════════════╝ 
   
    ┌──────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                          │
    │                                                                                          │
    │   ╔═══╗╔═══╗                                                                             │
    │   ║8 C║║3 P║                                                                             │
    │   ║   ║║   ║                                                                             │
    │   ╚═══╝╚═══╝                                                                             │
    │                                                                                          │
    │   ┌───┐┌───┐                                                                             │
    │   │8 O││3 E│                                                                             │
    │   │   ││   │                                                                             │
    │   └───┘└───┘                                                                             │
    ├──────────┐                                                                                        │
    │ WIN: 00% │                                                                                        │
    └──────────┴───────────────────────────────────────────────────────────────────────────────┘
   193 ┴
   195 ├
    │ = 179
    └ = 192
    ─ = 196
    ┐ = 191
    ┘ = 217
    ┌ = 218
    ╔ = 201
	═ = 205
	╗ = 187
	║ = 186
	╝ = 188
	╚ = 200
    ┌───┐┌───┐
    │8  ││3  │
    │   ││   │
    └───┘└───┘
    ┌───┐┌───┐
    │8  ││3  │
    │O  ││E  │
    └───┘└───┘
    ╔═══╗╔═══╗
    ║8  ║║3  ║
    ║   ║║   ║
    ╚═══╝╚═══╝
*/