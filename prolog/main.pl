clear_screen :-
    tty_clear.



input_number(Option) :-
    read_line_to_codes(user_input, Codes),
    string_to_atom(Codes, Atom),
    atom_number(Atom, Option).



show_title :-
    clear_screen,
    writeln("               $$$$$$$\134   $$$$$$\134  $$\134   $$\134 $$$$$$$$\134 $$$$$$$\134"),
    writeln("               $$  __$$\134 $$  __$$\134 $$ | $$  |$$  _____|$$  __$$\134"),
    writeln("               $$ |  $$ |$$ /  $$ |$$ |$$  / $$ |      $$ |  $$ |"),
    writeln("               $$$$$$$  |$$ |  $$ |$$$$$  /  $$$$$\134    $$$$$$$  |"),
    writeln("               $$  ____/ $$ |  $$ |$$  $$<   $$  __|   $$  __$$< "),
    writeln("               $$ |      $$ |  $$ |$$ |\134$$\134  $$ |      $$ |  $$ |"),
    writeln("               $$ |       $$$$$$  |$$ | \134$$\134 $$$$$$$$\134 $$ |  $$ |"),
    writeln("               \134__|       \134______/ \134__|  \134__|\134________|\134__|  \134__|"),
    writeln("                                  Carregando..."),
    sleep(3).



show_menu :-
    clear_screen,
    writeln("---------------------------------     MENU     ---------------------------------"),
    writeln("           1  -  Modos de jogo"),
    writeln("           2  -  Regras"),
    writeln("           3  -  Sair"),
    get_option(Option),
    select_menu_option(Option).



select_menu_option(1) :- writeln("Exibir os modos de jogo ...").
select_menu_option(2) :- writeln("Exibir as regras ...").
select_menu_option(3) :- writeln("Sair ...").
select_menu_option(_) :- writeln("Exibir opção inválida ...").



get_option(Option) :-
    write("\n\n                    Informe o número da opção desejada: "),
    input_number(Option).



:- initialization(main).

main :-
    show_title,
    show_menu.