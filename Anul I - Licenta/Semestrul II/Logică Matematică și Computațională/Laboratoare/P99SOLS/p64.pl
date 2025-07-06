% P64 (**) Layout a binary tree (1)
%
% Given a binary tree as the usual Prolog term t(X,L,R) (or nil).
% As a preparation for drawing the tree, a layout algorithm is
% required to determine the position of each node in a rectangular
% grid. Several layout methods are conceivable, one of them is
% the following:
%
% The position of a node v is obtained by the following two rules:
%   x(v) is equal to the position of the node v in the inorder sequence
%   y(v) is equal to the depth of the node v in the tree
%
% In order to store the position of the nodes, we extend the Prolog 
% term representing a node (and its successors) as follows:
%    nil represents the empty tree (as usual)
%    t(W,X,Y,L,R) represents a (non-empty) binary tree with root
%        W positionned at (X,Y), and subtrees L and R
%
% Write a predicate layout_binary_tree/2:

% layout_binary_tree(T,PT) :- PT is the "positionned" binary
%    tree obtained from the binary tree T. (+,?) or (?,+)

:- ensure_loaded(p57). % for test

layout_binary_tree(T,PT) :- layout_binary_tree(T,PT,1,_,1).

% layout_binary_tree(T,PT,In,Out,D) :- T and PT as in layout_binary_tree/2;
%    In is the position in the inorder sequence where the tree T (or PT)
%    begins, Out is the position after the last node of T (or PT) in the 
%    inorder sequence. D is the depth of the root of T (or PT). 
%    (+,?,+,?,+) or (?,+,+,?,+)
 
layout_binary_tree(nil,nil,I,I,_).
layout_binary_tree(t(W,L,R),t(W,X,Y,PL,PR),Iin,Iout,Y) :- 
   Y1 is Y + 1,
   layout_binary_tree(L,PL,Iin,X,Y1), 
   X1 is X + 1,
   layout_binary_tree(R,PR,X1,Iout,Y1).

% Test (see example given in the problem description):
% ?-  construct([n,k,m,c,a,h,g,e,u,p,s,q],T),layout_binary_tree(T,PT).
