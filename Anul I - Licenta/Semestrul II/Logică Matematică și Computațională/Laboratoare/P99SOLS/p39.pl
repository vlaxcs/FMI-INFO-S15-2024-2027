% P39 (*) A list of prime numbers. 
% Given a range of integers by its lower and upper limit, construct a 
% list of all prime numbers in that range.

:- ensure_loaded(p31).   % make sure is_prime/1 is loaded

% prime_list(A,B,L) :- L is the list of prime number P with A <= P <= B

prime_list(A,B,L) :- A =< 2, !, p_list(2,B,L).
prime_list(A,B,L) :- A1 is (A // 2) * 2 + 1, p_list(A1,B,L).

p_list(A,B,[]) :- A > B, !.
p_list(A,B,[A|L]) :- is_prime(A), !, 
   next(A,A1), p_list(A1,B,L). 
p_list(A,B,L) :- 
   next(A,A1), p_list(A1,B,L).

next(2,3) :- !.
next(A,A1) :- A1 is A + 2.
