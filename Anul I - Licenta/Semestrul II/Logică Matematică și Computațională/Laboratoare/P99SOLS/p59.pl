% P59 (**) Construct height-balanced binary trees
% In a height-balanced binary tree, the following property holds for
% every node: The height of its left subtree and the height of  
% its right subtree are almost equal, which means their
% difference is not greater than one.
% Write a predicate hbal_tree/2 to construct height-balanced
% binary trees for a given height. The predicate should
% generate all solutions via backtracking. Put the letter 'x'
% as information into all nodes of the tree.

% hbal_tree(D,T) :- T is a height-balanced binary tree with depth T

hbal_tree(0,nil) :- !.
hbal_tree(1,t(x,nil,nil)) :- !.
hbal_tree(D,t(x,L,R)) :- D > 1,
	D1 is D - 1, D2 is D - 2,
	distr(D1,D2,DL,DR),
	hbal_tree(DL,L), hbal_tree(DR,R).

distr(D1,_,D1,D1).
distr(D1,D2,D1,D2).
distr(D1,D2,D2,D1).