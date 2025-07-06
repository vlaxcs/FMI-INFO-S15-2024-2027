/*

vladut
`member(X, Lista)` - Find() basically<br>
`min_list(Lista, Min)` - min() dar pe liste<br>
`word_letters(W, L) :- word(W), atom_chars(W, L).` - Sparge un cuvant in lista sa de litere<br>
`union(L1, L2, Res)` - Ca append dar fara duplicate<br>
`listing(nume_predicat)` - Afiseaza toate clauzele unui predicat<br>
`is_list(v)` - Verifica daca v este o lista <br>
`:- consult('C:/Users/Dalv/swipl.rc').` - Incarca config <br>
<br>
### Linear reverse:
```prolog
reva(L,R) :- revah(L,[],R).
revah([], R, R).
revah([H|T], S, N) :- revah(T,[H|S],N).
```
<br>

### When to use setof/bagof/findall
🎯 When to use what?
    Use findall/3 when you just want to collect all results without worrying about duplicates or free variables.
    Use bagof/3 when you want to group results by some variable, e.g. get values of X for each different Y.
    Use setof/3 when you want grouping plus sorted, unique results.

<br>

| Predicate   | Groups by free vars? | Removes duplicates? | Sorts? | Fails if no result? |
| ----------- | -------------------- | ------------------- | ------ | ------------------- |
| `bagof/3`   | ✅ Yes               | ❌ No              | ❌ No  | ✅ Yes              |
| `setof/3`   | ✅ Yes               | ✅ Yes             | ✅ Yes | ✅ Yes              |
| `findall/3` | ❌ No                | ❌ No              | ❌ No  | ❌ No (returns `[]`)|


1 ?- 3+5 is 8.
false.

2 ?- X is 3+5.
X = 8.

3 ?- 8 is 3+X.
ERROR: Arguments are not sufficiently instantiated
De ce: Al doilea argument trebuie să fie o expresie aritmetică validă, cu toate variabilele inițializate.
(al doilea argument: 3+X) 

5 ?- X=3, 8 is 5+3.
X = 3.

6 ?- X is 30-4.
X = 26.

7 ?- X is 3 * 5.
X = 15.

8 ?- X is 9/4.
X = 2.25.

IS: Primește două argumente
Al doilea argument trebuie să fie o expresie aritmetică validă, cu toate variabilele inițializate.
Primul argument trebuie să fie număr/variabilă.

Funcții prestabilite:
ex: 
- 2 + (-3.2 * X - max(17,X)) / 2 ** 5
- 2 ** 5 (Adică 2^5)
- max/2, min/2, abs/1 (modul), sqrt/1 (radical), sin/1 (sinus)
- // pentru împărțire întreagă, / pentru float
- mod

Se folosește așa:
?- 8 is mod(8, 3).
2.

?- 2 =:= mod(8, 3).
true.


- Write / Scrie / Afișează / Afiseaza / Print

?- write(’Hello World!’), nl.
Hello World!
true
?- X = hello, write(X), nl.
hello
X = hello


- Liste, head, tail
1 ?- [1, 2, 3, 4, 5] = [Head | Tail].
Head = 1,
Tail = [2, 3, 4, 5].

- Liste: al doilea element din listă
?- [quod, licet, jovi, non, licet, bovi] = [_ , X | _].
X = licet


- Funcții predefinite liste

• length/2: al doilea argument ˆıntoarce lungimea listei date ca prim
argument
• member/2: este adev˘arat dac˘a primul argument se afl˘a ˆın lista dat˘a
ca al doilea argument
• append/3: identic cu predicatul anterior concat lists/3
• last/2: este adev˘arat dac˘a al doilea argument este identic cu
ultimul element al listei date ca prim argument
• reverse/2: lista din al doilea argument este lista dat˘a ca prim
element ˆın oglind˘

*/

% Triangle
    % Print a row of N Characters
    print_row(0, _) :- nl.
    print_row(N, C) :-
        N > 0,
        write(C),
        N1 is N - 1,
        print_row(N1, C).
    % Draw a triangle using C
    triangle(0, _).
    triangle(N, C) :-
        N > 0,
        print_row(N, C),
        N1 is N - 1,
        triangle(N1, C).

% Square - My version
write_fixed_line(0, _) :- nl.
write_fixed_line(N, C) :-
    N > 0,
    write(C),
    N1 is N - 1,
    write_fixed_line(N1, C).

sqr(0, _).
sqr(N, C) :-
    N > 0,
    write_line(N, C, N).

write_line(0, _, _).
write_line(RowsLeft, C, N) :-
    RowsLeft > 0,
    write_fixed_line(N, C),
    Next is RowsLeft - 1,
    write_line(Next, C, N).

% Element Of / Element în listă / Element listă / Element lista / Element in lista
    % Dacă elementul căutat este HEAD, e adevărat (există în listă)
    element_of(X, [X | _]).
    % Altfel, continuăm să tăiem din HEAD
    element_of(X, [_|Tail]) :- element_of(X, Tail).

% Concateneaza / Concatenare / Concat
% Rezultat în ultimul arg
concat_lists([], List, List).
concat_lists([Elem | List1], List2, [Elem | List3]) :-
concat_lists(List1, List2, List3).

/* A) Definiți un predicat all_a/1 care primește ca argument o listă și care
verifică dacă argumentul său este format doar din a-uri. */

all_a([]).
all_a([a|X]) :- all_a(X).


% ---------- Laboratorul II ----------

% Exercițiul 1: Distanța dintre două puncte
% Definiți un predicat distance/3 care calculează distanța dintre două puncte din plan.
% Punctele sunt date ca perechi de coordonate (X, Y). */
distance((X1, Y1), (X2, Y2), D) :- D is sqrt((X1 - X2) ** 2 + (Y1 - Y2) ** 2).


% Exercițiul 2: Numerele Fibonacci
% Scrieți un predicat fib/2 care, pentru orice n, calculează elementul de pe poziția n din șirul Fibonacci.
fib(0,1).
fib(1,1).
fib(N,X) :- 2 =< N, M is N - 1, fib(M, Y), P is N - 2, fib(P, Z), X is Y + Z.

fibo(0,0,1).
fibo(1,1,1).
fibo(N,Z,X) :- 2 =< N, M is N-1, fibo(M,Y,Z), X is Y + Z.

fibg(N,X) :- fibo(N,_,X).


% Exercițiul 3: Afișarea unui pătrat de caractere
% Scrieți un program în Prolog care afișează un pătrat de n × n caractere pe ecran.
% Denumiți predicatul square/2. Primul argument este un număr natural diferit de 0,
% iar al doilea argument este caracterul care trebuie afișat.
line(0,_).
line(X,C):- 
    X>0, Y is X-1, 
    write(C), 
    line(Y,C).

rectangle(0,_,_): - nl.
rectangle(X,Z,C) :- 
    X > 0, 
    Y is X-1, 
    line(Z,C), 
    nl, 
    rectangle(Y,Z,C).

square(X,C) :- rectangle(X,X,C).

% ex4:
/* A) Definiți un predicat all_a/1 care primește ca argument o listă și care
verifică dacă argumentul său este format doar din a-uri. */
all_a([]).
all_a([a|X]):-all_a(X).

/* Scrieți un predicat trans_a_b/2 care traduce o listă de a-uri într-o listă de b-uri. 
trans_a_b(X, Y) trebuie să fie adevărat dacă X este o listă de a-uri și Y este o listă de b-uri, 
iar cele două liste au lungimi egale. */
trans_a_b([],[]).
trans_a_b([a|X],[b|Y]):-trans_a_b(X,Y).

% ex5:
/* A) Scrieți un predicat scalarMult/3, al cărui prim argument este un
întreg, al doilea argument este o listă de întregi, iar al treilea argument
este rezultatul înmulțirii fiecărui element din a doua listă cu primul argument. */
scalarMult(_, [], []).
scalarMult(S, [H | T], [X | Y]) :- X is S * H, scalarMult(S, T, Y). 

/* B) Scrieți un predicat dot/3 al cărui prim argument este o listă de
întregi, al doilea argument este o listă de întregi de lungimea primeia, iar
al treilea argument este produsul scalar dintre primele două argumente. */
dot([], [], 0).
dot([H | T], [X | Y], Result) :- dot(T, Y, Next), Result is Next + H * X.
% dot([],[],0).
% dot([H|T],[X|Y],M) :- dot(T,Y,N), M is N + H * X.

/* C) Scrieți un predicat max/2 care caută elementul maxim într-o listă de numere naturale. */
max([], 0).
max([H | T], Current) :- max(T, Next), maxim(H, Next, Current).

maxim(A, B, B) :- B > A. % compara 1 cu 2 si pune in 3
maxim(A, B, A) :- A >= B.


% ---------- Laboratorul III ----------
/* Exercițiul 1
Definiți un predicat palindrome/1 care este adevărat dacă lista primită
ca argument este palindrom (lista citită de la stânga la dreapta este
identică cu lista citită de la dreapta la stânga).*/

palindrome([]).     % Orice șir vid este un palindrom
palindrome([_]).    % Orice șir de un caracter este un palindrom
palindrome([H|T]) :-
    append(Mid, [H], T),
    palindrome(Mid).

/* Exercițiul 2
Definiți un predicat remove_duplicates/2 care șterge toate duplicatele
din lista dată ca prim argument și întoarce rezultatul în al doilea
argument. */
remove_duplicates([], []).
remove_duplicates([H | T], [H | Result]) :-
    \+ member(H, T),    % verifică dacă H nu se află în lista T
    remove_duplicates(T, Result).
remove_duplicates([H | T], Result) :-
    member(H, T),
    remove_duplicates(T, Result).

% ?- remove_duplicates([a, b, c, c], List).    
% List = [a, b, c] 

% ?- remove_duplicates([a, b, a, c, d, d], List).
% List = [b, a, c, d]

/* Exercițiul 3
Definiți un predicat atimes/3 care să fie adevărat exact atunci când
elementul din primul argument apare în lista din al doilea argument de
numărul de ori precizat în al treilea argument. */
atimes(_, [], 0). % Orice element apare în lista vidă de 0 ori
atimes(This, [This | T], Count) :- atimes(This, T, CountFromLast), Count is CountFromLast + 1.
atimes(This, [Another | T], Count) :- atimes(This, T, Count), Another \= This.

/* Exercițiul 4
Predicatul insertsort/2 sortează lista de pe primul argument folosind
algoritmul insertion sort. */

insertsort([],[]).
insertsort([H|T],L) :- 
    insertsort(T,L1), 
    insert(H,L1,L).

insert(X,[],[X]).
insert(X,[H|T],[X|[H|T]]) :- X < H.
insert(X,[H|T],[H|L]) :- X >= H, insert(X,T,L).

/* Exercițiul 5
Predicatul quicksort/2 sortează lista de pe primul argument folosind algoritmul quicksort.
Scrieți regulile care definesc comportamentul predicatului ajutător split/4. */

quicksort([],[]).
quicksort([H|T],L) :-
    split(H,T,A,B), 
    quicksort(A,M), 
    quicksort(B,N),
    append(M,[H|N],L).

split(_, [], [], []).
split(X, [H|T], [H|A], B) :- 
    H < X, 
    split(X, T, A, B).

split(X, [H|T], A, [H|B]) :- 
    H >= X, 
    split(X, T, A, B).

% ---------- Laboratorul IV ----------
/* Exercițiul 1
Definiți un predicat listaNelem/3 astfel încât, pentru orice L, N, M,
listaNelem(L, N, M) este adevărat exact atunci când M este o listă cu N
elemente care sunt toate elemente ale lui L (cu eventuale repetiții). */

listaNelem(_,0,[]).
listaNelem(L,N,[H|T]) :- N > 0, P is N - 1, member(H,L), listaNelem(L,P,T).

% sau cu bagof
listeNelem(L,N,LL) :- bagof(M, listaNelem(L,N,M), LL).

/* Exercițiul 2

Șase cuvinte din engleză, anume:
abalone, abandon, anagram, connect, elegant, enhance
trebuie aranjate într-un puzzle de cuvinte încrucișate, ca în figură.


Exercițiul 2 (cont.)
Pornind de la faptele
% Definiți un predicat crosswd/6 care calculează toate variantele în care
% puteți completa grila. Primele trei argumente trebuie să fie cuvintele pe
% verticală, de la stânga la dreapta (V1, V2, V3), iar următoarele trei
% argumente trebuie să fie cuvintele pe orizontală, de sus în jos (H1, H2, H3).
% Hint: Specificați că V1, V2, V3, H1, H2, H3 sunt cuvinte care au
% anumite litere comune. Unde este cazul, folosiți variabile anonime. */

word(abalone,a,b,a,l,o,n,e).
word(abandon,a,b,a,n,d,o,n).
word(enhance,e,n,h,a,n,c,e).
word(anagram,a,n,a,g,r,a,m).
word(connect,c,o,n,n,e,c,t).
word(elegant,e,l,e,g,a,n,t).

crosswd(V1,V2,V3,H1,H2,H3) :-
                word(V1,_,A,_,B,_,C,_),
                word(V2,_,D,_,E,_,F,_),
                word(V3,_,G,_,H,_,I,_),
                word(H1,_,A,_,D,_,G,_),
                word(H2,_,B,_,E,_,H,_),
                word(H3,_,C,_,F,_,I,_).


% ex3:

path(X,X,[X]).
path(X,Y,[X|L]) :- connected(X,Z), path(Z,Y,L).

pathc(X,Y) :- path(X,Y,_).

% ex4:

word_letters(X,Y) :- atom_chars(X,Y).

liminus([C|L],C,L).
liminus([D|L],C,[D|M]) :- D\==C, liminus(L,C,M).

cover([],_).
cover([H|T],L) :- liminus(L,H,M), cover(T,M).

solution(Letters, Word, Len) :- word(Word), word_letters(Word,WordLetters), length(WordLetters,Len), cover(WordLetters, Letters).

search_solution(_,'no solution',0).
search_solution(ListLetters,Word,X) :- X > 0, solution(ListLetters,Word,X).
search_solution(ListLetters,Word,X) :- X > 0, not(solution(ListLetters,Word,X)), Y is X-1, search_solution(ListLetters,Word,Y).

topsolution(ListLetters,Word) :- length(ListLetters, MaxScore),  search_solution(ListLetters,Word,MaxScore).

% ---------- Laboratorul V ----------

% ex1:

vars(V,[V]) :- atom(V).
vars(non(X),S) :- vars(X,S).
vars(si(X,Y),S) :- vars(X,T), vars(Y,U), union(T,U,S).
vars(sau(X,Y),S) :- vars(X,T), vars(Y,U), union(T,U,S).
vars(imp(X,Y),S) :- vars(X,T), vars(Y,U), union(T,U,S).

% ex2:

val(V,[(V,A)|_],A).
val(V,[_|T],A) :- val(V,T,A).

% Solutie alternativa:

val(V,E,A) :- member((V,A),E).

% ex3:

bnon(0,1). bnon(1,0).
bsi(0,0,0). bsi(0,1,0). bsi(1,0,0). bsi(1,1,1).
bsau(0,0,0). bsau(0,1,1). bsau(1,0,1). bsau(1,1,1).
% X -> Y = (non X) sau Y
bimp(X,Y,Z) :- bnon(X,NX), bsau(NX,Y,Z).

% ex4:

eval(V,E,A) :- atom(V), val(V,E,A).
eval(non(X),E,A) :- eval(X,E,B), bnon(B,A).
eval(si(X,Y),E,A) :- eval(X,E,B), eval(Y,E,C), bsi(B,C,A).
eval(sau(X,Y),E,A) :- eval(X,E,B), eval(Y,E,C), bsau(B,C,A).
eval(imp(X,Y),E,A) :- eval(X,E,B), eval(Y,E,C), bimp(B,C,A).

% ex5:

evals(_,[],[]).
evals(X,[E|Es],[A|As]) :- eval(X,E,A), evals(X,Es,As).

% ex6:

evs([],[[]]).
evs([V|T],Es) :- evs(T,Esp), adauga(V,Esp,Es).
adauga(_,[],[]).
adauga(V,[E|T], [[(V,0)|E],[(V,1)|E]|Es]) :- adauga(V,T,Es).

% ex7:

all_evals(X,As) :- vars(X,S), evs(S,Es), evals(X,Es,As).

% ex8:

all_ones([]).
all_ones([1|T]) :- all_ones(T).
taut(X) :- all_evals(X,As), all_ones(As).

