% P41 (*) A list of Goldbach compositions. 
% Given a range of integers by its lower and upper limit, 
% print a list of all even numbers and their Goldbach composition.

:- ensure_loaded(p40).

% goldbach_list(A,B) :- print a list of the Goldbach composition
%    of all even numbers N in the range A <= N <= B
%    (integer,integer) (+,+)

goldbach_list(A,B) :- goldbach_list(A,B,2).

% goldbach_list(A,B,L) :- perform goldbach_list(A,B), but suppress
% all output when the first prime number is less than the limit L.

goldbach_list(A,B,L) :- A =< 4, !, g_list(4,B,L).
goldbach_list(A,B,L) :- A1 is ((A+1) // 2) * 2, g_list(A1,B,L).

g_list(A,B,_) :- A > B, !.
g_list(A,B,L) :- 
   goldbach(A,[P,Q]),
   print_goldbach(A,P,Q,L),
   A2 is A + 2,
   g_list(A2,B,L).

print_goldbach(A,P,Q,L) :- P >= L, !,
   writef('%t = %t + %t',[A,P,Q]), nl.
print_goldbach(_,_,_,_).

