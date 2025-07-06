% Crossword puzzle
%
% Given an empty (or almost empty) framework of a crossword puzzle and 
% a set of words. The problem is to place the words into the framework.
%
% werner.hett@hta-bi.bfh.ch     Time-stamp: <8-Oct-2000 14:46 hew>
% modified argument order in select/3 predicate (SWI 3.3 -> 3.4) 
% 15-May-2001 hew
%
% The particular crossword puzzle is specified in a text file which
% first lists the words (one word per line) in an arbitrary order. Then,
% after an empty line, the crossword framework is defined. In this 
% framework specification, an empty character location is represented
% by a dot (.). In order to make the solution easier, character locations 
% can also contain predefined character values. (See example files p99*.dat;
% note that p99c.dat does not have a solution).
%
% Words are strings (character lists) of at least two characters. 
% A horizontal or vertical sequence of character places in the 
% crossword framework is called a site. Our problem is to find a 
% compatible way of placing words onto sites.

:- ensure_loaded('p99-readfile.pl').  % used to read the data file

% main program section -----------------------------------------------------

crossword :-
	write('usage: crossword(File)'), nl,
   write('or     crossword(File,Opt)         with Opt one of 0,1, or 2'), nl,
   write('or     crossword(File,Opt,debug)   for extra output'), nl.

:- crossword.

% crossword/1 runs without optimization (not recommended for large files)
crossword(FileName) :- crossword(FileName,0).

% crossword/2 runs with a given optimization and no debug output
crossword(FileName,Opt) :- crossword(FileName,Opt,nodebug).

% crossword/3 runs with a given optimization and a given debugging modus
crossword(FileName,Opt,Debug) :-
   read_lines(FileName,Lines),  % from file p99-readfile.pl
                                % read_lines returns a list of character-lists
   separate(Lines,Words,FrameLines),
   length(Words,NWords), 
   construct_squares(FrameLines,Squares,MaxRow,MaxCol),
   debug_write(Debug,Squares),
   construct_sites(Squares,MaxRow,MaxCol,Sites),
	length(Sites,NSites),
   check_lengths(NWords,NSites), 
   solve(Words,Sites,Opt,Debug), % do the real work
   show_result(Squares,MaxRow,MaxCol).

debug_write(debug,X) :- !, write(X), nl, nl.
debug_write(_,_).

check_lengths(N,N) :- !.
check_lengths(NW,NS) :- NW \= NS, 
	write('Number of words does not correspond to number of sites.'), nl,
   fail.

% input preparation ----------------------------------------------------

% parse the data file and separate the word list from the framework 
% description
separate(Lines,Words,FrameLines) :-
   trim_lines(Lines,LinesT),
   parse_non_empty_lines(LinesT-L1,Words),  % difference lists!
   parse_empty_lines(L1-L2),
	parse_non_empty_lines(L2-L3,FrameLines),
   parse_empty_lines(L3-[]).

% remove white space at the end of the lines
trim_lines([],[]).
trim_lines([L|Ls],[LT|LTs]) :- trim_line(L,LT), trim_lines(Ls,LTs).

trim_line(L,LT) :- reverse(L,RL), rm_white_space(RL,RLT), reverse(RLT,LT).

rm_white_space([X|Xs],L) :- char_type(X,white), !, rm_white_space(Xs,L).
rm_white_space(L,L).      

% separate the word lines from the frame lines
parse_non_empty_lines([L|L1]-L2,[L|Ls]) :- L \= [], !, 
   parse_non_empty_lines(L1-L2,Ls).
parse_non_empty_lines(L-L,[]).

parse_empty_lines([[]|L1]-L2) :- !, parse_empty_lines(L1-L2).
parse_empty_lines(L-L).

% A square is a position for a single character. As Prolog term a square
% has the form sq(Row,Col,X), where X denotes the character and Row and
% Col define the position within the puzzle frame. Squares is simply
% the list of all sq/3 terms.

construct_squares(FrameLines,Squares,MaxRow,MaxCol) :-   % (+,-,+,+)
   construct_squares(FrameLines,SquaresList,1),
   flatten(SquaresList,Squares),
   maxima(Squares,0,0,MaxRow,MaxCol).

construct_squares([],[],_).                              % (+,-,+)
construct_squares([FL|FLs],[SL|SLs],Row) :- 
   construct_squares_row(FL,SL,Row,1),
   Row1 is Row+1,
   construct_squares(FLs,SLs,Row1).

construct_squares_row([],[],_,_).                        % (+,-,+,+)
construct_squares_row(['.'|Ps],[sq(Row,Col,_)|Sqs],Row,Col) :- !, 
   Col1 is Col+1, construct_squares_row(Ps,Sqs,Row,Col1).
construct_squares_row([X|Ps],[sq(Row,Col,X)|Sqs],Row,Col) :- 
   char_type(X,alpha), !, 
   Col1 is Col+1, construct_squares_row(Ps,Sqs,Row,Col1).
construct_squares_row([_|Ps],Sqs,Row,Col) :-  
   Col1 is Col+1, construct_squares_row(Ps,Sqs,Row,Col1).

% maxima(Squares,0,0,MaxRow,MaxCol) :- determine maximum dimensions

maxima([],MaxRow,MaxCol,MaxRow,MaxCol).
maxima([sq(Row,Col,_)|Sqs],AccRow,AccCol,MaxRow,MaxCol) :-
   AccRow1 is max(AccRow,Row),
   AccCol1 is max(AccCol,Col),
   maxima(Sqs,AccRow1,AccCol1,MaxRow,MaxCol).

% construction of sites -----------------------------------------------

% construct_sites/4 traverses the framework twice in order to
% collect all the sites in the list Sites

construct_sites(Squares,MaxRow,MaxCol,Sites) :-             % (+,+,+,-)
	construct_sites_h(Squares,MaxRow,MaxCol,1,SitesH,[]),    % horizontal
	construct_sites_v(Squares,MaxRow,MaxCol,1,Sites,SitesH). % vertical

% horizontal sites

construct_sites_h(_,MaxRow,_,Row,Sites,Sites) :- Row > MaxRow, !.
construct_sites_h(Squares,MaxRow,MaxCol,Row,Sites,AccSites) :-
   construct_sites_h(Squares,MaxRow,MaxCol,Row,1,AccSites1,AccSites),
   Row1 is Row+1,
	construct_sites_h(Squares,MaxRow,MaxCol,Row1,Sites,AccSites1).

construct_sites_h(_,_,MaxCol,_,Col,Sites,Sites) :- Col > MaxCol, !.
construct_sites_h(Squares,MaxRow,MaxCol,Row,Col,Sites,AccSites) :-
   construct_site_h(Squares,Row,Col,Site,Incr), !,
   Col1 is Col+Incr, 
   AccSites1 = [Site|AccSites],
   construct_sites_h(Squares,MaxRow,MaxCol,Row,Col1,Sites,AccSites1).
construct_sites_h(Squares,MaxRow,MaxCol,Row,Col,Sites,AccSites) :-
   Col1 is Col+1,
   construct_sites_h(Squares,MaxRow,MaxCol,Row,Col1,Sites,AccSites).

construct_site_h(Squares,Row,Col,[X,Y|Cs],Incr) :-
   memberchk(sq(Row,Col,X),Squares),
   Col1 is Col+1,
   memberchk(sq(Row,Col1,Y),Squares),
   Col2 is Col1+1,
   continue_site_h(Squares,Row,Col2,Cs,3,Incr).

continue_site_h(Squares,Row,Col,[X|Cs],Acc,Incr) :-
   memberchk(sq(Row,Col,X),Squares), !,
   Acc1 is Acc+1,
   Col1 is Col+1,
   continue_site_h(Squares,Row,Col1,Cs,Acc1,Incr).
continue_site_h(_,_,_,[],Incr,Incr).

% vertical sites
   
construct_sites_v(_,_,MaxCol,Col,Sites,Sites) :- Col > MaxCol, !.
construct_sites_v(Squares,MaxRow,MaxCol,Col,Sites,AccSites) :-
   construct_sites_v(Squares,MaxRow,MaxCol,1,Col,AccSites1,AccSites),
   Col1 is Col+1,
	construct_sites_v(Squares,MaxRow,MaxCol,Col1,Sites,AccSites1).

construct_sites_v(_,MaxRow,_,Row,_,Sites,Sites) :- Row > MaxRow, !.
construct_sites_v(Squares,MaxRow,MaxCol,Row,Col,Sites,AccSites) :-
   construct_site_v(Squares,Row,Col,Site,Incr), !,
   Row1 is Row+Incr,
   AccSites1 = [Site|AccSites],
   construct_sites_v(Squares,MaxRow,MaxCol,Row1,Col,Sites,AccSites1).
construct_sites_v(Squares,MaxRow,MaxCol,Row,Col,Sites,AccSites) :-
   Row1 is Row+1,
   construct_sites_v(Squares,MaxRow,MaxCol,Row1,Col,Sites,AccSites).

construct_site_v(Squares,Row,Col,[X,Y|Cs],Incr) :-
   memberchk(sq(Row,Col,X),Squares),
   Row1 is Row+1,
   memberchk(sq(Row1,Col,Y),Squares),
   Row2 is Row1+1,
   continue_site_v(Squares,Row2,Col,Cs,3,Incr).

continue_site_v(Squares,Row,Col,[X|Cs],Acc,Incr) :-
   memberchk(sq(Row,Col,X),Squares), !,
   Acc1 is Acc+1,
   Row1 is Row+1,
   continue_site_v(Squares,Row1,Col,Cs,Acc1,Incr).
continue_site_v(_,_,_,[],Incr,Incr).

% --------------------------------------------------------------------------

:- ensure_loaded('p28.pl').  % lsort and lfsort

% solve/4 does the optimization of the word and site lists

solve(Words,Sites,0,Debug) :- !,   % unsorted 
	solve(Words,Sites,Debug).
solve(Words,Sites,1,Debug) :- !,   % length sorted
	lsort(Words,Words1,desc),
   lsort(Sites,Sites1,desc),
	solve(Words1,Sites1,Debug).
solve(Words,Sites,2,Debug) :-      % length frequency sorted 
	lfsort(Words,Words1),
   lfsort(Sites,Sites1),
	solve(Words1,Sites1,Debug).

% solve/3 does the debug_write of the prepared Words and Sites
% and then calls solve/2 to do the real work

solve(Words,Sites,Debug) :-  
   debug_write(Debug,Words), 
   debug_write(Debug,Sites),
   solve(Words,Sites).        

% solve/2 does the real work: find the right site for every word

solve([],[]).
solve([W|Words],Sites) :- 
	select(W,Sites,SitesR),
	solve(Words,SitesR).

% --------------------------------------------------------------------------

show_result(Squares,MaxRow,MaxCol) :-
   show_result(Squares,MaxRow,MaxCol,1), nl.

show_result(_,MaxRow,_,Row) :- Row > MaxRow, !.
show_result(Squares,MaxRow,MaxCol,Row) :- 
   show_result(Squares,MaxRow,MaxCol,Row,1), nl,
   Row1 is Row+1, show_result(Squares,MaxRow,MaxCol,Row1).

show_result(_,_,MaxCol,_,Col) :- Col > MaxCol, !. 
show_result(Squares,MaxRow,MaxCol,Row,Col) :- 
   (memberchk(sq(Row,Col,X),Squares), !, write(X); write(' ')),
   Col1 is Col+1, show_result(Squares,MaxRow,MaxCol,Row,Col1).  

% -------------------------------------------------------------------------

% Benchmark results <8-Oct-2000 14:45 hew>

% On a 330 MHz Pentium II the following results have been measured
% with SWI-Prolog version 3.3.10 for i686-linux under SuSE Linux 6.3

% ?- time(crossword('p99b.dat',0)).
% 439,743,691 inferences in 1975.34 seconds (222617 Lips)

% ?- time(crossword('p99b.dat',1)).
% 19,644,100 inferences in 76.37 seconds (257223 Lips) 

% ?- time(crossword('p99b.dat',2)).
% 152,880 inferences in 0.94 seconds (162638 Lips)   
