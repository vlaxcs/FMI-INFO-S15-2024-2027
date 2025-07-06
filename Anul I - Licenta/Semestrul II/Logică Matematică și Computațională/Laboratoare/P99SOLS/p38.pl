% P38 (*) Compare the two methods of calculating Euler's totient function. 
% Use the solutions of problems P34 and P37 to compare the algorithms. 
% Take the number of logical inferences as a measure for efficiency.

:- ensure_loaded(p34).
:- ensure_loaded(p37).

totient_test(N) :-
   write('totient_phi (P34):'),
   time(totient_phi(N,Phi1)),
   write('result = '), write(Phi1), nl,
   write('totient_phi_2 (P37):'),
   time(totient_phi_2(N,Phi2)),
   write('result = '), write(Phi2), nl.

