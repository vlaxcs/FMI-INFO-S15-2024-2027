# Laborator 1 - www

*Sharing is caring*: fiecare participant la laborator își prezintă, pe rând, soluția pentru următorul exercițiu.  

1. Numește un website care îți place și unul care nu îți place, și explică de ce: enumeră cel puțin trei motive pentru fiecare alegere. Acestea pot fi legate, de exemplu, de structură, design, funcționalitate, sau interacțiunea cu utilizatorul.

bun: nytimes.com - simplu de folosit si joc wordle pe el
prost: https://portal.lbi.ro/ - derutant si nu merg bine linkurile

*Și-acum, la treabă!*  

2. Folosind parserul de URL [https://url-decode.com/tool/url-parser](https://url-decode.com/tool/url-parser), parsați adresa 
`https://boutique.tintin.com/en/s-1/search/albums-the_crab_with_the_golden_claws?search_query=milou`
pentru a găsi codul secret format din:
- ultimul caracter din protocol: s
- al treilea caracter din domeniu: n
- al doilea caracter din Tld: o
- penultimul caracter din file name: w
- ultimul caracter al atributului din query.: y

3. Introduceți codul secret în adresa mai jos, în locul caracterului `?`   
  `https://www.tintin.com/en/characters/?#character`
  https://www.tintin.com/en/characters/snowy#character
  și căutați numele personajului în franceză în textul paginii accesate. (hint: atenție la majuscule!): Milou

4. Adăugați numele la sfârșitul adresei `https://tintin.fandom.com/fr/wiki/`
https://tintin.fandom.com/fr/wiki/Milou
și rulați pentru URL-ul astfel obținut următoarele trei teste:  

a.  
[https://http.app/?ref=http.dev](https://http.app/?ref=http.dev) ca să aflați dacă roboții sunt permiși. Ce fel de roboți?  
Citiți mai multe despre roboți web aici: [https://www.robotstxt.org/](https://www.robotstxt.org/)  
  roboti care acceseaza API-ul, roboti care creeaze/modifica pagini wiki
  filibot?
b.  
[https://tools.keycdn.com/http2-test](https://tools.keycdn.com/http2-test) ca să aflați dacă website-ul admite HTTP2.  
Citiți mai multe despre diferențele dintre protocoalele HTTP și HTTP2 aici: [https://http.dev/2](https://http.dev/2)  
  DA
c.  
[https://www.whatsmyip.org/http-compression-test/](https://www.whatsmyip.org/http-compression-test/) ca să aflați dacă este permisă compresia HTTP.  
Citiți mai multe despre HTTP compression aici: [https://http.dev/compression](https://http.dev/compression)  
  DA

5. Pentru fiecare test de mai sus, considerăm că obținem valoarea 0 dacă testul eșuează și 1 dacă are succes. Folosiți codul de stare (status code) `s` primit la rularea testului de la exercițiul 4, punctul a, împreună cu rezultatele obținute la exercițiul 4 pentru punctele a, b, c, și calculați următorul număr:  
`n = (a+b)*s + s/(a+2b+c) + c`.  
a=1
b=1
c=1
s=200
n = 400 + 50 + 1 = 451

Care este titlul codului de stare corespunzător lui n?  
Vizitați biblioteca de coduri de stare `https://http.cat/n` (nu uitați să înlocuiți n cu valoarea lui) și folosiți-vă abilitățile de detectivi web pentru a identifica personajul din imagine. Puncte bonus dacă aflați numele pisicii.
451, Unavailable for legal reasons

6. Revenind la personajul descris pe pagina pe care tocmai ați testat-o la exercițiul 4. Identificați cel mai bun prieten al acestuia. Adăugați numele prietenului la începutul adresei`mudhalla.net`. Ce se întâmplă dacă la adresa obținută adaugăm și prefixul 'www'? Folosiți testerul 
[https://http.app/?ref=http.dev](https://http.app/?ref=http.dev) pentru a compara rezultatele celor două cereri HTTP (cu/fără 'www').  
initial nu se poate accesa site-ul, dupa ce punem www functioneaza
Repetați testul și pentru adresa de la exercițiul 2. Cum explicați diferențele în acest caz? Citiți mai multe aici: [https://en.wikipedia.org/wiki/World_Wide_Web#WWW_prefix](https://en.wikipedia.org/wiki/World_Wide_Web#WWW_prefix)
invers, acum site-ul nu mai poate fi accesat

7. Folosiți tool-ul *Network* al browserului (firefox: More Tools/Web Developer Tools/Network; chrome: More Tools/Developer Tools/Network) pentru a identifica ce tipuri de metode HTTP sunt invocate la accesarea linkului de la exercițiul 2. 
  fetching tracking event pt terms and conditions

   Ce diferențe sunt între metodele `GET` și `POST`? Citiți mai multe aici: 
   [https://www.w3schools.com/tags/ref_httpmethods.asp](https://www.w3schools.com/tags/ref_httpmethods.asp) 
   și aici (despre vulnerabilitățile metodelor HTTP): 
   [https://appcheck-ng.com/http-verbs-security-risks#](https://appcheck-ng.com/http-verbs-security-risks#)

8. Folosiți tool-ul *Inspector* din browser pentru a identifica fontul folosit în website-ul de la exercițiul 6.   
Consolas, monospace;

9. Folosind editoarele de HTML și CSS integrate în *Developer Tools*, modificați website-ul pentru a ascunde meniul, schimba titlul, culorile etc.

#### PREMIUM. Exerciții bonus

10. De ce numim homepage-ul homepage?  
[https://thehistoryoftheweb.com/why-do-we-call-it-a-homepage/](https://thehistoryoftheweb.com/why-do-we-call-it-a-homepage/)  

11. Link in BIO? Către ce pagini web avem voie să punem linkuri?  
[https://thehistoryoftheweb.com/the-right-to-link/](https://thehistoryoftheweb.com/the-right-to-link/) 

12. Călătorie către Xanadu. Ce principiu al proiectului Xanadu ați vrea să fie valabil și în lumea web?  
[https://screensresearchhypertext.com/Project-Xanadu](https://screensresearchhypertext.com/Project-Xanadu) 

13. Folosiți *Developer Tools* și *Inspector* pentru a vizualiza conținut aflat în spatele unui paywall (puteți încerca, de exemplu, să recuperați textul din articolul acesta despre [Tim Berners-Lee](https://www.newyorker.com/magazine/2025/10/06/tim-berners-lee-invented-the-world-wide-web-now-he-wants-to-save-it), sau acesta despre [proto-roboți medievali](https://www.lrb.co.uk/the-paper/v46/n04/james-vincent/its-rolling-furious-eyes). Website-urile permit vizualizarea unui număr limitat de articole. Deschideți câteva articole, până epuizați articolele disponibile, apoi redeschideți articolul despre web sau automate și încercați să găsiți textul). Despre user agents și *Googlebot* ce știți?
