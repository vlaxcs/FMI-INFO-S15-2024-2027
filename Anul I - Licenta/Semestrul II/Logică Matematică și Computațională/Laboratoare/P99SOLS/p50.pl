% (***) P50 Huffman code

% We suppose a set of symbols with their frequencies, given as a list 
% of fr(S,F) terms. 
% Example: [fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)]. 
% Our objective is to construct a list hc(S,C) terms, where C is the Huffman
% code word for the symbol S. In our example the result could be 
% [hc(a, '0'), hc(b, '101'), hc(c, '100'), hc(d, '111'), hc(e, '1101'), 
% hc(f, '1100')]  

% The task shall be performed by the predicate huffman/2 defined as follows: 
 
% huffman(Fs,Hs) :- Hs is the Huffman code table for the frequency table Fs
% (list-of-fr/2-terms, list-of-hc/2-terms)  (+,-).

% During the construction process, we need nodes n(F,S) where, at the 
% beginning, F is a frequency and S a symbol. During the process, as n(F,S)
% becomes an internal node, S becomes a term s(L,R) with L and R being 
% again n(F,S) terms. A list of n(F,S) terms, called Ns, is maintained 
% as a sort of priority queue.

huffman(Fs,Cs) :-
   initialize(Fs,Ns),
   make_tree(Ns,T),
   traverse_tree(T,Cs).

initialize(Fs,Ns) :- init(Fs,NsU), sort(NsU,Ns).

init([],[]).
init([fr(S,F)|Fs],[n(F,S)|Ns]) :- init(Fs,Ns).

make_tree([T],T).
make_tree([n(F1,X1),n(F2,X2)|Ns],T) :- 
   F is F1+F2,
   insert(n(F,s(n(F1,X1),n(F2,X2))),Ns,NsR),
   make_tree(NsR,T).

% insert(n(F,X),Ns,NsR) :- insert the node n(F,X) into Ns such that the
%    resulting list NsR is again sorted with respect to the frequency F.

insert(N,[],[N]) :- !.
insert(n(F,X),[n(F0,Y)|Ns],[n(F,X),n(F0,Y)|Ns]) :- F < F0, !.
insert(n(F,X),[n(F0,Y)|Ns],[n(F0,Y)|Ns1]) :- F >= F0, insert(n(F,X),Ns,Ns1).

% traverse_tree(T,Cs) :- traverse the tree T and construct the Huffman 
%    code table Cs,

traverse_tree(T,Cs) :- traverse_tree(T,'',Cs1-[]), sort(Cs1,Cs).

traverse_tree(n(_,A),Code,[hc(A,Code)|Cs]-Cs) :- atom(A). % leaf node
traverse_tree(n(_,s(Left,Right)),Code,Cs1-Cs3) :-         % internal node
   atom_concat(Code,'0',CodeLeft), 
   atom_concat(Code,'1',CodeRight),
   traverse_tree(Left,CodeLeft,Cs1-Cs2),
   traverse_tree(Right,CodeRight,Cs2-Cs3).


% The following predicate gives some statistical information.

huffman(Fs) :- huffman(Fs,Hs) , nl, report(Hs,5), stats(Fs,Hs).

report([],_) :- !, nl, nl.
report(Hs,0) :- !, nl, report(Hs,5).
report([hc(S,C)|Hs],N) :- N > 0, N1 is N-1, 
   writef('%w %8l  ',[S,C]), report(Hs,N1).

stats(Fs,Cs) :- sort(Fs,FsS), sort(Cs,CsS), stats(FsS,CsS,0,0).

stats([],[],FreqCodeSum,FreqSum) :- Avg is FreqCodeSum/FreqSum,
   writef('Average code length (weighted) = %w\n',[Avg]). 
stats([fr(S,F)|Fs],[hc(S,C)|Hs],FCS,FS) :- 
   atom_chars(C,CharList), length(CharList,N),
   FCS1 is FCS + F*N, FS1 is FS + F,
   stats(Fs,Hs,FCS1,FS1). 
   