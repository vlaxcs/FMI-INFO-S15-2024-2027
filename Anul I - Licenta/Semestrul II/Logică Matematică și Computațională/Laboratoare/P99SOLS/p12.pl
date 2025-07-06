% P12 (**): Decode a run-length compressed list.

% decode(L1,L2) :- L2 is the uncompressed version of the run-length
%    encoded list L1.
%    (list,list) (+,?)

decode([],[]).
decode([X|Ys],[X|Zs]) :- \+ is_list(X), decode(Ys,Zs).
decode([[1,X]|Ys],[X|Zs]) :- decode(Ys,Zs).
decode([[N,X]|Ys],[X|Zs]) :- N > 1, N1 is N - 1, decode([[N1,X]|Ys],Zs).
