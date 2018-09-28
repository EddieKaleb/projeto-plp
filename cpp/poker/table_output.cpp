#include<cstdio>
#include "deck.cpp"


/*struct card {
  char value;
  char naipe;
};*/

struct player {
  card hand[2];
  int chips;
  char role;
  float preFlopProb;
  float flopToTurnProb;
  float turnToRiverProb;
  float riverToShowDownProb;
  string action;
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
    //printf("%c", 218);
    printf("┌");
    
    for(int i = 0; i < 90; i++){
      //  printf("%c", 196);
        printf("─");
    }
    //printf("%c\n",191);
    printf("┐\n");
}

void bottomBorder(){
    //printf("%c", 192);
    printf("└");
    
    for(int i = 0; i < 10; i++){
        printf("─");
    }
    printf("┴");
    for(int i = 0; i < 79; i++){
        printf("─");
    }
    //printf("%c\n",217);
    printf("┘\n");

}

void lateralBorder(int n){
    for(int i = 0; i < n; i++){
        //printf("%c\n", 179);       \n   
        printf("│");
        for(int j = 0; j < 90; j++){
            printf(" ");
        }
        //printf("%c\n", 179);     
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
    //printf("%c", 218);  
    printf("┌");
    for(int j = 0; j < 3; j++){
        //printf("%c", 196);
        printf("─");
    }
    //printf("%c",191);
    printf("┐");
}

void cardTop(int n){
    for(int i = 0; i < n; i++){
        cardTop();
    }
}

void cardLateral(){
    //printf("%c\n", 179);      
    printf("│");
        for(int j = 0; j < 3; j++){
            printf(" ");
        }
    //printf("%c\n", 179);      
    printf("│");
    
}

void cardLateral(int n){
    for(int i = 0; i < n; i++){
        cardLateral();
    }   
}

void cardLateral(char c){   
    //printf("%c\n", 179);      
    printf("│");
    
    if(c == 'T'){
        printf("10 ");      
    }else{
        printf("%c  ", c);
    }
    //printf("%c\n", 179);      
    printf("│");  
}

void cardBottom(){
    //printf("%c", 192);
    printf("└");  
    for(int j = 0; j < 3; j++){
        //printf("%c", 196);
        printf("─");
    }
    //printf("%c\n",217);
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
    cardLateral(p.hand[0].value);
    cardLateral(p.hand[1].value);
    centralCardSpaces();
;     
    printf("│\n");     
   
    printf("│");

    centralCardSpaces();
    cardLateral(p.hand[0].naipe);
    cardLateral(p.hand[1].naipe);
    centralCardSpaces();
  
    printf("│\n");     
     
    printf("│");

    centralCardSpaces();
    cardBottom(2);
    centralCardSpaces();
     
    printf("│\n");
}

void centralCardWithProb(player p, int prob){      
    printf("│");

    centralCardSpaces();
    cardTop(2);
    centralCardSpaces();
       
    printf("│\n");
         
    printf("├");

    for(int i = 0; i < 10; i++)
        printf("─");
    printf("┐");
    spaces(29);
    cardLateral(p.hand[0].value);
    cardLateral(p.hand[1].value);
    centralCardSpaces();
;     
    printf("│\n");     
   
    printf("│");

    printf(" WIN: %f.1%", prob);
    if(numDigits(prob) == 1){
        spaces(1);
    }
    printf("│");
    centralCardSpaces();
    cardLateral(p.hand[0].naipe);
    cardLateral(p.hand[1].naipe);
    centralCardSpaces();
  
    printf("│\n");     
     
    printf("│");

    centralCardSpaces();
    cardBottom(2);
    centralCardSpaces();
     
    printf("│\n");
}


void cardsLateral(player p1, player p2){//card c1, card c2, card c3, card c4){
    //printf("%c\n", 179);      
    printf("│");
    lateralSpaces();
    cardTop(2);
    centralSpaces();
    cardTop(2);
    lateralSpaces();
    //printf("%c\n", 179);     
    printf("│\n");

    //printf("%c\n", 179);      
    printf("│");
    lateralSpaces(); 
    cardLateral(p1.hand[0].value);
    cardLateral(p1.hand[1].value);
    centralSpaces();
    cardLateral(p2.hand[0].value);
    cardLateral(p2.hand[1].value);
    lateralSpaces();
    //printf("%c\n", 179);     
    printf("│\n");

    //printf("%c\n", 179);      
    printf("│");
    lateralSpaces(); 
    cardLateral(p1.hand[0].naipe);
    cardLateral(p1.hand[1].naipe);
    centralSpaces();
    cardLateral(p2.hand[0].naipe);
    cardLateral(p2.hand[1].naipe);
    lateralSpaces();
    //printf("%c\n", 179);     
    printf("│\n");

    //printf("%c\n", 179);      
    printf("│");
    lateralSpaces();
    cardBottom(2);
    centralSpaces();
    cardBottom(2);
    lateralSpaces();
    //printf("%c\n", 179);     
    printf("│\n");
}

void flopTurnRiver(card cards[]){
    //printf("%c\n", 179);      
    printf("│");
    spaces(30);
    cardTop(3);
    spaces(2);
    cardTop();
    spaces(2);
    cardTop();
    spaces(31);
    //printf("%c\n", 179);     
    printf("│\n");

    //printf("%c\n", 179);      
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
    //printf("%c\n", 179);     
    printf("│\n");

    //printf("%c\n", 179);      
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
    //printf("%c\n", 179);     
    printf("│\n");

    //printf("%c\n", 179);      
    printf("│");
    spaces(30);
    cardBottom(3);
    spaces(2);
    cardBottom();
    spaces(2);
    cardBottom();
    spaces(31);
    //printf("%c\n", 179);     
    printf("│\n");

}

void printCentralPlayer(player p, int numPlayer){
    //printf("%c\n", 179);      
    printf("│");
    spaces(40);
    printf("Player %d", numPlayer);
    int numSpaces = 42;
    if(p.role != 'C'){
        printf("(%c)", p.role);
        numSpaces = numSpaces - 3;
    }
    spaces(numSpaces);
    //printf("%c\n", 179);     
    printf("│\n");
    
    int digits = numDigits(p.chips);
    //printf("%c\n", 179);      
    printf("│");
    spaces(40);
    printf("Chips: %d", p.chips);
    spaces(43 - digits);
    //printf("%c\n", 179);     
    printf("│\n");
}

void printLateralPlayers(player p1, int numPlayer1, player p2, int numPlayer2){
    //printf("%c\n", 179);          
    printf("│");
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
    lateralSpaces();
    //printf("%c\n", 179);     
    printf("│\n");

    //printf("%c\n", 179);          
    printf("│");
    lateralSpaces();
    printf("Chips: %d", p1.chips);
    spaces(70 - numDigits(p1.chips) - numDigits(p2.chips));
    printf("Chips: %d", p2.chips);
    lateralSpaces();
    //printf("%c\n", 179);     
    printf("│\n");
}

void printPot(int pot){
    ////printf("%c\n", 179);           
    printf("│");
    spaces(40);
    printf("Pot: %d", pot);
    spaces(45 - numDigits(pot));
    //printf("%c\n", 179);    
    printf("│\n");
}

void printTable(player players[], card cards[], int pot){
    topBorder();
    centralCard(players[3]);
    printCentralPlayer(players[3], 4);
    cardsLateral(players[2], players[4]);
    printLateralPlayers(players[2], 3, players[4], 5);
    
    flopTurnRiver(cards);
    printPot(pot);
    
    cardsLateral(players[1], players[5]);
    printLateralPlayers(players[1], 2, players[5], 6);

    printCentralPlayer(players[0], 1);
    int prob = 0;
    if(cards[0].value == ' '){
        prob = p1.preFlopProb;
    }else if(cards[3].values == ' '){
        prob = p1.flopToTurnProb;
    }else if(cards[4] == ' '){
        prob = p1.turnToRiverProb;
    }else{
        prob = p1.riverToShowDownProb;
    }
    centralCardWithProb(players[0], prob);
    bottomBorder();   
}

int main(){
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
    p1.hand[1] = c2;
    p1.chips = 50000;
    p1.role = 'C';
    player p2;
    p2.hand[0] = c3;
    p2.hand[1] = c4;
    p2.chips = 500;
    p2.role = 'C';
    player p3;
    p3.hand[0] = c5;
    p3.hand[1] = c5;
    p3.chips = 500;
    p3.role = 'D';
    player p4;
    p4.hand[0] = c3;
    p4.hand[1] = c1;
    p4.chips = 50000;
    p4.role = 'B';
    player p5;
    p5.hand[0] = c2;
    p5.hand[1] = c5;
    p5.chips = 500000;
    p5.role = 'S';
    player p6;
    p6.hand[0] = c5;
    p6.hand[1] = c2;
    p6.chips = 500;
    p6.role = 'C';

    player players[] = {p1, p2, p3, p4, p5, p6};
    card cards[] = {c1, c2, c3, c4, c5};

    printTable(players, cards, 50000);//p1, p2, p3, p4, p5, p6, c1, c2, c3, c4, c5, 500000);
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