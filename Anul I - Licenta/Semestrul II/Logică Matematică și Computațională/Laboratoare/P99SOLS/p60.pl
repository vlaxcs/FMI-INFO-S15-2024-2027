% P60 (**) Construct height-balanced binary trees with a given number of nodes

:- ensure_loaded(p59).

% minNodes(H,N) :- N is the minimum number of nodes in a height-balanced 
% binary tree of height H
% (integer,integer) (+,?)

minNodes(0,0) :- !.
minNodes(1,1) :- !.
minNodes(H,N) :- H > 1, 
	H1 is H - 1, H2 is H - 2,
	minNodes(H1,N1), minNodes(H2,N2),
	N is 1 + N1 + N2.

% maxNodes(H,N) :- N is the maximum number of nodes in a height-balanced 
% binary tree of height H
% (integer,integer) (+,?)

maxNodes(H,N) :- N is 2**H - 1.

% minHeight(N,H) :- H is the minimum height of a height-balanced 
% binary tree with N nodes
% (integer,integer) (+,?)

minHeight(0,0) :- !.
minHeight(N,H) :- N > 0, N1 is N//2, minHeight(N1,H1), H is H1 + 1.

% maxHeight(N,H) :- H is the maximum height of a height-balanced 
% binary tree with N nodes
% (integer,integer) (+,?)

maxHeight(N,H) :- maxHeight(N,H,1,1).

maxHeight(N,H,H1,N1) :- N1 > N, !, H is H1 - 1.
maxHeight(N,H,H1,N1) :- N1 =< N, 
	H2 is H1 + 1, minNodes(H2,N2), maxHeight(N,H,H2,N2).

% hbal_tree_nodes(N,T) :- T is a height-balanced binary tree with N nodes.

hbal_tree_nodes(N,T) :- 
	minHeight(N,Hmin), maxHeight(N,Hmax),
	between(Hmin,Hmax,H),
	hbal_tree(H,T), nodes(T,N).

% the following predicate is from the course (chapter 4)

%  nodes(T,N) :- the binary tree T has N nodes
% (tree,integer);  (i,*) 
 
nodes(nil,0).
nodes(t(_,Left,Right),N) :-
   nodes(Left,NLeft),
   nodes(Right,NRight),
   N is NLeft + NRight + 1.

% count_hbal_trees(N,C) :- there are C different height-balanced binary
% trees with N nodes.

count_hbal_trees(N,C) :- setof(T,hbal_tree_nodes(N,T),Ts), length(Ts,C). 