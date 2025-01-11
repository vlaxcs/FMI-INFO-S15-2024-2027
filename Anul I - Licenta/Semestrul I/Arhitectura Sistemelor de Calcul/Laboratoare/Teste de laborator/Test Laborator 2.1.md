# Test de Laborator (2.1 & 2.2 & 2.3)

1. (2.1/2.2) Ce valoare va reține EAX după executarea următoarei secvențe de instrucțiuni?
```
movl $0, %eax
movb $4, %ah
movb $2, %al
```

Grilă:
- A) 1026
- B) 258
- C) 513
- D) 0

Rezolvare:
```
                                            |      AH |     AL | 
movl $0, %eax   -> eax = 0000.0000.0000.0000.0000.0000.0000.0000
movb $4, %ah    -> eax = 0000.0000.0000.0000.0000.0100.0000.0000
movb $2, %al    -> eax = 0000.0000.0000.0000.0000.0100.0000.0010
                         ---------------------------------------
                         .........................0100.0000.0010 = 0x402 = 4 * 16^2 + 2 = 4 * 256 + 2 = 1026
```

Răspuns: A) 1026

---

1. (2.3) Ce valoare va reține registrul CH după executarea instrucțiunii `movl $553, %ecx`?

Grilă:
A) 10
B) 2
C) 512
D) 0

Rezolvare:
```
Reprezentarea pe biți a registrului %ecx este:
                            |    AH   |    AL   |
%ecx: 0b 0000.0000.0000.0000.0000.0000.0000.0000 (în baza 2)

              |AH|AL|
%ecx: 0x 00.00.00.00 (în baza 16)

Convertim 533 din baza 10 în baza 16:
533 = 512 + 16 + 7 = 2 * 16^2 + 1 * 16^1 + 7 * 16^0 = 0x217 = 0x00000217

Observăm că după ce asignăm valoarea 533 registrului %ecx, registrul va arăta astfel:

              |AH|AL|
%ecx: 0x 00.00.02.17 (în baza 16)
AH se desface în binar, astfel: 0000.0002, iar în decimal este 2
```

Răspuns: B) 2

---

2. (2.1) Ordonați crescător în funcție de spațiul ocupat în memorie următoarele declarații:
```
a: .long 10
b: .byte 50
c: .asciz "Sirul de caractere:\n"
d: .space 20
```

Grilă:

A) a, b, c, d
B) a, b, d, c
C) b, a, d, c
D) b, a, c, d

Rezolvare:
```
a: .long 10
a - ocupă 4 bytes

b: .byte 50
b - ocupă un byte

c: .asciz "Sirul de caractere:\n"
c - ocupă 19 + 1 (\n) + 1 (\0) = 21 bytes
(\0 pentru că este 'asciz' și are terminator by default, 19 pentru că fiecare caracter ocupă un byte)

d: .space 20
d - ocupă 20 bytes
```

Răspuns:
C) b, a, d, c

--- 

2. (2.2) Ordonați crescător în funcție de spațiul ocupat în memorie următoarele declarații:
```
a: .long 4
b: .asciz "hi!\n"
c: .byte 50
d: .space 50
```

Grilă:
A) c, d, b, a
B) c, a, b, d
C) b, a, d, c
D) b, a, c, d

Rezolvare:
```
a: .long 4
a - ocupă 4 bytes

b: .asciz "hi!\n"
b - ocupă 3 + 1 (\n) + 1 (\0) = 5 bytes
(\0 pentru că este 'asciz' și are terminator by default, 3 pentru că fiecare caracter ocupă un byte)

c: .byte 50
c - ocupă 1 byte

d: .space 50
d - ocupă 50 bytes
```

Răspuns:
B) c, a, b, d

---

2. (2.3) Ordonați crescător în funcție de spațiul ocupat în memorie următoarele declarații:
```
ch: .byte 'z'
v: .space 10
str: .asciz "1234567890"
y: .long 2
```

Grilă:
A) y, v, str, ch
B) ch, y, str, v
C) y, v, ch, str
D) ch, y, v, str

Rezolvare:
```
ch: .byte 'z'
ch - ocupă 1 byte

v: .space 10
v - ocupă 10 bytes

str: .asciz "1234567890"
str - ocupă 10 + 1 (\0) = 11 bytes
(\0 pentru că este 'asciz' și are terminator by default, 10 pentru că fiecare caracter ocupă un byte)

y: .long 2
y - ocupă 4 bytes
```

Răspuns:
D) ch, y, v, str

---

3. (2.1) Care este valoarea maximă pe care o poate lua n în următoarea declarație?
```
x: .word n
```

Grilă:
A) 255
B) 256
C) 2^16 - 1
D) 2^16

Rezolvare:
```
Tipul de date word ocupă 16 biți / 2 bytes (în arhitecutra x86 AT&T)

Așadar, din teoria de la cursul de ASC ar trebui să știm că pe 16 biți (unsigned) putem avea o valoare maximă de 2^16 - 1.
```

Răspuns:
C) 2^16 - 1

---

3. (2.2) Care este valoarea maximă pe care o poate lua n în următoarea declarație?
```
x: .byte n
```

Grilă:
A) 255
B) 256
C) 2^16 - 1
D) 2^16

Rezolvare:
```
Tipul de date byte ocupă 8 biți / 1 byte (așa cum ne spune și numele)

Așadar, din teoria de la cursul de ASC ar trebui să știm că pe 8 biți (unsigned) putem avea o valoare maximă de 2^8 - 1 = 255.
```

Răspuns:
A) 255

---

3. (2.3) Care este valoarea maximă pe care o poate stoca registrul `DX`?

Grilă:
A) 2^16 - 1
B) 2^16
C) 255
D) 256

Rezolvare:
```
Ne amintim că registrul %edx este reprezentat astfel:

                            |    DH   |    DL   |
%edx: 0b 0000.0000.0000.0000.0000.0000.0000.0000 (în baza 2)

              |DH|DL|
%edx: 0x 00.00.00.00 (în baza 16)

Gruparea (DHDL) este, de fapt, DX. DX are 2 bytes (jumătatea inferioară a registrului)
Valoarea maximă care poate fi stocată pe 2 bytes (16 biți) = 2^16 - 1 
```

Răspuns: A) 2^16 - 1

---

4. (2.1) Se consideră declarațiile:
```
x: .word 1
y: .word 2
```

Ce valoare va avea %eax după executarea instrucțiunii `mov x, %eax`?

Grilă:
A) 1
B) 2
C) 0x00020001

Rezolvare:
```
x: .word 1 | x = 0000.0000.0000.0000.0000.0000.0000.0001
y: .word 2 | y = 0000.0000.0000.0000.0000.0000.0000.0002

mov x, %eax:
Atenție cum arată instrucțiunea! Se folosește mov, nu movw.
Astfel, în %eax se pune valoarea de la adresa lui x, pe toți cei 32 de biți ai registrului.

Adresa lui x arată, de fapt, spre primii 16 biți din reprezentarea sa (este de tip byte), iar în continuare se trece la următorii 16 biți (în completarea a 32) din secțiunea .data.

Așadar:
mov x, %eax:
32b         pe 16 biți, y|      pe 16 biți, x| :.data
eax = 0000.0000.0000.0002.0000.0000.0000.0001
```

Răspuns:
C) 0x00020001

---

4. (2.2) Se consideră declarațiile:
```
x: .word 1
y: .word 0
z: .word 2
```

Ce valoare va avea %eax după executarea instrucțiunii `mov x, %eax`?

Grilă:
A) 1
B) 2
C) 0x00020001

Rezolvare:
```
Observăm cu atenție că se folosește instrucțiunea mov, în care nu se specifică tipul de date folosit.
Astfel, operația va actualiza toți cei 32 de biți ai registrului %eax cu primii 32 de biți găsiți în continuarea adresei lui x din .data.
x - word (2 bytes) ocupă primii 16 biți din %eax    (%eax: 0000.0000.0000.0000.xxxx.xxxx.xxxx.xxxx)
y - word (2 bytes) ocupă următorii 16 biți din %eax (%eax: yyyy.yyyy.yyyy.yyyy.xxxx.xxxx.xxxx.xxxx)

x are valoarea 1, iar y are valoarea 0
%eax: (0000.0000.0000.0000)(0000.0000.0000.0001) = 0d2
```
Răspuns: A) 1

---

4. (2.3) În instrucțiunea pentru întreruperea hardware, `int $0x80`, parametrul <b>0x80</b> este prefixat de simbolul $. Care este seminificația acestui simbol în contextul curent?

Grilă:
A) Reprezintă o convenție de implementare a întreruperii hardware
B) Simbolul $ este utilizat pentru prefixarea unei constante
C) Semnifică preluarea adresei din memorie la care se regăsește codul de întrerupere 0x80
D) Nu are nicio semnificație, se poate utiliza și scrierea int 0x80, cu același rezultat

Rezolvare:
```
Simbolul $ este utilizat atât pentru prefixarea constantelor, cât și pentru preluarea adreselor de memorie ale variabilelor globale. Cu toate acestea, aici este cazul despre o constantă. Instrucțiunea este echivalentă cu: int $128
```

Răspuns: B)

---

5. (2.1/2.2) Fie următoarea declarare în secțiunea .data:
```
mySpace: .space 100
```

Acest spațiu poate fi utilizat pentru a reține ulterior:

Grilă:
A) Un array de 30 de word-uri
B) Un array de 25 de long-uri
C) Un array de 50 de bytes
D) Un array de 50 de word-uri

Rezolvare:
```
Observăm că declararea .space 100 alocă 100 de bytes disponibili pentru orice tip de date.

A) Un array de 30 de word-uri   = 30 * 2 = 60 bytes, mai rămân 40 (Nu e bine)
B) Un array de 25 de long-uri   = 25 * 4 = 100 bytes (E bine)
C) Un array de 50 de bytes      = 50 * 1 = 50 bytes, mai rămân 50 (Nu e bine)
D) Un array de 50 de word-uri   = 50 * 2 = 100 bytes (E bine)
```

Răspunsuri:
B) Un array de 25 de long-uri
D) Un array de 50 de word-uri

---

5. (2.3) Care dintre următoarele instrucțiuni efectuează o interschimbare corectă a valorilor din variabilele de tipul .long x și y?

Grilă:
A) `movl %eax, x | movl y, x; | movl y, %eax;`
```
movl %eax, x
movl y, x
movl y, %eax
```
(A - INCORECT) Operația mov trebuie să aibă cel puțin un operand care să fie registru)

B) 
```
movl x, %eax 
movl y, %ebx 
movl %eax, %ebx
movl %ebx, x
movl %eax, y
```
(B - INCORECT) Dacă urmărim secvența de cod, x și y primesc aceleași valori pe care le aveau la început

C) 
```
movl x, %ecx
movl y, %edx
movl %ecx, %eax
movl %edx, %ecx
movl %eax, %edx
movl %edx, x
movl %ecx, y
```
(C - INCORECT) Dacă urmărim secvența de cod, observăm că:
```
ecx = x
edx = y
eax = ecx = (x)
ecx = edx = (y)
edx = eax = (ecx = x)
x = edx = x
y = ecx = y
```

D)
```
movl x, %ecx
movl y, %edx
movl %ecx, %eax
movl %edx, %ecx
movl %edx, %eax
```
(D - INCORECT) Dacă urmărim secvența de cod, observăm că:
```
ecx = x
edx = y
eax = ecx = (x)
ecx = edx = (y)
eax = edx (y)
```

Răspuns: Această întrebare nu are un răspuns corect.

---

6. (2.1) Fie următoarea declarare din secțiunea `.data`:
```
str1: .ascii "abc"
str2: .ascii "1"
```

Ce se va afișa în urma apelului WRITE următor?
```
movl $4, %eax
movl $1, %ebx
movl $str1, %ecx
movl $4, %edx
int $0x80
```

Grilă:
A) abc
B) abc1
C) nimic
D) abc + o valoare reziduală

Rezolvare:
```
Observăm ce se petrece cu instrucțiunea 
movl $str1, %ecx

În %ecx sunt setați primii 4 bytes care se găsesc la adresa lui str1 din .data.

În .data, avem următoarele:
str1: .ascii "abc" (reprezentat pe 3 bytes (fiecare caracter pe un byte), iar șirul nu are terminator (e de tip ascii))
str2: .ascii "1" (reprezentat pe 1 byte, ar fi pe 2 dacă ar avea terminator, dar e .ascii, la fel ca cel de sus)

Așadar, în %ecx sunt setați primii 3 bytes găsiți la adresa lui str1, iar în continuare, încă 1 byte găsit în continuarea adresei lui str1, adică primul caracter din str2.
```

Răspuns:
B) abc1

---

6. (2.2) Fie următoarea declarare în secțiunea `.data`:
```
movl $4, %eax
movl $1, %ebx
movl $str1, %ecx
movl $5, %edx
int $0x80
```

Grilă:
A) abc
B) abc12
C) nimic
D) abc + o valoare reziduală

Rezolvare:
```

```


---


7. În apelul sistem WRITE, șirul este încărcat în %ecx cu simbolul $. De exemplu, pentru `str: .asciz "Sir"`, încărcarea în %ecx se va face cu $str. Care este scopul acestui simbol?

Grilă:
A) Semnifică faptul că șirul este constant
B) Respectă convenția WRITE, unde toate argumentele trebuie precedate de $
C) Seminifică preluarea adresei din memorie pentru `str`
D) Nu are nicio semnificație, se poate utiliza și scrierea str pentru a obține același rezultat.

Rezolvare:
```
Când vrem să trimitem un string prin parametru, trebuie să transmitem întotdeauna adresa la care acesta începe.
Așadar, $str semnifică preluarea adresei din memorie pentru str.
```

Răspuns:
C) Seminifică preluarea adresei din memorie pentru `str`


8. Fie următorul program:

```
.data
x: .long 0x04030201
y: .long 0x08070605

.text
.global main
main:

mov x, %eax
mov y, %ah

mov $1, %eax
mov $0, %ebx
int $0x80
```

Acestea se compilează și executabilul se rulează folosind gdb. În gdb se vor da următoarele comenzi:

```
b main
run
stepi
stepi
```

Ce valoare va fi afișată în %eax în urma rulării comenzii `i r`?

Grilă:
A) 0x04030201
B) 0x08070605
C) 1
D) 0x04030501
E) 0x04030205

Rezolvare:
```
1. b main
    Pune un breakpoint pe adresa label-ului main:

2. run
    Rulează executabilul, setează instruction point-ul la prima instrucțiune găsită

3. stepi -> Execută mov x, %eax

    Observăm că se folosește mov, nu movl. Așadar, în %eax sunt folosiți cei 4 bytes referiți de adresa lui x. %eax are tot 4 bytes, deci valoarea setată este doar cea a lui x. 
    (Ne raportăm mereu la 4 bytes dacă avem un registru întreg (%eax, %ebx, etc...) și nu se specifică tipul de date în operație)

    %eax = 0x04030201

4. stepi -> Execută mov y, %ah

    Observăm din nou că se folosește mov, dar de data aceasta registrul destinație este %ah (de 1 byte). 
    Se iau primii 8 biți referiți de adresa lui y și se pun în %ah, peste cei existenți. 
    Restul celor 16 (din stânga) și 8 biți (din dreapta) rămân intacți.

    Înainte:
                AHAL
    %eax = 0x04030201

    După:        
                AHAL
    %eax = 0x0403__01
    %eax = 0x04030501
```

Răspuns:
D) 0x04030501