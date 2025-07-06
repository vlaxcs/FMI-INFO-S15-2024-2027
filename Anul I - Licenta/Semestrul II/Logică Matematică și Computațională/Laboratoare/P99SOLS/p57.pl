% P57 (**) Binary search trees (dictionaries)

% Use the predicate add/3, developed in chapter 4 of the course,
% to write a predicate to construct a binary search tree 
% from a list of integer numbers. Then use this predicate to test 
% the solution of the problem P56

:- ensure_loaded(p56).

% add(X,T1,T2) :- the binary dictionary T2 is obtained by 
% adding the item X to the binary dictionary T1
% (element,binary-dictionary,binary-dictionary) (i,i,o)

add(X,nil,t(X,nil,nil)).
add(X,t(Root,L,R),t(Root,L1,R)) :- X @< Root, add(X,L,L1).
add(X,t(Root,L,R),t(Root,L,R1)) :- X @> Root, add(X,R,R1).

construct(L,T) :- construct(L,T,nil).

construct([],T,T).
construct([N|Ns],T,T0) :- add(N,T0,T1), construct(Ns,T,T1).
 	
test_symmetric(L) :- construct(L,T), symmetric(T).
