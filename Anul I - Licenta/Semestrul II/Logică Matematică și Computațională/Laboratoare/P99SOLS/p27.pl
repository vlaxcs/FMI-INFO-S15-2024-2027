% P27 (**) Group the elements of a set into disjoint subsets.

% Problem a)

% group3(G,G1,G2,G3) :- distribute the 9 elements of G into G1, G2, and G3,
%    such that G1, G2 and G3 contain 2,3 and 4 elements respectively

group3(G,G1,G2,G3) :- 
   selectN(2,G,G1),
   subtract(G,G1,R1),
   selectN(3,R1,G2),
   subtract(R1,G2,R2),
   selectN(4,R2,G3),
   subtract(R2,G3,[]).

% selectN(N,L,S) :- select N elements of the list L and put them in 
%    the set S. Via backtracking return all posssible selections, but
%    avoid permutations; i.e. after generating S = [a,b,c] do not return
%    S = [b,a,c], etc.

selectN(0,_,[]) :- !.
selectN(N,L,[X|S]) :- N > 0, 
   el(X,L,R), 
   N1 is N-1,
   selectN(N1,R,S).

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).

% subtract/3 is predefined

% Problem b): Generalization

% group(G,Ns,Gs) :- distribute the elements of G into the groups Gs.
%    The group sizes are given in the list Ns.

group([],[],[]).
group(G,[N1|Ns],[G1|Gs]) :- 
   selectN(N1,G,G1),
   subtract(G,G1,R),
   group(R,Ns,Gs).
