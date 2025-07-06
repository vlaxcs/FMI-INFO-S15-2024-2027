% (**) P87 Depth-first order graph traversal

% Write a predicate that generates a depth-first order graph
% traversal sequence. The starting point should be specified,
% and the output should be a list of nodes that are reachable from
% this starting point (in depth-first order).

% The main problem is that if we traverse the graph recursively,
% we must store the encountered nodes in such a way that they
% do not disappear during the backtrack step.

% In this solution we use the "recorded database" which is a
% more efficient alternative to the well-known assert/retract 
% mechanism. See the SWI-Prolog manuals for details.

:- ensure_loaded(p80).  % conversions
:- ensure_loaded(p81).  % adjacent/3

depth_first_order(Graph,Start,Seq) :- 
   (Graph = graph(Ns,_), !; Graph = digraph(Ns,_)),
   memberchk(Start,Ns),
   clear_rdb(dfo),
   recorda(dfo,Start),
   (dfo(Graph,Start); true),
   bagof(X,recorded(dfo,X),Seq).

dfo(Graph,X) :-
   adjacent(X,Y,Graph), 
   \+ recorded(dfo,Y),
   recordz(dfo,Y),
   dfo(Graph,Y).

clear_rdb(Key) :-
   recorded(Key,_,Ref), erase(Ref), fail.
clear_rdb(_).


