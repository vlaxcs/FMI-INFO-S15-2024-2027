% P91 (**) Knight's tour
% Another famous problem is this one: How can a knight jump on an
% NxN chessboard in such a way that it visits every square exactly once?

% knights(N,Knights) :- Knights is a knight's tour on a NxN chessboard 

knights(N,Knights) :- M is N*N-1,  knights(N,M,[1/1],Knights).

% closed_knights(N,Knights) :- Knights is a knight's tour on a NxN 
% chessboard which ends at the same square where it begun.

closed_knights(N,Knights) :- 
   knights(N,Knights), Knights = [X/Y|_], jump(N,X/Y,1/1). 

% knights(N,M,Visited,Knights) :- the list of squares Visited must be
% extended by M further squares to give the solution Knights of the
% NxN chessboard knight's tour problem. 

knights(_,0,Knights,Knights).
knights(N,M,Visited,Knights) :-
   Visited = [X/Y|_],
   jump(N,X/Y,U/V),
   \+ memberchk(U/V,Visited),
   M1 is M-1,
   knights(N,M1,[U/V|Visited],Knights).

% jumps on an NxN chessboard from square A/B to C/D
jump(N,A/B,C/D) :- 
   jump_dist(X,Y), 
   C is A+X, C > 0, C =< N,
   D is B+Y, D > 0, D =< N.

% jump distances
jump_dist(1,2).
jump_dist(2,1).
jump_dist(2,-1).
jump_dist(1,-2).
jump_dist(-1,-2).
jump_dist(-2,-1).
jump_dist(-2,1).
jump_dist(-1,2).


% A more user-friendly presentation of the results ------------------------

show_knights(N) :- 
   get_time(Time), convert_time(Time,Tstr),
   write('Start: '), write(Tstr), nl, nl,
   knights(N,Knights), nl, show(N,Knights).

show(N,Knights) :-
   get_time(Time), convert_time(Time,Tstr),
   write(Tstr), nl, nl,
   length(Chessboard,N),
   Pred =.. [invlength,N],
   checklist(Pred,Chessboard),
   fill_chessboard(Knights,Chessboard,1),
   checklist(show_row,Chessboard),
   nl, fail.

invlength(N,L) :- length(L,N).

show_row([]) :- nl.
show_row([S|Ss]) :- writef('%3r',[S]), show_row(Ss). 

fill_chessboard([],_,_).
fill_chessboard([X/Y|Ks],Chessboard,K) :-
   nth1(Y,Chessboard,Row),
   nth1(X,Row,K),
   K1 is K+1,
   fill_chessboard(Ks,Chessboard,K1).

% --------------------------------------------------------------------------


