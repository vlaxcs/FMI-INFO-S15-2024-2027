% P65 (**) Layout a binary tree (2)
%
% See problem P64 for the conventions.
%
% The position of a node v is obtained by the following rules:
%   (1) y(v) is equal to the depth of the node v in the tree
%   (2) if D denotes the depth of the tree (i.e. the number of
%       populated levels) then the horizontal distance between
%       nodes at level i (counted from the root, beginning with 1)
%       is equal to 2**(D-i+1). The leftmost node of the tree
%       is at position 1.

% layout_binary_tree2(T,PT) :- PT is the "positionned" binary
%    tree obtained from the binary tree T. (+,?)

:- ensure_loaded(p57). % for test

layout_binary_tree2(nil,nil) :- !. 
layout_binary_tree2(T,PT) :- 
   hor_dist(T,D4), D is D4//4, x_pos(T,X,D), 
   layout_binary_tree2(T,PT,X,1,D).

% hor_dist(T,D4) :- D4 is four times the horizontal distance between the 
%    root node of T and its successor(s) (if any).
%    (+,-)

hor_dist(nil,1).
hor_dist(t(_,L,R),D4) :- 
   hor_dist(L,D4L), 
   hor_dist(R,D4R),
   D4 is 2 * max(D4L,D4R).

% x_pos(T,X,D) :- X is the horizontal position of the root node of T
%    with respect to the picture co-ordinate system. D is the horizontal
%    distance between the root node of T and its successor(s) (if any).
%    (+,-,+)

x_pos(t(_,nil,_),1,_) :- !.
x_pos(t(_,L,_),X,D) :- D2 is D//2, x_pos(L,XL,D2), X is XL+D.

% layout_binary_tree2(T,PT,X,Y,D) :- T and PT as in layout_binary_tree/2;
%    D is the the horizontal distance between the root node of T and 
%    its successor(s) (if any). X, Y are the co-ordinates of the root node.
%    (+,-,+,+,+)
 
layout_binary_tree2(nil,nil,_,_,_).
layout_binary_tree2(t(W,L,R),t(W,X,Y,PL,PR),X,Y,D) :- 
   Y1 is Y + 1,
   Xleft is X - D,
   D2 is D//2,
   layout_binary_tree2(L,PL,Xleft,Y1,D2), 
   Xright is X + D,
   layout_binary_tree2(R,PR,Xright,Y1,D2).

% Test (see example given in the problem description):
% ?- construct([n,k,m,c,a,e,d,g,u,p,q],T),layout_binary_tree2(T,PT).
