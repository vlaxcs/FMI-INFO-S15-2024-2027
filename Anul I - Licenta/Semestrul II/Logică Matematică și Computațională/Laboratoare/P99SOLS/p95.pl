% P95 (**) English number words
% On financial documents, like cheques, numbers must sometimes be 
% written in full words. Example: 175 must be written as one-seven-five.
% Write a predicate full_words/1 to print (non-negative) integer numbers
% in full words.

% full_words(N) :- print the number N in full words (English)
% (non-negative integer) (+)

full_words(0) :- !, write(zero), nl.
full_words(N) :- integer(N), N > 0, full_words1(N), nl.

full_words1(0) :- !.
full_words1(N) :- N > 0,
   Q is N // 10, R is N mod 10,
   full_words1(Q), numberword(R,RW), hyphen(Q), write(RW).

hyphen(0) :- !.
hyphen(Q) :- Q > 0, write('-'). 

numberword(0,zero).
numberword(1,one).
numberword(2,two).
numberword(3,three).
numberword(4,four).
numberword(5,five).
numberword(6,six).
numberword(7,seven).
numberword(8,eight).
numberword(9,nine).
