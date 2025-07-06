% P84 (**) Construct the minimal spanning tree of a labelled graph 

% ms_tree(G,T,S) :- T is a minimal spanning tree of the graph G.
%    S is the sum of the edge values. Prim's algorithm.
%    (graph-term graph-term) (+,?)

:- ensure_loaded(p80).  % conversions
:- ensure_loaded(p83).  % transfer/3, incident/3, and accept/3

ms_tree(graph([N|Ns],GraphEdges),graph([N|Ns],TreeEdges),Sum) :- 
   predsort(compare_edge_values,GraphEdges,GraphEdgesSorted),
   transfer(Ns,GraphEdgesSorted,TreeEdgesUnsorted),
   sort(TreeEdgesUnsorted,TreeEdges),
   edge_sum(TreeEdges,Sum).

compare_edge_values(Order,e(X1,Y1,V1),e(X2,Y2,V2)) :- 
	compare(Order,V1+X1+Y1,V2+X2+Y2).

edge_sum([],0).
edge_sum([e(_,_,V)|Es],S) :- edge_sum(Es,S1), S is S1 + V. 

% Example graph p84.dat

test :-  
   see('p84.dat'), read(G), seen,
   human_gterm(H,G),
   write(H), nl, 
   ms_tree(G,T,S),
	human_gterm(TH,T),
   write(S), nl,
	write(TH).
