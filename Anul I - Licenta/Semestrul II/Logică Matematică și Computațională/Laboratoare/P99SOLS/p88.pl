% P88 (**) Connected components

%  Write a predicate that splits a graph into its connected components.

:- ensure_loaded(p80).  % conversions
:- ensure_loaded(p81).  % path/4

% connected_components(G,Gs) :- Gs is the list of the connected components
%    of the graph G (only for graphs, not for digraphs!)
%    (gterm, list-of-gterms), (+,-)

connected_components(graph([],[]),[]) :- !.
connected_components(graph(Ns,Es),[graph(Ns1,Es1)|Gs]) :-
   Ns = [N|_],
   component(graph(Ns,Es),N,graph(Ns1,Es1)),
   subtract(Ns,Ns1,NsR),
   subgraph(graph(Ns,Es),graph(NsR,EsR)),
   connected_components(graph(NsR,EsR),Gs).

component(graph(Ns,Es),N,graph(Ns1,Es1)) :-
   Pred =..[is_path,graph(Ns,Es),N],
   sublist(Pred,Ns,Ns1),
   subgraph(graph(Ns,Es),graph(Ns1,Es1)).

is_path(Graph,A,B) :- path(Graph,A,B,_).

% subgraph(G,G1) :- G1 is a subgraph of G
subgraph(graph(Ns,Es),graph(Ns1,Es1)) :-
   subset(Ns1,Ns),
   Pred =.. [edge_is_compatible,Ns1],
   sublist(Pred,Es,Es1).

edge_is_compatible(Ns1,Z) :- 
   (Z = e(X,Y),!; Z = e(X,Y,_)),
   memberchk(X,Ns1), 
   memberchk(Y,Ns1). 
