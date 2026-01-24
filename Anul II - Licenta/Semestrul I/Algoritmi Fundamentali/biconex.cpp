#include <bitset>
#include <fstream>
#include <vector>
#include <stack>
#include <set>
using namespace std;
ifstream f("biconex.in");
ofstream g("biconex.out");

constexpr int NMAX = 1e6 + 6;
vector<vector<int>> a;
vector<set<int>> conexe;
vector<int> nma, nivel, tata;
bitset<NMAX> visited;
stack<pair<int, int>> s;
int n, m;
long long cost;

void cache_biconexa(const int x, const int y) {
    set<int> comp;
    int tx, ty;
    do {
        tx = s.top().first;
        ty = s.top().second;
        s.pop();
        comp.insert(tx);
        comp.insert(ty);
    } while (tx != x || ty != y);

    conexe.push_back(comp);
}

void DFSC(const int p) {
    int fii_p(0);
    nma[p] = nivel[p];
    visited[p] = true;

    for (const int ngh : a[p]) {
        if (ngh == tata[p]) {
            continue;
        }

        // Muchie de avansare
        if (!visited[ngh]) {
            tata[ngh] = p;
            nivel[ngh] = nivel[p] + 1;
            s.emplace(p, ngh);
            DFSC(ngh);
            fii_p++;

            nma[p] = min(nma[p], nma[ngh]);
            // Punct critic (rădăcină / non-rădăcină)
            // Scoatem de pe stivă tot până la muchia (p, ngh)
            if (nivel[p] <= nma[ngh]) {
                cache_biconexa(p, ngh);
            }
        } else {
            // Muchie de întoarcere
            nma[p] = min(nma[p], nivel[ngh]);
        }
    }
}

void init(const int size) {
    a.resize(size);
    tata.resize(size);
    nma.resize(size);
    nivel.resize(size);
}

int main() {
    f >> n >> m;
    init(n + 1);

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

    g << conexe.size() << endl;
    for (const auto& comp : conexe) {
        for (const int x : comp) {
            g << x << " ";
        }
        g << endl;
    }

    f.close();
    g.close();
    return 0;
}