% P26 (**):  Generate the combinations of k distinct objects
%            chosen from the n elements of a list.

% combination(K,L,C) :- C is a list of K distinct elements 
%    chosen from the list L

combination(0,_,[]).
combination(K,L,[X|Xs]) :- K > 0,
   el(X,L,R), K1 is K-1, combination(K1,R,Xs).

% Find out what the following predicate el/3 exactly does.

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).
