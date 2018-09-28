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
void setPlayersRoles(int dealerPosition);
int nextPlayerPosition(int currentPos);
void showTable();
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
void runRound(int beginPosition, int round);
void runPreFlopRound(int beginPosition, int endPosition, int round);

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

            cout << "ROUND: " << i << endl;
        }

        setRoundsWinners();
        showUserProfile();
    }

    cout << "\n\n\n\n Novo Jogo \n";
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

    MINIMUM_BET *= 2;

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

/**
    Realiza as operações necessárias do turno de turn.
**/
void turnRound() {
    int smallPosition = nextPlayerPosition(DEALER_POSITION);

    cardsTable[3] = getCard();

    MINIMUM_BET *= 2;

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

/**
    Executa uma rodada permitindo que todos os jogadores ativos na mesa façam suas ações.
**/
void runRound(int beginPosition, int round) {
    int currentPosition = beginPosition;

    if (getActivePlayers() >= 2) {

        while(true) {

            showTable();

            if (playersTable[currentPosition].active == true) {
                cout << "Jogando: Jogador " << currentPosition + 1<< endl;
                wait(1);

                if (currentPosition == USER_POSITION) {
                    showUserActions(round, currentPosition);
                } else {
                    botActions(round, currentPosition);
                }
            }
            currentPosition = nextPlayerPosition(currentPosition);
            showTable();
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

            showTable();

            if (playersTable[currentPosition].active == true) {
                cout << "Jogando: Jogador " << currentPosition + 1<< endl;
                wait(1);

                if (currentPosition == USER_POSITION) {
                    showUserActions(round, currentPosition);
                } else {
                    botActions(round, currentPosition);
                }
            }
            currentPosition = nextPlayerPosition(currentPosition);
            showTable();
            wait(5);
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
    
    int betterHand = -1;
    int j = 0;

    for (int i = 0; i < QTD_PLAYERS; i++) {
        if (playersTable[i].active == true) {

            handStatus hStatus = verifyHand(playersTable[i].hand, cardsTable, 7);

            int handValue = mapHands(hStatus.flag);

            if (handValue > betterHand) { 
                betterHand = handValue;
                copyArrayPlayers(empty, winners, QTD_PLAYERS);
                winners[0] = playersTable[i];
                j = 1;
            } else if (handValue == betterHand) { // empate
                winners[j] = playersTable[i];
                j++;
            }
        }
    }

    for (int x = 0; x < j; x++) {
        cout << winners[x].hand << endl;
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
    return (rand() % 11) / 100;
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
void showTable() {
    clearScreen();
    printTable(playersTable, cardsTable, POT);
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

    if (round == 0) {
        if(playersTable[playerPosition].role != 'B') {
            win_prob = playersTable[playerPosition].preFlopProb;
            if(getRandomProb() > (win_prob * 10)) {
                foldAction(playerPosition);
            }
            else {
                if(!callAction(playerPosition)){
                    POT += playersTable[playerPosition].chips;
                    foldAction(playerPosition);
                }
            }
        }
    } else if (round <= 3) {
        win_prob = playersTable[playerPosition].flopToTurnProb;
        
        if(getRandomProb() > (win_prob * 10)) {
            foldAction(playerPosition);
        } else {
            if (lastBet != 0) {
                if(!callAction(playerPosition)){
                    POT += playersTable[playerPosition].chips;
                    foldAction(playerPosition);
                }
            } else {
                if (getRandomProb() > (win_prob * 10)) {
                    callAction(playerPosition);
                } else {
                    checkAction(playerPosition);
                }
            }
        }
    }
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
        if(lastBet = 0){
            lastBet = MINIMUM_BET;
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
