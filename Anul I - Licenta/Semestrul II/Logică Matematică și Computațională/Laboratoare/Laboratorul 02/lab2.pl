% laboratorul 2
distance((X1, Y1), (X2, Y2), R) :-
	R is sqrt( (X1 - X2)**2 + (Y1 - Y2)**2 ).

tailfib(0, A, _, A).
tailfib(K, A, B, R) :-
	K > 0,
	K1 is K - 1,
	C is A + B,
	tailfib(K1, B, C, R).

% ineficient
% fib(N, X) :- N > 1, N1 is N - 1, N2 is N - 2, fib(N1, Y), fib(N2, Z), X is Y + Z.
% eficient cu tail recursion
fib(N, X) :- tailfib(N, 0, 1, R), X is R.

line(0, _).
line(N, A) :- N1 is N - 1, write(A), line(N1, A).
n_lines(0, _, _).
n_lines(C, N, A) :- D is C - 1, line(N, A), nl, n_lines(D, N, A).
square(N, A) :- n_lines(N, N, A).

all_X([X], X).
all_X([Elem|List], X) :- Elem = X, all_X(List, X).

all_a(List) :- all_X(List, a).
all_b(List) :- all_X(List, b).

trans_a_b(List1, List2) :- length(List1, N), length(List2, N), all_a(List1), all_b(List2).

scalarMult(_, [], []).
scalarMult(X, [Elem | Nums], [R | Rest]) :-
	integer(X),
	integer(Elem),
	R is X * Elem,
	scalarMult(X, Nums, Rest).

list_product([], [], _).
list_product([Head1|Tail1], [Head2|Tail2], [R|Result]) :-
	length([Head1|Tail1], N),
	length([Head2|Tail2], N),
	integer(Head1),
	integer(Head2),
	R is Head1 * Head2,
	list_product(Tail1, Tail2, Result).

add_elems([], 0).
add_elems([Head|Tail], Result) :-
	integer(Head),
	add_elems(Tail, TailResult),
	Result is Head + TailResult.

dot([], [], 0).
dot(List1, List2, Result) :-
	list_product(List1, List2, P),
	add_elems(P, Sum),
	Result is Sum.

bigger(X, Y, R) :-
	X > Y,
	R is X.
bigger(X, Y, R) :-
	X < Y,
	R is Y.

max([], 0).
max([Head|Tail], Result) :-
	max(Tail, TailResult),
	bigger(Head, TailResult, B),
	Result is B.
