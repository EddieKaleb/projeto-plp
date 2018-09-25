#include "hands.cpp"

/**
    Representação de um jogador.
**/
struct player {
  card hand[2];
  int chips;
};

// Array que armazena as cartas comunitárias.
card cardsTable[5];

// Array que armazena os jogadores da mesa.
player playersTable[9];

// Posição do usuário na mesa.
int USER_POSITION = 0;

/**
    Inicia o jogo.
**/
void startGame() {
    setGame();


}

/**
    Configura inicialmente o jogo, com a criação e embaralhamento do deck,
    e configuração dos jogadores da mesa.
**/
void setGame() {
    buildDeck();
    shuffleDeck();

    setPlayers();
}

/**
    Configura as fichas e as cartas dos jogadores.
**/
void setPlayers() {
    setPlayersChips();
    setPlayersCards();
}

/**
    Configura as fichas dos jogadores.
**/
void setPlayersChips() {
    for(int i = 0; i < sizeof(playersTable); i++) {
        playersTable[i].chips = 200;
    }
}

/**
    Configura as cartas dos jogadores.
**/
void setPlayersCards() {
    for(int i = 0; i < sizeof(playersTable); i++) {
        playersTable[i].hand[0] = getCard();
        playersTable[i].hand[1] = getCard();
    }
}

/**
    Exibe a representação da mesa.
**/
void showTable() {
    cout << "Mesa aqui" << endl;
}

/**
    Exibe as ações que um usuário pode realizar em sua vez.
**/
void showUserActions() {
    clearScreen();
    
    cout << endl;
    cout << "-----------------------------     AÇÕES     -----------------------------";
    cout << endl << endl;

    cout << "          1  -  Mesa" << endl;
    cout << "          2  -  Apostar" << endl;
    cout << "          3  -  Pagar" << endl;
    cout << "          4  -  Aumentar" << endl;
    cout << "          5  -  Desistir" << endl;

    selectActionOption(getOption());
}

/**
    Retorna a opção escolhida pelo usuário.
**/
int getOption() {
    int option;

    cout << endl << "           Digite o número da opção desejada: ";
    cin >> option;

    return option;
}

/**
    Interpreta a ação selecionada pelo usuário.
**/
void selectActionOption(int option) {
    switch(option) {
        case 1:
            checkAction();
            break;
        case 2:
            betAction();
            break;
        case 3:
            callAction();
            break;
        case 4:
            raiseAction();
            break;
        case 5:
            foldAction();
            break;
        default:
            break;
    }
}

/**
    Realiza a ação de 'Mesa' (Passar a vez).
**/
void checkAction() {

}

/**
    Realiza a ação de 'Apostar'.
**/
void betAction() {

}

/**
    Realiza a ação de 'Pagar'.
**/
void callAction() {

}

/**
    Realiza a ação de 'Aumentar' a aposta.
**/
void raiseAction() {

}

/**
    Realiza a ação de 'Desistir' (Encerrar o jogo).
**/
void foldAction() {

}