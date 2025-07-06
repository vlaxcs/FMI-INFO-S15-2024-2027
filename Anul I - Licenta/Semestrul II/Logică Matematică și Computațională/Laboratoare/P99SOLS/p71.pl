% P71 (*) Determine the internal path length of a tree

% We define the internal path length of a multiway tree as the
% total sum of the path lengths from the root to all nodes of the tree.

% ipl(Tree,L) :- L is the internal path length of the tree Tree
%    (multiway-tree, integer) (+,?)

ipl(T,L) :- ipl(T,0,L).

ipl(t(_,F),D,L) :- D1 is D+1, ipl(F,D1,LF), L is LF+D.

ipl([],_,0).
ipl([T1|Ts],D,L) :- ipl(T1,D,L1), ipl(Ts,D,Ls), L is L1+Ls.

% Notice the polymorphism: ipl is called with trees and with forests
% as first argument.

