% P61A (*) Collect the leaves of a binary tree in a list

:- ensure_loaded(p54).

% leaves(T,S) :- S is the list of the leaves of the binary tree T

leaves(nil,[]).
leaves(t(X,nil,nil),[X]).
leaves(t(_,L,nil),S) :- L = t(_,_,_), leaves(L,S).
leaves(t(_,nil,R),S) :- R = t(_,_,_), leaves(R,S).
leaves(t(_,L,R),S) :- L = t(_,_,_), R = t(_,_,_),
    leaves(L,SL), leaves(R,SR), append(SL,SR,S).

% The above solution works in the flow patterns (i,o) and (i,i)
% without cut and produces a single correct result. Using a cut 
% we can obtain the same result in a much shorter program, like this:

leaves1(nil,[]).
leaves1(t(X,nil,nil),[X]) :- !.
leaves1(t(_,L,R),S) :- 
    leaves1(L,SL), leaves1(R,SR), append(SL,SR,S).

% To write a predicate that works in the flow pattern (o,i)
% is a more difficult problem, because using append/3 in
% the flow pattern (o,o,i) always generates an empty list 
% as first solution and the result is an infinite recursion
% along the left subtree of the generated binary tree.
% A possible solution is the following trick: we successively
% construct binary tree structures for a given number of nodes
% and fill the leaf nodes with the elements of the leaf list.
% We then increment the number of tree nodes successively,
% and so on. 

% nnodes(T,N) :- T is a binary tree with N nodes (o,i)
nnodes(nil,0) :- !.
nnodes(t(_,L,R),N) :- N > 0, N1 is N-1, 
   between(0,N1,NL), NR is N1-NL,
   nnodes(L,NL), nnodes(R,NR).


% leaves2(T,S) :- S is the list of leaves of the tree T (o,i)

leaves2(T,S) :- leaves2(T,S,0).

leaves2(T,S,N) :- nnodes(T,N), leaves1(T,S).
leaves2(T,S,N) :- N1 is N+1, leaves2(T,S,N1).

% OK, this was difficulty (**)


