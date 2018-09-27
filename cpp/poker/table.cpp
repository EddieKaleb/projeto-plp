#include "hands.cpp"
#include <cstdlib>
#include <string>

void enablePlayers();
void disablePlayer(int position);
void setGame();
void startGame();
void setPlayers();
void setPlayersChips();
void setPlayersCards();
void setInitialPlayersRoles();
void setPlayersRoles(int dealerPosition);
int nextPlayerPosition(int currentPos);
void showTable();
void showUserActions(int round, int currentPosition);
void selectActionOption(int option, int round, int playerPosition);
bool checkAction(int round, int position, int bigBet);
bool betAction(int position, int bet);
bool callAction(int position);
bool raiseAction(int position, int raise);
void foldAction(int position);
void exitAction();
void clearScreen();
int getOption();
void setInitialDealerPosition();
void setNextDealerPosition();
void setPlayersPreFlopProb();
void checkPlayerAction(int round, int position, int bigBet);
void betPlayerAction(int position);
void callPlayerAction(int position);
void raisePlayerAction(int position);
void preFlopRound();
void flopRound();
void turnRound();
void riverRound();
void runRound(int beginPosition, int endPosition, int round);

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

/**
    Quantidade de jogadores na mesa.
**/
int QTD_PLAYERS = 6;

/**
    Array que armazena as cartas comunitárias.
**/
card cardsTable[5];

/**
    Array que armazena os jogadores da mesa.
**/
player playersTable[6];

/**
    Posição do usuário na mesa.
**/
int USER_POSITION = 0;

/**
    Posição do dealer durante a partida.
**/
int DEALER_POSITION = 0;

/**
    Valor da aposta inicial que é realizada pelo Small Blind.
**/
int MINIMUM_BET = 2;

/**
    Variável que armazena o valor atual da aposta do Big Blind;
**/
int bigBet = 0;

/**
    Valor do pot da partida.
**/
int POT = 0;

/**
    Ativa todos os usuários.
**/
void enablePlayers(){
    for(int i = 0; i < QTD_PLAYERS; i++){
        playersTable[i].enabled = true;
    }
}

/**
    Desativar determinado usuário.
**/
void disablePlayer(int position){
    playersTable[position].enabled = false;
}

/**
    Última aposta feita por um jogador durante uma partida.
**/
int lastBet = 0;

/**
    Inicia o jogo.
**/
void startGame() {

    setPlayersChips();
    setInitialDealerPosition();

    /**
        Controlar a passagem do dealer, e executar enquanto o usuário não desiste, ou
        perde todas as fichas.
    **/
    while(true) {

        buildDeck();
        shuffleDeck();
        setPlayersCards();

        setNextDealerPosition();
        setPlayersRoles(DEALER_POSITION);

        POT = 0;

        /**
            Controla os quartro turnos do jogo: pre-flop, flop, turn e river.
        **/
        for(int i = 0; i < 4; i++) {

            lastBet = 0;

            switch(i) {
                case 0:
                    preFlopRound();
                    break;
                case 1:
                    flopRound();
                    break;
                case 2:
                    turnRound();
                    break;
                case 3:
                    riverRound();
                default:
                    break;
            }
        }
    }
}

/**
    Realiza as operações necessárias do turno de pre-flop.
**/
void preFlopRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);
    int bigPosition = nextPlayerPosition(smallPosition);

    lastBet = MINIMUM_BET;

    betAction(smallPosition, MINIMUM_BET);
    raiseAction(bigPosition, MINIMUM_BET);

    runRound(nextPlayerPosition(bigPosition), bigPosition, 0);
}

/**
    Realiza as operações necessárias do turno de flop.
**/
void flopRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    cardsTable[0] = getCard();
    cardsTable[1] = getCard();
    cardsTable[2] = getCard();

    runRound(smallPosition, DEALER_POSITION, 1);
}

/**
    Realiza as operações necessárias do turno de turn.
**/
void turnRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    cardsTable[3] = getCard();

    runRound(smallPosition, DEALER_POSITION, 2);
}

/**
    Realiza as operações necessárias do turno de river.
**/
void riverRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    cardsTable[4] = getCard();

    runRound(smallPosition, DEALER_POSITION, 3);

    /** chamar método que compara as mãos e declarar o vencedor**/
}

/**
    Executa uma rodada permitindo que todos os jogadores ativos na mesa façam suas ações.
**/
void runRound(int beginPosition, int endPosition, int round) {
    int currentPosition = beginPosition;
    do {
        if(playersTable[currentPosition].enabled == true) {
            if(currentPosition == USER_POSITION) {
                showUserActions(round, currentPosition);
            }
            else {
                //botActions();
            }
        }
        currentPosition = nextPlayerPosition(currentPosition);
    } while(currentPosition == nextPlayerPosition(endPosition));
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

/**
    Define as funções iniciais dos jogadores de forma aleatória.
**/
void setInitialPlayersRoles() {
    setInitialDealerPosition();
    setPlayersRoles(DEALER_POSITION);
}

/**
    Define a posição atual do dealer de forma aleatória.
**/
void setInitialDealerPosition() {
    srand(time(NULL));
    DEALER_POSITION = rand() % QTD_PLAYERS;
}

/**
    Define a próxima posição do dealer.
**/
void setNextDealerPosition() {
    DEALER_POSITION = nextPlayerPosition(DEALER_POSITION);
}

/**
    Define as funções de cada jogador com base no dealer.
**/
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
    Define as probabilidades pré-flop de cada jogador.
**/
void setPlayersPreFlopProb() {
    for (int i = 0; i < QTD_PLAYERS; i++) {
        playersTable[i].preFlopProb = getPreFlopProb(playersTable[i].hand, QTD_PLAYERS);
    }
}

/**
    Retorna a posição do próximo jogador com base no array de jogadores.
**/
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
    Exibe as ações que um usuário pode realizar em sua vez. lastBet round position qtd
**/
void showUserActions(int round, int playerPosition) {
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

    selectActionOption(getOption(), round, playerPosition);
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
void selectActionOption(int option, int round, int playerPosition) {
    switch(option) {
        case 1:
            checkPlayerAction(round, playerPosition, bigBet);
            break;
        case 2:
            betPlayerAction(playerPosition);
            break;
        case 3:
            callPlayerAction(playerPosition);
            break;
        case 4:
            raisePlayerAction(playerPosition);
            break;
        case 5:
            foldAction(playerPosition);
            break;
        case 6:
            exitAction();
            break;
        default:
            break;
    }
}

/**
 * Ligações entre menu de seleção e métodos de ação
**/
void checkPlayerAction(int round, int position, int bigBet){
    if(!checkAction(round, position, bigBet)){
        cout << "Ação inválida!";
    }
}

void betPlayerAction(int position){
    int value;
    cout << "Digite a quantia que você deseja apostar: ";
    cin >> value;

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
    cout << "Digite a quantia que você deseja aumentar na aposta: ";
    cin >> value;

    if(!raiseAction(position, value)){
        cout << "Ação inválida!";
    }
}

/**
    Realiza a ação de 'Mesa' (Passar a vez).
**/
bool checkAction(int round, int position, int bigBet) {
    if(!(round == 0 && playersTable[position].role == 'B' && bigBet == lastBet) || lastBet != 0) {
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