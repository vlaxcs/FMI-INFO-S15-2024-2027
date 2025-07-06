% P62B (*) Collect the nodes of a binary tree at a given level in a list

:- ensure_loaded(p54).

% atlevel(T,D,S) :- S is the list of nodes of the binary tree T at level D
% (i,i,o)

atlevel(nil,_,[]).
atlevel(t(X,_,_),1,[X]).
atlevel(t(_,L,R),D,S) :- D > 1, D1 is D-1,
   atlevel(L,D1,SL), atlevel(R,D1,SR), append(SL,SR,S).


% The following is a quick-and-dirty solution for the
% level-order sequence

levelorder(T,S) :- levelorder(T,S,1).

levelorder(T,[],D) :- atlevel(T,D,[]), !.
levelorder(T,S,D) :- atlevel(T,D,SD),
   D1 is D+1, levelorder(T,S1,D1), append(SD,S1,S).

