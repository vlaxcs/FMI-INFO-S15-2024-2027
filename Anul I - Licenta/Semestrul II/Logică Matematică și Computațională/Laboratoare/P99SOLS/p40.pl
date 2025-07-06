% P40 (**) Goldbach's conjecture. 
% Goldbach's conjecture says that every positive even number greater 
% than 2 is the sum of two prime numbers. Example: 28 = 5 + 23.

:- ensure_loaded(p31).

% goldbach(N,L) :- L is the list of the two prime numbers that
%    sum up to the given N (which must be even).
%    (integer,integer) (+,-)

goldbach(4,[2,2]) :- !.
goldbach(N,L) :- N mod 2 =:= 0, N > 4, goldbach(N,L,3).

goldbach(N,[P,Q],P) :- Q is N - P, is_prime(Q), !.
goldbach(N,L,P) :- P < N, next_prime(P,P1), goldbach(N,L,P1).

next_prime(P,P1) :- P1 is P + 2, is_prime(P1), !.
next_prime(P,P1) :- P2 is P + 2, next_prime(P2,P1).

