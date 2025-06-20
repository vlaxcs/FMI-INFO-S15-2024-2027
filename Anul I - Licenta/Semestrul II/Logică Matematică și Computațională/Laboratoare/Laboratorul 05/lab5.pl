% laboratorul 5

vars(Phi, [Phi]) :-
	atom(Phi).

vars(imp(A,B), Var) :-
	vars(A, VA),
	vars(B, VB),
	union(VA, VB, Var).

vars(non(A), Var) :-
	vars(A, Var).

vars(si(A,B), Var) :-
	vars(A, VA),
	vars(B, VB),
	union(VA, VB, Var).

vars(sau(A,B), Var) :-
	vars(A, VA),
	vars(B, VB),
	union(VA, VB, Var).

val(_, [], _).
val(V, [(V1,T)|E], A) :-
	V == V1,
	A is T,
	val(V, E, A).
val(V, [(V1,_)|E], A) :-
	V \== V1,
	val(V, E, A).

bsi(A1,A2,R) :-
	A1 = 0,
	A2 = 0,
	R = 0.
bsi(A1,A2,R) :-
	A1 = 0,
	A2 = 1,
	R = 0.
bsi(A1,A2,R) :-
	A1 = 1,
	A2 = 0,
	R = 0.
bsi(A1,A2,R) :-
	A1 = 1,
	A2 = 1,
	R = 1.

bimp(A1,A2,R) :-
	A1 = 0,
	A2 = 0,
	R = 1.
bimp(A1,A2,R) :-
	A1 = 0,
	A2 = 1,
	R = 1.
bimp(A1,A2,R) :-
	A1 = 1,
	A2 = 0,
	R = 0.
bimp(A1,A2,R) :-
	A1 = 1,
	A2 = 1,
	R = 1.

bsau(A1,A2,R) :-
	A1 = 0,
	A2 = 0,
	R = 0.
bsau(A1,A2,R) :-
	A1 = 0,
	A2 = 1,
	R = 1.
bsau(A1,A2,R) :-
	A1 = 1,
	A2 = 0,
	R = 1.
bsau(A1,A2,R) :-
	A1 = 1,
	A2 = 1,
	R = 1.

bnon(A, R) :-
	A = 0,
	R = 1.
bnon(A, R) :-
	A = 1,
	R = 0.

eval(X, E, A) :-
	atom(X),
	val(X, E, A).
eval(imp(X,Y), E, A) :-
	eval(X, E, A1),
	eval(Y, E, A2),
	bimp(A1,A2,A).
eval(si(X,Y), E, A) :-
	eval(X, E, A1),
	eval(Y, E, A2),
	bimp(A1,A2,A).
eval(sau(X,Y), E, A) :-
	eval(X, E, A1),
	eval(Y, E, A2),
	bimp(A1,A2,A).
eval(non(X), E, A) :-
	eval(X, E, A1),
	bnon(A1,A).

evals(_, [], []).
evals(X, [H|Es], [A|As]) :-
	eval(X, H, A),
	evals(X, Es, As).

pair([], _, []).
pair([V|Vs], Values, [(V,Val)|Rest]) :-
	member(Val, Values),
	pair(Vs, Values, Rest).

evs(Vars, R) :-
	findall(R0, pair(Vars, [0, 1], R0), R).

all_evals(X, As) :-
	vars(X, Vars),
	evs(Vars, Es),
	findall(A, (member(E, Es), eval(X, E, A)), As).

just_X([], _).
just_X([H|List], X) :-
	H = X,
	just_X(List, X).

taut(X) :-
	all_evals(X, R),
	just_X(R, 1).
