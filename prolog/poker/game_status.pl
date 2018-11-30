:- module(
    game_status,
    [dealer_position/1,
    minimum_bet/1,
    cards_table/3,
    active_players/1,
    pot/1,
    current_round/1,
    actual_player/1,
    last_bet/1,
    first_bet_player/1,
    small_position/1,
    big_position/1,
    get_next_position/2,
    set_dealer_position/1,
    set_minimum_bet/1,
    set_card_table/3,
    set_active_players/1,
    set_pot/1,
    set_current_round/1,
    set_actual_player/1,
    set_last_bet/1,
    set_first_bet_player/1,
    start_dealer_position/0,
    next_player/1,
    reset_cards_table/0,
    get_cards_table/1,
    get_card_table/2
]).

:- dynamic(dealer_position/1).
dealer_position(-1).

:- dynamic(minimum_bet/1).
minimum_bet(2).

:- dynamic(cards_table/3).
cards_table(0, "1", "E").
cards_table(1, " ", " ").
cards_table(2, " ", " ").
cards_table(3, " ", " ").
cards_table(4, " ", " ").

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

small_position(Small_pos):-
    dealer_position(Dealer_pos),
    get_next_position(Dealer_pos, Small_pos).

big_position(Big_pos):-
    small_position(Small_pos),
    get_next_position(Small_pos, Big_pos).    

get_next_position(Actual_pos, Next_pos):-
    Next_pos is mod(Actual_pos + 1, 6).

set_dealer_position(New_dealer_position):-
    retract(dealer_position(_)),
    asserta(dealer_position(New_dealer_position)).

set_minimum_bet(New_minimun_bet):-
    retract(minimum_bet(_)),
    asserta(minimum_bet(New_minimun_bet)).

set_card_table(Index, Value, Naipe):-
    retract(cards_table(Index, _, _)),
    asserta(cards_table(Index, Value, Naipe)).

set_active_players(New_active_players):-
    retract(active_players(_)),
    asserta(active_players(New_active_players)).

set_pot(New_pot):-
    retract(pot(_)),
    asserta(pot(New_pot)).

set_current_round(New_current_round):-
    retract(current_round(_)),
    asserta(current_round(New_current_round)).

set_actual_player(New_actual_player):-
    retract(actual_player(_)),
    asserta(actual_player(New_actual_player)).

set_last_bet(New_last_bet):-
    retract(last_bet(_)),
    asserta(last_bet(New_last_bet)).

set_first_bet_player(New_first_bet_player):-
    retract(first_bet_player(_)),
    asserta(first_bet_player(New_first_bet_player)).

next_player(New_player_position):-
    actual_player(Actual_player),
    get_next_position(Actual_player, New_player_position),
    set_actual_player(New_player_position).

start_dealer_position:-
    dealer_position(Dealer_pos),
    (
        (Dealer_pos =:= -1, random(0, 5, Dealer_position));
        get_next_position(Dealer_pos, Dealer_position)
    ),
    set_dealer_position(Dealer_position).


get_cards_table(Cards):-
    Aux2 = [], get_card_table(0, Aux1), append(Aux1,[],Cards).
    %Aux4 = [], get_card_table(1, Aux3), append(Aux2,Aux3,Cards).
    %Aux6 = [], get_card_table(2, Aux5), append(Aux4,Aux5,Aux6),
    %Aux8 = [], get_card_table(3, Aux7), append(Aux6,Aux7,Aux8),
    %get_card_table(4, Aux9), append(Aux8,Aux9,Cards).

get_card_table(Id, Card):-
    cards_table(Id, V1, N1), V1 =\= " " -> append([[N1, V1]], [], Card); Card = [].

reset_cards_table:-
    set_card_table(0, " ", " "),
    set_card_table(1, " ", " "),
    set_card_table(2, " ", " "),
    set_card_table(3, " ", " "),
    set_card_table(4, " ", " ").

