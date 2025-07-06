% P23 (**): Extract a given number of randomly selected elements 
%    from a list.

% rnd_select(L,N,R) :- the list R contains N randomly selected 
%    items taken from the list L.
%    (list,integer,list) (+,+,-)

:- ensure_loaded(p20).

rnd_select(_,0,[]).
rnd_select(Xs,N,[X|Zs]) :- N > 0,
    length(Xs,L),
    I is random(L) + 1,
    remove_at(X,Xs,I,Ys),
    N1 is N - 1,
    rnd_select(Ys,N1,Zs).
