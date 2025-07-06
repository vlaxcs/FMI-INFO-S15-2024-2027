% P68 (**) Preorder and inorder sequences of binary trees

% We consider binary trees with nodes that are identified by
% single lower-case letters.

% a) Given a binary tree, construct its preorder sequence

preorder(T,S) :- preorder_tl(T,L), atom_chars(S,L).

preorder_tl(nil,[]).
preorder_tl(t(X,Left,Right),[X|List]) :-
   preorder_tl(Left,ListLeft),
   preorder_tl(Right,ListRight),
   append(ListLeft,ListRight,List).

inorder(T,S) :- inorder_tl(T,L), atom_chars(S,L).

inorder_tl(nil,[]).
inorder_tl(t(X,Left,Right),List) :-
   inorder_tl(Left,ListLeft),
   inorder_tl(Right,ListRight),
   append(ListLeft,[X|ListRight],List).
