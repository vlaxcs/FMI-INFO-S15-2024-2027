% P81 (**) Path from one node to another one

% path(G,A,B,P) :- P is a (acyclic) path from node A to node B in the graph G.
%   G is given in graph-term form.
%   (+,+,+,?)

:- ensure_loaded(p80).  % conversions

path(G,A,B,P) :- path1(G,A,[B],P).

path1(_,A,[A|P1],[A|P1]).
path1(G,A,[Y|P1],P) :- 
   adjacent(X,Y,G), \+ memberchk(X,[Y|P1]), path1(G,A,[X,Y|P1],P).

% A useful predicate: adjacent/3

adjacent(X,Y,graph(_,Es)) :- member(e(X,Y),Es).
adjacent(X,Y,graph(_,Es)) :- member(e(Y,X),Es).
adjacent(X,Y,graph(_,Es)) :- member(e(X,Y,_),Es).
adjacent(X,Y,graph(_,Es)) :- member(e(Y,X,_),Es).
adjacent(X,Y,digraph(_,As)) :- member(a(X,Y),As).
adjacent(X,Y,digraph(_,As)) :- member(a(X,Y,_),As).

