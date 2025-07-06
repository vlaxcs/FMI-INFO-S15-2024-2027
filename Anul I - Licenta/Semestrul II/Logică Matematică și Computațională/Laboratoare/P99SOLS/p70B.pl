% P70B: Write a predicate istree/1 which succeeds if and only if its argument
%       is a Prolog term representing a multiway tree.
%
% istree(T) :- T is a term representing a multiway tree (i), (o)

% the following is a test case:
tree(1,t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])).

istree(t(_,F)) :- isforest(F).

isforest([]).
isforest([T|Ts]) :- istree(T), isforest(Ts).
