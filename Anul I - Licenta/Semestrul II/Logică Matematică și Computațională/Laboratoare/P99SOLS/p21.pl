% P21 (*): Insert an element at a given position into a list
% The first element in the list is number 1.

% insert_at(X,L,K,R) :- X is inserted into the list L such that it
%    occupies position K. The result is the list R.
%    (element,list,integer,list) (?,?,+,?)

:- ensure_loaded(p20).

insert_at(X,L,K,R) :- remove_at(X,R,K,L).

