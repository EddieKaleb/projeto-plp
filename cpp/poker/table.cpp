#include "hands.cpp"

/**
    Representação de um jogador.
**/
struct player {
  card hand[2];
  int chips;
};

// Quantidade de jogadores na mesa
int QTD_PLAYERS = 9;

// Array que armazena as cartas comunitárias.
card cardsTable[5];

// Array que armazena os jogadores da mesa.
player playersTable[QTD_PLAYERS];

char playersRoles[QTD_PLAYERS];

// Posição do usuário na mesa.
int USER_POSITION = 0;

// Posição do dealer durante a partida;
int DEALER_POSITION = 0;

// Valor do pot da partida.
int POT = 0;

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
    Configura as fichas, as cartas dos jogadores e define a função inicial de cada jogador.
**/
void setPlayers() {
    setPlayersChips();
    setPlayersCards();
    setInitialPlayersRoles();
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

// Define as funções iniciais dos jogadores de forma aleatória.
void setInitialPlayersRoles() {
    srand(time(NULL));

    DEALER_POSITION = rand() % 9;

    setPlayersRoles(DEALER_POSITION);
}

// Define as funções de cada jogador durante a partida.
void setPlayersRoles(int dealerPosition) {
    int i = 0;
    int index = dealerPosition;

    playersRoles[index] = 'D';

    index = nextPlayerPosition(index);

    playersRoles[index] = 'S';

    index = nextPlayerPosition(index);

    playersRoles[index] = 'B';

    while(i < QTD_PLAYERS - 3) {
        index = nextPlayerPosition(index);
        playersRoles[index] = 'C';

    }
}

// Retorna a posição do próximo jogador com base no array de jogadores.
int nextPlayerPosition(int currentPos) {
    return (currentPos + 1) % QTD_PLAYERS;
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