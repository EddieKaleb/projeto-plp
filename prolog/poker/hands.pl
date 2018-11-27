

verifyHand(Cards,Hand):-quick_sort(Cards,Sorted), verify_hand(Sorted,Hand).
verify_hand(Cards,Hand):- % verifyFour(Cards,Hand), Hand == "IS_FOUR";
                          % verifyFullHouse(Cards,Hand), Hand == "IS_FULL_HOUSE";
                          % verifyFlush(Cards,Hand), Hand == "IS_FLUSH";
                          % verifyStraight(Cards,Hand), Hand == "IS_STRAIGHT";
                          verifyThree(Cards) -> (Hand = "IS_THREE");
                          verifyTwoPair(Cards) -> (Hand = "IS_TWO_PAIR");
                          verifyOnePair(Cards) -> (Hand = "IS_ONE_PAIR");
                          Hand = "null".

verifyOnePair([_]):- false.
verifyOnePair([X,Y|T]):- nth0(1,X,ValueX), nth0(1,Y,ValueY), ValueX==ValueY; 
                         verifyOnePair([Y|T]).

verifyTwoPair([_]):- false.
verifyTwoPair([X,Y|T]):- nth0(1,X,ValueX), nth0(1,Y,ValueY), ValueX==ValueY -> (verifyOnePair(T)); 
                         verifyTwoPair([Y|T]).

verifyThree([_,_]):- false.
verifyThree([X,Y,Z|T]):- nth0(1,X,ValueX), nth0(1,Y,ValueY), nth0(1,Z,ValueZ), ValueX==ValueY, ValueZ==ValueY; 
                         verifyThree([Y,Z|T]).


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
