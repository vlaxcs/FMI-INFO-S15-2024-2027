% P86 (**) Node degree and graph coloration

:- ensure_loaded(p80).  % conversions
:- ensure_loaded(p81).  % adjacent/3

% a) Write a predicate degree(Graph,Node,Deg) that determines the degree 
% of a given node. 

% degree(Graph,Node,Deg) :- Deg is the degree of the node Node in the
%    graph Graph.
%    (graph-term, node, integer), (+,+,?).

degree(graph(Ns,Es),Node,Deg) :- 
   alist_gterm(graph,AList,graph(Ns,Es)),
   member(n(Node,AdjList),AList), !,
   length(AdjList,Deg).

% --------------------------------------------------------------------------

% b) Write a predicate that generates a list of all nodes of a graph 
% sorted according to decreasing degree.

% degree_sorted_nodes(Graph,Nodes) :- Nodes is the list of the nodes
%    of the graph Graph, sorted according to decreasing degree.

degree_sorted_nodes(graph(Ns,Es),DSNodes) :- 
   alist_gterm(graph,AList,graph(Ns,Es)),  
   predsort(compare_degree,AList,AListDegreeSorted),
   reduce(AListDegreeSorted,DSNodes).

compare_degree(Order,n(N1,AL1),n(N2,AL2)) :-
   length(AL1,D1), length(AL2,D2),
   compare(Order,D2+N1,D1+N2).

% Note: compare(Order,D2+N1,D1+N2) sorts the nodes according to 
% decreasing degree, but alphabetically if the degrees are equal. Cool!

reduce([],[]).
reduce([n(N,_)|Ns],[N|NsR]) :- reduce(Ns,NsR).

% --------------------------------------------------------------------------

% c) Use Welch-Powell's algorithm to paint the nodes of a graph in such 
% a way that adjacent nodes have different colors.

% Use Welch-Powell's algorithm to paint the nodes of a graph
% in such a way that adjacent nodes have different colors.

paint(Graph,ColoredNodes) :-
   degree_sorted_nodes(Graph,DSNs),
   paint_nodes(Graph,DSNs,[],1,ColoredNodes).

% paint_nodes(Graph,Ns,AccNodes,Color,ColoNodes) :- paint the remaining
%    nodes Ns with a color number Color or higher. AccNodes is the set
%    of nodes already colored. Return the result in ColoNodes.
%    (graph-term,node-list,c-node-list,integer,c-node-list)
%    (+,+,+,+,-) 
paint_nodes(_,[],ColoNodes,_,ColoNodes) :- !.
paint_nodes(Graph,Ns,AccNodes,Color,ColoNodes) :-
   paint_nodes(Graph,Ns,Ns,AccNodes,Color,ColoNodes).
   
% paint_nodes(Graph,DSNs,Ns,AccNodes,Color,ColoNodes) :- paint the
%    nodes in Ns with a fixed color number Color, if possible.
%    If Ns is empty, continue with the next color number.
%    AccNodes is the set of nodes already colored. 
%    Return the result in ColoNodes.
%    (graph-term,node-list,c-node-list,c-node-list,integer,c-node-list)
%    (+,+,+,+,+,-) 
paint_nodes(Graph,Ns,[],AccNodes,Color,ColoNodes) :- !,
   Color1 is Color+1,
   paint_nodes(Graph,Ns,AccNodes,Color1,ColoNodes).
paint_nodes(Graph,DSNs,[N|Ns],AccNodes,Color,ColoNodes) :- 
   \+ has_neighbor(Graph,N,Color,AccNodes), !,
   delete(DSNs,N,DSNs1),
   paint_nodes(Graph,DSNs1,Ns,[c(N,Color)|AccNodes],Color,ColoNodes).
paint_nodes(Graph,DSNs,[_|Ns],AccNodes,Color,ColoNodes) :- 
   paint_nodes(Graph,DSNs,Ns,AccNodes,Color,ColoNodes).
   
has_neighbor(Graph,N,Color,AccNodes) :- 
   adjacent(N,X,Graph),
   memberchk(c(X,Color),AccNodes).
