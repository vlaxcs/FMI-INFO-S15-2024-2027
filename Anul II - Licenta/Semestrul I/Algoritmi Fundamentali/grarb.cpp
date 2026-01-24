#include <fstream>
#include <vector>
using namespace std;
ifstream f("grarb.in");
ofstream g("grarb.out");

#define nil (-1)

vector<vector<int>> a;
vector<int> d, u, pi;
int n, m, ra, rb, t;

void DFS(const int x) {
    d[x] = t = t + 1;
    for (const int ngh : a[x]) {
        if (d[ngh] == nil) {
            pi[ngh] = x;
            DFS(ngh);
        } else if (u[ngh] == nil && ngh != pi[x]) {
            // Găsim muchie de întoarcere
            // Dar nu merge <=> e multigraf
            ra++;
        }
    }
    u[x] = t = t + 1;
}

int main() {
    f >>n >> m;
    a.resize(n + 1);
    d.resize(n + 1, nil);
    u.resize(n + 1, nil);
    pi.resize(n + 1);
    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        a[x].push_back(y);
        a[y].push_back(x);
    }

    for (int i = 1; i <= n; ++i) {
        if (d[i] == nil) {
            DFS(i);
            rb++;   // Adăugăm muchie, am găsit componentă conexă nouă
        }
    }

    // m - n + cc <=> Numărul de muchii pentru a forma pădure
    // --rb <=> Avem nevoie de nr. cc - 1 muchii
    g << m - n + rb-- << endl << rb;

    f.close();
    g.close();
    return 0;
}