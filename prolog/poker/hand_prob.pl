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

% Falta ordenar cartas 
format_hand([N1,V1],[N2,V2],Formated):-
  map_card(V1,R1),map_card(V2,R2),R1 >= R2,
  V1 =\= V2,N1 =:= N2 -> string_concat(V1,V2,Values),string_concat(Values,'s',Formated);
  map_card(V1,R1),map_card(V2,R2),R2 >= R1,
  V1 =\= V2,N1 =:= N2 -> string_concat(V2,V1,Values),string_concat(Values,'s',Formated);
  map_card(V1,R1),map_card(V2,R2),R1 >= R2,
  V1 =\= V2,N1 =\= N2 -> string_concat(V1,V2,Values), string_concat(Values,'o',Formated);
  map_card(V1,R1),map_card(V2,R2),R2 >= R1,
  V1 =\= V2,N1 =\= N2 -> string_concat(V2,V1,Values), string_concat(Values,'o',Formated);
  string_concat(V1,V2,Formated).

map_card("2",2).
map_card("3",3).
map_card("4",4).
map_card("5",5).
map_card("6",6).
map_card("7",7).
map_card("8",8).
map_card("9",9).
map_card("T",10).
map_card("J",11).
map_card("Q",12).
map_card("K",13).
map_card("A",14).