% P58 (**) Generate-and-test paradigm

% Apply the generate-and-test paradigm to construct all symmetric,
% completely balanced binary trees with a given number of nodes.

:- ensure_loaded(p55).
:- ensure_loaded(p56).


sym_cbal_tree(N,T) :- cbal_tree(N,T), symmetric(T).

sym_cbal_trees(N,Ts) :- setof(T,sym_cbal_tree(N,T),Ts).

investigate(A,B) :-
	between(A,B,N),
	sym_cbal_trees(N,Ts), length(Ts,L),
	writef('%w   %w',[N,L]), nl,
    fail.
investigate(_,_).
