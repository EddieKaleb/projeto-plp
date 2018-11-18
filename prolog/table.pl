start_game :-
    sleep(3),
    writeln("Casual Match").


start_game_manual :-
    sleep(3),
    writeln("Manual Match").    

get_improve_prob("IS_ONE_PAIR", Iprob) :- improve_prob(5, Prob), Iprob is Prob / 100.
get_improve_prob("IS_TWO_PAIR", Iprob) :- improve_prob(4, Prob), Iprob is Prob / 100.
get_improve_prob("IS_THREE", Iprob) :- improve_prob(8, Prob), Iprob is Prob / 100.
get_improve_prob("IS_STRAIGHT", Iprob) :- improve_prob(1, Prob), Iprob is Prob / 100.
get_improve_prob("IS_FLUSH", Iprob) :-  improve_prob(2, Prob), Iprob is Prob / 100.
get_improve_prob("IS_FULL_HOUSE", Iprob) :-  improve_prob(1, Prob), Iprob is Prob / 100.
get_improve_prob("IS_HIGH_CARD", Iprob) :- improve_prob(15, Prob), Iprob is Prob / 100.
get_improve_prob(_, Iprob) :- improve_prob(0, Prob), Iprob is Prob / 100.

improve_prob(Outs, Prob) :- Prob is (Outs * 4) - (Outs - 8).
