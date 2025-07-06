% P63 (**) Construct a complete binary tree
%
% A complete binary tree with height H is defined as follows: 
% The levels 1,2,3,...,H-1 contain the maximum number of nodes 
% (i.e 2**(i-1) at the level i, note that we start counting the 
% levels from 1 at the root). In level H, which may contain less 
% than the maximum number possible of nodes, all the nodes are 
% "left-adjusted". This means that in a levelorder tree traversal 
% all internal nodes come first, the leaves come second, and
% empty successors (the nils which are not really nodes!) 
% come last. Complete binary trees are used for heaps.

:- ensure_loaded(p57).

% complete_binary_tree(N,T) :- T is a complete binary tree with
% N nodes. (+,?)

complete_binary_tree(N,T) :- complete_binary_tree(N,T,1).

complete_binary_tree(N,nil,A) :- A > N, !.
complete_binary_tree(N,t(_,L,R),A) :- A =< N,
	AL is 2 * A, AR is AL + 1,
	complete_binary_tree(N,L,AL),
	complete_binary_tree(N,R,AR).


% ----------------------------------------------------------------------

% This was the solution of the exercise. What follows is an application
% of this result.

% We define a heap as a term heap(N,T) where N is the number of elements
% and T a complete binary tree (in the sense used above).

% The conservative usage of a heap is first to declare it with a predicate
% declare_heap/2 and then use it with a predicate element_at/3.

% declare_heap(H,N) :- 
%    declare H to be a heap with a fixed number N  of elements

declare_heap(heap(N,T),N) :- complete_binary_tree(N,T).

% element_at(H,K,X) :- X is the element at address K in the heap H. 
%  The first element has address 1.
%  (+,+,?)

element_at(heap(_,T),K,X) :- 
   binary_path(K,[],BP), element_at_path(T,BP,X).

binary_path(1,Bs,Bs) :- !.
binary_path(K,Acc,Bs) :- K > 1, 
   B is K /\ 1, K1 is K >> 1, binary_path(K1,[B|Acc],Bs).

element_at_path(t(X,_,_),[],X) :- !.
element_at_path(t(_,L,_),[0|Bs],X) :- !, element_at_path(L,Bs,X).
element_at_path(t(_,_,R),[1|Bs],X) :- element_at_path(R,Bs,X).


% We can transform lists into heaps and vice versa with the following
% useful predicate:

% list_heap(L,H) :- transform a list into a (limited) heap and vice versa.

list_heap(L,H) :- is_list(L), list_to_heap(L,H).
list_heap(L,heap(N,T)) :- integer(N), fill_list(heap(N,T),N,1,L).

list_to_heap(L,H) :- 
   length(L,N), declare_heap(H,N), fill_heap(H,L,1).

fill_heap(_,[],_).
fill_heap(H,[X|Xs],K) :- element_at(H,K,X), K1 is K+1, fill_heap(H,Xs,K1).

fill_list(_,N,K,[]) :- K > N.
fill_list(H,N,K,[X|Xs]) :- K =< N, 
   element_at(H,K,X), K1 is K+1, fill_list(H,N,K1,Xs).


% However, a more aggressive usage is *not* to define the heap in the
% beginning, but to use it as a partially instantiated data structure.
% Used in this way, the number of elements in the heap is unlimited.
% This is Power-Prolog!

% Try the following and find out exactly what happens.

% ?- element_at(H,5,alfa), element_at(H,2,beta), element(H,5,A).

% -------------------------------------------------------------------------

% Test section. Suppose you have N elements in a list which must be looked
% up M times in a random order.

test1(N,M) :-
   length(List,N), lookup_list(List,N,M).

lookup_list(_,_,0) :- !.
lookup_list(List,N,M) :- 
   K is random(N)+1,       % determine a random address
   nth1(K,List,_),         % look up and throw away
   M1 is M-1,
   lookup_list(List,N,M1).

% ?- time(test1(100,100000)).
% 1,384,597 inferences in 3.98 seconds (347889 Lips)
% ?- time(test1(500,100000)).
% 4,721,902 inferences in 13.82 seconds (341672 Lips)
% ?- time(test1(10000,100000)).
% 84,016,719 inferences in 277.51 seconds (302752 Lips)

test2(N,M) :-
   declare_heap(Heap,N), 
   lookup_heap(Heap,N,M).

lookup_heap(_,_,0) :- !.
lookup_heap(Heap,N,M) :- 
   K is random(N)+1,       % determine a random address
   element_at(Heap,K,_),   % look up and throw away
   M1 is M-1,
   lookup_heap(Heap,N,M1).

% ?- time(test2(100,100000)).
% 3,002,061 inferences in 7.81 seconds (384387 Lips)                          
% ?- time(test2(500,100000)).
% 4,097,961 inferences in 10.75 seconds (381206 Lips)
% ?- time(test2(10000,100000)).
% 6,366,206 inferences in 19.16 seconds (332265 Lips)

% Conclusion: In this scenario, for lists longer than 500 elements 
% it is more efficient to use a heap.
