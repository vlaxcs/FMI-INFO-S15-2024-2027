% P89 (**) Bipartite graphs

%  Write a predicate that finds out whether a given graph is bipartite.

:- ensure_loaded(p80).  % conversions
:- ensure_loaded(p88).  % connected_components/2

% is_bipartite(G) :- the graph G is bipartite

is_bipartite(G) :- 
   connected_components(G,Gs),
   checklist(is_bi,Gs).

is_bi(graph(Ns,Es)) :- Ns = [N|_], 
   alist_gterm(_,Alist,graph(Ns,Es)),
   paint(Alist,[],red,N).

% paint(Alist,ColoredNodes,Color,ActualNode)
% (+,+,+,+)

paint(_,CNs,Color,N) :-  
   memberchk(c(N,Color),CNs), !.
paint(Alist,CNs,Color,N) :- 
   \+ memberchk(c(N,_),CNs),
   other_color(Color,OtherColor),
   memberchk(n(N,AdjNodes),Alist),
   Pred =.. [paint,Alist,[c(N,Color)|CNs],OtherColor],
   checklist(Pred,AdjNodes).

other_color(red,blue).
other_color(blue,red).
