% laboratorul 4

listaNelem(_, 0, []).
listaNelem(L, N, [X|M]) :-
	N > 0,
	N1 is N - 1,
	member(X, L),
	listaNelem(L, N1, M).

listeNelem(L, N, LL) :- bagof(M, listaNelem(L, N, M), LL).

% exercitiul 2

word(abalone,a,b,a,l,o,n,e).
word(abandon,a,b,a,n,d,o,n).
word(anagram,a,n,a,g,r,a,m).
word(connect,c,o,n,n,e,c,t).
word(elegant,e,l,e,g,a,n,t).
word(enhance,e,n,h,a,n,c,e).

crosswd(H1, H2, H3, V1, V2, V3) :-
	word(V1, _, A, _, B, _, C, _),
	word(V2, _, D, _, E, _, F, _),
	word(V3, _, G, _, H, _, I, _),
	word(H1, _, A, _, D, _, G, _),
	word(H2, _, B, _, E, _, H, _),
	word(H3, _, C, _, F, _, I, _).

% exercitiul 3

connected(1,2).
connected(3,4).
connected(5,6).
connected(7,8).
connected(9,10).
connected(12,13).
connected(13,14).
connected(15,16).
connected(17,18).
connected(19,20).
connected(4,1).
connected(6,3).
connected(4,7).
connected(6,11).
connected(14,9).
connected(11,15).
connected(16,12).
connected(14,17).
connected(16,19).

path(P1, P2, [(P1, P2)]) :-
	connected(P1, P2).
path(P1, P2, [(P1, X)|L]) :-
	connected(P1, X),
	path(X, P2, L).

pathc(P1, P2) :-
	path(P1, P2, _).

% exercitiul 4

word_letters(A, L) :-
	atom_chars(A, L).

count_letters(_, [], 0).
count_letters(L, [H|WL], C) :-
	count_letters(L, WL, CN),
	L = H,
	C is CN + 1.
count_letters(L, [H|WL], C) :-
	count_letters(L, WL, CN),
	L \= H,
	C is CN.

cover([], _).
cover([H|T], L) :-
	count_letters(H, [H|T], C1),
	count_letters(H, L, C2),
	C1 =< C2,
	cover(T, L).

solution(WordDict, Word, Length) :-
	word(Word),
	word_letters(Word, WordList),
	length(WordList, Length),
	cover(WordList, WordDict).
