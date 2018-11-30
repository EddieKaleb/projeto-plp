% :- module(hands, 
%     [verifyHand/2]).

verifyHand(Cards,Hand):-quick_sort(Cards,Sorted), verify_hand(Sorted,Hand).
verify_hand(Cards,Hand):- verifyFour(Cards) -> (Hand = "IS_FOUR");
                          % verifyFullHouse(Cards,Hand), Hand == "IS_FULL_HOUSE";
                          verifyFlush(Cards) -> (Hand = "IS_FLUSH");
                          verifyStraight(Cards) -> (Hand = "IS_STRAIGHT");
                          verifyThree(Cards) -> (Hand = "IS_THREE");
                          verifyTwoPair(Cards) -> (Hand = "IS_TWO_PAIR");
                          verifyOnePair(Cards) -> (Hand = "IS_ONE_PAIR");
                          Hand = "IS_HIGH_CARD".

verifyOnePair([_]):- false.
verifyOnePair([X,Y|T]):- nth0(1,X,ValueX), nth0(1,Y,ValueY), ValueX==ValueY; 
                         verifyOnePair([Y|T]).

verifyTwoPair([_]):- false.
verifyTwoPair([X,Y|T]):- nth0(1,X,ValueX), nth0(1,Y,ValueY), ValueX==ValueY -> (verifyOnePair(T)); 
                         verifyTwoPair([Y|T]).

verifyThree([_,_]):- false.
verifyThree([X,Y,Z|T]):- nth0(1,X,ValueX), nth0(1,Y,ValueY), nth0(1,Z,ValueZ), ValueX==ValueY, ValueZ==ValueY; 
                         verifyThree([Y,Z|T]).
 
verifyStraight(Cards):- verify_straight(Cards,1).
verify_straight(_, 5).
verify_straight([X,Y|T],Cont):-
    map_cards(X,X1),
    map_cards(Y,Y1)->( 
    Y2 is Y1 + 1,
    X1 == Y2 ,
    Cont1 is Cont + 1, 
    verify_straight([Y|T],Cont1); 
    X1 == Y1,
    verify_straight([Y|T],Cont); 
    Cont = 1,
    verify_straight([Y|T],Cont)).


verifyFlush(Cards):- verify_flush(Cards,"O", 5);verify_flush(Cards,"P", 5);verify_flush(Cards,"E", 5);verify_flush(Cards,"C", 5).
verify_flush([],_, Cont):- Cont=<0.
verify_flush([H|T],Naipe, Cont):- nth0(0,H,Cn), Cn == Naipe, Cont1 is Cont - 1, verify_flush(T,Naipe, Cont1); verify_flush(T,Naipe, Cont).

verifyFour([_,_,_]):- false.
verifyFour([X,Y,Z,W|T]):- nth0(1,X,ValueX), nth0(1,Y,ValueY), nth0(1,Z,ValueZ), nth0(1,W,ValueW), ValueX==ValueY, ValueZ==ValueY, ValueZ==ValueW; 
verifyFour([Y,Z,W|T]).

quick_sort(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
	pivoting(H,T,L1,L2),
	q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

pivoting(H,[],[],[]).
pivoting(H,[X|T],[X|L],G):-map_cards(X,X1),map_cards(H,H1),X1=<H1,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-map_cards(X,X1),map_cards(H,H1),X1>H1,pivoting(H,T,L,G).

map_cards(Card,NumCard):- mapCards(["2","3","4","5","6","7","8","9","T","J","Q","K","A"],Card,2,NumCard).
mapCards([H|T],Card,Cont,NumCard):- nth0(1,Card,Value), H == Value  ->(NumCard is Cont);
                                    mapCards(T,Card,Cont+1,NumCard).
