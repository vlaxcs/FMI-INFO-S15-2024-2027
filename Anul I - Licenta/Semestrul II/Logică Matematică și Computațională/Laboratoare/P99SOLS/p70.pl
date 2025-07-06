% P70 (**) Multiway tree construction from a node string

% We suppose that the nodes of a multiway tree contain single
% characters. In the depth-first order sequence of its nodes, a
% special character ^ has been inserted whenever, during the
% tree traversal, the move is a backtrack to the previous level.

% Define the syntax of the string and write a predicate tree(String,Tree)
% to construct the Tree when the String is given. Work with atoms (instead
% of strings). Make your predicate work in both directions.
%

% Syntax in BNF:

% <tree> ::= <letter> <forest> '^'

% <forest> ::= | <tree> <forest> 


% First a nice solution using difference lists

tree(TS,T) :- atom(TS), !, atom_chars(TS,TL), tree_d(TL-[],T). % (+,?)
tree(TS,T) :- nonvar(T), tree_d(TL-[],T), atom_chars(TS,TL).   % (?,+)

tree_d([X|F1]-T, t(X,F)) :- forest_d(F1-['^'|T],F).

forest_d(F-F,[]).
forest_d(F1-F3,[T|F]) :- tree_d(F1-F2,T), forest_d(F2-F3,F).


% Another solution, not as elegant as the previous one.

tree_2(TS,T) :- atom(TS), !, atom_chars(TS,TL), tree_a(TL,T). % (+,?)
tree_2(TS,T) :- nonvar(T), tree_a(TL,T), atom_chars(TS,TL).   % (?,+)

tree_a(TL,t(X,F)) :- 
   append([X],FL,L1), append(L1,['^'],TL), forest_a(FL,F).

forest_a([],[]).
forest_a(FL,[T|Ts]) :- append(TL,TsL,FL), 
   tree_a(TL,T), forest_a(TsL,Ts).
