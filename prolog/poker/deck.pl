:- module(
    deck, 
    [buildDeck/0,
    getCardByIndex/2
    ]).

:- dynamic(deck/1).
deck([]).

setDeck(Deck):-  
    retract(deck(_)),
    asserta(deck(Deck)).

buildDeck():- 
    build_deck(["A","K","Q","J","T","9","8","7","6","5","4","3","2"], ["E","C","P","O"], Deck),
    setDeck(Deck).

build_deck(Values,[H],Deck):- 
    create(H,Values,Deck).
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


getCardByIndex(Index,Card):-
    deck(X), 
    nth0(Index,X,Value), 
    Card = Value.

