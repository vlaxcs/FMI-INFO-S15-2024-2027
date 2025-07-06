% P82 (*) Cycle from a given node

% cycle(G,A,P) :- P is a closed path starting at node A in the graph G.
%    G is given in graph-term form.
%    (+,+,?)

:- ensure_loaded(p80).  % conversions
:- ensure_loaded(p81).  % adjacent/3 and path/4

cycle(G,A,P) :- 
   adjacent(B,A,G), path(G,A,B,P1), length(P1,L), L > 2, append(P1,[A],P).
