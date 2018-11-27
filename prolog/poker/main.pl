:- use_module('table.pl').
:- initialization(main).


clear_screen :-
    tty_clear.


pause :-
    get_char(_),
    clear_screen.


input_number(Option) :-
    read_line_to_codes(user_input, Codes),
    string_to_atom(Codes, Atom),
    atom_number(Atom, Option).


show_title :-
    clear_screen,
    writeln("\n\n               $$$$$$$\134   $$$$$$\134  $$\134   $$\134 $$$$$$$$\134 $$$$$$$\134"),
    writeln("               $$  __$$\134 $$  __$$\134 $$ | $$  |$$  _____|$$  __$$\134"),
    writeln("               $$ |  $$ |$$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |"),
    writeln("               $$$$$$$  |$$ |  $$ |$$$$$  /  $$$$$\134    $$$$$$$  |"),
    writeln("               $$  ____/ $$ |  $$ |$$  $$<   $$  __|   $$  __$$< "),
    writeln("               $$ |      $$ |  $$ |$$ |\134$$\134  $$ |      $$ |  $$ |"),
    writeln("               $$ |       $$$$$$  |$$ | \134$$\134 $$$$$$$$\134 $$ |  $$ |"),
    writeln("               \134__|       \134______/ \134__|  \134__|\134________|\134__|  \134__|"),
    writeln("\n\n                                  Carregando..."),
    sleep(3).


get_option(Option) :-
    write("\n\n                    Informe o número da opção desejada: "),
    input_number(Option).


show_menu :-
    clear_screen,
    writeln("---------------------------------     MENU     ---------------------------------\n"),
    writeln("           1  -  Modos de jogo"),
    writeln("           2  -  Regras"),
    writeln("           3  -  Sair"),
    get_option(Option),
    select_menu_option(Option).


show_game_modes_menu :-
    clear_screen,
    writeln("-----------------------------     MODOS DE JOGO     -----------------------------\n"),
    writeln("          1  -  Partida Casual"),
    writeln("          2  -  Modo Aprendizado"),
    writeln("          3  -  Voltar"),
    get_option(Option),
    select_game_mode_option(Option).


show_rules :- 
    clear_screen,
    writeln("\n----------------------------------     REGRAS     --------------------------------\n\n"),
    writeln("------------------------------  LIMIT TEXAS HOLD'EM  -----------------------------\n"),
    writeln("As apostas no Limit são valores estruturados e pré-determinados.\n"),
    writeln("No pré-flop e no flop, todas as apostas e raises são do mesmo valor do big blind.\n"),
    writeln("No turn e no river, o tamanho de todas as apostas e raises é dobrado.\n\n"),
    writeln("-----------------------------------    MECANICA    -------------------------------\n"),
    writeln("O botão de Dealer gira ao longo da partida de forma a alternar as posições na mesa.\n"),
    writeln("O botão de Small Blind determina quem inicia com a menor aposta obrigatoria.\n"),
    writeln("O botão de Big Blind determina quem inicia com a maior aposta obrigatoria.\n"),
    writeln("O valor do Small Blind é 2 e do Big Blind é 4.\n"),
    writeln("O jogador sempre sera o player1.\n\n"),
    writeln("------------------------------------    AÇÕES     --------------------------------\n"),
    writeln("                               CALL: cobrir uma aposta.\n"),
    writeln("                               CHECK: passar a vez.\n"),
    writeln("                               FOLD: desistir.\n\n"),
    writeln("-----------------------------------     TURNOS     --------------------------------\n"),
    writeln("PRE-FLOP: O Dealer é escolhido através de sorteio e cada jogador recebe 2 cartas.\n"),
    writeln("FLOP: O Crupier coloca 3 cartas na mesa.\n"),
    writeln("TURN: O Crupier coloca 1 carta na mesa\n"),
    writeln("RIVER: O Crupier coloca 1 carta na mesa\n\n\n"),
    writeln("                         [ Pressione ENTER para voltar ]\n"),
    pause,
    show_menu.


quit :-
    clear_screen,
    writeln("\n\n                                    Até mais!"),
    writeln("\n\n\n             Paradigmas de Linguagem de Programação - 2018.2 - UFCG"),
    writeln("\n\n\n                                DESENVOLVIDO POR:"),
    writeln("\n\n                              Arthur de Lima Ferrão"),
    writeln("                           Eddie Kaleb Lopes Fernandes"),
    writeln("                             Gabriel de Sousa Barros"),
    writeln("                        Marcus Vinícius de Farias Barbosa"),
    writeln("                              Rayla Medeiros Araújo"),
    sleep(3).


show_invalid_option_message :-
    writeln("           Opção inválida... Pressione ENTER para tentar novamente!\n"),
    pause.


select_menu_option(1) :- show_game_modes_menu.
select_menu_option(2) :- show_rules.
select_menu_option(3) :- quit.
select_menu_option(_) :- show_invalid_option_message, show_menu.


select_game_mode_option(1) :- casual_match, show_menu.
select_game_mode_option(2) :- manual_match, show_menu.
select_game_mode_option(3) :- show_menu.
select_game_mode_option(_) :- show_invalid_option_message, show_game_modes_menu.


casual_match :- 
    clear_screen,
    writeln("\n\n                    O JOGO VAI COMEÇAR !!!!"),
    writeln("\n\n                 você jogará como o player 1"),
    sleep(3),
    start_game.


manual_match :-
    clear_screen,
    writeln("\n\n                    O JOGO VAI COMEÇAR !!!!"),
    writeln("\n\n                 você jogará como o player 1"),
    sleep(3),
    start_game_manual.

main :-
    show_title,
    show_menu.