:- initialization main.



verifyHand(Cards,Hand):-
                        % verifyFour(Cards,Hand), Hand == "IS_FOUR";
                        % verifyFullHouse(Cards,Hand), Hand == "IS_FULL_HOUSE";
                        % verifyFlush(Cards,Hand), Hand == "IS_FLUSH";
                        % verifyStraight(Cards,Hand), Hand == "IS_STRAIGHT";
                        % verifyThree(Cards,Hand), Hand == "IS_THREE";
                        % verifyTwoPair(Cards,Hand), Hand == "IS_TWO_PAIR";
                        verifyOnePair(Cards,Hand), Hand == "IS_ONE_PAIR";
                        Hand = "null".


verifyOnePair(Cards,Hand):- Hand= "IS_ONE_PAIR".



quick_sort(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
	pivoting(H,T,L1,L2),
	q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

pivoting(H,[],[],[]).
pivoting(H,[X|T],[X|L],G):-map_cards(X,X1),map_cards(H,H1),X1=<H1,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-map_cards(X,X1),map_cards(H,H1),X1>H1,pivoting(H,T,L,G).

map_cards(Card,NumCard):- mapCards(["2","3","4","5","6","7","8","9","10","J","Q","K","A"],Card,2,NumCard).
mapCards([H|T],Card,Cont,NumCard):- H == Card ->(NumCard is Cont);
                                    mapCards(T,Card,Cont+1,NumCard).

main:- verifyHand([],Hand), write(Hand).