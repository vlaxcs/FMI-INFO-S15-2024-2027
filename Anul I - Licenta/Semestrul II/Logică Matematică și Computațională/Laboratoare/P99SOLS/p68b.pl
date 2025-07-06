% P68b (**) Preorder and inorder sequences of binary trees

% b) Make preorder/2 and inorder/2 reversible.

% Similar to the solution p68a.pl. However, for the flow pattern (-,+) 
% we have to modify the order of the subgoals in the second clauses 
% of preorder_l/2 and inorder_l/2

% preorder(T,S) :- S is the preorder tre traversal sequence of the
%    nodes of the binary tree T. (tree,atom) (+,?) or (?,+)

preorder(T,S) :- nonvar(T), !, preorder_tl(T,L), atom_chars(S,L). 
preorder(T,S) :- atom(S), atom_chars(S,L), preorder_lt(T,L).

preorder_tl(nil,[]).
preorder_tl(t(X,Left,Right),[X|List]) :-
   preorder_tl(Left,ListLeft),
   preorder_tl(Right,ListRight),
   append(ListLeft,ListRight,List).

preorder_lt(nil,[]).
preorder_lt(t(X,Left,Right),[X|List]) :-
   append(ListLeft,ListRight,List),
   preorder_lt(Left,ListLeft),
   preorder_lt(Right,ListRight).

% inorder(T,S) :- S is the inorder tre traversal sequence of the
%    nodes of the binary tree T. (tree,atom) (+,?) or (?,+)

inorder(T,S) :- nonvar(T), !, inorder_tl(T,L), atom_chars(S,L). 
inorder(T,S) :- atom(S), atom_chars(S,L), inorder_lt(T,L).

inorder_tl(nil,[]).
inorder_tl(t(X,Left,Right),List) :-
   inorder_tl(Left,ListLeft),
   inorder_tl(Right,ListRight),
   append(ListLeft,[X|ListRight],List).

inorder_lt(nil,[]).
inorder_lt(t(X,Left,Right),List) :-
   append(ListLeft,[X|ListRight],List),
   inorder_lt(Left,ListLeft),
   inorder_lt(Right,ListRight).
