% P35 (**) Determine the prime factors of a given positive integer. 

% prime_factors(N, L) :- N is the list of prime factors of N.
%    (integer,list) (+,?)

prime_factors(N,L) :- N > 0,  prime_factors(N,L,2).

% prime_factors(N,L,K) :- L is the list of prime factors of N. It is 
% known that N does not have any prime factors less than K.

prime_factors(1,[],_) :- !.
prime_factors(N,[F|L],F) :-                           % N is multiple of F
   R is N // F, N =:= R * F, !, prime_factors(R,L,F).
prime_factors(N,L,F) :- 
   next_factor(N,F,NF), prime_factors(N,L,NF).        % N is not multiple of F
   

% next_factor(N,F,NF) :- when calculating the prime factors of N
%    and if F does not divide N then NF is the next larger candidate to
%    be a factor of N.

next_factor(_,2,3) :- !.
next_factor(N,F,NF) :- F * F < N, !, NF is F + 2.
next_factor(N,_,N).                                 % F > sqrt(N)
