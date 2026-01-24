#include <bitset>
#include <fstream>
#include <iostream>
#include <vector>
#include <set>
using namespace std;
ifstream f("data.in");
ofstream g("data.out");

const long long NMAX = 1e5 + 5;

vector<vector<int>> a;
vector<int> nivel, niv_min, tata;
vector<pair<int, int>> muchii_critice;
set<int> puncte_critice;
bitset<NMAX> visited;
int n, m;

// DFS pentru determinarea
// - nodurilor critice
// - muchiilor critice
void DFSC(const int p) {
    int fii_p = 0;
    visited[p] = true;
    niv_min[p] = nivel[p];

    for (const int ngh : a[p]) {
        if (ngh == tata[p]) {
            continue;
        }

        if (!visited[ngh]) {
            // Muchie de avansare (p, ngh)
            nivel[ngh] = nivel[p] + 1;  // Nivelul vecinului este nivelul următor părintelui
            tata[ngh] = p;
            DFSC(ngh);
            fii_p++;

            // La final pe call-stack
            // Dacă vecinul a ajuns pe un nivel mai mic, îl setăm pe al vecinului
            // (putem accesa vecinul -> putem accesa ceva de pe nivelul minim accesibil al vecinului
            niv_min[p] = min(niv_min[p], niv_min[ngh]);

            // Test muchie critică
            // Nu face parte dintr-un ciclu
            if (nivel[p] < niv_min[ngh]) {
                muchii_critice.emplace_back(p, ngh);
            }

            // Articulație - Non-rădăcină
            if (tata[p] != 0 && nivel[p] <= niv_min[ngh]) {
                puncte_critice.insert(p);
            }
        } else {
            // Muchie de întoarcere (p, ngh)
            niv_min[p] = min(niv_min[p], nivel[ngh]);
        }
    }

    // Articulație - Rădăcină
    // FII ÎN ARBORELE DFS, NU ÎN GRAF!
    if (tata[p] == 0 && fii_p > 1) {
        puncte_critice.insert(p);
    }
}

void init() {
    a.resize(n + 1);
    tata.resize(n + 1);
    nivel.resize(n + 1);
    niv_min.resize(n + 1);
}

int main() {
    f >> n >> m;
    init();

    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        a[x].push_back(y);
        a[y].push_back(x);
    }

    for (int i = 1; i <= n; ++i) {
        if (!visited[i]) {
            nivel[i] = 1;
            DFSC(i);
        }
    }

    for (const int p : puncte_critice) {
        g << p << " ";
    }
    g << endl;

    for (const auto& [x, y] : muchii_critice) {
        g << x << " " << y << endl;
    }

    f.close();
    g.close();
    return 0;
}