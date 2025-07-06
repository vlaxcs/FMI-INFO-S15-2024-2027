% P22 (*):  Create a list containing all integers within a given range.

% range(I,K,L) :- I <= K, and L is the list containing all 
%    consecutive integers from I to K.
%    (integer,integer,list) (+,+,?)

range(I,I,[I]).
range(I,K,[I|L]) :- I < K, I1 is I + 1, range(I1,K,L).
