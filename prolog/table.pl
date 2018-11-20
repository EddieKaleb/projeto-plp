start_game :-
    sleep(3),
    writeln("Casual Match"),
    run_game.

run_game:-
    run_match.

run_match:- 
    run_round(0),
    run_round(1),
    run_round(2),
    run_round(3).

run_round(0):- run_preflop_round.
run_round(1):- run_flop_round.
run_round(2):- run_turn_round.
run_round(3):- run_river_round.

run_preflop_round:-
    writeln("PreFlopRound"),
    sleep(3).

run_flop_round:-
    writeln("FlopRound"),
    sleep(3).

run_turn_round:-
    writeln("TurnRound"),
    sleep(3).

run_river_round:-
    writeln("RiverRound"),
    sleep(3).

start_game_manual:-
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
