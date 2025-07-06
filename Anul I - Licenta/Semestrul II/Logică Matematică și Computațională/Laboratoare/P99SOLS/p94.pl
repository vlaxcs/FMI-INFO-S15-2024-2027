% P94 (**) Generate K-regular simple graphs with N nodes. 
% 
% In a K-regular graph all nodes have a degree of K.

% k_regular(K,N,Graph) :- Graph is a K-regular simple graph with N nodes.
% The graph is in graph-term form. The nodes are identified by numbers 1..N.
% All solutions can be generated via backtracking. 
% (+,+,?)  (int,int,graph(nodes,edges))
%
% Note: The predicate generates the Nodes list and a list of terms u(V,F)
% which indicates, for each node V, the number F of unused (or free) edges. 
% For example: with N=5, K=3 the algorithm starts with Nodes=[1,2,3,4,5]
% and UList=[u(1,3),u(2,3),u(3,3),u(4,3),u(5,3)].

k_regular(K,N,graph(Nodes,Edges)) :-
   range(1,N,Nodes),                         % generate Nodes list
   maplist(mku(K),Nodes,UList),              % generate initial UList
   k_reg(UList,0,Edges).

mku(K,V,u(V,K)).

% k_reg(UList,MinY,Edges) :- Edges is a list of e(X,Y) terms where u(X,UX)
% is the first element in UList and u(Y,UY) is another element of UList,
% with Y > MinY. Both UX and UY, which indicate the number of free edges
% of X and Y, respectively, must be greater than 0. They are both reduced
% by 1 for the recursion if the edge e(X,Y) is chosen. 
% (+,+,-) (ulist,int,elist)

k_reg([],_,[]). 
k_reg([u(_,0)|Us],_,Edges) :- !, k_reg(Us,0,Edges).   % no more unused edges
k_reg([u(1,UX)|Us],MinY,[e(1,Y)|Edges]) :- UX > 0,    % special case X = 1
   pick(Us,Y,MinY,Us1), !,                    % pick a Y
   UX1 is UX - 1,                             % reduce number of unused edges
   k_reg([u(1,UX1)|Us1],Y,Edges).
k_reg([u(X,UX)|Us],MinY,[e(X,Y)|Edges]) :- X > 1, UX > 0,
   pick(Us,Y,MinY,Us1),                       % pick a Y
   UX1 is UX - 1,                             % reduce number of unused edges
   k_reg([u(X,UX1)|Us1],Y,Edges).

% pick(UList_in,Y,MinY,UList_out) :- there is an element u(Y,UY) in UList_in,
% Y is greater than MinY, and UY > 0. UList_out is obtained from UList_in
% by reducing UY by 1 in the term u(Y,_). This predicate delivers all
% possible values of Y via backtracking.
% (+,-,+,-) (ulist,int,int,ulist)

pick([u(Y,UY)|Us],Y,MinY,[u(Y,UY1)|Us]) :- Y > MinY, UY > 0, UY1 is UY - 1.
pick([U|Us],Y,MinY,[U|Us1]) :- pick(Us,Y,MinY,Us1).
   
% range(X,Y,Ls) :- Ls is the list of the integer numbers from X to Y.
% (+,+,?) (int,int,int_list)

range(B,B,[B]).
range(A,B,[A|L]) :- A < B, A1 is A + 1, range(A1,B,L).

:- dynamic solution/1.

% all_k_regular(K,N,Gs) :- Gs is the list of all (non-isomorphic)
% K-regular graphs with N nodes.
% (+,+,-) (int,int,list_of_graphs)
% Note: The predicate prints each new solution as a progress report.
% Use tell('/dev/null') to switch off the printing if you don't like it.

all_k_regular(K,N,_) :-
   retractall(solution(_)),
   k_regular(K,N,Graph),
   no_iso_solution(Graph),
   write(Graph), nl,
   assert(solution(Graph)),
   fail.
all_k_regular(_,_,Graphs) :- findall(G,solution(G),Graphs).

:- ensure_loaded(p85).  % load isomorphic/2

% no_iso_solution(Graph) :- there is no graph G in the solution/1 data base
% predicate which is isomorphic to Graph

no_iso_solution(Graph) :-
   solution(G), isomorphic(Graph,G), !, fail.
no_iso_solution(_).

% The rest of this program constructs a table of K-regular simple graphs
% with N nodes for N up to a maximum N and sensible values of K.
% Example:  ?- table(6).

table(Max) :-  
   nl, write('K-regular simple graphs with N nodes'), nl,
   table(3,Max).

table(N,Max) :- N =< Max, !,
   table(2,N,Max),
   N1 is N + 1,
   table(N1,Max).
table(_,_) :- nl. 

table(K,N,Max) :- K < N, !,
   tell('/dev/null'),
   statistics(inferences,I1),
   all_k_regular(K,N,Gs),
   length(Gs,NSol),    
   statistics(inferences,I2),
   NInf is I2 - I1,
   told,
   plural(NSol,Pl),
   writef('\nN = %w  K = %w   %w solution%w  (%w inferences)\n',[N,K,NSol,Pl,NInf]),
   checklist(print_graph,Gs),
   K1 is K + 1,
   table(K1,N,Max).
table(_,_,_) :- nl.

plural(X,' ') :- X < 2, !.
plural(_,'s').

:- ensure_loaded(p80).  % conversion human_gterm/2

print_graph(G) :- human_gterm(HF,G), write(HF), nl.
   
