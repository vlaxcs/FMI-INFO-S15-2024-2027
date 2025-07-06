% P36 (**) Determine the prime factors of a given positive integer (2). 
% Construct a list containing the prime factors and their multiplicity.
% Example: 
% ?- prime_factors_mult(315, L).
% L = [[3,2],[5,1],[7,1]]

:- ensure_loaded(p35).  % make sure next_factor/3 is loaded

% prime_factors_mult(N, L) :- L is the list of prime factors of N. It is
%    composed of terms [F,M] where F is a prime factor and M its multiplicity.
%    (integer,list) (+,?)

prime_factors_mult(N,L) :- N > 0, prime_factors_mult(N,L,2).

% prime_factors_mult(N,L,K) :- L is the list of prime factors of N. It is 
% known that N does not have any prime factors less than K.

prime_factors_mult(1,[],_) :- !.
prime_factors_mult(N,[[F,M]|L],F) :- divide(N,F,M,R), !, % F divides N
   next_factor(R,F,NF), prime_factors_mult(R,L,NF).
prime_factors_mult(N,L,F) :- !,                          % F does not divide N
   next_factor(N,F,NF), prime_factors_mult(N,L,NF).

% divide(N,F,M,R) :- N = R * F**M, M >= 1, and F is not a factor of R. 
%    (integer,integer,integer,integer) (+,+,-,-)

divide(N,F,M,R) :- divi(N,F,M,R,0), M > 0.

divi(N,F,M,R,K) :- S is N // F, N =:= S * F, !,          % F divides N
   K1 is K + 1, divi(S,F,M,R,K1).
divi(N,_,M,N,M).

