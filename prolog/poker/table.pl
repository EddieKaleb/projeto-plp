:- module(table, 
    [start_game/0, 
    start_game_manual/0]).
:- use_module('players.pl').
:- use_module('game_status.pl').
:- use_module('hand_prob.pl').
:- use_module('deck.pl').
:- use_module('table_output.pl').
:- use_module('hands.pl').

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
    set_pot(0),
    set_minimum_bet(2),
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
    printTable,
    run_pre_flop_action(New_position2, Big_position).


run_flop_round:-
    writeln(" -------- FlopRound -------- \n"),

    get_first_card([Value1, Naipe1]),
    get_first_card([Value2, Naipe2]),
    get_first_card([Value3, Naipe3]),
    set_card_table(0, Value1, Naipe1),
    set_card_table(1, Value2, Naipe2),
    set_card_table(2, Value3, Naipe3),

    writeln([Value1, Naipe1]),
    writeln([Value2, Naipe2]),
    writeln([Value3, Naipe3]),

    config_new_round(1),
    sleep(3).


run_turn_round:-
    writeln(" ------- TurnRound -------- \n"),

    get_first_card([Value4, Naipe4]),
    set_card_table(3, Value4, Naipe4),

    writeln([Value4, Naipe4]),

    minimum_bet(Min_bet),
    New_min_bet is (Min_bet * 2),
    set_minimum_bet(New_min_bet),
    config_new_round(2),
    sleep(3).


run_river_round:-
    writeln(" -------- RiverRound ---------- \n"),

    get_first_card([Value5, Naipe5]),
    set_card_table(4, Value5, Naipe5),

    writeln([Value5, Naipe5]),

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
    init_deck,
    init_players_hand,
    set_minimum_bet(2),
    set_pot(0),
    set_minimum_bet(2),
    set_active_players(6),
    start_dealer_position,
    small_position(Small_position),
    set_actual_player(Small_position),
    set_player_active(0, 1),
    set_player_active(1, 1),
    set_player_active(2, 1),
    set_player_active(3, 1),
    set_player_active(4, 1),
    set_player_active(5, 1),
    reset_cards_table.


run_pre_flop_action(Actual_position, End_position):-
    (Actual_position =:= End_position);
    print_table,
    ((get_player_active(Actual_position, Active), Active =:= 1,
        (
            (Actual_position =:= 0, clear_screen, print_table, show_user_actions);
            bot_actions, sleep(2), print_table
        )
    ); !),
    next_player(Next_position),
    run_pre_flop_action(Next_position, End_position).


run_action(Actual_position, End_position):-
    (Actual_position =:= End_position);
    print_table,
    ((get_player_active(Actual_position, Active), Active =:= 1,
        (
            (Actual_position =:= 0, clear_screen, print_table, show_user_actions);
            bot_actions, sleep(2), print_table
        )
    ); !),
    next_player(Next_position),
    first_bet_player(First_bet_player),
    run_action(Next_position, First_bet_player).


% ----- Partida manual --------

start_game_manual:-
    sleep(3),
    config_new_match,
    run_game_manual,
    clear_screen.

run_game_manual:-
    select_card_hand,
    set_pot(0),
    set_minimum_bet(2),
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
    show_infos,
    writeln(" ----- Selecione as cartas da sua mão ------"),
    config_card(Value1, Naipe1),
    config_card(Value2, Naipe2),
    set_player_cards(0, [Naipe1, Value1], [Naipe2, Value2]).

config_card(Value, Naipe):-
    writeln("Digite o Value da carta (2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A): "),
    read_line_to_string(user_input, ValueTest),
    writeln("Digite o naipe da carta (O, C, P, E): "),
    read_line_to_string(user_input, NaipeTest),
    ((not(get_card_selected([NaipeTest, ValueTest])), (card_invalid_message), config_card(Value, Naipe));
    Value = ValueTest,
    Naipe = NaipeTest,
    write("Carta: "),
    write(Value),
    write(" "),
    writeln(Naipe)).

card_invalid_message:-
    writeln("                       Carta inválida... Selecione outra !"),
    sleep(1).

flop_round_manual:-
    select_flop_cards.

select_flop_cards:- 
    clear_screen,
    writeln(" --- SELEÇÃO DAS TRÊS PRIMEIRAS CARTAS DA MESA --- "),
    config_card(Value0, Naipe0),
    set_card_table(0, Value0, Naipe0),
    config_card(Value1, Naipe1),
    set_card_table(1, Value1, Naipe1),
    config_card(Value2, Naipe2),
    set_card_table(2, Value2, Naipe2).

select_turn_card:-
    clear_screen,
    writeln(" --- SELEÇÃO DA CARTA DE TURN --- "),
    config_card(Value, Naipe),
    set_card_table(3, Value, Naipe).

select_river_card:-
    clear_screen,
    writeln(" --- SELEÇÃO DA CARTA DE RIVER --- "),
    config_card(Value, Naipe),
    set_card_table(4, Value, Naipe).

turn_round_manual:-
    select_turn_card,
    minimum_bet(Minimum_bet),
    New_minimun_bet is Minimum_bet * 2,
    set_minimum_bet(New_minimun_bet).

river_round_manual:-
    select_river_card.

invalid_action :- 
    clear_screen,
    writeln("\n\n\n              Ação inválida, escolha outra opção !\n\n\n"),
    sleep(3).

end_game:-
    show_winners,
    clear_screen,
    show_profile,
    sleep(15),
    clear_screen,
    writeln("\n\n                                   FIM DO JOGO !!!\n\n\n"),
    writeln("                         Deseja continuar jogando ? 1 (Sim) / 2 (Não)\n"),
    input_number(Op),
    ((Op =:= 1, start_game);
    clear_screen).

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
    New_active_players is (Active_players - 1),
    set_active_players(New_active_players).


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
select_player_option(_):- invalid_action, clear_screen, print_table, show_user_actions.

bot_actions:- current_round(Current_round),run_bot(Current_round).

init_players_hand:-
    get_first_card(P0_card1), get_first_card(P0_card2),
    get_first_card(P1_card1), get_first_card(P1_card2),
    get_first_card(P2_card1), get_first_card(P2_card2),
    get_first_card(P3_card1), get_first_card(P3_card2),
    get_first_card(P4_card1), get_first_card(P4_card2),
    get_first_card(P5_card1), get_first_card(P5_card2),

    set_player_cards(0, P0_card1, P0_card2),
    set_player_cards(1, P1_card1, P1_card2),
    set_player_cards(2, P2_card1, P2_card2),
    set_player_cards(3, P3_card1, P3_card2),
    set_player_cards(4, P4_card1, P4_card2),
    set_player_cards(5, P5_card1, P5_card2).
    

run_bot(0):- % Apenas a probabilidade de vitoria 
         actual_player(Actual_player),
         random(0,40.0,RandProb),
         get_player_pre_flop_prob(Actual_player, WinProb),
         RandProb > WinProb,
         call_action(Result), Result =:= 1 -> writeln("Bot Call");
         fold_action,writeln("Bot Fold").

run_bot(1):- % Apenas a probabilidade de vitoria
        (actual_player(Actual_player),
         random(0,40.0,RandProb),
         get_player_flop_turn_prob(Actual_player, WinProb),
         RandProb < WinProb) -> fold_action,writeln("Bot Fold");
         % Probabilidade de vitoria e nao houve aposta antes
         (last_bet(Last_bet),
         Last_bet =:= 0,
         random(0,35.0,RandProb),
         get_player_flop_turn_prob(Actual_player, WinProb),
         RandProb < WinProb) ->
            ((call_action(Result), Result =:= 1) -> writeln("Bot Call"); 
            (last_bet(Last_bet),
            Last_bet =:= 0,
            random(0,30.0,RandProb),
            get_player_flop_turn_prob(Actual_player, WinProb),
            RandProb < WinProb) ->
                ((check_action(Result), Result =:= 1) -> writeln("Bot Check"); 
                fold_action,writeln("Bot Fold"));
         % Houve aposta antes
         (call_action(Result), Result =:= 1) -> writeln("Bot Call");
         fold_action,writeln("Bot Fold")).

% Chances de continuar na partida são maiores %          
run_bot(2):- 
         % Probabilidade de vitoria e nao houve aposta antes
         (last_bet(Last_bet),
         Last_bet =:= 0,
         random(0,15.0,RandProb),
         get_player_turn_river_prob(Actual_player, WinProb),
         RandProb < WinProb) ->
            ((call_action(Result), Result =:= 1) -> writeln("Bot Call"); 
            (last_bet(Last_bet),
            Last_bet =:= 0,
            random(0,30.0,RandProb),
            get_player_flop_turn_prob(Actual_player, WinProb),
            RandProb < WinProb) ->
                ((check_action(Result), Result =:= 1) -> writeln("Bot Check"); 
            fold_action, writeln("Bot Fold"));
         % Houve aposta antes
         (call_action(Result), Result =:= 1) -> writeln("Bot Call");
         fold_action,writeln("Bot Fold")).

% Chances de continuar na partida são maiores %
run_bot(3):- % Probabilidade de vitoria e nao houve aposta antes
         (last_bet(Last_bet),
         Last_bet =:= 0,
         random(0,15.0,RandProb),
         get_player_river_showdown_prob(Actual_player, WinProb),
         RandProb < WinProb) ->
            ((call_action(Result), Result =:= 1) -> writeln("Bot Call"); 
            (last_bet(Last_bet),
            Last_bet =:= 0,
            random(0,35.0,RandProb),
            get_player_flop_turn_prob(Actual_player, WinProb),
            RandProb > WinProb) ->
                ((check_action(Result), Result =:= 1) -> writeln("Bot Check"); 
                fold_action, writeln("Bot Fold"));
         % Houve aposta antes
         (call_action(Result), Result =:= 1) -> writeln("Bot Call");
         fold_action, writeln("Bot Fold")).

show_infos:-
    dealer_position(Dealer_position),
    small_position(Small_position),
    big_position(Big_position),
    minimum_bet(Min_bet),
    cards_table(0, Value0, Naipe0),
    cards_table(1, Value1, Naipe1),
    cards_table(2, Value2, Naipe2),
    cards_table(3, Value3, Naipe3),
    cards_table(4, Value4, Naipe4),
    active_players(Active_players),
    pot(Pot),
    current_round(Current_round),
    actual_player(Actual_player),
    first_bet_player(First_bet_player),
    write("Posição do Dealer: "), writeln(Dealer_position),
    write("Posição do Small: "), writeln(Small_position),
    write("Posição do Big: "), writeln(Big_position),
    write("Aposta mínima: "), writeln(Min_bet),
    write("Cartas da mesa: "),
    write(Value0), write("  "), writeln(Naipe0),
    write(Value1), write("  "), writeln(Naipe1),
    write(Value2), write("  "), writeln(Naipe2),
    write(Value3), write("  "), writeln(Naipe3),
    write(Value4), write("  "), writeln(Naipe4),
    write("Pot: "), writeln(Pot),    
    write("Round: "), writeln(Current_round),
    write("Jogador atual: "), writeln(Actual_player),
    write("Primeiro a apostar: "), writeln(First_bet_player),
    write("Jogadores ativos: "), writeln(Active_players),
    get_player_cards(0, P0_Card1, P0_Card2),
    get_player_cards(1, P1_Card1, P1_Card2),
    get_player_cards(2, P2_Card1, P2_Card2),
    get_player_cards(3, P3_Card1, P3_Card2),
    get_player_cards(4, P4_Card1, P4_Card2),
    get_player_cards(5, P5_Card1, P5_Card2),
    write(P0_Card1), writeln(P0_Card2),
    write(P1_Card1), writeln(P1_Card2),
    write(P2_Card1), writeln(P2_Card2),
    write(P3_Card1), writeln(P3_Card2),
    write(P4_Card1), writeln(P4_Card2),
    write(P5_Card1), writeln(P5_Card2),
    write("\n\n").

print_table:-
    clear_screen,
    printTable.

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
                             append([Card1],[Card2],Hand),
                             get_all_cards_table(TableCards),
                             append(Hand,TableCards,AllCards),
                             verifyHand(AllCards, HandStatus),
                             get_improve_prob(HandStatus,ImproveProb),
                             get_player_pre_flop_prob(Pos, PreFlopProb),
                             FlopToTurnProb is PreFlopProb * (1 - ImproveProb),
                             write("Probabilidade: "), writeln(FlopToTurnProb),
                             set_player_flop_turn_prob(Pos, FlopToTurnProb),
                             Aux is Pos + 1,
                             set_players_probs(1, Aux).

set_players_probs(2, Pos):- get_player_cards(Pos, Card1, Card2),
                            append([Card1],[Card2],Hand),
                            get_all_cards_table(TableCards),
                            append(Hand,TableCards,AllCards),
                            verifyHand(AllCards, HandStatus),
                            get_improve_prob(HandStatus,ImproveProb),
                            get_player_flop_turn_prob(Pos, FlopToTurnProb),
                            TurnToRiverProb is FlopToTurnProb * (1 - ImproveProb),
                            write("Probabilidade: "), writeln(TurnToRiverProb),
                            set_player_turn_river_prob(Pos, TurnToRiverProb),
                            Aux is Pos + 1,
                            set_players_probs(2, Aux).

set_players_probs(3, Pos):- get_player_cards(Pos, Card1, Card2),
                            append([Card1],[Card2],Hand),
                            get_all_cards_table(TableCards),
                            append(Hand,TableCards,AllCards),
                            verifyHand(AllCards, HandStatus),
                            get_improve_prob(HandStatus,ImproveProb),
                            get_player_turn_river_prob(Pos, TurnToRiverProb),
                            RiverToShowDownProb is TurnToRiverProb * (1 - ImproveProb),
                            write("Probabilidade: "), writeln(RiverToShowDownProb),
                            set_player_river_showdown_prob(Pos, RiverToShowDownProb),
                            Aux is Pos + 1,
                            set_players_probs(3, Aux).

% VENCEDORES 

show_winners:-
    writeln("***********************"),
    writeln("****** FINALISTAS *****"),
    writeln("***********************"),
    get_finalists(0, 0, Big),
    writeln("\n\n***********************"),
    writeln("****** VENCEDORES *****"),
    writeln("***********************"),
    print_winners(0, Big),
    sleep(15).


print_winners(6,Biggest):- !.
print_winners(Pos, Biggest):- 
    ((get_player_active(Pos, Active),
    Active =:= 1,
    get_player_cards(Pos, Card1, Card2),
    append([Card1],[Card2],Hand),
    get_all_cards_table(TableCards),
    append(Hand,TableCards,AllCards),
    verifyHand(AllCards, HandStatus),
    map_hands(HandStatus, Value),
    Value =:= Biggest,
    Id is Pos + 1) ->
    (write("Player "),write(Id),write(" -> "),writeln(HandStatus),print_winners(Id, Biggest)));
    (Id is Pos + 1,print_winners(Id, Biggest)).

get_finalists(6,BigAux, Biggest):- Biggest = BigAux.
get_finalists(Pos, BigAux, Biggest):- 
    get_player_active(Pos, Active),Active =:= 1,Id is Pos + 1 -> 
        (   get_player_cards(Pos, Card1, Card2),
            append([Card1],[Card2],Hand),
            get_all_cards_table(TableCards),
            append(Hand,TableCards,AllCards),
            verifyHand(AllCards, HandStatus),
            write("Player "),write(Id),write(" -> "),writeln(HandStatus),
        (   get_player_cards(Pos, Card1, Card2),
            append([Card1],[Card2],Hand),
            get_all_cards_table(TableCards),
            append(Hand,TableCards,AllCards),
            verifyHand(AllCards, HandStatus),
            map_hands(HandStatus, Value), Value > BigAux ->
            get_finalists(Id, Value, Biggest); get_finalists(Id, BigAux, Biggest)));
Id is Pos + 1, get_finalists(Id, BigAux, Biggest).

map_hands("IS_HIGH_CARD", 0).
map_hands("IS_ONE_PAIR", 1).
map_hands("IS_TWO_PAIR", 2).
map_hands("IS_THREE", 3).
map_hands("IS_STRAIGHT", 4).
map_hands("IS_FLUSH", 5).
map_hands("IS_FULL_HOUSE", 6).


% PERFIL DO JOGADOR

show_profile:-
    writeln("        .------..------..------..------..------..------."),
    writeln("        |P.--. ||E.--. ||R.--. ||F.--. ||I.--. ||L.--. |"),
    writeln("        | :/\134: || (\134/) || :(): || :(): || (\134/) || :/\134: |"),
    writeln("        | (__) || :\134/: || ()() || ()() || :\134/: || (__) |"),
    writeln("        | '--'P|| '--'E|| '--'R|| '--'F|| '--'I|| '--'L|"),
    writeln("        `------'`------'`------'`------'`------'`------'"),
    writeln(" "),
    writeln("PERFIS POSSÍVEIS"),
    writeln(" "),
    writeln("[-] MUITO AGRESSIVO [-] AGRESSIVO [+] MUITO MODERADO [+] MODERADO"),
    get_average_prob(AvgProb),
    pot(Pot),
    AvgPot is Pot/ 4,
    show_profile_status(AvgProb,AvgPot).

get_average_prob(Prob):- 
    writeln(" "),
    writeln("PROBABILIDADES"),
    writeln(" "),
    get_player_pre_flop_prob(0, Prob1),
    write("* PRÉ-FLOP ---> "), writeln(Prob1),
    get_player_flop_turn_prob(0, Prob2),
    write("* FLOP -------> "), writeln(Prob2),
    get_player_turn_river_prob(0, Prob3),
    write("* TURN -------> "), writeln(Prob3),
    get_player_river_showdown_prob(0, Prob4),
    write("* RIVER ------> "), writeln(Prob4),
    writeln(" "),
    Sum is (Prob1 + Prob2 + Prob3 + Prob4),
    Prob is Sum / 4.

show_profile_status(AvgProb,AvgPot):-
    get_player_pre_flop_prob(0, FlopToTurn),
    get_player_chips(0, Chips),
    AvgProb < FlopToTurn -> worst_hand(AvgPot, Chips);
    better_hand(AvgPot, Chips).

worst_hand(AvgPot, Chips):-
    Chips < AvgPot -> show_msg_profile1;
    show_msg_profile2.

better_hand(AvgPot, Chips):-
    Chips < AvgPot -> show_msg_profile3;
    show_msg_profile4.

show_msg_profile1:- 
    writeln(" "),
    writeln("Seu perfil é MUITO AGRESSIVO, no geral sua probabilidade"),
    writeln("de vitória não melhorou em relação a sua probabilidade no FLOP "),
    writeln("e suas fichas estão abaixo da média do pote.").
    
show_msg_profile2:- 
    writeln(" "),
    writeln("Seu perfil é AGRESSIVO, no geral sua probabilidade"),
    writeln("de vitória não melhorou em relação a sua probabilidade no FLOP,"),
    writeln("mas suas fichas estão acima da média do pote.").

show_msg_profile3:- 
    writeln(" "),
    writeln("Seu perfil é MUITO MODERADO, no geral sua probabilidade"), 
    writeln("de vitória melhorou em relação a sua probabilidade no FLOP,"),
    writeln("mas suas fichas estão abaixo da média do pote").

show_msg_profile3:- 
    writeln(" "),
    writeln("Seu perfil é MODERADO, no geral sua probabilidade"), 
    writeln("de vitória melhorou em relação a sua probabilidade no FLOP"),  
    writeln("e suas fichas estão acima da média do pote").
