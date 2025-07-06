% P67 (**)  A string representation of binary trees

% The string representation has the following syntax:
%
% <tree> ::=  | <letter><subtrees>
%
% <subtrees> ::=  | '(' <tree> ',' <tree> ')'
%
% According to this syntax, a leaf node (with letter x) could
% be represented by x(,) and not only by the single character x.
% However, we will avoid this when generating the string 
% representation.

tree_string(T,S) :- nonvar(T), !, tree_to_string(T,S). 
tree_string(T,S) :- nonvar(S), string_to_tree(S,T). 

tree_to_string(T,S) :- tree_to_list(T,L), atom_chars(S,L).

tree_to_list(nil,[]).
tree_to_list(t(X,nil,nil),[X]) :- !.
tree_to_list(t(X,L,R),[X,'('|List]) :- 
   tree_to_list(L,LsL),
   tree_to_list(R,LsR),
   append(LsL,[','],List1),
   append(List1,LsR,List2),
   append(List2,[')'],List).

string_to_tree(S,T) :- atom_chars(S,L), list_to_tree(L,T).

list_to_tree([],nil).
list_to_tree([X],t(X,nil,nil)) :- char_type(X,alpha).
list_to_tree([X,'('|List],t(X,Left,Right)) :- char_type(X,alpha),
   append(List1,[')'],List),
   append(LeftList,[','|RightList],List1),
   list_to_tree(LeftList,Left),
   list_to_tree(RightList,Right).
