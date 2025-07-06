% P85 (**) Graph isomorphism

:- ensure_loaded(p80).  % conversions

% This is a solution for graphs only. It is not difficult to write the 
% corresponding predicates for digraphs.

% isomorphic(G1,G2) :- the graphs G1 and G2 are isomorphic.

isomorphic(G1,G2) :- isomorphic(G1,G2,_). 

% isomorphic(G1,G2,Iso) :- the graphs G1 and G2 are isomorphic. 
%    Iso is a list representing the bijection between the node 
%    sets of the graphs. It is an open-ended list and contains 
%    a term i(X,Y) for each pair of corresponding nodes

isomorphic(graph(Ns1,Es1),graph(Ns2,Es2),Iso) :-
   append(Es1,Ns1,List1),
   append(Es2,Ns2,List2),
   isomo(List1,List2,Iso).

% isomo(List1,List2,Iso) :- the graphs represented by List1 and 
%    List2 are isomorphic. 

isomo([],[],_) :- !.
isomo([X|Xrest],Ys,Iso) :- 
   select(Ys,Y,Yrest),
   iso(X,Y,Iso),
   isomo(Xrest,Yrest,Iso).

% iso(E1,E2,Iso) :- the edge E1 in one graph corresponds 
%    to the edge E2 in the other. Note that edges are undirected.
% iso(N1,N2,Iso) :- matches isolated vertices.

iso(E1,E2,Iso) :- 
   edge(E1,X1,Y1), edge(E2,X2,Y2), 
   bind(X1,X2,Iso), bind(Y1,Y2,Iso).
iso(E1,E2,Iso) :- 
   edge(E1,X1,Y1), edge(E2,X2,Y2), 
   bind(X1,Y2,Iso), bind(Y1,X2,Iso).
iso(N1,N2,Iso) :-
   \+ edge(N1,_,_),\+ edge(N2,_,_),     % isolated vertices
   bind(N1,N2,Iso).

edge(e(X,Y),X,Y).
edge(e(X,Y,_),X,Y).

% bind(X,Y,Iso) :- it is possible to "bind X to Y" as part of the
%    bijection Iso; i.e. a term i(X,Y) is already in the list Iso,
%    or it can be added to it without violating the rules. Note that
%    bind(X,Y,Iso) makes sure that both X and Y are really "new"
%    if i(X,Y) is added to Iso.

bind(X,Y,Iso) :- memberchk(i(X,Y0),Iso), nonvar(Y0), !, Y = Y0.
bind(X,Y,Iso) :- memberchk(i(X0,Y),Iso), X = X0.

% ----------------------------------------------------------------------

test(1) :-
   human_gterm([f-e,e-d,e-g,c-e,c-b,a-b,c-d,beta],G1),
   human_gterm([6-3,6-4,3-4,alfa,4-5,7-4,6-2,1-2],G2),
   isomorphic(G1,G2,Iso), write(Iso).
test(2) :-
   human_gterm([f-e,e-d,e-g,c-e,c-b,a-b,c-d,beta],G1),
   human_gterm([6-3,6-4,3-4,4-5,7-4,6-2,1],G2),
   isomorphic(G1,G2,Iso), write(Iso).
test(3) :-
   human_gterm([a-b,c-d,e,d-f],G1),
   human_gterm([1-2,1-3,5,4-6],G2),
   isomorphic(G1,G2,Iso), write(Iso).
