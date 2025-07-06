% P34 (**) Calculate Euler's totient function phi(m). 
%    Euler's so-called totient function phi(m) is defined as the number 
%    of positive integers r (1 <= r < m) that are coprime to m. 
%    Example: m = 10: r = 1,3,7,9; thus phi(m) = 4. Note: phi(1) = 1.

% totient_phi(M,Phi) :- Phi is the value of the Euler's totient function
%    phi for the argument M.
%    (integer, integer) (+,-)

:- ensure_loaded(p33).
:- arithmetic_function(totient_phi/1).

totient_phi(1,1) :- !.
totient_phi(M,Phi) :- t_phi(M,Phi,1,0).

% t_phi(M,Phi,K,C) :- Phi = C + N, where N is the number of integers R
%    such that K <= R < M and R is coprime to M.
%    (integer,integer,integer,integer) (+,-,+,+)

t_phi(M,Phi,M,Phi) :- !.
t_phi(M,Phi,K,C) :- 
   K < M, coprime(K,M), !, 
   C1 is C + 1, K1 is K + 1,
   t_phi(M,Phi,K1,C1).
t_phi(M,Phi,K,C) :- 
   K < M, K1 is K + 1,
   t_phi(M,Phi,K1,C).
