% Module to extract a poker hand prob 
:- module(hand_prob, [get_hand_prob/4]).
:- use_module(library(apply)).
:- use_module(library(csv)).
:- set_prolog_flag(double_quotes, chars).

get_hand_prob(Card1, Card2, Numplayers, Prob) :-
  get_rows_data("../data/hands.csv", L), 
  Num is Numplayers - 1,
  format_hand(Card1,Card2,Hand),
  get_hand(Hand, Num, L, Prob).

get_hand(_, _, [], 0). 
get_hand(Hand, Numplayers, [[H|Ta]|Tb], Handprob) :-
  H = Hand,
  nth1(Numplayers, Ta, Handprob); 
  get_hand(Hand, Numplayers, Tb, Handprob).

get_rows_data(File, Lists):-
  csv_read_file(File, Rows, []),
  rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):-
  maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
  Row =.. [row|List].

format_hand([N1,V1],[N2,V2],Formated):-
  V1 =\= V2, N1 =:= N2,
    append(V1,V2,Values),
    append(Values,"s",Aux),
    atom_string(Aux,Formated);
  V1 =\= V2, N1 =\= N2,  
    append(V1,V2,Values),
    append(Values,"o",Aux),
    atom_string(Aux,Formated);
  V1 =:= V2,
    append(V1,V2,Values),atom_string(Values,Formated).