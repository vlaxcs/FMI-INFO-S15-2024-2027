% P70C: Write a predicate nnodes/2 to count the nodes of a multiway tree.
%
% nnodes(T,N) :- the multiway tree T has N nodes (i,o))

% the following is a test case:
tree(1,t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])).

nnodes(t(_,F),N) :- nnodes(F,NF), N is NF+1.

nnodes([],0).
nnodes([T|Ts],N) :- nnodes(T,NT), nnodes(Ts,NTs), N is NT+NTs.

% Note that nnodes is called for trees and for forests. An early
% form of polymorphism!

% For the flow pattern (o,i) we can write:

nnodes2(t(_,F),N) :- N > 0, NF is N-1, nnodes2F(F,NF).

nnodes2F([],0).
nnodes2F([T|Ts],N) :- N > 0, 
   between(1,N,NT), nnodes2(T,NT), 
   NTs is N-NT, nnodes2F(Ts,NTs).
