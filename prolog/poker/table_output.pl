:- module(table_output, [printTable/0]).
:- initialization(main).
:- use_module('game_status.pl').
:- use_module('players.pl').

printNTimes(S, N) :-
    N < 1 -> true;
    write(S),
    N0 is (N - 1),
    printNTimes(S, N0).

topBorder :-
    write("/"),
    printNTimes("-", 90),
    write("\\\n").

bottomBorder :-
    write("\\"),
    printNTimes("-", 12),
    write("T"),
    printNTimes("-", 77),
    write("/\n").

lateralBorders(N):-
    N < 1 -> true;
    write("|"),
    spaces(90),
    write("|\n"),
    N0 is N - 1,
    lateralBorders(N0).

spaces(N):-
    printNTimes(" ", N).

centralSpaces:-
    spaces(64).

centralCardSpaces:-
    spaces(40).

lateralSpaces:-
    spaces(3).

cardTop:-
    write("/"),
    printNTimes("-",3),
    write("\\").

nCardTops(N):-
    N == 0 -> true;
    cardTop,
    N0 is N - 1,
    nCardTops(N0).

cardLateral:-
    write("|"),
    spaces(3),
    write("|").

cardLateralValue(Value):-
    write("|"),
    formatInfo(Value, FormatedInfo),
    write(FormatedInfo),
    write("|").

formatInfo("T", "10 "). 
formatInfo(I, S):-
    atom_concat(I, "  ", S).


nCardLaterals(N):-
    N == 0 -> true;
    cardLateral,
    N0 is N - 1,
    nCardLaterals(N0).

cardBottom:-
    write("\\"),
    printNTimes("-",3),
    write("/").

nCardBottoms(N):-
    N == 0 -> true;
    cardBottom,
    N0 is N - 1,
    nCardBottoms(N0).

centralCards:-
    write("|"),
    centralCardSpaces,
    nCardTops(2),
    centralCardSpaces,
    write("|\n"),

    write("|"),
    centralCardSpaces,
    nCardLaterals(2),
    centralCardSpaces,
    write("|\n"),

    write("|"),
    centralCardSpaces,
    nCardLaterals(2),
    centralCardSpaces,
    write("|\n"),

    write("|"),
    centralCardSpaces,
    nCardBottoms(2),
    centralCardSpaces,
    write("|\n").

centralCardsWithProb(Prob):-
    write("|"),

    centralCardSpaces,
    nCardTops(2),
    centralCardSpaces,

    write("|\n"),
    
    get_player_cards(0, Card1, Card2),
    
    write("|"),
    centralCardSpaces,
    nth0(1, Card1, Value1),
    nth0(1, Card2, Value2),
    cardLateralValue(Value1),
    cardLateralValue(Value2),
    centralCardSpaces,
    write("|\n"),

    

    write("E"),
    printNTimes("-", 12),
    write("\\"),
    spaces(27),
    nth0(0, Card1, Naipe1),
    nth0(0, Card2, Naipe2),
    cardLateralValue(Naipe1),
    cardLateralValue(Naipe2),
    centralCardSpaces,
    write("|\n"),
   
    write("|"),
    write(" WIN: "),
    write(Prob),
    write("%"),
    numDigits(Prob, Ndigits),
    spaces(5 - Ndigits),
    write("|"),
    spaces(27),
    nCardBottoms(2),
    centralCardSpaces,
    write("|\n").

lateralCards:-
    write("|"),
    lateralSpaces,
    nCardTops(2),
    centralSpaces,
    nCardTops(2),
    lateralSpaces,
    write("|\n"),

    write("|"),
    lateralSpaces,
    nCardLaterals(2),
    centralSpaces,
    nCardLaterals(2),
    lateralSpaces,
    write("|\n"),

    write("|"),
    lateralSpaces,
    nCardLaterals(2),
    centralSpaces,
    nCardLaterals(2),
    lateralSpaces,
    write("|\n"),

    write("|"),
    lateralSpaces,
    nCardBottoms(2),
    centralSpaces,
    nCardBottoms(2),
    lateralSpaces,
    write("|\n").

flopTurnRiver:-
    write("|"),
    spaces(30),
    nCardTops(3),
    spaces(2),
    cardTop,
    spaces(2),
    cardTop,
    spaces(31),
    write("|\n"),

    cards_table(0, Naipe1, Value1),
    cards_table(1, Naipe2, Value2),
    cards_table(2, Naipe3, Value3),
    cards_table(3, Naipe4, Value4),
    cards_table(4, Naipe5, Value5),

    write("|"),
    spaces(30),
    cardLateralValue(Value1),
    cardLateralValue(Value2),
    cardLateralValue(Value3),
    spaces(2),
    cardLateralValue(Value4),
    spaces(2),
    cardLateralValue(Value5),
    spaces(31),
    write("|\n"),

    write("|"),
    spaces(30),
    cardLateralValue(Naipe1),
    cardLateralValue(Naipe2),
    cardLateralValue(Naipe3),
    spaces(2),
    cardLateralValue(Naipe4),
    spaces(2),
    cardLateralValue(Naipe5),
    spaces(31),
    write("|\n"),

    write("|"),
    spaces(30),
    nCardBottoms(3),
    spaces(2),
    cardBottom,
    spaces(2),
    cardBottom,
    spaces(31),
    write("|\n").

role("dealer", "(D)").
role("small", "(S)").
role("big", "(B)").
role(X, "   ").

playing(0, _, _):-write("X").
playing(1, X, X):- write("*").
playing(1, Player, X):- write(" ").

blinds(Player, Role):-
    dealer_position(D),
    Player == D -> Role = "dealer".

blinds(Player, Role):-
    small_position(S),
    Player == S -> Role = "small".

blinds(Player, Role):-
    big_position(B),
    Player == B -> Role = "big".

blinds(Player, Role):-
    Role = "none".


centralPlayer(Player, ActualPlayer):-
    write("|"),
    spaces(39),
    /**active*/
    PlayerId is Player - 1,
    get_player_active(PlayerId, Active),
    playing(Active, PlayerId, ActualPlayer),
    write("Player "),
    write(Player),
    /**role*/
    blinds(PlayerId, PlayerRole),
    role(PlayerRole, Role),
    write(Role),
    spaces(39),
    write("|\n"),

    write("|"),
    spaces(40),
    write("Chips: "),
    get_player_chips(PlayerId, Chips),
    write(Chips),
    numDigits(Chips, Ndigits),
    spaces(43 - Ndigits),
    write("|\n").

lateralPlayers(Player1, Player2, ActualPlayer):-
    write("|"),
    spaces(2),
    /**active*/
    PlayerId1 is Player1 - 1,
    get_player_active(PlayerId1, Active1),
    playing(Active1, PlayerId1, ActualPlayer), 
    write("Player "),
    write(Player1),
    /**role*/
    blinds(PlayerId1, Player1Role),
    role(Player1Role, Role1),
    write(Role1),
    spaces(58),

    PlayerId2 is Player2 - 1,
    get_player_active(PlayerId2, Active2),
    
    /**role*/
    spaces(2),
    blinds(PlayerId2, Player2Role),
    role(Player2Role, Role2),
    write(Role2),
    write("Player "),
    write(Player2),
    /**active*/
    playing(Active2, PlayerId2, ActualPlayer),
     
    spaces(4),
    write("|\n"),

    write("|"),
    lateralSpaces,
    write("Chips: "),
    get_player_chips(PlayerId1, Chips1),
    get_player_chips(PlayerId2, Chips2),
    write(Chips1),
    numDigits(Chips1, Ndigits1),
    numDigits(Chips2, Ndigits2),
    spaces(70 - Ndigits1 - Ndigits2),
    write("Chips: "),
    write(Chips2),
    lateralSpaces,
    write("|\n").

printPot:-
    write("|"),
    spaces(40),
    write("Pot: "),
    pot(Pot),
    write(Pot),
    numDigits(Pot, Ndigits),
    spaces(45 - Ndigits),
    write("|\n").

printTable:-
    actual_player(ActualPlayer),
    topBorder,
    centralCards,
    centralPlayer(4, ActualPlayer),
    lateralCards,
    lateralPlayers(3, 5, ActualPlayer),
    flopTurnRiver,
    printPot,
    lateralPlayers(2, 6, ActualPlayer),
    lateralCards,
    centralPlayer(1, ActualPlayer),
    centralCardsWithProb(30.0),
    bottomBorder.

numDigits(Number, Num):-
    atom_string(Number, S),
    atom_codes(L, S),
    atom_chars(L, X),
    length(X, N),
    Num is N.


main :-
    set_dealer_position(3),
    set_player_active(1, 0),
    set_player_active(2, 0),
    set_player_active(3, 0),
    set_player_active(4, 0),
    set_player_active(5, 0),
    set_player_active(0, 0),
    set_player_chips(5, 600000),
    set_pot(6000000000),
    set_card_table(0, "P", "J"),
    set_card_table(1, "P", "J"),
    set_card_table(2, "P", "J"),
    set_card_table(3, "P", "J"),
    set_card_table(4, "P", "J"),
    
    printTable.
    