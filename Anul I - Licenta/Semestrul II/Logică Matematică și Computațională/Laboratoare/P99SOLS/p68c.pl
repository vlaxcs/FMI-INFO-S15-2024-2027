% P68c (**) Preorder and inorder sequences of binary trees

% If both the preorder sequence and the inorder sequence of
% the nodes of a binary tree are given, then the tree is determined
% unambiguously. 

:- ensure_loaded(p68b).

% pre_in_tree(P,I,T) :- T is the binary tree that has the preorder
%   sequence P and inorder sequence I.
%   (atom,atom,tree) (+,+,?)

pre_in_tree(P,I,T) :- preorder(T,P), inorder(T,I).

% This is a nice application of the generate-and-test method.


% We can push the tester inside the generator in order to get
% a (much) better performance.

pre_in_tree_push(P,I,T) :- 
   atom_chars(P,PL), atom_chars(I,IL), pre_in_tree_pu(PL,IL,T).

pre_in_tree_pu([],[],nil).
pre_in_tree_pu([X|PL],IL,t(X,Left,Right)) :- 
   append(ILeft,[X|IRight],IL),
   append(PLeft,PRight,PL),
   pre_in_tree_pu(PLeft,ILeft,Left),
   pre_in_tree_pu(PRight,IRight,Right).
   
% Nice. But there is a still better solution. See problem d)!