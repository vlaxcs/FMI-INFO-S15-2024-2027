% P92 (***) Von Koch's conjecture

% Von Koch's Conjecture: Given a tree with N nodes (and hence N-1 edges).
% Find a way to enumerate the nodes from 1 to n and, accordingly, the
% edges from 1 to N-1 in such a way, that for each edge K the difference
% of its node numbers equals to K. The conjecture is that this is always
% possible.

% Example:      *      Solution:     4    Note that the node number 
%              /                    /     differences of adjacent nodes
%        * -- *               3 -- 1      are just the numbers 1,2,3,4
%        |     \              |     \     which can be used to enumerate
%        *      *             2      5    the edges.

:- ensure_loaded(p80).  % conversions
:- ensure_loaded(p83).  % is_tree

% vonkoch(G,Enum) :- the nodes of the graph G can be enumerated
%    as described in Enum. Enum is a list of pairs X/K, where X
%    is a node and K the corresponding number. 

vonkoch(Graph,Enum) :- 
   is_tree(Graph),            % check before doing too much work!
   Graph = graph(Ns,_),
   length(Ns,N),
   human_gterm(Hs,Graph),
   vonkoch(Hs,N,Enum).

vonkoch([IsolatedNode],1,[IsolatedNode/1|_]).  % special case
vonkoch(EdgeList,N,Enum) :-
   range(1,N,NodeNumberList), 
   N1 is N-1,range(1,N1,EdgeNumberList),
   bind(EdgeList,NodeNumberList,EdgeNumberList,Enum).

% The tree is given as an edge list; e.g. [d-a,a-g,b-c,e-f,b-e,a-b].
% Our problem is to find a bijection between the nodes (a,b,c,...) and
% the integer numbers 1..N which is compatible with the condition
% cited above. In order to construct this bijection, we use an open-
% ended list Enum; and we scan the given edge list.

bind([],_,_,_) :- !.
bind([V1-V2|Es],NodeNumbers,EdgeNumbers,Enum) :-
   bind_node(V1,K1,NodeNumbers,NodeNumbers1,Enum), 
   bind_node(V2,K2,NodeNumbers1,NodeNumbers2,Enum), 
   D is abs(K1-K2), select(D,EdgeNumbers,EdgeNumbers1), % modif 15-May-2001
   bind(Es,NodeNumbers2,EdgeNumbers1,Enum).

% bind_node(V,K,NodeNumsIn,NodeNumsOut,Enum) :-  
% V/K is an element of the list Enum, and there is no V1 \= V 
% such that V1/K is in Enum, and there is no K1 \= K such that 
% V =:= K1 is in Enum. In the case V gets a new number, it is
% selected from the set NodeNumsIn; what remains is NodeNumsOut.
% (node,integer,integer-list,integer-list,enumeration)  (+,?,+,-,?)

bind_node(V,K,NodeNumbers,NodeNumbers,Enum) :- 
   memberchk(V/K1,Enum), number(K1), !, K = K1.
bind_node(V,K,NodeNumbers,NodeNumbers1,Enum) :- 
   select(K,NodeNumbers,NodeNumbers1), memberchk(V/K,Enum).

% range(A,B,L) :- L is the list of numbers A..B

range(B,B,[B]) :- !.
range(A,B,[A|L]) :- A < B, A1 is A+1, range(A1,B,L).

% test suite ------------------------------------------------------------

test(K) :-
   test_tree(K,TH),
   write(TH), nl,  
   human_gterm(TH,T),
   vonkoch(T,Enum),
   write(Enum).
      
test_tree(1,[a-b,b-c,c-d,c-e]).
test_tree(2,[d-a,a-g,b-c,e-f,b-e,a-b]).
test_tree(3,[g-a,i-a,a-h,b-a,k-d,c-d,m-q,p-n,q-n,e-q,e-c,f-c,c-a]).
test_tree(4,[a]).

% Solution for the tree given in the problem statement (picture p92b.gif):
%
% ?- test(3).
% [g-a, i-a, a-h, b-a, k-d, c-d, m-q, p-n, q-n, e-q, e-c, f-c, c-a]
% [a/1, b/2, c/12, g/11, h/13, i/14, d/3, e/4, f/5, k/8, q/10, m/6, n/7, p/9|_]
%
% Remark: In most cases, there are many different solutions.
