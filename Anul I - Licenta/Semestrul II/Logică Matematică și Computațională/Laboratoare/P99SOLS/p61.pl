% P61 (*) Count the leaves of a binary tree

:- ensure_loaded(p54).

% count_leaves(T,N) :- the binary tree T has N leaves

count_leaves(nil,0).
count_leaves(t(_,nil,nil),1).
count_leaves(t(_,L,nil),N) :- L = t(_,_,_), count_leaves(L,N).
count_leaves(t(_,nil,R),N) :- R = t(_,_,_), count_leaves(R,N).
count_leaves(t(_,L,R),N) :- L = t(_,_,_), R = t(_,_,_),
   count_leaves(L,NL), count_leaves(R,NR), N is NL + NR.

% The above solution works in the flow patterns (i,o) and (i,i)
% without cut and produces a single correct result. Using a cut 
% we can obtain the same result in a much shorter program, like this:

count_leaves1(nil,0).
count_leaves1(t(_,nil,nil),1) :- !.
count_leaves1(t(_,L,R),N) :- 
    count_leaves1(L,NL), count_leaves1(R,NR), N is NL+NR.

% For the flow pattern (o,i) see P61A
