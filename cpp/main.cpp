#include <iostream>
#include <string>
#include "./poker/table.cpp"
using namespace std;

void showMenu();
void showTitle();
void clearScreen();
int getOption();
void selectMenuOption(int option);
void showGameModesMenu();
void selectGameModeOption(int option);
void quit();
void showRules();
void pause();
void showRanking();

void clearScreen() {
    system("clear");
}

void showTitle() {
    cout << endl;
    cout << "               $$$$$$$\134   $$$$$$\134  $$\134   $$\134 $$$$$$$$\134 $$$$$$$\134"  << endl;
    cout << "               $$  __$$\134 $$  __$$\134 $$ | $$  |$$  _____|$$  __$$\134" << endl;
    cout << "               $$ |  $$ |$$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |" << endl;
    cout << "               $$$$$$$  |$$ |  $$ |$$$$$  /  $$$$$\134    $$$$$$$  |" << endl;
    cout << "               $$  ____/ $$ |  $$ |$$  $$<   $$  __|   $$  __$$< " << endl;
    cout << "               $$ |      $$ |  $$ |$$ |\134$$\134  $$ |      $$ |  $$ |" << endl;
    cout << "               $$ |       $$$$$$  |$$ | \134$$\134 $$$$$$$$\134 $$ |  $$ |" << endl;
    cout << "               \134__|       \134______/ \134__|  \134__|\134________|\134__|  \134__|" << endl;
    cout << endl;
    cout << "                                  Carregando..." << endl;

    system("sleep 2s");
}

void showMenu() {
    clearScreen();

    cout << endl;
    cout << "---------------------------------     MENU     ---------------------------------";
    cout << endl << endl;

    cout << "           1  -  Modos de jogo" << endl;
    cout << "           2  -  Regras" << endl;
    cout << "           3  -  Sair" << endl;

    selectMenuOption(getOption());
}

int getOption() {
    int option;

    cout << endl << "           Digite o número da opção desejada: ";
    cin >> option;

    return option;
}

void selectMenuOption(int option) {
    switch(option) {
        case 1:
            showGameModesMenu();
            break;
        case 2:
            showRules();
            break;
        case 3:
            quit();
            break;
        default:
            break;
    }
}

void showGameModesMenu() {
     clearScreen();

     cout << endl;
     cout << "-----------------------------     MODOS DE JOGO     -----------------------------";
     cout << endl << endl;

     cout << "          1  -  Partida Casual" << endl;
     cout << "          2  -  Modo Aprendizado" << endl;
     cout << "          3  -  Voltar" << endl;

     selectGameModeOption(getOption());
}

void selectGameModeOption(int option) {
    switch(option) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
}

void showRules() {
    clearScreen();

    cout << endl;
    cout << "-----------------------------     REGRAS     -----------------------------";
    cout << endl << endl;

    cout << "                         [ Pressione ENTER para voltar ]" << endl;

    pause();
}

void pause() {
    cin.ignore();
    getchar();
}

void quit() {
    clearScreen();

    cout << endl << endl;

    cout << "                                    Até mais!";
    cout << endl << endl << endl;

    cout << "             Paradigmas de Linguagem de Programação - 2018.2 - UFCG";
    cout << endl << endl << endl;

    cout << "                                DESENVOLVIDO POR:";
    cout << endl << endl;

    cout << "                              Arthur de Lima Ferrão" << endl;
    cout << "                           Eddie Kaleb Lopes Fernandes" << endl;
    cout << "                             Gabriel de Sousa Barros" << endl;
    cout << "                        Marcus Vinícius de Farias Barbosa" << endl;
    cout << "                              Rayla Medeiros Araújo" << endl;
    cout << endl << endl;

    exit(1);
}

int main() {

    showTitle();

    while(true) {
        showMenu();
    }

    return 0;
}

string getUserProfile() {

    string profile = "\n\n        .------..------..------..------..------..------.\n";
    profile += "        |P.--. ||E.--. ||R.--. ||F.--. ||I.--. ||L.--. |\n";
    profile += "        | :/\134: || (\134/) || :(): || :(): || (\134/) || :/\134: |\n";
    profile += "        | (__) || :\134/: || ()() || ()() || :\134/: || (__) |\n";
    profile += "        | '--'P|| '--'E|| '--'R|| '--'F|| '--'I|| '--'L|\n";
    profile += "        `------'`------'`------'`------'`------'`------'\n\n\n";

    profile += "PERFIS POSSÍVEIS \n\n[-] MUITO AGRESSIVO [-] AGRESSIVO [+] MUITO MODERADO [+] MODERADO\n\n\n";

    float average_prob = 45;

    float average_pot = 190 / 4;

    // MÃO NÃO MELHOROU AO LONGO DOS TURNOS
    if (average_prob < 47) {
    
        // USUARIO COM POUCAS FICHAS 
        if (40 < average_pot) {
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
        if (40 < average_pot) {
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
    profile += "* PRÉ-FLOP ---> 10%\n";
    profile += "* FLOP -------> 20%\n";
    profile += "* TURN -------> 30%\n";
    profile += "* RIVER ------> 40%\n\n";

  return profile;
}