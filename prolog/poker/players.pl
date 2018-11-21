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
player(1, ["A", 1], ["A", 1], 100, True).
player(2, ["A", 1], ["A", 1], 100, True).
player(3, ["A", 1], ["A", 1], 100, True).
player(4, ["A", 1], ["A", 1], 100, True).
player(5, ["A", 1], ["A", 1], 100, True).
player(6, ["A", 1], ["A", 1], 100, True).


set_player(Id, Card1, Card2, Chips, Active):-
    set_player_cards(Id, Card1, Card2),
    set_player_chips(Id, Pot),
    set_player_active(Id, Active).


set_player_chips(Id, Pot):-
    retract(player(Id, _, _, _, _)),
    asserta(player(Id, _, _, Pot, _)).


get_player_chips(Id, Pot):-
    player(Id, _, _, Pot, _).


set_player_cards(Id, Card1, Card2):-
    retract(player(Id, _, _, _, _)),
    asserta(player(Id, Card1, Card2, _, _)).


get_player_cards(Id, Card1, Card2):-
    player(Id, Card1, Card2, _, _).


set_player_active(Id, Active):-
    retract(player(Id, _, _, _, _)),
    asserta(player(Id, _, _, _, Active)).


get_player_active(Id, Active):-
    player(Id, _, _, _, Active).


config_players:-
    set_player(1, ['P', 3], ["O", 4], 100, True),
    set_player(2, ["E", "K"], ["C", 2], 100, True),
    set_player(3, ["C", "Q"], ["E", "J"], 100, True),
    set_player(4, ["O", "J"], ["P", 2], 100, True),
    set_player(5, ["C", 3], ["E", 4], 100, True),
    set_player(6, ["E", 5], ["O", "T"], 100, True).