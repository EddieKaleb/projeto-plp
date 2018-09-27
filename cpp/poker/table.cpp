#include "hands.cpp"
#include <cstdlib>
#include <string>

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
void setPlayersPreFlopProb();

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
  float preFlopProb;
  bool enabled;
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

// Ativar todos os usuários.
void enablePlayers(){
    for(int i = 0; i < QTD_PLAYERS; i++){
        playersTable[position].enabled = true;
    }
}

// Desativar determinado usuário.
void disablePlayer(int position){
    playersTable[position].enabled = false;
}

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
            int i = DEALER_POSITION + 1;
            int lastBet = 0;

            do{
                i = nextPlayerPosition(i);
            }while(i != DEALER_POSITION + 1);
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
/**
    Define as probabilidades pré-flop de cada jogador
**/
void setPlayersPreFlopProb() {
    for (int i = 0; i < QTD_PLAYERS; i++) {
        playersTable[i].preFlopProb = getPreFlopProb(playersTable[i].hand, QTD_PLAYERS);
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

void checkPlayerAction(int position, int raise, int bigBet){
    if(!checkAction(position, raise, bigBet)){
        cout << "Ação inválida!";
    }
}

void betPlayerAction(int position){
    int value;
    cin >> "Digite a quantia que você deseja apostar: " >> value;

    if(!raiseAction(position, value)){
        cout << "Ação inválida!";
    }
}

void callPlayerAction(int position){
    if(!callAction(position)){
        cout << "Ação inválida!";
    }
}

void raisePlayerAction(int position){
    int value;
    cin >> "Digite a quantia que você deseja aumentar na aposta: " >> value;

    if(!raiseAction(position, value)){
        cout << "Ação inválida!";
    }
}

void foldPlayerAction(int position){
    if(!foldAction(position)){
        cout << "Ação inválida!";
    }
}

/**
    Realiza a ação de 'Mesa' (Passar a vez).
**/
bool checkAction(int round, int position, int bigBet) {
    if(!(round == 0 && playersTable[position] == 'B' && bigBet == lastBet) || lastBet != 0) {
        return false;
    }

    return true;
}

/**
    Realiza a ação de 'Apostar'.
**/
bool betAction(int position, int bet) {
    if(lastBet == 0){
        playersTable[position].chips -= bet;
        POT += bet;
        lastBet = bet;

        return true;
    }
    
    return false;
}

/**
    Realiza a ação de 'Pagar'.
**/
bool callAction(int position) {
    if(playersTable[position].chips >= lastBet){
        playersTable[position].chips -= lastBet;
        POT += lastBet;
        return true;
    }
    
    return false;
}

/**
    Realiza a ação de 'Aumentar' a aposta.
**/
bool raiseAction(int position, int raise) {
    if(playersTable[position].chips >= lastBet + raise){
        playersTable[position].chips -= lastBet + raise;
        POT += lastBet + raise;
        lastBet += raise;

        return true;
    }
    
    return false;
}

/**
    Realiza a ação de 'Desistir' (Encerrar o jogo).
**/
void foldAction(int position) {
    disablePlayer(position);
}

/**
    Realiza a ação de 'Sair' da mesa.
**/
void exitAction() {

}

int main(){
    return 0;
}