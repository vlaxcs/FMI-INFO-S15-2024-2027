% laboratorul 6

srd(vid,[]).
srd(arb(R,T,U),L) :- srd(T,L1), srd(U,L2),
	append(L1,[R|L2],L).

bt_ins(X, vid, arb(X,vid,vid)).
bt_ins(X, arb(R,T,U), arb(R,NT,U)) :-
	X =< R,
	bt_ins(X, T, NT).
bt_ins(X, arb(R,T,U), arb(R,T,NU)) :-
	X > R,
	bt_ins(X, U, NU).

bt_list([], vid).
bt_list([H|T0], R) :-
	bt_list(T0, T),
	bt_ins(H, T, R).

bt_sort(I, O) :-
	bt_list(I, T),
	srd(T, O).

listN([], 0).
listN([a|T], N) :-
	N > 0,
	M is N - 1,
	listN(T, M).

% rev([], []).
% rev([H|T], L) :- rev(T, N), append(N, [H], L).

reva(L, R) :- revah(L, [], R).
revah([], R, R).
revah([H|T], S, N) :- revah(T, [H|S], N).

revd(L,R) :- revdh(L,(R,[])).
revdh([],(R,R)).
revdh([H|T],(N,S)) :- revdh(T,(N,[H|S])).

flatten(L,R) :- flattenh(L, [], R).
flattenh([], A, A).
flattenh([H|T], A, R) :-
	\+ is_list(H),
	append(A, [H], A0),
	flattenh(T,A0,R).
flattenh([H|T], A, R) :-
	is_list(H),
	flattenh(H, A, R0),
	flattenh(T, R0, R).

flattend(L,R) :- flattendh(L,(R,[])).
flattendh([],(R,R)).
flattendh([H|T],(B,E)) :-
	is_list(H),
	flattendh(H,(B,M)),
	flattendh(T,(M,E)).
flattendh([H|T],([H|B],E)) :-
	\+ is_list(H),
	flattendh(T,(B,E)).

quicksort([],[]).
quicksort([H|T],L) :-
	split(H,T,A,B), quicksort(A,M),
	quicksort(B,N), append(M,[H|N],L).
split(_,[],[],[]).
split(X,[H|T],[H|A],B) :- H < X, split(X,T,A,B).
split(X,[H|T],A,[H|B]) :- H >= X, split(X,T,A,B).

sent(R) :- np(A), vp(B), append(A,B,R).
np(R) :- dete(A), n(B), append(A,B,R).
vp(R) :- tv(A), np(B), append(A,B,R).
vp(R) :- v(R).
dete([the]). dete([a]). dete([every]).
n([teacher]). n([doctor]). n([park]).
tv([likes]). v([walks]).

sentd(R) :- sentdh((R,[])).
sentdh((R,S)) :- npdh((R,Z)), vpdh((Z,S)).
npdh((R,S)) :- detedh((R,Z)), ndh((Z,S)).
vpdh((R,S)) :- tvdh((R,Z)), npdh((Z,S)).
vpdh((R,S)) :- vdh((R,S)).
detedh(([the|S],S)). detedh(([a|S],S)).
detedh(([every|S],S)).
ndh(([teacher|S],S)). ndh(([doctor|S],S)).
ndh(([park|S],S)).
tvdh(([likes|S],S)). vdh(([walks|S],S)).

sentgh --> np, vp.
np --> dete, n.
vp --> tv, np.
vp --> v.
dete --> [the]. dete --> [a]. dete --> [every].
n --> [teacher]. n --> [doctor]. n --> [park].
tv --> [likes]. v --> [walks].

parA --> par.
par --> [].
par --> [a], impar.
par --> [b], par.
impar --> [a], par.
impar --> [b], impar.

anbn --> [].
anbn --> [a], anbn, [b].
