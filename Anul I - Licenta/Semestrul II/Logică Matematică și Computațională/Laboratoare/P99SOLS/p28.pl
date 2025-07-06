% P28 (**) Sorting a list of lists according to length
%
% a) length sort
%
% lsort(InList,OutList) :- it is supposed that the elements of InList 
% are lists themselves. Then OutList is obtained from InList by sorting 
% its elements according to their length. lsort/2 sorts ascendingly,
% lsort/3 allows for ascending or descending sorts.
% (list_of_lists,list_of_lists), (+,?)

lsort(InList,OutList) :- lsort(InList,OutList,asc).

% sorting direction Dir is either asc or desc

lsort(InList,OutList,Dir) :-
   add_key(InList,KList,Dir),
   keysort(KList,SKList),
   rem_key(SKList,OutList).

add_key([],[],_).
add_key([X|Xs],[L-p(X)|Ys],asc) :- !, 
	length(X,L), add_key(Xs,Ys,asc).
add_key([X|Xs],[L-p(X)|Ys],desc) :- 
	length(X,L1), L is -L1, add_key(Xs,Ys,desc).

rem_key([],[]).
rem_key([_-p(X)|Xs],[X|Ys]) :- rem_key(Xs,Ys).

% b) length frequency sort
%
% lfsort (InList,OutList) :- it is supposed that the elements of InList
% are lists themselves. Then OutList is obtained from InList by sorting
% its elements according to their length frequency; i.e. in the default,
% where sorting is done ascendingly, lists with rare lengths are placed
% first, other with more frequent lengths come later.
%
% Example:
% ?- lfsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],L).
% L = [[i, j, k, l], [o], [a, b, c], [f, g, h], [d, e], [d, e], [m, n]]
%
% Note that the first two lists in the Result have length 4 and 1, both
% length appear just once. The third and forth list have length 3 which
% appears, there are two list of this length. And finally, the last
% three lists have length 2. This is the most frequent length.

lfsort(InList,OutList) :- lfsort(InList,OutList,asc).

% sorting direction Dir is either asc or desc

lfsort(InList,OutList,Dir) :-
	add_key(InList,KList,desc),
   keysort(KList,SKList),
   pack(SKList,PKList),
   lsort(PKList,SPKList,Dir),
   flatten(SPKList,FKList),
   rem_key(FKList,OutList).
   
pack([],[]).
pack([L-X|Xs],[[L-X|Z]|Zs]) :- transf(L-X,Xs,Ys,Z), pack(Ys,Zs).

% transf(L-X,Xs,Ys,Z) Ys is the list that remains from the list Xs
%    when all leading copies of length L are removed and transfed to Z

transf(_,[],[],[]).
transf(L-_,[K-Y|Ys],[K-Y|Ys],[]) :- L \= K.
transf(L-_,[L-X|Xs],Ys,[L-X|Zs]) :- transf(L-X,Xs,Ys,Zs).

test :-
   L = [[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],
   write('L = '), write(L), nl,
   lsort(L,LS),
   write('LS = '), write(LS), nl,
   lsort(L,LSD,desc),
   write('LSD = '), write(LSD), nl,
   lfsort(L,LFS),
   write('LFS = '), write(LFS), nl.
