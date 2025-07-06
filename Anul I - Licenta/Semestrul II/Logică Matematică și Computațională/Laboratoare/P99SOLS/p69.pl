%  P69 (**) Dotstring representation of binary trees</B>

% The syntax of the dotstring representation is super simple:
%
% <tree> ::= . | <letter> <tree> <tree>

tree_dotstring(T,S) :- nonvar(T), !, tree_dots_dl(T,L-[]), atom_chars(S,L). 
tree_dotstring(T,S) :- atom(S), atom_chars(S,L), tree_dots_dl(T,L-[]).

tree_dots_dl(nil,L1-L2) :- symbol('.',L1-L2).
tree_dots_dl(t(X,Left,Right),L1-L4) :- 
   letter(X,L1-L2),
   tree_dots_dl(Left,L2-L3),
   tree_dots_dl(Right,L3-L4).

symbol(X,[X|Xs]-Xs).

letter(X,L1-L2) :- symbol(X,L1-L2), char_type(X,alpha).

