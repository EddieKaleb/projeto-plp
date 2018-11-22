:- module(table, [start_game/0]).
:- use_module('players.pl').

:- dynamic(dealer_position/1).
dealer_position(0).

:- dynamic(minimum_bet/2).
minimum_bet(2).

:- dynamic(cards_table/1).
cards_table([]).

:- dynamic(active_players/1).
active_players(6).

:- dynamic(pot/1).
pot(0).

:- dynamic(current_round/1).
current_round(0).

:- dynamic(actual_player/1).
actual_player(0).

:- dynamic(last_bet/1).
last_bet(0).

:- dynamic(first_bet_player/1).
first_bet_player(-1).

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

small_position(Small_pos):-
    dealer_position(Dealer_pos),
    next_player_position(Dealer_pos, Small_pos).

big_position(Big_pos):-
    small_position(Small_pos),
    next_player_position(Small_pos, Big_pos).    

next_player_position(Actual_pos, Next_pos):-
    Next_pos is mod(Actual_pos + 1, 6).

checkPlayerAction :-
    writeln("checkPlayerAction").

callPlayerAction :-
    writeln("callPlayerAction").

checkAction :-
    writeln("checkAction").

callAction :-
    writeln("callAction").

foldAction :-
    writeln("foldAction").

exitAction :-
    writeln("exitAction").

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