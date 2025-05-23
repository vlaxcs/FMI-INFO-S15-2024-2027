# Structuri de Date - Tema de Laborator 3

## Problema I - [Strămoși](https://www.infoarena.ro/problema/stramosi)

### Soluție

Problema pleacă de la premiza că sunt cunoscute tupluri de forma (copil, părinte). Pe baza acestora, se cere răspunsul la întrebarea <code>'Care este al P-lea copil al nodului Q?'</code>.

Am rezolvat problema folosind Binary Lifting. Astfel, în tabloul <code>anc</code> definim:
- <code>anc[i][j] = al 2<sup>j</sup>-lea ancestor/strămoș al nodului i</code>.
- <code>anc[i][j] = anc[anc[i][j-1]][j-1] (sau 0, dacă anc[i][j-1] nu este definit / nu are strămoș la distanța 2<sup>j-1</sup>)</code>.

Ulterior, pentru a răspunde la întrebări, verificăm pentru fiecare valoare din intervalul [0, LOG_MAX ~ 18] (cu iterator <code>j</code>, de la mare la mic) compatibilitatea cu reprezentarea binară a numărului P.
Dacă bit-ul lui P de pe poziția <code>2<sup>j</sup></code> este activ, se face un salt cel de-al <code>2<sup>j</sup></code>-lea strămoș. Astfel, răspunsurile sunt date în O(logP) ~ O(logN) | p <= n.

Formula recursivă prin care se realizează salturile este:
- <code>q = anc[q][j], dacă P are bit-ul j activ în reprezentare</code>

### Sursă - [infoarena.ro](https://www.infoarena.ro/job_detail/3297682?action=view-source) (100p)

```
#include <fstream>
using namespace std;
ifstream f("stramosi.in");
ofstream g("stramosi.out");

#define NLIM 250000
#define LOG 18

int anc[NLIM + 1][LOG + 1], n, m;
int main() {
	f >> n >> m;

	for (int i = 1; i <= n; ++i) {
		f >> anc[i][0];
	}

	for (int j = 1; j <= LOG; ++j) {
		for (int i = 1; i <= n; ++i) {
			int m = anc[i][j - 1];
			anc[i][j] = anc[i][j - 1] ? anc[m][j - 1] : 0;
		}
	}

	while (m--) {
		int p, q;
		f >> q >> p;
		
		for (int j = LOG; j >= 0 && q; --j) {
			if (p & (1 << j)) {
				q = anc[q][j];
			}
		}
		
		g << q << '\n';
	}
	
	f.close();
	g.close();
	return 0;
}
```

## Problema II - [Timbre](https://www.infoarena.ro/problema/timbre)

Problema constă într-o alegere optimă a câte maxim K timbre de paginare pentru toate cele N pagini, alese din subsecvențe ale M intervale.

Plecăm de la premiza că avem informația despre capătul superior al fiecărui interval și costul unei secvențe din acesta.

Fiecare tuplu de forma <code>[capăt, cost]</code> este introdus într-un 'heap de maxim' implementat prin <code>priority_queue</code>, prioritatea fiind dată de capătul superior, motiv pentru care numerotăm de la mare la mic.

Ulterior, se evaluzează toate intervalele despre care știm că au capătul superior mai mare sau egal cu N-ul curent (ultimele N pagini de numerotat) prin folosirea unui min-heap, implementat prin <code>priority code</code>, prioritatea fiind dată de această dată de cost. Odată cu evaluarea, se elimină tuplul din coada inițială.

Dintre aceste intervale, se alege cel ce are cel mai mic cost. Se alege o secvență de K timbre din acest interval. Costul se adaugă la suma finală și numărul paginilor de numerotat scade cu K.

### Soluție [infoarena.ro](https://www.infoarena.ro/job_detail/3297834) (100p)

```
#include <fstream>
#include <queue>
using namespace std;

ifstream f("timbre.in");
ofstream g("timbre.out");

priority_queue<pair<int, int>> units;
priority_queue<int, vector<int>, greater<>> costs;

int main() {
    int n, m, k;
    f >> n >> m >> k;

    for (int i = 0; i < m; ++i) {
        int upper_bound, price;
        f >> upper_bound >> price;
        units.emplace(upper_bound, price);
    }

    int answer = 0;

    while (n > 0) {
        while (!units.empty() && units.top().first >= n) {
            costs.push(units.top().second);
            units.pop();
        }

        answer += costs.top();
        costs.pop();
        n -= k;
    }

    g << answer;
    return 0;
}
```

## Problema III - [Dacians vs. Samurais]()

### Soluție - Codeforces.com (100p)
```
#include <iostream>
#include <algorithm>
#include <vector>
#include <unordered_map>
using namespace std;
vector<pair<int, int>> poll;
unordered_map<int, int> freq;
int main() {
    int n, a, b;
    cin >> n;

    for (int i = 0; i < n; ++i) {
        cin >> a >> b;
        poll.emplace_back(a, i);
        poll.emplace_back(b, i);
    }

    sort(poll.begin(), poll.end());

    int total(0), left(0), answer(INT_MAX);

    for (int right = 0; right < poll.size(); ++right) {
        ++freq[poll[right].second];
        if (freq[poll[right].second] == 1) {
            ++total;
        }

        while (total == n) {
            int current_diff = poll[right].first - poll[left].first;
            answer = min(answer, current_diff);

            --freq[poll[left].second];
            if (freq[poll[left].second] == 0) {
                --total;
            }
            ++left;
        }
    }

    cout << answer;
    return 0;
}
```

## Problema IV - [Schi](https://www.infoarena.ro/problema/schi)



### Soluție - [infoarena.ro](https://www.infoarena.ro/job_detail/3297877?action=view-source) (100p)
```
#include <vector>
#include <fstream>
using namespace std;
ifstream f("schi.in");
ofstream g("schi.out");
vector <int> v;
int main()
{
    int n, pos;
    f >> n;
    for (int i = 0; i < n; i++)
    {
        f >> pos;
        v.insert(v.begin() + pos - 1, i);
    }
    
    for (int i = 0; i < v.size(); ++i) {
        g << v[i] + 1 << endl;
    }

    f.close();
    g.close();
    return 0;
}
```



## Problema V - ceva