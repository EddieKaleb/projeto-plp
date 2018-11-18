% Module to extract a poker hand prob 
:- use_module(library(apply)).
:- use_module(library(csv)).

get_hand(Hand, Numplayers, Prob) :-
  get_rows_data("../data/hands.csv", L), 
  Num is Numplayers - 1,
  get_hand_prob(Hand, Num, L, Prob).

get_hand_prob(_, _, [], 0). 
get_hand_prob(Hand, Numplayers, [[H|Ta]|Tb], Handprob) :-
  H = Hand,
  nth1(Numplayers, Ta, Handprob); 
  get_hand_prob(Hand, Numplayers, Tb, Handprob).

get_rows_data(File, Lists):-
  csv_read_file(File, Rows, []),
  rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):-
  maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
  Row =.. [row|List].
