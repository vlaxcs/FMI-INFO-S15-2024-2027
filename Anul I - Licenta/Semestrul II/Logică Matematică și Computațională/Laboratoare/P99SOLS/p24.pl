% P24 (*): Lotto: Draw N different random numbers from the set 1..M

% lotto(N,M,L) :- the list L contains N randomly selected distinct
%    integer numbers from the interval 1..M
%    (integer,integer,number-list) (+,+,-)

:- ensure_loaded(p22).
:- ensure_loaded(p23).

lotto(N,M,L) :- range(1,M,R), rnd_select(R,N,L).
