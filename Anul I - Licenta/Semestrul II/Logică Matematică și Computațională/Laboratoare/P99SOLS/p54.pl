% P54: Write a predicate istree/1 which succeeds if and only if its argument
%      is a Prolog term representing a binary tree.
%
% istree(T) :- T is a term representing a binary tree (i), (o)

istree(nil).
istree(t(_,L,R)) :- istree(L), istree(R).


% Test cases (can be used for other binary tree problems as well)

tree(1,t(a,t(b,t(d,nil,nil),t(e,nil,nil)),t(c,nil,t(f,t(g,nil,nil),nil)))).
tree(2,t(a,nil,nil)).
tree(3,nil).
