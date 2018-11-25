:- module(table, [start_game/0]).
:- use_module('players.pl').
:- use_module('game_status.pl').
:- use_module('hand_prob.pl').

clear_screen :-
    tty_clear.

start_game :-
    sleep(3),
    writeln("Casual Match"),%retirar isso quando implementar rodadas
    run_game,
    clear_screen,
    writeln("O jogo acabou."),
    sleep(5).

run_game:-
    start_dealer_position,
    small_position(Small_position),
    set_actual_player(Small_position),
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
    sleep(3),
    call_action(_),
    
    next_player(_),
    minimum_bet(Min_bet),
    New_min_bet is Min_bet * 2,
    set_minimum_bet(New_min_bet),
    call_action(_),

    next_player(New_position2),
    run_pre_flop_actions(New_position2).

run_pre_flop_actions(Actual_position):-
    (big_position(Big_position), Actual_position =:= Big_position);
    
    (
        (Actual_position =:= 0, get_player_active(Actual_position, Active1), Active1 =:= 1, show_user_actions);
        (get_player_active(Actual_position, Active2), Active2 =:= 1, bot_actions)
    ) ->

    show_infos,
    sleep(2),
    next_player(Next_position),
    run_pre_flop_actions(Next_position).

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
    actual_player(Actual_player),
    get_player_chips(Actual_player, Chips),
    minimum_bet(Minimum_bet),
    New_chips is Chips - Minimum_bet,

    (Chips >= Minimum_bet,
        set_player_chips(Actual_player, New_chips),
        pot(Pot),
        New_pot is (Pot + Minimum_bet),
        set_pot(New_pot),
        Result = true);
    Result = false.
    

fold_action :-
    actual_player(Actual_player),
    set_player_active(Actual_player, 0).

exit_action :-
    clear_screen,
    writeln("                  Até a próxima !!!"),
    sleep(3).


show_user_actions:-
    writeln("Ações do usuário").

bot_actions:-
    writeln("Ações do bot").

show_infos:-
    dealer_position(Dealer_position),
    small_position(Small_position),
    big_position(Big_position),
    minimum_bet(Min_bet),
    cards_table(Cards_table),
    active_players(Active_players),
    pot(Pot),
    current_round(Current_round),
    actual_player(Actual_player),
    last_bet(Last_bet),
    write("Posição do Dealer: "), writeln(Dealer_position),
    write("Posição do Small: "), writeln(Small_position),
    write("Posição do Big: "), writeln(Big_position),
    write("Aposta mínima: "), writeln(Min_bet),
    write("Cartas da mesa: "), writeln(Cards_table),
    write("Pot: "), writeln(Pot),    
    write("Round: "), writeln(Current_round),
    write("Jogador atual: "), writeln(Actual_player),
    write("Última aposta: "), writeln(Last_bet),
    write("Jogadores ativos: "), writeln(Active_players),
    write("\n\n").


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