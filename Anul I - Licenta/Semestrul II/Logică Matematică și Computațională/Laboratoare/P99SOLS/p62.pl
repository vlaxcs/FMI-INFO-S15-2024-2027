% P62 (*) Collect the internal nodes of a binary tree in a list

:- ensure_loaded(p54).

% internals(T,S) :- S is the list of internal nodes of the binary tree T.

internals(nil,[]).
internals(t(_,nil,nil),[]).
internals(t(X,L,nil),[X|S]) :- L = t(_,_,_), internals(L,S).
internals(t(X,nil,R),[X|S]) :- R = t(_,_,_), internals(R,S).
internals(t(X,L,R),[X|S]) :- L = t(_,_,_), R = t(_,_,_), 
   internals(L,SL), internals(R,SR), append(SL,SR,S).

% The above solution works in the flow patterns (i,o) and (i,i)
% without cut and produces a single correct result. Using a cut 
% we can obtain the same result in a much shorter program, like this:

internals1(nil,[]).
internals1(t(_,nil,nil),[]) :- !.
internals1(t(X,L,R),[X|S]) :- 
    internals1(L,SL), internals1(R,SR), append(SL,SR,S).

% For the flow pattern (o,i) there is the following very
% elegant solution:

internals2(nil,[]).
internals2(t(X,L,R),[X|S]) :- 
   append(SL,SR,S), internals2(L,SL), internals2(R,SR).
