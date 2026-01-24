## BFS / DFS

### [BFS](https://www.infoarena.ro/problema/bfs) | [Soluție](./bfs.cpp)
- Parcurge în lățime (prima dată pe același nivel)
- Complexitate: O(V * E)
- Memorie: O(n + m)
- Pentru un nod sursă:
    - Îl adăugăm în coadă
    - Câtă vreme coada nu e vidă:
        - Nodul curent devine vârful cozii
        - Adăugăm toți vecinii nodului curent în coadă:
            - Îi marcăm ca vizitați
            - Setăm timpul de vizitare la 1 + timpul nodului părinte

### [DFS](https://www.infoarena.ro/problema/dfs) | [Soluție](./dfs.cpp)
- Parcurge în adâncime / Determină numărul de componente conexe
- Complexitate: O(V * E)
- Memorie: O(n + m)
- Pentru fiecare nod nevizitat:
    - Nodul nevizitat devine sursa DFS-ului
    - Se marchează vizitat
    - Pentru toți vecinii acestui nod nou vizitat
        - Se vizitează doar cei nevizitați: DFS(neighbour)


- [Berarii](https://www.infoarena.ro/problema/berarii2) | [Soluție](./berarii2_100p.cpp)
    - Se face DFS din fiecare berărie, deci se inversează drumurile
    - Nodurile nevizitate sunt intersecțiile căutate

- [Grarb](https://www.infoarena.ro/problema/grarb) | [Soluție](./grarb.cpp)
    - Pentru structura de arbore trebuie să adăugăm:
        - Adăugăm: CC - 1 muchii pentru a uni componentele conexe
        - Știm că N - CC este numărul muchii pentru a nu forma cicluri
        - Eliminăm: M - (N - CC) muchii pentru a nu avea cicluri
    - Numărul de componente conexe e dat de numărul de parcurgeri DFS / BFS

- [Amici2](https://www.infoarena.ro/problema/amici2) | [Soluție](./amici2.cpp)
    - Facem BFS dintr-un nod și aflăm distanța maximă dintre două noduri
    - Distanța maximă >= D/2 (diametrul grafului)
    - Rezultat ~ ceil(log2(dmax)) - Fiecare zi dublează viteza de împrietenire 


## Puncte și muchii critice | [Algoritm](./biconex.cpp)
- Puncte critice: Le scoți -> graful nu mai e conex
- Muchii critice: Le scoți -> graful nu mai e conex

Un algoritm DFS:
- Facem DFS(p) în toate componentele conexe
- Nivelul minim accesibil (nma) la început de parcurgere e nivelul nodului
- Numărul de fii ai lui p la început de DFS e 0
- Trecem prin toți vecinii lui p
    - Dacă un vecin este tatăl lui p, îl ignorăm
    - Altfel, dacă e nevizitat (muchie de avansare)
        - Setăm tata[vecin] = p
        - DFS(vecin)
        - După ce se termină DFS:
        - Creșetem numărul de fii ai lui p
        - Propagăm nivelul minim accesibil al vecinului în p:
            - nma[p] = min(nma[p], nma[vecin])
        - Muchie critică (nu face parte din buclă)
            - nivel[p] < nma[vecin]
        - Punct critic (se pot repeta / aici verificăm dacă nu e rădăcină)
            - tata[p] != 0 && nivel[p] <= nma[vecin]
    - Dacă e vizitat (muchie de întoarcere)
        - Dacă putem ajunge din p prin vecin mai sus, actualizăm
            - nma[p] = min(nma[p], nivel[vecin])
- La final, dacă e rădăcină și are mai mult de un fiu e punct critic
    - tata[p] == 0 && fii_p > 1

## Componente biconexe | [Algoritm](./biconex.cpp)
Același algoritm ca mai sus, cu mici schimbări:
- Dacă vecinul e nevizitat, adăugăm muchia într-o stivă
    - s.push({p, ngh})
- Folosim condiția de la puncte critice pentru a identifica componenta biconexă
    - Nu mai ținem cont de paternitate
    - nivel[p] <= nma[vecin]
        -> Am găsit componentă biconexă, o formăm: biconex(p, ngh)

- Biconex(p, ngh):
    - Inițializăm un set
    - Scoatem din stivă {x, y} până când ajungem la muchia adăugată {p, ngh}
    - Adăugăm x și y într-un set
    - Acest set este componenta biconexă
        - Un punct poate face parte din mai multe componente biconexe!

## Algorimul lui Kosaraju | [Algoritm](./kosaraju_ctc.cpp)
- Se folosește pentru determinarea componentelor tare conexe
- Implementare:
    - Construim graful G în listele de adiacență GR și graful GT în listele de adiacență GT;
    - Facem parcurgeri DFS pentru toate componentele conexe din GR, iar la finalul parcurgerilor adăugăm tații într-un vector (nodurile care au durat mai mult vor fi la final);
    - Rotim vectorul de tați și facem DFS pe GT în ordine descrescătoare a terminării nodurilor (adică în DFS alegem să nu mai parcurgem GR, ci GT, și vom parcurge nodurile din noul vector în loc să iterăm de la 1 la N);
    - La fiecare DFS început parcurâng vectorul găsim o nouă componentă conexă, în timpul DFS-ului adăugăm toate nodurile găsite în această nouă componentă conexă.

### Probleme:
- [Componente tare conexe](./kosaraju_ctc.cpp) ~ Strict implementarea Kosaraju

## Arbori Parțiali de Cost Minim

- [Problema APM](https://www.infoarena.ro/problema/apm)
    - **Kruskal | [Algoritm](./kruskal.cpp)**
        - Sortăm muchiile după cost / Folosim heap cu criteriu pe cost
        - Inițializăm tații (fiecare nod este rădăcină la început, înălțimea 0)
        - Reprezentanții sunt rădăcinile componentelor conexe
        - Reuniunea a două capete: 
            - Componenta mai înaltă o înghite pe cealaltă
            - Dacă sunt la fel de înalte, înălțimea celei setate crește cu o unitate
        - Pentru fiecare muchie, în ordine
            - Obținem reprezentanții capetelor
            - Dacă sunt diferiți, adăugăm muchia în arbore, union pe capete
            - Dacă avem deja n - 1 muchii în arbore, ne oprim
    
    - **Prim | [Algoritm](./prim.cpp)**
        - Stocăm muchiile în liste de adiacență (to, cost)
        - Costul din sursă e mereu 0
        - Adăugăm muchia (sursă, 0) în priority queue, acest pq le ține descrescător după cost
        - Câtă vreme pq nu e vid
            - Dacă nodul 'to' e vizitat, skip
            - Altfel, marcăm vizitat, adunăm costul și iterăm prin vecinii nodului 'to'
                - Dacă vecinul nu e vizitat și costul 'cost' spre vecin e mai mic decât costul găsit deja pentru acel vecin d[vecin], actualizăm costul și setăm părintele vecinului t[vecin] = 'to'
                - Adăugăm muchia (to, cost) în pq
        - Costul este calculat în timpul rulării
        - Numărul total de muchii din APM este n - 1 (graful este conex)
        - Afișăm muchiile (t[i], i), cu excepția celei unde t[i] = 0


## BFS10
- tbc
    - https://www.infoarena.ro/problema/camionas

## Sortare topologică / [Algoritmul lui Kahn](./kahn.cpp)
- tbc


## [Dijkstra - Infoarena](https://www.infoarena.ro/problema/dijkstra) ||| [Algoritm](./dijkstra.cpp)
- Exact ca la Prim, dar diferă condiția de selecție a costului minim:
```
if (!visited[to] && d[current] + cost < d[to]) {
    d[to] = d[current] + cost;
    t[to] = current;
    pq.push({to, d[to]});
}
```

- Probleme cu Dikstra:
    - [Catun](https://www.infoarena.ro/problema/camionas) | [Solutie](./catun.cpp)


## Teste de laborator
- [Test AF 1](https://www.hackerrank.com/contests/test-laborator-af-1)
    - C 1.1: Sortare topologică minim lexicografică | [Soluție](./kahn_topo_lexico.cpp)
        - Se folosește **Algoritmul lui Kahn** (adăugăm într-o coadă toate nodurile cu indegree 0, ulterior facem BFS din coadă și la un vecin găsit scădem gradul acestuia până ajunge la 0, ulterior îl adăugăm și pe acesta în coadă | se ignoră 'revizitările', e graf aciclic)
        - Se cere ordinea minimă lexicografic pe nivel de prioritate, deci o să folosim coadă de priorități / **priority queue (min-heap!)**
    - C 1.2: Q queries K face parte din drum minim (i, j)? | [Soluție](./q_queries_k_in_ij_min.cpp)
        - Precalculăm cu **Roy-Floyd** (fără matrice de părinți)
        - În fiecare query, facem drumul de la j la i și verificăm dacă apare K
        - Graf neorientat <=> p[x][y] = x, p[y][x] = y
        - Apare **K în ORICE drum de cost minims?** Nu e suficient să reconstruim drumul, pentru că se reface 'un singur drum aleatoriu de lungime minimă' -> Există drum cu k conținut de (i, j) dacă d[i][j] = d[i][k] + d[k][j]
    - C 1.3: Sudoku fără supracelule | [Soluție](./simple_sudoku.cpp)
        - Se poate rezolva cu backtracking
- [Test AF 2](https://www.hackerrank.com/contests/test-laborator-af-2/challenges)
    - C 2.1: Sortare topologică maxim lexicografică | [Soluție](./kahn_topo_lexicomax.cpp)
        - Se folosește **Algoritmul lui Kahn**, cu **priority queue default**
        - Putem verifica dacă există cicluri / dacă nu au fost vizitate toate nodurile, caz în care le putem afișa pe cele nevizitate la final (nu e cazul în problema asta)
    - C 2.2: Q queries K nu face parte din niciun drum minim (i, j)? | [Soluție](./q_queries_not_k_in_ij_min.cpp)
        - Singura diferență față de 1.2 este condiția pentru răspuns:
            - `d[x][y] == INF || (d[x][y] != INF && d[x][y] != d[x][k] + d[k][y])`;

- [Test AF 4](https://www.hackerrank.com/contests/test-laborator-af-4)
    - C 4.1: Adăugarea muchiei (i, j) scurtează drumul (1, n)?
        - 15p | [Soluție](./muchie_noua_scurteaza_15p.cpp)
            - Facem BFS din 1 și păstrăm distanțele în vectorul C
            - Pentru fiecare întrebare, dacă muchia nu există deja, facem BFS și păstrăm distanțele în vectorul D
            - Dacă D[n] < C[n] înseamnă că muchia nouă poate reduce distanța
    - C 4.2: Planete / Dijkstra + BFS
        - Se păstrează relațiile într-o listă de adiacență suplimentară SA și în cea default A
        - Se face BFS din fiecare nod, se parcurg vecinii cu SA, iar dacă pasul curent este mai mic decât k și facem buclă, adăugăm portalul în A.
        - Facem Dijkstra pe A 
        
## ?? nu știu
https://www.infoarena.ro/problema/reinvent \
https://csacademy.com/contest/archive/task/bad-triplet/


## ---------------------------------------------

- https://www.infoarena.ro/problema/ciclueuler
- https://www.infoarena.ro/problema/hamilton
- https://www.infoarena.ro/problema/domino
- https://www.infoarena.ro/problema/fotbal2
- https://www.infoarena.ro/problema/nogcd
- https://www.infoarena.ro/problema/maxflow
- https://www.infoarena.ro/problema/cuplaj (cu flux)
- https://www.infoarena.ro/problema/senat (cu flux)
- https://www.infoarena.ro/problema/harta
- https://www.infoarena.ro/problema/drumuri2 (cu flux)
- https://www.infoarena.ro/problema/ghizi
- https://www.infoarena.ro/problema/ciclueuler
- https://www.infoarena.ro/problema/hamilton
- https://www.infoarena.ro/problema/domino
- https://www.infoarena.ro/problema/fotbal2
- https://www.infoarena.ro/problema/nogcd
- https://www.hackerrank.com/contests/restanta-af-toamna/challenges/restanta-1
- https://www.hackerrank.com/contests/colocviu-af-123/challenges
- https://www.hackerrank.com/contests/test-laborator-af-1/challenges/c-1-2-13
- https://www.hackerrank.com/contests/test-laborator-af-3/challenges/c-3-1-4
- https://www.hackerrank.com/contests/test-laborator-af-1/challenges/c-1-1-13
- https://www.hackerrank.com/contests/test-laborator-af-3/challenges/c-3-2-3
- https://www.infoarena.ro/problema/royfloyd
- https://www.infoarena.ro/problema/bellmanford
- https://www.infoarena.ro/problema/catun
- https://kilonova.ro/problems/56
- https://kilonova.ro/problems/32
- https://kilonova.ro/problems/2443
- https://www.infoarena.ro/problema/disjoint
- https://www.infoarena.ro/problema/cablaj
- https://www.infoarena.ro/problema/apm2
- https://csacademy.com/contest/archive/task/x-distance/
- https://csacademy.com/contest/archive/task/array-removal/statement/
- https://www.infoarena.ro/problema/oracol
 
# Alte colocvii
 
- www.hackerrank.com/model-colocviu-af
- www.hackerrank.com/colocviu-af-123
- www.hackerrank.com/restanta-af-123
- www.hackerrank.com/colocviu-af-987
- www.hackerrank.com/restanta-af-987
- www.hackerrank.com/restanta-af-toamna
- www.hackerrank.com/test-laborator-af-3