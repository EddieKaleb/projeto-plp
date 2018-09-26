#include "hands.cpp"
#include <cstdlib>
void setGame();
void startGame();
void setPlayers();
void setPlayersChips();
void setPlayersCards();
void setInitialPlayersRoles();
void setPlayersRoles(int dealerPosition);
int nextPlayerPosition(int currentPos);
void showTable();
void showUserActions();
void selectActionOption(int option);
void checkAction();
void betAction();
void callAction();
void raiseAction();
void foldAction();
void exitAction();
void clearScreen();
int getOption();
void setInitialDealerPosition();
void setNextDealerPosition();

void clearScreen() {
    system("clear");
}

/**
    Representação de um jogador.
**/
struct player {
  card hand[2];
  int chips;
  char role;
};

// Quantidade de jogadores na mesa
int QTD_PLAYERS = 6;

// Array que armazena as cartas comunitárias.
card cardsTable[5];

// Array que armazena os jogadores da mesa.
player playersTable[6];

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

    setPlayersChips();
    setInitialDealerPosition();

    /**
        Controlar a passagem do dealer, e executar enquanto o usuário não desiste,
        perde todas as fichas, ou não é vencedor.
    **/
    while(true) {

        buildDeck();
        shuffleDeck();
        setPlayersCards();

        setNextDealerPosition();
        setPlayersRoles(DEALER_POSITION);

        POT = 0;

        /**
            Controlar as partidas, ou seja, roda enquanto as cinco cartas comunitárias não são definidas.
        **/
        while(true) {

            /**
                Controla a passagem de vez de cada jogador.
            **/
            for(int i = 0; i < QTD_PLAYERS; i++) {

            }
        }
    }
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
    setInitialDealerPosition();
    setPlayersRoles(DEALER_POSITION);
}

void setInitialDealerPosition() {
    srand(time(NULL));
    DEALER_POSITION = rand() % QTD_PLAYERS;
}

void setNextDealerPosition() {
    DEALER_POSITION = nextPlayerPosition(DEALER_POSITION);
}

// Define as funções de cada jogador durante a partida com base no dealer.
void setPlayersRoles(int dealerPosition) {
    int i = 0;
    int index = dealerPosition;

    playersTable[index].role = 'D';

    index = nextPlayerPosition(index);

    playersTable[index].role = 'S';

    index = nextPlayerPosition(index);

    playersTable[index].role = 'B';

    while(i < QTD_PLAYERS - 3) {
        index = nextPlayerPosition(index);
        playersTable[index].role = 'C';
        i++;
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
    cout << "          6  -  Sair da mesa" << endl;

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
        case 6:
            exitAction();
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

/**
    Realiza a ação de 'Sair' da mesa.
**/
void exitAction() {

}

int main(){
    return 0;
}