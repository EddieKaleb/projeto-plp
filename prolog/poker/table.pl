:- module(table, [start_game/0]).
:- use_module('players.pl').
:- use_module('game_status.pl').
:- use_module('hand_prob.pl').

clear_screen :-
    tty_clear.

input_number(Option) :-
    read_line_to_codes(user_input, Codes),
    string_to_atom(Codes, Atom),
    atom_number(Atom, Option).

start_game :-
    sleep(3),
    config_new_match,
    run_game,
    clear_screen.

run_game:-
    % Adicionar a configuração das mãos dos jogadores.
    set_pot(0),
    set_minimum_bet(2),
    start_dealer_position,
    small_position(Small_position),
    set_actual_player(Small_position),
    run_match,
    end_game.

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
    writeln(" ------- PreFlopRound -------- \n"),

    call_action(_),
    
    next_player(_),
    minimum_bet(Min_bet),
    New_min_bet is Min_bet * 2,
    set_minimum_bet(New_min_bet),
    call_action(_),

    next_player(New_position2),
    big_position(Big_position),
    show_infos,
    set_players_probs(0,0),
    run_pre_flop_action(New_position2, Big_position).


run_flop_round:-
    writeln(" -------- FlopRound -------- \n"),

    %Adicionar método que seta as 3 primeiras cartas

    config_new_round(1),
    sleep(3).


run_turn_round:-
    writeln(" ------- TurnRound -------- \n"),

    %Adicionar método que seta a quarta carta

    minimum_bet(Min_bet),
    New_min_bet is (Min_bet * 2),
    set_minimum_bet(New_min_bet),
    config_new_round(2),
    sleep(3).


run_river_round:-
    writeln(" -------- RiverRound ---------- \n"),

    %Adicionar método que seta a quinta carta

    config_new_round(3),
    sleep(3).

config_new_round(Round_id):-
    small_position(Small_position),
    set_actual_player(Small_position),
    set_current_round(Round_id),
    set_last_bet(0),
    set_first_bet_player(-1),
    first_bet_player(First_bet_player),
    actual_player(Actual_player),
    set_players_probs(Round_id,0),
    run_action(Actual_player, First_bet_player).

config_new_match:-
    set_minimum_bet(2),
    set_pot(0),
    set_minimum_bet(2),
    start_dealer_position,
    small_position(Small_position),
    set_actual_player(Small_position),
    set_player_active(0, 1),
    set_player_active(1, 1),
    set_player_active(2, 1),
    set_player_active(3, 1),
    set_player_active(4, 1),
    set_player_active(5, 1).


run_pre_flop_action(Actual_position, End_position):-
    (Actual_position =:= End_position);
    
    ((get_player_active(Actual_position, Active), Active =:= 1,
        (
            (Actual_position =:= 0, show_user_actions);
            bot_actions
        )
    ); !),
    show_infos,
    sleep(2),
    next_player(Next_position),
    run_pre_flop_action(Next_position, End_position).


run_action(Actual_position, End_position):-
    (Actual_position =:= End_position);
    
    (
        (Actual_position =:= 0, get_player_active(Actual_position, Active1), Active1 =:= 1, show_user_actions);
        (get_player_active(Actual_position, Active2), Active2 =:= 1, bot_actions)
    ) ->
    
    show_infos,
    sleep(2),
    next_player(Next_position),
    first_bet_player(First_bet_player),
    run_action(Next_position, First_bet_player).

start_game_manual:-
    sleep(3),
    config_new_match,
    run_game_manual,
    clear_screen.

run_game_manual:-
    select_card_hand,
    set_pot(0),
    set_minimum_bet(2),
    start_dealer_position,
    small_position(Small_position),
    set_actual_player(Small_position),
    run_match_manual,
    end_game.

run_match_manual:- 
    run_round_manual(0),
    run_round_manual(1),
    run_round_manual(2),
    run_round_manual(3).

run_round_manual(0):- run_preflop_round.
run_round_manual(1):- run_flop_round_manual.
run_round_manual(2):- run_turn_round_manual.
run_round_manual(3):- run_river_round_manual.

run_flop_round_manual:-
    config_new_round(1),
    flop_round_manual,
    sleep(3).

run_turn_round_manual:-
    minimum_bet(Min_bet),
    New_min_bet is (Min_bet * 2),
    set_minimum_bet(New_min_bet),
    config_new_round(2),
    turn_round_manual,
    sleep(3).

run_river_round_manual:-
    config_new_round(3),
    river_round_manual,
    sleep(3).

select_card_hand:-
    clear_screen,
    actual_player(Actual_player),
    writeln(" --- SELEÇÃO DAS CARTAS DA SUA MÃO --- "),
    config_card(Card1),
    config_card(Card2),
    set_player_cards(Actual_player, Card1, Card2).

config_card(Card):-
    writeln("Digite o valor da carta (2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A): "),
    input_number(Valor),
    writeln("Digite o naipe da carta (O, C, P, E): "),
    read_line_to_string(user_input, Naipe),
    (not(is_valid_card([Naipe, Valor])) -> config_card(Card)),
    write("Carta: "),
    write(Valor),
    write(" "),
    writeln(Naipe),
    Card = [Naipe, Valor].

is_valid_card(Card, Result):-
    not(get_card_player(Card)) -> (card_invalid_message, Result = False);
    Result = True.

card_invalid_message:-
    writeln("                       Carta inválida... Selecione outra !"),
    sleep(1).

flop_round_manual:-
    select_flop_cards,
    bots_flop,
    run_round(1).

select_flop_cards:- 
    clear_screen,
    writeln(" --- SELEÇÃO DAS TRÊS PRIMEIRAS CARTAS DA MESA --- "),
    config_card(Card1),
    config_card(Card2),
    config_card(Card3),
    set_cards_table([Card1, Card2, Card3, _, _]).

select_turn_card:-
    clear_screen,
    writeln(" --- SELEÇÃO DA CARTA DE TURN --- "),
    config_card(Card),
    set_cards_table([_, _, _, Card, _]).

select_river_card:-
    clear_screen,
    writeln(" --- SELEÇÃO DA CARTA DE RIVER --- "),
    config_card(Card),
    set_cards_table([_, _, _, _, Card]).

turn_round_manual:-
    select_turn_card,
    minimum_bet(Minimum_bet),
    New_minimun_bet is Minimum_bet * 2,
    set_minimum_bet(New_minimun_bet),
    bots_turn,
    run_round(2).

river_round_manual:-
    select_river_card,
    bots_river,
    run_round(3).

invalid_action :- 
    clear_screen,
    writeln("\n\n\n              Ação inválida, escolha outra opção !\n\n\n"),
    clear_screen,
    sleep(3).

end_game:-
    clear_screen,
    writeln("\n\n                                   FIM DO JOGO !!!\n\n\n"),
    writeln("                         Deseja continuar jogando ? 1 (Sim) / 2 (Não)\n"),
    input_number(Op),
    (Op =:= 1, start_game);
    clear_screen.

check_player_action :-
    (check_action(Check_action), Check_action =:= 1);
    invalid_action, show_user_actions.


check_action(Result) :-
    current_round(Current_round),
    last_bet(Last_bet),
    ((Current_round \= 0, Last_bet =:= 0, Result is 1);
    Result is 0).


call_player_action:-
    (call_action(Call_action), Call_action =:= 1);
    (invalid_action, show_user_actions).


call_action(Result) :-
    actual_player(Actual_player),
    get_player_chips(Actual_player, Chips),
    minimum_bet(Minimum_bet),
    New_chips is (Chips - Minimum_bet),

    ((Chips >= Minimum_bet,
        set_player_chips(Actual_player, New_chips),
        pot(Pot),
        New_pot is (Pot + Minimum_bet),
        set_pot(New_pot),
        config_first_bet_player,
        Result is 1
    );
    Result is 0).
    
config_first_bet_player:-
    (actual_player(Actual_player),
    first_bet_player(First_bet_player), 
    First_bet_player =:= -1,
    set_first_bet_player(Actual_player)); !.

fold_action :-
    actual_player(Actual_player),
    set_player_active(Actual_player, 0),
    active_players(Active_players),
    set_active_players((Active_players - 1)).


exit_action :-
    clear_screen,
    writeln("\n\n\n                           Até a próxima !!!\n\n\n"),
    sleep(3).


show_user_actions:-
    writeln("\n\n-----------------------------     AÇÕES     -----------------------------\n\n"),
    writeln("          1  -  Mesa"),
    writeln("          2  -  Apostar"),
    writeln("          3  -  Desistir"),
    writeln("          4  -  Sair da mesa"),
    get_option(Option),
    select_player_option(Option).

get_option(Option) :-
    write("\n\n                    Informe o número da opção desejada: "),
    input_number(Option),
    write("\n\n\n").

select_player_option(1):- check_player_action.
select_player_option(2):- call_player_action.
select_player_option(3):- fold_action.
select_player_option(4):- exit_action, halt.
select_player_option(_):- invalid_action, show_user_actions.


bot_actions:- writeln("Ações do bot"),
              current_round(Current_round),
              run_bot(Current_round).

run_bot(0):- writeln("Ação pre flop").

run_bot(1):- writeln("Ação flop").
run_bot(2):- writeln("Ação turn").
run_bot(3):- writeln("Ação river").

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
    first_bet_player(First_bet_player),
    write("Posição do Dealer: "), writeln(Dealer_position),
    write("Posição do Small: "), writeln(Small_position),
    write("Posição do Big: "), writeln(Big_position),
    write("Aposta mínima: "), writeln(Min_bet),
    write("Cartas da mesa: "), writeln(Cards_table),
    write("Pot: "), writeln(Pot),    
    write("Round: "), writeln(Current_round),
    write("Jogador atual: "), writeln(Actual_player),
    write("Último que apostou: "), writeln(First_bet_player),
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

set_players_probs(_, 6).
set_players_probs(0, Pos) :- get_player_cards(Pos, Card1, Card2),
                             get_hand_prob(Card1, Card2, 6, PreFlopProb),
                             write("Probabilidade: "), writeln(PreFlopProb),
                             set_player_pre_flop_prob(Pos, PreFlopProb),
                             Aux is Pos + 1,
                             set_players_probs(0, Aux).

set_players_probs(1, Pos) :- get_player_cards(Pos, Card1, Card2),
                             %cards_table(Cards_table),
                             Cards_table = [],
                             append(Card1,Card2,Hand),
                             writeln(Cards_table),
                             append(Hand,Cards_table,AllCards),
                             verify_hand(AllCards, HandStatus),
                             get_improve_prob(HandStatus,ImproveProb),
                             get_player_pre_flop_prob(Pos, PreFlopProb),
                             FlopToTurnProb is PreFlopProb * (1 - ImproveProb),
                             write("Probabilidade: "), writeln(FlopToTurnProb),
                             set_player_flop_turn_prob(Pos, FlopToTurnProb),
                             Aux is Pos + 1,
                             set_players_probs(1, Aux).

set_players_probs(2, Pos) :- writeln("inicio do turn").
set_players_probs(3, Pos) :- writeln("inicio do river").


verify_hand(_, "IS_THREE").

%handStatus hand = verifyHand(playersTable[i].hand, cardsTable, 5);
%        playersTable[i].flopToTurnProb = playersTable[i].preFlopProb * (1 - getImproveHandProb(hand.flag));
%        cout << playersTable[i].flopToTurnProb << "%" << endl;
        
