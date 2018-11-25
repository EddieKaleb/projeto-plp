:- initialization(main).

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

centralPlayer(Player, Chips):-
    write("|"),
    spaces(39),
    /**active*/
    spaces(1),
    write("Player "),
    write(Player),
    /**role*/
    spaces(3),
    spaces(39),
    write("|\n"),

    write("|"),
    spaces(40),
    write("Chips: "),
    write(Chips),
    numDigits(Chips, Ndigits),
    spaces(43 - Ndigits),
    write("|\n").

lateralPlayers(Player1, Chips1, Player2, Chips2):-
    write("|"),
    spaces(2),
    /**active*/
    spaces(1), 
    write("Player "),
    write(Player1),
    /**role*/
    spaces(3),
    spaces(62),
    /**role*/
    spaces(3),
    write("Player "),
    write(Player2),
    /**active*/
    spaces(1),
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
    topBorder,
    centralCards,
    centralPlayer(4,50),
    lateralCards,
    lateralPlayers(3, 10, 5, 6000),
    flopTurnRiver,
    lateralPlayers(2, 0, 6, 200),
    lateralCards,
    centralPlayer(1,500),
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