:- initialization(main).
:-use_module(game_status).

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

centralCardsWithProb(Value1, Naipe1, Value2, Naipe2, Prob):-
    write("|"),

    centralCardSpaces,
    nCardTops(2),
    centralCardSpaces,

    write("|\n"),

    write("|"),
    centralCardSpaces,
    cardLateralValue(Value1),
    cardLateralValue(Value2),
    centralCardSpaces,
    write("|\n"),

    write("E"),
    printNTimes("-", 12),
    write("\\"),
    spaces(27),

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

flopTurnRiver():-
    write("|"),
    spaces(30),
    nCardTops(3),
    spaces(2),
    cardTop,
    spaces(2),
    cardTop,
    spaces(31),
    write("|\n"),

    write("|"),
    spaces(30),
    nCardLaterals(3),
    spaces(2),
    cardLateral,
    spaces(2),
    cardLateral,
    spaces(31),
    write("|\n"),

    write("|"),
    spaces(30),
    nCardLaterals(3),
    spaces(2),
    cardLateral,
    spaces(2),
    cardLateral,
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

playing(X, X):- write("*").
playing(Player, X):- write(" ").



centralPlayer(Player, Chips, PlayerRole, ActualPlayer):-
    write("|"),
    spaces(39),
    /**active*/
    PlayerId is Player - 1,
    playing(PlayerId, ActualPlayer),
    write("Player "),
    write(Player),
    /**role*/
    role(PlayerRole, Role),
    write(Role),
    spaces(39),
    write("|\n"),

    write("|"),
    spaces(40),
    write("Chips: "),
    write(Chips),
    numDigits(Chips, Ndigits),
    spaces(43 - Ndigits),
    write("|\n").

lateralPlayers(Player1, Chips1, Player1Role, Player2, Chips2, Player2Role, ActualPlayer):-
    write("|"),
    spaces(2),
    /**active*/
    PlayerId1 is Player1 - 1,
    playing(PlayerId1, ActualPlayer), 
    write("Player "),
    write(Player1),
    /**role*/
    role(Player1Role, Role1),
    write(Role1),
    spaces(62),
    /**role*/
    role(Player2Role, Role2),
    write(Role2),
    write("Player "),
    write(Player2),
    /**active*/

    PlayerId2 is Player2 - 1,
    playing(PlayerId2, ActualPlayer), 
    spaces(2),
    write("|\n"),

    write("|"),
    lateralSpaces,
    write("Chips: "),
    write(Chips1),
    numDigits(Chips1, Ndigits1),
    numDigits(Chips2, Ndigits2),
    spaces(70 - Ndigits1 - Ndigits2),
    write("Chips: "),
    write(Chips2),
    lateralSpaces,
    write("|\n").

printTable:-
    actual_player(ActualPlayer),
    topBorder,
    centralCards,
    centralPlayer(4,50, "jaaj", ActualPlayer),
    lateralCards,
    lateralPlayers(3, 10,"dealer", 5, 6000,"small", ActualPlayer),
    flopTurnRiver,
    lateralPlayers(2, 0, "big", 6, 200, "", ActualPlayer),
    lateralCards,
    centralPlayer(1,500, "dealer", ActualPlayer),
    centralCardsWithProb("T","K", "5", "P", 30.0),
    bottomBorder.

numDigits(Number, Num):-
    atom_string(Number, S),
    atom_codes(L, S),
    atom_chars(L, X),
    length(X, N),
    Num is N.


main :-
    printTable.
    