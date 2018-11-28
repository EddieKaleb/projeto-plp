

buildDeck(Deck):- build_deck(["A","K","Q","J","T","9","8","7","6","5","4","3","2"], ["E","C","P","O"], Deck).

build_deck(Values,[H],Deck):- create(H,Velues,Part) -> (Deck = Part).
build_deck(Values,[H|T],Deck):- (create(H,Velues,Part), 
                                build_deck(Values,T,D),
                                append(Part, D, X)) -> (Deck = X).
create(Nipe,[H],Part):- Part = [Nipe,H].
create(Nipe,[H|T],Part):- create(Nipe,T,P), append(P, [Nipe,H], X), Part = X.