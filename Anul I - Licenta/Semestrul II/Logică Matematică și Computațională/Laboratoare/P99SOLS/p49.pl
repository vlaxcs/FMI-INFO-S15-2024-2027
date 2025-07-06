% (**) P49 Gray codes

% gray(N,C) :- C is the N-bit Gray code

gray(1,['0','1']).
gray(N,C) :- N > 1, N1 is N-1,
   gray(N1,C1), reverse(C1,C2),
   prepend('0',C1,C1P),
   prepend('1',C2,C2P),
   append(C1P,C2P,C).

prepend(_,[],[]) :- !.
prepend(X,[C|Cs],[CP|CPs]) :- atom_concat(X,C,CP), prepend(X,Cs,CPs).


% This gives a nice example for the result caching technique:

:- dynamic gray_c/2.

gray_c(1,['0','1']) :- !.
gray_c(N,C) :- N > 1, N1 is N-1, 
   gray_c(N1,C1), reverse(C1,C2),
   prepend('0',C1,C1P),
   prepend('1',C2,C2P),
   append(C1P,C2P,C),
   asserta((gray_c(N,C) :- !)).

% Try the following goal sequence and see what happens:

% ?- [p49]. 
% ?- listing(gray_c/2).
% ?- gray_c(5,C).
% ?- listing(gray_c/2).


% There is an alternative definition for the gray code construction:

gray_alt(1,['0','1']).
gray_alt(N,C) :- N > 1, N1 is N-1,
   gray_alt(N1,C1), 
   postpend(['0','1'],C1,C).   

postpend(_,[],[]).
postpend(P,[C|Cs],[C1P,C2P|CsP]) :- P = [P1,P2],
   atom_concat(C,P1,C1P), 
   atom_concat(C,P2,C2P),
   reverse(P,PR),
   postpend(PR,Cs,CsP).
