% P66 (***) Layout a binary tree (3)
%
% See problem P64 for the conventions.
%
% The position of a node v is obtained by the following rules:
%   (1) y(v) is equal to the depth of the node v in the tree
%   (2) in order to determine the horizontal positions of the nodes we
%       construct "contours" for each subtree and shift them together 
%       horizontally as close as possible. However, we maintain the
%       symmetry in each node; i.e. the horizontal distance between
%       a node and the root of its left subtree is the same as between
%       it and the root of its right subtree.
%
%       The "contour" of a tree is a list of terms c(Xleft,Xright) which
%       give the horizontal position of the outermost nodes of the tree
%       on each level, relative to the root position. In the example
%       given in the problem description, the "contour" of the tree with
%       root k would be [c(-1,1),c(-2,0),c(-1,1)]. Note that the first
%       element in the "contour" list is derived from the position of
%       the nodes c and m.

% layout_binary_tree3(T,PT) :- PT is the "positionned" binary
%    tree obtained from the binary tree T. (+,?)

:- ensure_loaded(p57). % for test

layout_binary_tree3(nil,nil) :- !. 
layout_binary_tree3(T,PT) :-
   contour_tree(T,CT),      % construct the "contour" tree CT
   CT = t(_,_,_,Contour),
   mincont(Contour,MC,0),   % find the position of the leftmost node
   Xroot is 1-MC,
   layout_binary_tree3(CT,PT,Xroot,1).

contour_tree(nil,nil).
contour_tree(t(X,L,R),t(X,CL,CR,Contour)) :- 
   contour_tree(L,CL),
   contour_tree(R,CR),
   combine(CL,CR,Contour).

combine(nil,nil,[]).
combine(t(_,_,_,CL),nil,[c(-1,-1)|Cs]) :- shift(CL,-1,Cs).
combine(nil,t(_,_,_,CR),[c(1,1)|Cs]) :- shift(CR,1,Cs).
combine(t(_,_,_,CL),t(_,_,_,CR),[c(DL,DR)|Cs]) :-
   maxdiff(CL,CR,MD,0), 
   DR is (MD+2)//2, DL is -DR,
   merge(CL,CR,DL,DR,Cs).

shift([],_,[]).
shift([c(L,R)|Cs],S,[c(LS,RS)|CsS]) :-
   LS is L+S, RS is R+S, shift(Cs,S,CsS).

maxdiff([],_,MD,MD) :- !.
maxdiff(_,[],MD,MD) :- !.
maxdiff([c(_,R1)|Cs1],[c(L2,_)|Cs2],MD,A) :- 
   A1 is max(A,R1-L2),
   maxdiff(Cs1,Cs2,MD,A1).

merge([],CR,_,DR,Cs) :- !, shift(CR,DR,Cs).
merge(CL,[],DL,_,Cs) :- !, shift(CL,DL,Cs).
merge([c(L1,_)|Cs1],[c(_,R2)|Cs2],DL,DR,[c(L,R)|Cs]) :-
   L is L1+DL, R is R2+DR,
   merge(Cs1,Cs2,DL,DR,Cs).

mincont([],MC,MC).
mincont([c(L,_)|Cs],MC,A) :- 
   A1 is min(A,L), mincont(Cs,MC,A1).

layout_binary_tree3(nil,nil,_,_).
layout_binary_tree3(t(W,nil,nil,_),t(W,X,Y,nil,nil),X,Y) :- !. 
layout_binary_tree3(t(W,L,R,[c(DL,DR)|_]),t(W,X,Y,PL,PR),X,Y) :- 
   Y1 is Y + 1,
   Xleft is X + DL,
   layout_binary_tree3(L,PL,Xleft,Y1), 
   Xright is X + DR,
   layout_binary_tree3(R,PR,Xright,Y1).

% Test (see example given in the problem description):
% ?- construct([n,k,m,c,a,e,d,g,u,p,q],T),layout_binary_tree3(T,PT).
