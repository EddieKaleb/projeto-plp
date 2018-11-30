:- module(
    deck, 
    [init_deck/0,
    getCardSelected/1,
    getFirstCard/1
    ]).

:- dynamic(deck/1).
deck([]).

set_deck(Deck):-  
    retract(deck(_)),
    asserta(deck(Deck)).

init_deck:- 
    build_deck(["A","K","Q","J","T","9","8","7","6","5","4","3","2"], ["E","C","P","O"], Deck),
    random_permutation(Deck,Shuffled),
    set_deck(Shuffled).

build_deck(Values,[H],Deck):- create(H,Values,Deck).
build_deck(Values,[H|T],Deck):- 
    create(H,Values,Part), 
    build_deck(Values,T,D),
    append(Part, D, X), 
    Deck = X.

create(Nipe,[H],Part):- 
    Part = [[Nipe,H]].
create(Nipe,[H|T],Part):- 
    create(Nipe,T,P), 
    append(P, [[Nipe,H]], X), 
    Part = X.

getFirstCard(Card):-
    deck(Deck), 
    removeFirst(Deck,D,R),
    Card = R,
    set_deck(D).
     
removeFirst([H|T],Deck,R):- R = H, Deck = T.

getCardSelected(Selected):-
    deck(Deck),
    validCard(Selected,Deck)->(
        remove(Selected,Deck,R),
        set_deck(R)
    ).

remove(_,[_],R):- R=[].
remove(Selected,[H|T],R):- 
    compareCards(Selected,H) -> (R=T);
    remove(Selected,T,Re), append([H],Re,X), R=X.

compareCards(Selected,H):-
    nth0(1,H,ValueH), 
    nth0(1,Selected,ValueS), 
    ValueH==ValueS ,  
    nth0(0,H,NaipeH), 
    nth0(0,Selected,NaipeS),
    NaipeH==NaipeS.

validCard(Selected,[H]):-
    compareCards(Selected,H).
validCard(Selected,[H|T]):- 
    compareCards(Selected,H);
    validCard(Selected,T).
    

