% P83 (**) Construct all spanning trees 

% s_tree(G,T) :- T is a spanning tree of the graph G
%    (graph-term graph-term) (+,?)

:- ensure_loaded(p80).  % conversions

s_tree(graph([N|Ns],GraphEdges),graph([N|Ns],TreeEdges)) :- 
   transfer(Ns,GraphEdges,TreeEdgesUnsorted),
   sort(TreeEdgesUnsorted,TreeEdges).

% transfer(Ns,GEs,TEs) :- transfer edges from GEs (graph edges)
%    to TEs (tree edges) until the list NS of still unconnected tree nodes
%    becomes empty. An edge is accepted if and only if one end-point is 
%    already connected to the tree and the other is not.

transfer([],_,[]).
transfer(Ns,GEs,[GE|TEs]) :- 
   select(GE,GEs,GEs1),        % modified 15-May-2001
   incident(GE,X,Y),
   acceptable(X,Y,Ns),
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   transfer(Ns2,GEs1,TEs).

incident(e(X,Y),X,Y).
incident(e(X,Y,_),X,Y).

acceptable(X,Y,Ns) :- memberchk(X,Ns), \+ memberchk(Y,Ns), !.
acceptable(X,Y,Ns) :- memberchk(Y,Ns), \+ memberchk(X,Ns).

% An almost trivial use of the predicate s_tree/2 is the following
% tree tester predicate:
 
% is_tree(G) :- the graph G is a tree
is_tree(G) :- s_tree(G,G), !.


% Another use is the following connectivity tester:

% is_connected(G) :- the graph G is connected
is_connected(G) :- s_tree(G,_), !.

% Example graph p83.dat

test :-  
   see('p83.dat'), read(G), seen,
   human_gterm(H,G),
   write(H), nl, 
   setof(T,s_tree(G,T),Ts), length(Ts,N),
   write(N).
