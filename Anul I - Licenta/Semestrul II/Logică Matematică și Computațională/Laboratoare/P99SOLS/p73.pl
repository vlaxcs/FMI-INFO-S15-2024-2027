% P73 (**)  Lisp-like tree representation

% Here is my most elegant solution: a single predicate for both flow 
% patterns (i,o) and (o,i)

% tree_ltl(T,L) :- L is the "lispy token list" of the multiway tree T

tree_ltl(T,L) :- tree_ltl_d(T,L-[]).

% using difference lists

tree_ltl_d(t(X,[]),[X|L]-L) :- X \= '('.
tree_ltl_d(t(X,[T|Ts]),['(',X|L]-R) :- forest_ltl_d([T|Ts],L-[')'|R]).

forest_ltl_d([],L-L).
forest_ltl_d([T|Ts],L-R) :- tree_ltl_d(T,L-M), forest_ltl_d(Ts,M-R).
 
% some auxiliary predicates

write_ltl([]) :- nl.
write_ltl([X|Xs]) :- write(X), write(' '), write_ltl(Xs).

dotest(T) :- write(T), nl, tree_ltl(T,L),
   write_ltl(L), tree_ltl(T1,L), write(T1), nl.

test(1) :- T = t(a,[t(b,[]),t(c,[])]), dotest(T).
test(2) :- T = t(a,[t(b,[t(c,[])])]), dotest(T).
test(3) :- T = t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])]), 
   dotest(T).
