% P37 (**) Calculate Euler's totient function phi(m) (improved). 
% See problem P34 for the definition of Euler's totient function. 
% If the list of the prime factors of a number m is known in the 
% form of problem P36 then the function phi(m) can be efficiently
% calculated as follows: 
%
% Let [[p1,m1],[p2,m2],[p3,m3],...] be the list of prime factors (and their
% multiplicities) of a given number m. Then phi(m) can be calculated 
% with the following formula:
%
% phi(m) = (p1 - 1) * p1 ** (m1 - 1) * (p2 - 1) * p2 ** (m2 - 1) * 
%          (p3 - 1) * p3 ** (m3 - 1) * ...
%
% Note that a ** b stands for the b'th power of a.

:- ensure_loaded(p36).

% totient_phi_2(N,Phi) :- Phi is the value of Euler's totient function
%    for the argument N.
%    (integer,integer) (+,?)

totient_phi_2(N,Phi) :- prime_factors_mult(N,L), to_phi(L,Phi).

to_phi([],1).
to_phi([[F,1]|L],Phi) :- !,
   to_phi(L,Phi1), Phi is Phi1 * (F - 1).
to_phi([[F,M]|L],Phi) :- M > 1,
   M1 is M - 1, to_phi([[F,M1]|L],Phi1), Phi is Phi1 * F.
