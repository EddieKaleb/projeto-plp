:- module(table, [start_game/0]).
:- use_module('players.pl').
:- use_module('game_status.pl').
:- use_module('hand_prob.pl').

cls :- write("\e[2J").

start_game :-
    sleep(3),
    writeln("Casual Match"),%retirar isso quando implementar rodadas
    run_game,
    cls,
    writeln("O jogo acabou."),
    sleep(5).

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

invalid_action :- writeln("Ação inválida").

check_player_action :-
    check_action(Check_action),
    not(Check_action) -> invalid_action.%, show_user_actions.

call_player_action :-
    call_action(Call_action),
    not(Call_action) -> invalid_action.

check_action(Result) :-
    current_round(Current_round),
    last_bet(Last_bet),
    (Current_round \= 0, Last_bet =:= 0) -> Result = true;
    Result = false.

call_action(Result) :-
    actualPlayer(Actual_player),
    get_player_chips(Actual_player, Chips),
    minimum_bet(Minimum_bet),
    New_chips is Chips - Minimum_bet,
    (Chips >= Minimum_bet) -> set_player_chips(Actual_player, New_chips),
        Result = true;
    Result = false.
    

fold_action :-
    actual_player(Actual_player),
    set_player_active(Actual_player, 0).

exit_action :-
    cls,
    writeln("                  Até a próxima !!!"),
    sleep(3).

% PROBABILIDADES

get_improve_prob("IS_ONE_PAIR", Iprob) :- improve_prob(5, Prob), Iprob is Prob / 100.
get_improve_prob("IS_TWO_PAIR", Iprob) :- improve_prob(4, Prob), Iprob is Prob / 100.
get_improve_prob("IS_THREE", Iprob) :- improve_prob(8, Prob), Iprob is Prob / 100.
get_improve_prob("IS_STRAIGHT", Iprob) :- improve_prob(1, Prob), Iprob is Prob / 100.
get_improve_prob("IS_FLUSH", Iprob) :-  improve_prob(2, Prob), Iprob is Prob / 100.
get_improve_prob("IS_FULL_HOUSE", Iprob) :-  improve_prob(1, Prob), Iprob is Prob / 100.
get_improve_prob("IS_HIGH_CARD", Iprob) :- improve_prob(15, Prob), Iprob is Prob / 100.
get_improve_prob(_, Iprob) :- improve_prob(0, Prob), Iprob is Prob / 100.

improve_prob(Outs, Prob) :- Prob is (Outs * 4) - (Outs - 8).