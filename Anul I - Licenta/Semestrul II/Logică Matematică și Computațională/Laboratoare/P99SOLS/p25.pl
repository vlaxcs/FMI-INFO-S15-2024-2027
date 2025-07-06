% P25 (*):  Generate a random permutation of the elements of a list

% rnd_permu(L1,L2) :- the list L2 is a random permutation of the
%    elements of the list L1.
%    (list,list) (+,-)

:- ensure_loaded(p23).

rnd_permu(L1,L2) :- length(L1,N), rnd_select(L1,N,L2).
