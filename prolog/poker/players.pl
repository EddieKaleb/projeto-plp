:- module(
    players, 
    [player/9, 
    config_players/0,
    set_player/5,
    set_player_chips/2, 
    get_player_chips/2,
    set_player_cards/3,
    get_player_cards/3,
    set_player_active/2,
    get_player_active/2,
    set_player_pre_flop_prob/2,
    set_player_flop_turn_prob/2,
    set_player_turn_river_prob/2,
    set_player_river_showdown_prob/2
]).

:- dynamic(player/9).
player(0, ["E", 3], ["E", 3], 100, 1, 0, 0, 0, 0).
player(1, ["E", 3], ["E", 3], 100, 1, 0, 0, 0, 0).
player(2, ["E", 3], ["E", 3], 100, 1, 0, 0, 0, 0).
player(3, ["E", 3], ["E", 3], 100, 1, 0, 0, 0, 0).
player(4, ["E", 3], ["E", 3], 100, 1, 0, 0, 0, 0).
player(5, ["E", 3], ["E", 3], 100, 1, 0, 0, 0, 0).


set_player(Id, Card1, Card2, Chips, Active):-
    set_player_cards(Id, Card1, Card2),
    set_player_chips(Id, Chips),
    set_player_active(Id, Active).


set_player_pre_flop_prob(Id, PreFlopProb):-
    player(Id, Card1, Card2, Pot, Active, _, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb),
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb)).

set_player_flop_turn_prob(Id, FlopToTurnProb):-
    player(Id, Card1, Card2, Pot, Active, PreFlopProb, _, TurnToRiverProb, RiverToShowDownProb),
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb)).

set_player_turn_river_prob(Id, TurnToRiverProb):-
    player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, _, RiverToShowDownProb),
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb)).

set_player_river_showdown_prob(Id, RiverToShowDownProb):-
    player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, _),
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb)).
     
set_player_chips(Id, Pot):-
    player(Id, Card1, Card2, _, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb),
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb)).


get_player_chips(Id, Chips):-
    player(Id, _, _, Chips, _, _, _, _, _).


set_player_cards(Id, Card1, Card2):-
    player(Id, _, _, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb),
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb)).


get_player_cards(Id, Card1, Card2):-
    player(Id, Card1, Card2, _, _, _, _, _, _).


set_player_active(Id, Active):-
    player(Id, Card1, Card2, Pot, _, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb),
    retract(player(Id, _, _, _, _, _, _, _, _)),
    asserta(player(Id, Card1, Card2, Pot, Active, PreFlopProb, FlopToTurnProb, TurnToRiverProb, RiverToShowDownProb)).


get_player_active(Id, Active):-
    player(Id, _, _, _, Active, _, _, _, _).


config_players:-
    set_player(0, ["P", 3], ["O", 4], 100, 1),
    set_player(1, ["E", "K"], ["C", 2], 100, 1),
    set_player(2, ["C", "Q"], ["E", "J"], 100, 1),
    set_player(3, ["O", "J"], ["P", 2], 100, 1),
    set_player(4, ["C", 3], ["E", 4], 100, 1),
    set_player(5, ["E", 5], ["O", "6"], 100, 1).