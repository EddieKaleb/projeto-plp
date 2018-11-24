:- module(
    players, 
    [player/5, 
    config_players/0,
    set_player/5,
    set_player_chips/2, 
    get_player_chips/2,
    set_player_cards/3,
    get_player_cards/3,
    set_player_active/2,
    get_player_active/2
]).

:- dynamic(player/5).
player(0, ["A", 1], ["A", 1], 100, 1, 0, 0, 0, 0).
player(1, ["A", 1], ["A", 1], 100, 1, 0, 0, 0, 0).
player(2, ["A", 1], ["A", 1], 100, 1, 0, 0, 0, 0).
player(3, ["A", 1], ["A", 1], 100, 1, 0, 0, 0, 0).
player(4, ["A", 1], ["A", 1], 100, 1, 0, 0, 0, 0).
player(5, ["A", 1], ["A", 1], 100, 1, 0, 0, 0, 0).


set_player(Id, Card1, Card2, Chips, Active):-
    set_player_cards(Id, Card1, Card2),
    set_player_chips(Id, Chips),
    set_player_active(Id, Active).


set_player_pre_flop_prob(Id, PreFlopProb):-
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, _, _, _, _, PreFlopProb, _, _, _)).

set_player_flop_turn_prob(Id, FlopToTurnProb):-
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, _, _, _, _, _, FlopToTurnProb, _, _)).

set_player_turn_river_prob(Id, TurnToRiverProb):-
    retract(player(Id, _, _, _, _, _, _, _, _)),
     asserta(player(Id, _, _, _, _, _, _, TurnToRiverProb, _)).

set_player_river_showdown_prob(Id, RiverToShowDownProb):-
    retract(player(Id, _, _, _, _, _, _, _, _)),
     asserta(player(Id, _, _, _, _, _, _, _, RiverToShowDownProb)).
     
set_player_chips(Id, Pot):-
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, _, _, Pot, _, _, _, _, _)).


get_player_chips(Id, Pot):-
    player(Id, _, _, Pot, _, _, _, _, _).


set_player_cards(Id, Card1, Card2):-
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, _, _, _, _, _, _)).


get_player_cards(Id, Card1, Card2):-
    player(Id, Card1, Card2, _, _, _, _, _, _).


set_player_active(Id, Active):-
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, _, _, _, Active, _, _, _, _)).


get_player_active(Id, Active):-
    player(Id, _, _, _, Active, _, _, _, _).


config_players:-
    set_player(0, ["P", 3], ["O", 4], 100, 1, _, _, _, _),
    set_player(1, ["E", "K"], ["C", 2], 100, 1, _, _, _, _),
    set_player(2, ["C", "Q"], ["E", "J"], 100, 1, _, _, _, _),
    set_player(3, ["O", "J"], ["P", 2], 100, 1, _, _, _, _),
    set_player(4, ["C", 3], ["E", 4], 100, 1, _, _, _, _),
    set_player(5, ["E", 5], ["O", "T"], 100, 1, _, _, _, _).