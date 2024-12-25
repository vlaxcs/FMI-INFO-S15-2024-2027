# Modele test de laborator

# Model 1
## Problema 1 [4 pct]

### Enunt
Fișierul text `numere.in` conține, pe fiecare linie, câte un șir de numere întregi despărțite prin spații. Să se scrie în fișierul text `numere.out` șirurile din fișierul de intrare grupate în funcție de suma elementelor lor, conform modelului din exemplul de mai jos. Grupele de șiruri vor fi scrise în ordinea crescătoare a sumelor elementelor lor, iar în fiecare grupă șirurile se vor scrie în ordinea descrescătoare a numărului de elemente.

### Exemplu

| `numere.in`                                                    | `numere.out`                                                                                         |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| 10 -5 5 10<br>100 -20 -30<br>11 9<br>5 5 10 20 10<br>-100 -100 | Suma -200:<br>-100 -100<br>Suma 20:<br>10 -5 5 10<br>11 9<br>Suma 50:<br>5 5 10 20 10<br>100 -20 -30 |

### Rezolvare

```py
def read_file(input_file):
    arrays = []
    with open(input_file, "r") as f:
        for line in f.readlines():
            arrays.append([int(x) for x in line.split()])
    return arrays


def main():
    arrays = read_file("numere.in")
    dict = {}
    for array in arrays:
        try:
            dict[sum(array)].append(array)
        except:
            dict[sum(array)] = [array, ]
    with open("numere.out", "w") as f:
        for key in sorted(dict.keys()):
            f.write(f"Suma {key}:\n")
            for array in sorted(dict[key], key=lambda x: -len(x)):
                text = " ".join([str(x) for x in array])
                f.write(text + "\n")


if __name__ == "__main__":
    main()
```


## Problema 2 [3 pct]

### Enunt
Se dă fișierul `matrice.in` cu următoarea structură: pe linia $$i$$ se află separate prin câte un spațiu $$n$$ numere naturale reprezentând elementele de pe linia $$i$$ a unei matrice, ca în exemplul de mai jos. Este cunoscut faptul că în fișier se află $$n \times n$$ elemente numere naturale, unde $$n$$ este un număr natural **impar** $$> 2$$.

### Cerinte
a) [0,25 pct] Să se scrie o funcție `citire_matrice` care citește datele din fișierul `matrice.in` și returnează o matrice de dimensiune $$n \times n$$ formată din aceste numere.

b) [1,5 pct] Să se scrie o funcție care primește ca parametru matricea și returnează matricea bordată după următoarele reguli:

- se va adăuga o coloană nouă la final (pe poziția 𝑛) care va avea pe poziția 𝑘 **suma** valorilor de pe **linia** 𝑘

- se va adăuga o linie nouă la final (poziția 𝑛) care va avea pe poziția 𝑘 **suma** valorilor de pe **coloana** 𝑘

c) [1,25 pct] Se consideră matricea citită la punctul a), peste care se aplică funcția de la punctul b). Să se parcurgă matricea mai întâi pe diagonala principală, apoi pe diagonala secundară și, în final, restul elementelor care nu aparțin diagonalelor (parcurgerea se face pe linii de sus în jos și de la stânga la dreapta) și se afișează elementele în fișierul `matrice.out`.

### Exemplu

| `matrice.in`            | `dupa bordare`                                                             | `matrice.out`                         |
| ----------------------- | -------------------------------------------------------------------------- | ------------------------------------- |
| 7 8 9<br>6 1 2<br>5 4 3 | 7   8    9  24<br>   6   1    2   9<br>   5   4    3  12<br>18  13  14  45 | 7 1 3 45 24 2 4 18 8 9 6 9 5 12 13 14 |

### Rezolvare

```py
def read_file(input_file):
    matrix = []
    with open(input_file, "r") as f:
        for line in f.readlines():
            matrix.append([int(x) for x in line.split()])
    return matrix


def update(matrix):
    n = len(matrix)
    for i in range(n):
        matrix[i].append(sum(matrix[i]))
    sum_list = [0] * (n + 1)
    for i in range(n):
        for j in range(n + 1):
            sum_list\[j] += matrix[i\][j]
    matrix.append(sum_list)
    return matrix


def parcurgere(matrix):
    v = []
    n = len(matrix) - 1
    for i in range(n + 1):
        v.append(matrix\[i\][i])
    for i in range(n + 1):
        v.append(matrix\[i\][n - i])
    for i in range(n + 1):
        for j in range(n + 1):
            if i != j and i + j != n:
                v.append(matrix\[i\][j])
    return v


def write_file(output_file, v):
    with open(output_file, "w") as f:
        f.write(" ".join([str(x) for x in v]))


def main():
    write_file("matrice.out", parcurgere(update(read_file("matrice.in"))))


if __name__ == "__main__":
    main()
```

## Problema 3 [4 pct]

Se consideră fișierul text `catalog.in` cu următoarea structură:

- pe prima linie apare numărul $$n$$ reprezentând numărul de elevi dintr-o clasă a unui liceu
- pe următoarele linii avem informații despre cei $$n$$ elevi, respectiv pentru fiecare elev informațiile sunt structurate astfel:
    - linie de forma `<șir de caractere> <m>`, unde șirul de caractere este numele elevului (acesta este unic), iar $$m$$ este un număr natural reprezentând numărul de materii
    - urmată de $$m$$ linii care conțin notele elevului (numere naturale) la $$m$$ materii, fiecare având următoarea structură: 
        `<nume_materie>,<nota_1>,<nota_2>,...,<nota_k>`

### Observație:

- Orice elev are la fiecare materie cel puțin o notă, iar denumirile materiilor nu conțin caracterul ',' (virgulă).

### Exemplu de fisier de intrare

    5
    Ana Maria Pop 3
    Matematica,10,9,9,10,10
    Limba romana,8,9,9,8
    Fizica,10,9,7,10,10
    Mihai Popescu 3
    Matematica,9,7,10,10
    Limba romana,8,3,5,10
    Fizica,10,10
    Andrei Mincu 2
    Matematica,10,9,2
    Fizica,3,7,9
    Ioana Matei 3
    Fizica,10,10
    Matematica,10,10,10,9
    Limba romana,9,9,10,10
    Alin Enache 3
    Limba romana,10,10,10
    Matematica,10,10,10,10
    Fizica,10

### Cerinte
a) [2 pct] Scrieți o funcție care citește datele din fișierul `catalog.in` și returnează o structură de date cu informațiile din fișier. Folosiți o structură de date convenabilă pentru a rezolva
eficient subpunctele următoare.

b) [1 pct] Scrieți o funcție `detalii_elev` care primește ca parametri structura în care s-au memorat datele la cerința a) și un șir de caractere reprezentând numele unui elev și returnează mediile la toate materiile elevului cu numele primit ca parametru, memorate sub formă de listă de tupluri de tipul `(nume_materie, medie)`. Dacă un elev are o singură notă la o materie sau media este mai mică strict decât 5, acesta va avea media egală cu 0 și va rămâne corigent. Să se citească de la tastatură numele unui elev și să se afișeze pe ecran mediile acestuia (rotunjite cu două zecimale) la fiecare materie (sortate lexicografic) folosind această funcție.

| `Intrare trastatura` | `Afisare pe ecran`                                  |
| -------------------- | --------------------------------------------------- |
| Ana Maria Pop        | Fizica 9.20<br>Limba romana 8.50<br>Matematica 9.60 |

c) [1 pct] Scrieți o funcție clasament care primește structura de date în care s-au memorat datele la cerința a) și un număr variabil de parametri de tip șir de caractere reprezentând nume de elevi. Funcția returnează o listă de tupluri de tipul (nume_elev, medie_generala) cu mediile generale ale elevilor ale căror nume au fost primite ca parametru ordonată descrescător după medii. Media generală a unui elev este egală cu media aritmetică a mediilor de la fiecare materie, dacă acesta nu este corigent, altfel media este 0.

### Exemplu:
Dacă se apelează funcția pentru elevii Alin Enache și Ioana Matei se va returna lista
[(Ioana Matei,9.75), (Alin Enache,0)], deoarece Alin Enache are o singură notă la
fizică, deci este corigent.

### Rezolvare

```py
def read_file(input_file):
    dict = {}
    with open(input_file, "r") as f:
        n = int(f.readline())
        for i in range(n):
            info_elev = f.readline().split()
            nume_elev = " ".join(info_elev[:-1])
            m = int(info_elev[-1])
            dict[nume_elev] = {}
            for j in range(m):
                info_materie = f.readline().split(",")
                nume_materie = info_materie[0]
                dict\[nume_elev\][nume_materie] = [int(x) for x in info_materie[1:]]
    return dict


def detalii_elev(dict, nume_elev):
    medii = []
    for materie in dict[nume_elev]:
        note = dict\[nume_elev\][materie]
        if len(note) == 1 or sum(note) / len(note) < 5:
            medii.append((materie, 0))
        else:
            medii.append((materie, round(sum(note) / len(note), 2)))
    medii.sort()
    return medii


def clasament(dict, *argv):
    clasament_medii = []
    for nume_elev in argv:
        medii = detalii_elev(dict, nume_elev)
        suma = 0
        ok = 1
        for materie, nota in medii:
            suma += nota
            if nota == 0:
                ok = 0
        if ok == 0:
            clasament_medii.append((nume_elev, 0))
        else:
            clasament_medii.append((nume_elev, round(suma / len(medii), 2)))
    return sorted(clasament_medii, key=lambda x: -x[1])


def main():
    dict = read_file("catalog.in")
    medii = detalii_elev(dict, input())
    for materie, medie in medii:
        print(materie, medie)
    clasament_medii = clasament(dict, "Ioana Matei", "Alin Enache")
    print(clasament_medii)


if __name__ == "__main__":
    main()
```



# Model 2
## Problema 1 [4 pct]

**Enunt**
Fișierul text `text.in` conține pe prima linie un cuvânt $$w$$ nevid format din litere mici ale
alfabetului englez, iar pe următoarele linii un text în care cuvintele sunt despărțite prin spații
și semnele de punctuație uzuale. Să se scrie în fișierul text `text.out` toate cuvintele din fișierul `text.in` care au mulțimea literelor inclusă în mulțimea literelor cuvântului $$w$$ sau mesajul *“Imposibil”*dacă în fișierul de intrare nu există nici un cuvânt cu proprietatea cerută,
conform modelului din exemplul de mai jos. Cuvintele vor fi scrise grupat, în funcție de
mulțimile literelor. Grupele vor fi scrise în ordine lexicografică, iar în cadrul fiecărui grup
cuvintele vor fi scrise în ordinea descrescătoare a lungimilor lor. Fiecare cuvânt va fi scris o
singură dată și nu se va face distincție între litere mici și litere mari.

**Exemplu**

| `text.in`                                                                                                                          | `text.out`                                                                                                                                                                                                                                                |
| ---------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| semnificare<br>Mama s-a gandit sa isi puna seara<br>pe masa de ceara<br>o sama de bucate si bauturi care sunt<br>si acre si dulci. | Literele ['a', 'c', 'e', 'r']:<br>ceara<br>care<br>acre<br>Literele ['a', 'e', 'r', 's']:<br>seara<br>Literele ['a', 'm']:<br>mama<br>Literele ['a', 'm', 's']:<br>masa<br>sama<br>Literele ['a', 's']:<br>s-a<br>sa<br>Literele ['i', 's']:<br>isi<br>si |

Cuvântul "semnificare" are mulțimea literelor egală cu {'a', 'c', 'e', 'f', 'i', 'm', 'n', 'r', 's'}, iar cuvintele scrise în fișierul `text.out` sunt singurele din fișierul `text.in` care au mulțimea literelor inclusă în mulțimea literelor sale.

### Rezolvare
```py
# citire
f = open('text.in', 'r')
cuvant = set(f.readline().strip())
text = f.read().lower()
f.close()

# separarea sirului in cuvinte unice
thisdict = {}
separatori = ",.;:!?"

for x in separatori:
    text = text.replace(x, " ")

multime = [x for x in text.split()]

# crearea unui dictionar 'grup' : [cuvinte]
for word in multime:
    new_word = word.replace('-', '')
    letters = {i for i in new_word}
    lista = sorted([letters])
    if letters & cuvant == letters:
        key = ",".join([f"'{x}'" for x in lista])
        if key in thisdict.keys():
            thisdict[key].append(word)
        else:
            thisdict[key] = [word]

# sortarea cuvintelor din fiecare grup dupa lungime
for key in thisdict.keys():
    thisdict[key] = sorted(thisdict[key], key=lambda x: len(x), reverse=True)

# sortarea grupelor alfabetic
word_groups = sorted(thisdict.items(), key=lambda item: item[0])

f = open('text.out', 'w')
if not bool(word_groups):
    f.write("Imposibil\n")
else:
    for grupa, cuvinte in word_groups:
        f.write(f'Literele [{grupa}]:\n')
        for cuvant in cuvinte:
            f.write(cuvant + '\n')

f.close()
```



## Problema 2 [3 pct]

**Enunt**
a) [0.5 pct] Scrieți o funcție `citire_matrice` ****care primește un parametru reprezentând numele unui fișier care conține elementele unei matrice pătratice de $$n \times n$$ de numere întregi cu următoarea structură:

- pe prima linie a fișierului este $$n$$
- pe a doua linie sunt $$n \times n$$ numere separate prin câte un spațiu reprezentând elementele matricei transformate în vector prin concatenarea liniilor matricei de la prima la ultima; astfel primele n numere de pe linie sunt elementele primei linii din matrice, urmate de elementele celei de a doua linii etc.

Funcția citește elementele matricei din fișierul cu numele dat ca parametru și returnează matricea cu aceste elemente. Pentru fișierul `"matrice.in"` ****din exemplul de mai jos matricea este:

    1 2 3
    4 5 6
    7 8 9

b) [1.5 pct] Scrieți o funcție **duplicare** care primește ca parametri (în această ordine): o matrice (listă de liste) și un număr variabil de numere naturale reprezentând indici ai liniilor din matrice (indicele primei linii din matrice este 0) și **inserează după fiecare linie cu indicele dat ca parametru o copie a ei** (duplică linia). Funcția va modifica matricea primită ca parametru.

c) [1 pct] Se dă fișierul `matrice.in` ****cu structura descrisă la punctul a). Folosind apeluri utile ale funcțiilor de la a) și b) să se citească matricea din fișierul `matrice.in`, să se modifice această matrice duplicând prima și a doua linie (după prima linie se va insera o linie egală cu ea, la fel și după a doua) și adăugând apoi 1 la primul element de pe prima linie. Să se afișeze pe ecran matricea obținută.

**Exemplu**

| `matrice.in`           | `consola (iesire pe ecran)`               |
| ---------------------- | ----------------------------------------- |
| 3<br>1 2 3 4 5 6 7 8 9 | 2 2 3<br>1 2 3<br>4 5 6<br>4 5 6<br>7 8 9 |

### Rezolvare
```py
def citire_matrice(fisier):
    A = []
    linii = [line.strip().split() for line in open(fisier)]
    if len(linii) > 0 and len(linii[-1]) == 0:
        linii.pop()
    n = int(linii\[0\][0])
    linie = linii[1]

    for i in range(n):
        lin = []
        for j in range(n):
            lin.append(linie[j])
        linie = linie[n:]
        A.append(lin)

    return A


def duplicare(M, *linii):
    C = []
    cnt = 0
    for i in range(len(M)):
        lin = []
        for j in range(len(M[i])):
            lin.append(M\[i\][j])
        C.append(lin)

    for ind in linii:
        linie = C[ind]
        M.insert(ind + 1 + cnt, linie)
        cnt = cnt + 1


A = citire_matrice("matrice.in")

duplicare(A, 0, 1)

A\[0\][0] = int(A\[0\][0]) + 1

for i in range(len(A)):
    for j in range(len(A[i])):
        print(A\[i\][j], end=" ")
    print("\n", end="")
```


## Problema 3 [4 pct]

**Enunt**
Alice și Bob comunică folosind următorul algoritm pentru a-și codifica mesajele:

- Alice și Bob cunosc amândoi o cheie secretă sub forma unui șir de caractere care este o

permutare a celor 26 de litere mici din alfabetul englez, astfel: literei 'a' îi corespunde prima
literă din cheia secretă, literei 'b' îi corespunde a doua literă din cheia secretă, ..., literei 'z' îi
corespunde ultima literă din cheia secretă, după cum se poate observa din următorul
exemplu:

    - Alfabetul englez = `a b c d e f g h i j k l m n o p q r s t u v w x y z`
    -     Cheia secretă = `o b c g s e f h i z j k l m n p q r d t u v a w x y`
- Codificarea unui mesaj presupune înlocuirea fiecărei litere din el cu litera corespunzătoare din cheia secretă. De exemplu, dacă Alice și Bob au cheia secretă `"obcgsefhizjklmnpqrdtuvawxy"`, atunci cuvântul `"astazi"` se va codifica prin cuvântul `"odtoyi"`, deoarece literei 'a' îi corespunde litera 'o', literei 's' îi corespunde litera 'd' ș.a.m.d.
- Decodificarea unui mesaj codificat presupune căutarea fiecărei litere din el în cheia secretă și înlocuirea ei cu litera corespunzătoare din alfabetul englez. De exemplu, dacă Alice și Bob au cheia secretă `"obcgsefhizjklmnpqrdtuvawxy"`, atunci cuvântul codificat `"endt"` se va decodifica în cuvântul `"fost"`, deoarece literei 'e' îi corespunde litera 'f', literei 'n' îi corespunde litera 'o' ș.a.m.d.

Mesajele sunt codificate și transmise cuvânt cu cuvânt. Toate literele din mesaje sunt litere mici din alfabetul englez și nu se folosesc semne de punctuație, cu excepția caracterului ‘-’, care nu se criptează.

Eve este un hacker care interceptează traficul și reușește să găsească algoritmul de decodificare, precum și cheia secretă. Eve are dificultăți în reconstrucția propozițiilor deoarece nu salvează cuvintele în ordinea în care sunt trimise. Să se reconstruiască propozițiile trimise de Alice și Bob.

**Cerinte**
a) ****[1 pct] Fișierul text `comunicare.in` are următoarea structură:

- pe prima linie se găsește cheia secretă
- pe fiecare dintre următoarele linii se găsesc informațiile despre un cuvânt (transmis la cel puțin un minut distanță), despărțite printr-un spațiu astfel:
    - primul caracter este A dacă cuvântul este trimis de Alice sau B dacă este trimis de Bob
    - separat printr-un spațiu se va găsi cuvântul în formă codificată
    - ultima informație va fi ora la care este trimis mesajul în format de 5 caractere și 24 de ore (de exemplu, 12:34 sau 21:03)

Să se scrie o funcție `citire_date` care să returneze o structură cu datele din fișier.

b) ****[1,5 pct] Să se scrie o funcție `decodificare` care primește ca parametri un cuvânt codificat și cheia secretă utilizată. Funcția trebuie să decodifice eficient cuvântul codificat și apoi să-l
returneze.

c) [1,5 pct] Să se reconstituie propozițiile trimise de Bob și Alice astfel :

- se decodifică fiecare cuvânt folosind funcția definită la punctul b)
- se determină ordinea în care au fost trimise cuvintele
- se salvează în fișierul text `comunicare.out` propozițiile reconstituite conform exemplului.

**Exemplu**

| `comunicare.in`                                                                                                                                                                                             | `după decriptarea datelor`                                                                                                                                                    | `comunicare.out`                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| obcgsefhizjklmnpqrdtuvawxy<br>B cnlprnlido 13:20<br>A ko 12:00<br>A vnl 10:00<br>B o 10:20<br>A dug 12:30<br>B rstrofsti-vo 14:20<br>A odtoyi 09:00<br>B cnlumicorso 09:20<br>A otoco 11:00<br>B endt 12:20 | B compromisa 13:20<br>A la 12:00<br>A vom 10:00<br>B a 10:20<br>A sud 12:30<br>B retrageti-va 14:20<br>A astazi 09:00<br>B comunicarea 09:20<br>A ataca 11:00<br>B fost 12:20 | A : astazi vom ataca la sud<br>B : comunicarea a fost<br>compromisa retrageti-va |

### Rezolvare

```py
def citire_date(f):
    result_a = []
    result_b = []

    i = 0

    for line in f:
        if i == 0:
            key = line.strip()

        split_line = line.split()

        if split_line[0] == "A":
            result_a.append((split_line[1], split_line[2]))
        elif split_line[0] == "B":
            result_b.append((split_line[1], split_line[2]))

        i += 1

    return [key, result_a, result_b]


def decodificare(key, word):
    new_word = ""

    for letter in word:
        if not letter == '-':
            new_word += chr(ord('a') + key.find(letter))
        else:
            new_word += letter

    return new_word


fin = open("comunicare.in", "r")
fout = open("comunicare.out", "w")

structure = citire_date(fin)

for i in range(len(structure[1])):
    decoded = decodificare(structure\[0], structure[1\][i][0])
    hour_split = structure\[1\][i][1].split(":")
    time = int(hour_split[0]) * 60 + int(hour_split[1])
    structure\[1\][i] = (decoded, time)

for i in range(len(structure[2])):
    decoded = decodificare(structure\[0], structure[2\][i][0])
    hour_split = structure\[2\][i][1].split(":")
    time = int(hour_split[0]) * 60 + int(hour_split[1])
    structure\[2\][i] = (decoded, time)

a = structure[1]
a.sort(key=lambda word: word[1])
b = structure[2]
b.sort(key=lambda word: word[1])

output = "A : "

for word in a:
    output += word[0]
    output += " "

output += "\nB : "

for word in b:
    output += word[0]
    output += " "

fout.write(output)

fout.close()
```

