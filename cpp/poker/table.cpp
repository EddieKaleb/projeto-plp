#include "hands.cpp"
#include <cstdlib>
#include <string>
#include <iostream> 
#include <time.h> 

void enablePlayers();
void disablePlayer(int position);
void startGame();
void setPlayersChips();
void setPlayersCards();
void setPlayersCardsManual(card card1, card card2);
void setPlayersRoles(int dealerPosition);
int nextPlayerPosition(int currentPos);
void showTable(int playerPosition);
void showUserActions(int round, int currentPosition);
void selectActionOption(int option, int round, int playerPosition);
bool checkAction(int round);
bool callAction(int position);
void foldAction(int position);
void exitAction();
void clearScreen();
int getOption();
void setInitialDealerPosition();
void setNextDealerPosition();
void setPlayersPreFlopProb();
void checkPlayerAction(int round);
void callPlayerAction(int position);
void preFlopRound();
void flopRound();
void turnRound();
void riverRound();
void flopRoundManual();
void turnRoundManual();
void riverRoundManual();
void runRound(int beginPosition, int round);
void runPreFlopRound(int beginPosition, int endPosition, int round);
void startGameManualMatch();
void flopRoundManual();
void selectFlopCards();
void selectCardHand();
card configCardHand(card card1, string message);
bool isValidCard(card card1);
void cardInvalidMessage();
void setCardsTable();

/* Métodos que controlam o comportamento dos bots */
void setPlayersPreFlopProb();
void setPlayersFlopToTurnProb();
void setPlayersTurnToRiverProb();
void setPlayersRiverToShowDown();
void botsPreFlop();
void botsFlop();
void botsTurn();
void botsRiver();
void setRaiseOtherwiseCall(player plyr, int prob);
void setFoldOtherwiseCall(player plyr, int prob);
float getImproveHandProb(string hand);
float getImproveProb(int outs);
float getRandomProb();
void botActions(int round, int playerPosition);
int getActivePlayers();
void wait(int time);
int mapHands(string value);
void setRoundsWinners();
void showUserProfile();

void clearScreen() {
    system("clear");
}

void wait (int seconds) {
  clock_t endwait;
  endwait = clock () + seconds * CLOCKS_PER_SEC ;
  while (clock() < endwait) {}
}

// Quantidade de jogadores na mesa
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

string USER_ACTION;

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
    Posição do primeiro jogador a apostar.
**/
int firstBetPlayerPosition = 0;

/**
    Indica a escolha do jogador para sair da partida
**/
bool returnMenu = false;

void setCardsTable() {
    for(int i = 0; i < 5; i++){
        cardsTable[i].value = ' ';
        cardsTable[i].naipe = ' ';
    }
}

/**
    Verifica se foi possivel achar e dá shift na carta desejada
**/
bool getCardPlayer(card cardPlayer){
    bool verify = false;
    for(int i = 0; i <= contCard; i++){
        if(deck[i].value == cardPlayer.value && deck[i].naipe == cardPlayer.naipe){
            shift(cardsTable, i, 51);
            contCard--;
            verify = true;
            break;
        }
    }
    return verify;
}

/**
    Ativa todos os usuários.
**/
void enablePlayers(){
    for(int i = 0; i < QTD_PLAYERS; i++){
        playersTable[i].active = true;
    }
}

/**
    Desativar determinado usuário.
**/
void disablePlayer(int position){
    playersTable[position].active = false;
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
        setCardsTable();
        shuffleDeck();
        setPlayersCards();

        setNextDealerPosition();
        setPlayersRoles(DEALER_POSITION);
        enablePlayers();

        POT = 0;
         
        /**
            Controla os quartro turnos do jogo: pre-flop, flop, turn e river.
        **/
        for(int i = 0; i < 4; i++) {

            lastBet = 0;
            firstBetPlayerPosition = -1;

            if(i == 0) {
                preFlopRound();
            }
            else if(i == 1) {
                flopRound();
            }
            else if(i == 2) {
                turnRound();
            }
            else {
                riverRound();
            }

            if(returnMenu) {
                returnMenu = false;
                return;
            }
            cout << "ROUND: " << i << endl;
        }

        setRoundsWinners();
        wait(10);
        showUserProfile();
        wait(20);        
    }
}

void startGameManualMatch() {
    setPlayersChips();
    setInitialDealerPosition();

    /**
        Controlar a passagem do dealer, e executar enquanto o usuário não desiste, ou
        perde todas as fichas.
    **/
    while(true) {

        buildDeck();
        setCardsTable();
        shuffleDeck();

        selectCardHand();
        setNextDealerPosition();
        setPlayersRoles(DEALER_POSITION);
        enablePlayers();

        POT = 0;

        /**
            Controla os quartro turnos do jogo: pre-flop, flop, turn e river.
        **/
        for(int i = 0; i < 4; i++) {

            lastBet = 0;
            firstBetPlayerPosition = -1;

            if(i == 0) {
                preFlopRound();
            }
            else if(i == 1) {
                flopRoundManual();
            }
            else if(i == 2) {
                turnRoundManual();
            }
            else {
                riverRoundManual();
            }

            cout << "ROUND: " << i << endl;
        }

        setRoundsWinners();
        showUserProfile();
    }

    cout << "\n\n\n\n Novo Jogo \n";
}

void selectCardHand() {
    clearScreen();

    int option;

    cout << endl << " --- SELEÇÃO DAS CARTAS DA SUA MÃO --- " << endl;

    card card1 = configCardHand(card1, "primeira");
    card card2 = configCardHand(card2, "segunda");

    setPlayersCardsManual(card1, card2);
}

card configCardHand(card card1, string message) {
    bool validCard;
    do {
        cout << endl << "Digite o valor da " + message + " carta (2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A): " << endl;
        cin >> card1.value;

        cout << endl << "Digite o naipe da " + message + " carta (O, C, P, E): " << endl;
        cin >> card1.naipe;

        validCard = isValidCard(card1);
    } while(!validCard);

    cout << "Carta: " << card1.value << "  " << card1.naipe << endl;
    wait(2);

    return card1;
}

bool isValidCard(card card1) {
    if(!getCardPlayer(card1)) {
        cardInvalidMessage();
        return false;
    }
    return true;
}

void cardInvalidMessage() {
    cout << "                       Carta inválida... Selecione outra !" << endl;
    system("sleep 1s");
}

/**
    Realiza as operações necessárias do turno de pre-flop.
**/
void preFlopRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);
    int bigPosition = nextPlayerPosition(smallPosition);

    lastBet = MINIMUM_BET;

    botsPreFlop();

    callAction(smallPosition);

    MINIMUM_BET = MINIMUM_BET * 2;

    lastBet = MINIMUM_BET;

    callAction(bigPosition);

    runPreFlopRound(nextPlayerPosition(bigPosition), smallPosition, 0);
}

/**
    Realiza as operações necessárias do turno de flop.
**/
void flopRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    cardsTable[0] = getCard();
    cardsTable[1] = getCard();
    cardsTable[2] = getCard();

    botsFlop();

    runRound(smallPosition, 1);
}

void flopRoundManual() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    selectFlopCards();

    botsFlop();

    runRound(smallPosition, 1);
}

void selectFlopCards() {
    clearScreen();

    cout << endl << " --- SELEÇÃO DAS TRÊS PRIMEIRAS CARTAS DA MESA --- " << endl;

    card card1, card2, card3;

    card1 = configCardHand(card1, "primeira");
    card2 = configCardHand(card2, "segunda");
    card3 = configCardHand(card3, "terceira");

    cardsTable[0] = card1;
    cardsTable[1] = card2;
    cardsTable[2] = card3;
}

void selectTurnCard() {
    clearScreen();

    cout << endl << " --- SELEÇÃO DA CARTA DE TURN --- " << endl;

    card card;

    card = configCardHand(card, "");


    cardsTable[3] = card;
}

void selectRiverCard() {
    clearScreen();

    cout << endl << " --- SELEÇÃO DA CARTA DE RIVER --- " << endl;
    
    card card;
    
    card = configCardHand(card, "");

    cardsTable[4] = card;
}


/**
    Realiza as operações necessárias do turno de turn.
**/
void turnRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    cardsTable[3] = getCard();

    MINIMUM_BET = MINIMUM_BET * 2;

    botsTurn();

    runRound(smallPosition, 2);
}

void turnRoundManual() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    selectTurnCard();

    MINIMUM_BET = MINIMUM_BET * 2;

    botsTurn();

    runRound(smallPosition, 2);
}


/**
    Realiza as operações necessárias do turno de river.
**/
void riverRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    cardsTable[4] = getCard();

    botsRiver();

    runRound(smallPosition, 3);

    /** chamar método que compara as mãos e declarar o vencedor**/
}

void riverRoundManual() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);
    
    selectRiverCard();

    botsRiver();
    
    runRound(smallPosition, 3);
}

/**
    Executa uma rodada permitindo que todos os jogadores ativos na mesa façam suas ações.
**/
void runRound(int beginPosition, int round) {
    int currentPosition = beginPosition;
    firstBetPlayerPosition = beginPosition;

    if (getActivePlayers() >= 2) {

        while(true) {

            showTable(currentPosition);

            if (playersTable[currentPosition].active == true) {
                cout << "Jogando: Jogador " << currentPosition + 1<< endl;
                cout << "Jogadores ativos: " << getActivePlayers() << endl;

                if (currentPosition == USER_POSITION) {
                    showUserActions(round, currentPosition);
                } else {
                    // modo automatico
                    botActions(round, currentPosition);
                }
            }
            showTable(currentPosition);
            currentPosition = nextPlayerPosition(currentPosition);
            wait(5);

            if(currentPosition == firstBetPlayerPosition) {
                break;
            }
        }
    } 
}

/**
    Executa uma rodada permitindo que todos os jogadores ativos na mesa façam suas ações.
**/
void runPreFlopRound(int beginPosition, int endPosition, int round) {
    int currentPosition = beginPosition;

    if (getActivePlayers() >= 2) {
        do {

            showTable(currentPosition);

            if (playersTable[currentPosition].active == true) {
                cout << "Jogando: Player " << currentPosition + 1 << endl;
                cout << "Jogadores ativos: " << getActivePlayers() << endl;
                cout << "Última aposta: " << lastBet << endl;
                cout << "Aposta mínima: " << MINIMUM_BET << endl;
                wait(2);

                if (currentPosition == USER_POSITION) {
                    showUserActions(round, currentPosition);
                } else {
                    botActions(round, currentPosition);
                }
            }
            showTable(currentPosition);
            currentPosition = nextPlayerPosition(currentPosition);
            wait(3);
        } while(currentPosition != nextPlayerPosition(endPosition));
    } 
}

/*
    Retorna os players que ainda estão na partida
*/
int getActivePlayers() {
    int count = 0;
    for (int i = 0; i < QTD_PLAYERS; i++) {
        if (playersTable[i].active == true) {
            count++;
        }
    }
    return count;
}

void setRoundsWinners() {
    
    player winners[QTD_PLAYERS];
    player empty[QTD_PLAYERS];
    handStatus handWinners[QTD_PLAYERS];
    handStatus emptyHands[QTD_PLAYERS];

    int posWinners[QTD_PLAYERS];

    int betterHand = -1;
    int j = 0;

    for (int i = 0; i < QTD_PLAYERS; i++) {
        if (playersTable[i].active == true) {
            handStatus hStatus = verifyHand(playersTable[i].hand, cardsTable, 7);

            int handValue = mapHands(hStatus.flag);

            if (handValue > betterHand) { 
                betterHand = handValue;
                copyArrayPlayers(empty, winners, QTD_PLAYERS);
                copyArrayHandStatus(emptyHands, handWinners, QTD_PLAYERS);
                winners[0] = playersTable[i];
                handWinners[0] = hStatus;
                posWinners[0] = i;
                j = 1;
            } else if (handValue == betterHand) { 
                winners[j] = playersTable[i];
                posWinners[j] = i;                
                handWinners[j] = hStatus;                
                j++;
            }
        }
    }

    cout << "\n***********************" << endl;
    cout << "*      FINALISTAS     *" << endl;
    cout << "***********************\n" << endl;

    for (int i = 0; i < QTD_PLAYERS; i++) {
        if (playersTable[i].active == true) {
            cout << "- JOGADOR " << i + 1 << ":-> HAND: ";
            cout << playersTable[i].hand[0].value << playersTable[i].hand[0].naipe << " ";
            cout << playersTable[i].hand[1].value << playersTable[i].hand[1].naipe << endl << endl;
        }
    }

    cout << "\n***********************" << endl;
    cout << "*      VENCEDORES     *" << endl;
    cout << "***********************\n" << endl;
    
    int countCards = 0;

    int newChips = POT / j;
    for (int x = 0; x < j; x++) {

        playersTable[posWinners[x]].chips += newChips;

        cout << "- JOGADOR " << posWinners[x] + 1 << " " << handWinners[x].flag << " -> GAME: ";

        if (handWinners[x].flag == "HIGH_CARD") {
            countCards = 5;
        } else if (handWinners[x].flag == "IS_ONE_PAIR") {
            countCards = 2;
        } else if (handWinners[x].flag == "IS_TWO_PAIR" && handWinners[x].flag == "IS_FOUR") {
            countCards = 4;
        } else {
            countCards = 5;
        }
        for (int i = 0; i <= countCards; i++) {
            cout << handWinners[x].agroupCards[i].value << handWinners[x].agroupCards[i].naipe << " ";
        }   

        cout << endl;
    }
}

int mapHands(string value){
    string hands[] = {
        "IS_HIGH_CARD","IS_ONE_PAIR","IS_TWO_PAIR","IS_THREE",
        "IS_STRAIGHT","IS_FLUSH","IS_FULL_HOUSE","IS_FOUR",
        "IS_STRAIGHT_FLUSH","IS_ROYAL_FLUSH"
    };
    
    for(int i = 0; i < 10; i++){
        if(hands[i] == value){
            return i+1;
        }
    }
    return 0;
}

/**
    Configura as fichas dos jogadores.
**/
void setPlayersChips() {
    for(int i = 0; i < QTD_PLAYERS; i++) {
        playersTable[i].chips = 200;
    }
}

/**
    Configura as cartas dos jogadores.
**/
void setPlayersCards() {
    for(int i = 0; i < QTD_PLAYERS; i++) {
        for(int j = 0; j < 2; j++) {
            playersTable[i].hand[j] = getCard();
        }
    }
}

void setPlayersCardsManual(card card1, card card2) {
    playersTable[0].hand[0] = card1;
    playersTable[0].hand[1] = card2;
    for(int i = 1; i < QTD_PLAYERS; i++) {
        for(int j = 0; j < 2; j++) {
            playersTable[i].hand[j] = getCard();
        }
    }
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
    cout << "LOG: PROBABILIDADES PRÉ-FLOP" << endl;
    for (int i = 0; i < QTD_PLAYERS; i++) {
        cout << "PLAYER " << i + 1 << " ";
        playersTable[i].preFlopProb = getPreFlopProb(playersTable[i].hand, QTD_PLAYERS);
        cout << playersTable[i].preFlopProb << endl;
    }
}

void setPlayersFlopToTurnProb() {
    cout << "LOG: PROBABILIDADES TURN" << endl;
    for (int i = 0; i < QTD_PLAYERS; i++) {
        cout << "PLAYER " << i + 1 << " ";
        handStatus hand = verifyHand(playersTable[i].hand, cardsTable, 5);
        playersTable[i].flopToTurnProb = playersTable[i].preFlopProb * (1 - getImproveHandProb(hand.flag));
        cout << playersTable[i].flopToTurnProb << "%" << endl;
    }
}

void setPlayersTurnToRiverProb() {
    cout << "LOG: PROBABILIDADES RIVER" << endl;
    for (int i = 0; i < QTD_PLAYERS; i++) {
        cout << "PLAYER " << i + 1 << " ";
        handStatus hand = verifyHand(playersTable[i].hand, cardsTable, 6);
        playersTable[i].turnToRiverProb = playersTable[i].flopToTurnProb * (1 - getImproveHandProb(hand.flag));
        cout << playersTable[i].turnToRiverProb << "%" << endl;
    }
}

void setPlayersRiverToShowDown() {
    cout << "LOG: PROBABILIDADES SHOWDOWN" << endl;
    for (int i = 0; i < QTD_PLAYERS; i++) {
        cout << "PLAYER " << i + 1 << " ";
        handStatus hand = verifyHand(playersTable[i].hand, cardsTable, 7);
        playersTable[i].riverToShowDownProb = playersTable[i].turnToRiverProb * (1 - getImproveHandProb(hand.flag));
        cout << playersTable[i].riverToShowDownProb << "%" << endl;
    }
}

void botsPreFlop() {
    setPlayersPreFlopProb();
}

void botsFlop() {
    setPlayersFlopToTurnProb();
}

void botsTurn() {
    setPlayersTurnToRiverProb();
}

void botsRiver() {
    setPlayersRiverToShowDown();
}

/**
    Probabilidade de melhorar a mão do flop ao river
**/
float getImproveHandProb(string hand) { 
    int outs;

    if (hand == "IS_ONE_PAIR"){ // TRINCA (2) OU DOIS PARES (3)
        outs = 5;
    } else if (hand == "IS_TWO_PAIR") { // FULL HOUSE (4)
        outs = 4;
    } else if (hand == "IS_THREE") { // QUADRA (1) OU FULL HOUSE (7)
        outs = 8;
    } else if (hand == "IS_STRAIGHT") { // DRAW ROYAL FLUSH (1)
        outs = 1;
    } else if (hand == "IS_FLUSH") { // DRAW STRAIGHT FLUSH (2)
        outs = 2;
    } else if (hand == "IS_FULL_HOUSE") { // QUADRA
        outs = 1;
    } else if (hand == "IS_FOUR") {
        outs = 0;
    } else if (hand == "IS_STRAIGHT_FLUSH") {
        outs = 0;
    } else if (hand == "IS_ROYAL_FLUSH") {
        outs = 0;
    } else { // HIGH CARD QUALQUER PAR (3 * 5)
        hand = "IS_HIGH_CARD";
        outs = 15;
    }

    cout << hand << " ";

    float prob = getImproveProb(outs) / 100;

    return prob;
}

/**
    Gera uma probabilidade aleatória
**/
float getRandomProb() {
    return rand() % 3;
}

/**
    Calcula a probabilidade no flop (47 odds) até o river
**/
float getImproveProb(int outs) {
    return (outs * 4) - (outs - 8);
}

// Retorna a posição do próximo jogador com base no array de jogadores.
int nextPlayerPosition(int currentPos) {
    return (currentPos + 1) % QTD_PLAYERS;
}

/**
    Exibe a representação da mesa.
**/
void showTable(int playerPosition) {
    clearScreen();
    printTable(playersTable, cardsTable, POT, playerPosition);
}

/**
    Exibe as ações que um usuário pode realizar em sua vez. lastBet round position qtd
**/
void showUserActions(int round, int playerPosition) {

    cout << endl;
    cout << "-----------------------------     AÇÕES     -----------------------------";
    cout << endl << endl;

    cout << "          1  -  Mesa" << endl;
    cout << "          2  -  Apostar" << endl;
    cout << "          3  -  Desistir" << endl;
    cout << "          4  -  Sair da mesa" << endl;

    selectActionOption(getOption(), round, playerPosition);
}

/**
    Interpreta a ação selecionada pelo usuário.
**/
void selectActionOption(int option, int round, int playerPosition) {
    if(option == 1) {
        checkPlayerAction(round);
    }
    else if(option == 2) {
        callPlayerAction(playerPosition);
    }
    else if(option == 3) {
        foldAction(playerPosition);
    }
    else if(option == 4) {
        exitAction();
    }
    else {

    }
}

/**

**/
void botActions(int round, int playerPosition) {

    float win_prob;
    int r1 = getRandomProb();
    int r2 = getRandomProb();
    
    cout << "RANDOM PROB 1: " << r1 << "%" << endl;
    cout << "RANDOM PROB 2: " << r2 << "%" << endl;

    if (round == 0) {
        cout << "ROUND: 0" << endl;

        if(playersTable[playerPosition].role != 'B') {
            win_prob = playersTable[playerPosition].preFlopProb * 1.15;

            cout << "WIN PROB: " << win_prob << "%" << endl;
            if(r1 > ((win_prob / 10) * 1.15)) {
                foldAction(playerPosition);
                cout << "ACTION: FOLD" << endl;
            }
            else {
                if(!callAction(playerPosition)){
                    POT += playersTable[playerPosition].chips;
                    foldAction(playerPosition);
                    cout << "ACTION: FOLD" << endl;
                } else {
                    cout << "ACTION: CALL" << endl;
                }
            }
        }
    } else if (round <= 3) {
        cout << "ROUND: " << round << endl;

        win_prob = playersTable[playerPosition].flopToTurnProb;
        
        cout << "WIN PROB: " << win_prob << "%" << endl;
        if(r1 > ((win_prob / 10) * 1.15)) {
            foldAction(playerPosition);
            cout << "ACTION: FOLD" << endl;
        } else {
            if (lastBet != 0) {
                if(!callAction(playerPosition)) {
                    POT += playersTable[playerPosition].chips;
                    foldAction(playerPosition);
                    cout << "ACTION: FOLD" << endl;
                } else {
                    cout << "ACTION: CALL" << endl;
                }
            } else {
                
                if (r2 > ((win_prob / 10) * 1.15)) {
                    if (!callAction(playerPosition)) {
                        POT += playersTable[playerPosition].chips;
                        foldAction(playerPosition);
                        cout << "ACTION: FOLD" << endl;
                    } else {
                        cout << "ACTION: CALL" << endl;
                    }
                } else {
                    checkAction(playerPosition);
                    cout << "ACTION: CHECK" << endl;                    
                }
            }
        }
    }

    wait(5);
}

/**
 * Ligações entre menu de seleção e métodos de ação
**/
void checkPlayerAction(int round){
    if(!checkAction(round)){
        cout << "Ação inválida!";
    }
}

void callPlayerAction(int position){
    if(!callAction(position)){
        cout << "Ação inválida!";
    }
}

/**
    Realiza a ação de 'Mesa' (Passar a vez).
**/
bool checkAction(int round) {
    if(round != 0 && lastBet == 0) {
        return true;
    }

    return false;
}

/**
    Realiza a ação de 'Pagar'.
**/
bool callAction(int position) {
    if(playersTable[position].chips >= MINIMUM_BET){
        lastBet = MINIMUM_BET;
        if(lastBet == 0){
            firstBetPlayerPosition = position;
        }

        playersTable[position].chips -= MINIMUM_BET;
        POT += MINIMUM_BET;

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
    Realiza a ação de 'Sair' da mesa.showTable
**/
void exitAction() {
    returnMenu = true;
}

void showUserProfile() {
    string profile = "\n\n        .------..------..------..------..------..------.\n";
    profile += "        |P.--. ||E.--. ||R.--. ||F.--. ||I.--. ||L.--. |\n";
    profile += "        | :/\134: || (\134/) || :(): || :(): || (\134/) || :/\134: |\n";
    profile += "        | (__) || :\134/: || ()() || ()() || :\134/: || (__) |\n";
    profile += "        | '--'P|| '--'E|| '--'R|| '--'F|| '--'I|| '--'L|\n";
    profile += "        `------'`------'`------'`------'`------'`------'\n\n\n";
    profile += "PERFIS POSSÍVEIS \n\n[-] MUITO AGRESSIVO [-] AGRESSIVO [+] MUITO MODERADO [+] MODERADO\n\n\n";
    float average_prob = 
        (playersTable[0].preFlopProb + playersTable[0].flopToTurnProb + 
        playersTable[0].turnToRiverProb + playersTable[0].riverToShowDownProb) / 4;
    float average_pot = POT / 4;
    // MÃO NÃO MELHOROU AO LONGO DOS TURNOS
    if (average_prob < playersTable[0].flopToTurnProb) {
    
        // USUARIO COM POUCAS FICHAS 
        if (playersTable[0].chips < average_pot) {
            profile += "Seu perfil é MUITO AGRESSIVO, no geral sua probabilidade\n";
            profile += "de vitória não melhorou em relação a sua probabilidade no \nFLOP ";
            profile += "e suas fichas estão abaixo da média do pote.";
        } else {
            profile += "Seu perfil é AGRESSIVO, no geral sua probabilidade\n";
            profile += "de vitória não melhorou em relação a sua probabilidade \n no FLOP,\n";
            profile += "mas suas fichas estão acima da média do pote.";
        }
    // MÃO MELHOROU AO LONGO DOS TURNOS    
    } else {
        // USUARIO COM POUCAS FICHAS 
        if (playersTable[0].chips < average_pot) {
            profile += "Seu perfil é MUITO MODERADO, no geral sua probabilidade\n"; 
            profile += "de vitória melhorou em relação a sua probabilidade no FLOP,\n";
            profile += "mas suas fichas estão abaixo da média do pote"; 
        } else {
            profile += "Seu perfil é MODERADO, no geral sua probabilidade\n"; 
            profile += "de vitória melhorou em relação a sua probabilidade no FLOP\n";  
            profile += "e suas fichas estão acima da média do pote";
        }
    }


    profile += "\n\nPROBABILIDADES \n\n";

    cout << profile << endl;

   cout << "* PRÉ-FLOP ---> " << playersTable[0].preFlopProb << "%\n";
   cout << "* FLOP -------> " << playersTable[0].flopToTurnProb << "%\n";
   cout << "* TURN -------> " << playersTable[0].turnToRiverProb << "%\n";
   cout << "* RIVER ------> " << playersTable[0].riverToShowDownProb << "%\n\n";
} 

void copyArrayHandStatus (handStatus current[], handStatus* target, int quantHands){
  for(int i = 0; i < quantHands; i++){
    target[i] = current[i];
  }
}