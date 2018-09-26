#include<stdio.h>

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
    if(c != '0'){
        printf("%c", 179);
        
        if(c == 'T'){
        printf("10 ", c);      
        }else{
            printf("%c  ", c);
        }
        printf("%c", 179);
    }else{
        cardLateral();
    }
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

void centralCard(char num1, char naipe1, char num2, char naipe2){
    printf("%c", 179);

    centralCardSpaces();
    cardTop(2);
    centralCardSpaces();

    printf("%c\n", 179);

    printf("%c", 179);

    centralCardSpaces();
    cardLateral(num1);
    cardLateral(num2);
    centralCardSpaces();

    printf("%c\n", 179);

    printf("%c", 179);

    centralCardSpaces();
    cardLateral(naipe1);
    cardLateral(naipe2);
    centralCardSpaces();

    printf("%c\n", 179);

    printf("%c", 179);

    centralCardSpaces();
    cardBottom(2);
    centralCardSpaces();

    printf("%c\n", 179);
}

void centralCard(){
    centralCard('0','0','0','0');
}

void cardsLateral(){
    printf("%c", 179);
    lateralSpaces();
    cardTop(2);
    centralSpaces();
    cardTop(2);
    lateralSpaces();
    printf("%c\n", 179);

    printf("%c", 179);
    lateralSpaces(); 
    cardLateral(2);
    centralSpaces();
    cardLateral(2);
    lateralSpaces();
    printf("%c\n", 179);

    printf("%c", 179);
    lateralSpaces(); 
    cardLateral(2);
    centralSpaces();
    cardLateral(2);
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

void flopTurnRiver(char num1, char naipe1, char num2, char naipe2, char num3, char naipe3, char num4, char naipe4, char num5, char naipe5){
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
    cardLateral(num1);
    cardLateral(num2);
    cardLateral(num3);
    spaces(2);
    cardLateral(num4);
    spaces(2);
    cardLateral(num5);
    spaces(31);
    printf("%c\n", 179);

    printf("%c", 179);
    spaces(30);
    cardLateral(naipe1);
    cardLateral(naipe2);
    cardLateral(naipe3);
    spaces(2);
    cardLateral(naipe4);
    spaces(2);
    cardLateral(naipe5);
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

void flopTurnRiver(){
    flopTurnRiver('0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
}

void flopTurnRiver(char num1, char naipe1, char num2, char naipe2, char num3, char naipe3){
    flopTurnRiver(num1, naipe1, num2, naipe2, num3, naipe3, '0', '0', '0', '0');
}

void flopTurnRiver(char num1, char naipe1, char num2, char naipe2, char num3, char naipe3, char num4, char naipe4){
    flopTurnRiver(num1, naipe1, num2, naipe2, num3, naipe3, num4, naipe4, '0', '0');
}


void printTable(){
    topBorder();
    centralCard();
    cardsLateral();
    lateralBorder(2);
    flopTurnRiver('K', 'P', 'Q', 'C', 'J', 'O');
    lateralBorder(2);
    cardsLateral();
    centralCard('T','O','8','P');
    bottomBorder();   
}



int main(){
    printTable();
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
    │                                                                                          │
    │                                                                                          │
    └──────────────────────────────────────────────────────────────────────────────────────────┘
   
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