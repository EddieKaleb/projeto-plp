% Module to extract a poker hand prob 
:- module(hand_prob, [get_hand_prob/4]).
:- use_module(library(apply)).
:- use_module(library(csv)).

get_hand_prob([N1,V1], [N2,V2], Numplayers, Prob) :-
  get_rows_data("../data/hands.csv", L), 
  Num is Numplayers - 1,
  format_hand([N1,V1], [N2,V2],Hand),
  get_hand(Hand, Num, L, Prob).

get_hand(_, _, [], 0). 
get_hand(Hand, Numplayers, [[H|Ta]|Tb], Handprob) :-
  atom_string(H,HStr),HStr = Hand -> nth1(Numplayers, Ta, Handprob); 
  get_hand(Hand, Numplayers, Tb, Handprob).

get_rows_data(File, Lists):-
  csv_read_file(File, Rows, []),
  rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):-
  maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
  Row =.. [row|List].

format_hand([N1,V1],[N2,V2],Formated):-
  V1 =\= V2,N1 =:= N2 -> string_concat(V1,V2,Values),string_concat(Values,'s',Formated);
  V1 =\= V2, N1 =\= N2 -> string_concat(V1,V2,Values), string_concat(Values,'o',Formated);
  string_concat(V1,V2,Formated),
  writeln(Formated).