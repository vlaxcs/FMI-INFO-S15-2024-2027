remove_duplicates([], []).
remove_duplicates([H | T], [H | Result]) :-
    \+ member(H, T),
    remove_duplicates(T, Result).
remove_duplicates([H | T], Result) :-
    member(H, T),
    remove_duplicates(T, Result).

% ?- remove_duplicates([a, b, c, c], List).    
% List = [a, b, c] 

% ?- remove_duplicates([a, b, a, c, d, d], List).
% List = [b, a, c, d]