% laboratorul 3
get_head([], _).
get_head([Elem|_], Result) :-
	Result is Elem.

% rev([], []).
% rev([Head1|Tail1], Result) :-
% 	rev(Tail1, TailResult),
% 	append(TailResult, [Head1], Result).

% tail recursion
rev_helper([], Temp, Temp).
rev_helper([Head|Tail], Temp, Result) :-
	rev_helper(Tail, [Head | Temp], Result).
rev([], []).
rev(List, Result) :-
	rev_helper(List, [], Result).

lists_equal([], []).
lists_equal([Head1|Tail1], [Head2|Tail2]) :-
	Head1 == Head2,
	lists_equal(Tail1, Tail2).

palindrome(List) :-
	rev(List, Result),
	lists_equal(List, Result).

/*
remove_duplicates_helper([], Temp, Temp).
remove_duplicates_helper([Head|Tail], Temp, Result) :-
	\+ member(Head, Temp),
	remove_duplicates_helper(Tail, [Head|Temp], Result).
remove_duplicates_helper([Head|Tail], Temp, Result) :-
	member(Head, Temp),
	remove_duplicates_helper(Tail, Temp, Result).

remove_duplicates(List, Result) :-
	remove_duplicates_helper(List, [], Result).
*/

remove_duplicates([], []).
remove_duplicates([H|T], Result) :-
    member(H, T),
    remove_duplicates(T, Result).

remove_duplicates([H|T], [H|Result]) :-
    remove_duplicates(T, Result).

atimes_helper(_, [], Temp, Temp).
atimes_helper(Elem, [Head|Tail], Temp, Count) :-
	Elem == Head,
	NewTemp is Temp + 1,
	atimes_helper(Elem, Tail, NewTemp, Count).
atimes_helper(Elem, [Head|Tail], Temp, Count) :-
	Elem \== Head,
	atimes_helper(Elem, Tail, Temp, Count).
atimes(_, [], _).
atimes(Elem, List, Count) :-
	atimes_helper(Elem, List, 0, Count).

insertsort([], []).
insertsort([H|T], L) :- insertsort(T, L1), insert(H, L1, L).

insert(Elem, [], [Elem]).
insert(Elem, [Head|Tail], [Elem, Head|Tail]) :-
	Elem =< Head.
insert(Elem, [Head|Tail1], [Head|Tail2]) :-
	Elem > Head,
	insert(Elem, Tail1, Tail2).

quicksort([], []).
quicksort([H|T], L) :-
	split(H, T, A, B), quicksort(A, M), quicksort(B, N),
	append(M, [H|N], L).

split(_, [], [], []).
split(P, [H|I], [H|L], G) :-
	H =< P,
	split(P, I, L, G).
split(P, [H|I], L, [H|G]) :-
	H > P,
	split(P, I, L, G).
