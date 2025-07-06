% P68d (**) Preorder and inorder sequences of binary trees

% Work with difference lists

% pre_in_tree_d(P,I,T) :- T is the binary tree that has the preorder
%   sequence P and inorder sequence I.
%   (atom,atom,tree) (+,+,?)

pre_in_tree_d(P,I,T) :-  
   atom_chars(P,PL), atom_chars(I,IL), pre_in_tree_dl(PL-[],IL-[],T).

pre_in_tree_dl(P-P,I-I,nil).
pre_in_tree_dl(P1-P4,I1-I4,t(X,Left,Right)) :-
   symbol(X,P1-P2), symbol(X,I2-I3),
   pre_in_tree_dl(P2-P3,I1-I2,Left),
   pre_in_tree_dl(P3-P4,I3-I4,Right).

symbol(X,[X|Xs]-Xs).




% Isn't it cool? But the best of it is the performance!

% With the generate-and-test solution (p68c):
% ?- time(pre_in_tree(abdecfg,dbeacgf,_)).
% 9,048 inferences in 0.01 seconds (904800 Lips)  

% With the "pushed" generate-and-test solution (p68c):
% ?- time(pre_in_tree_push(abdecfg,dbeacgf,_)).
% 67 inferences in 0.00 seconds (Infinite Lips)
  
% With the difference list solution (p68d):
% ?- time(pre_in_tree_d(abdecfg,dbeacgf,_)).
% 32 inferences in 0.00 seconds (Infinite Lips)                     

% Note that the predicate pre_in_tree_dl/3 runs in almost any
% flow pattern. Try it out!

