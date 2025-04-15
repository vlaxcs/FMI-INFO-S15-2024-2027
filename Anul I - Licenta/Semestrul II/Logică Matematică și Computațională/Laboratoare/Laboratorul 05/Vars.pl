vars(X, [X]) :- atom(X).
vars(si(A, B), V) :- vars(A, V1), vars(B, V2), union(V1, V2, V).
vars(sau(A, B), V) :- vars(A, V1), vars(B, V2), union(V1, V2, V).
vars(imp(A, B), V) :- vars(A, V1), vars(B, V2), union(V1, V2, V).
vars(non(A), V) :- vars(A, V).

% vars(imp(non(a), imp(a, b)), S).
% S = [a, b].