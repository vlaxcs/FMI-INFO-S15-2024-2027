#include <fstream>
#include <vector>
#include <algorithm>
#include <bitset>
using namespace std;
ifstream f("ctc.in");
ofstream g("ctc.out");

const long long NMAX = 1e5 + 10;

vector<vector<int>> gr, gt, comp;
vector<int> u;
bitset<NMAX> visited;
int n, m, t, cnt(-1);

void DFS(const int p) {
    visited[p] = true;

    if (cnt >= 0) {
        comp[cnt].push_back(p);
        // Parcurgem GT
        for (const int ngh : gt[p]) {
            if (!visited[ngh]) {
                DFS(ngh);
            }
        }
    } else {
        // Parcurgem G
        for (const int ngh : gr[p]) {
            if (!visited[ngh]) {
                DFS(ngh);
            }
        }
        u.push_back(p);
    }
}

int main() {
    f >> n >> m;
    gr.resize(n + 1);
    gt.resize(n + 1);
    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        gr[x].push_back(y);     // Formăm G
        gt[y].push_back(x);     // Formăm GT
    }

    // Calculăm timpii de terminare
    // Optimizare: Când se termină DFS(i), îi adaug pe i într-un vector
    // La final, întoarcem vectorul (nodurile care s-au terminat cel mai târziu vin din spate în față)
    for (int i = 1; i <= n; ++i) {
        if (!visited[i]) {
            DFS(i);
        }
    }

    visited &= 0;
    ranges::reverse(u);

    for (const int i : u) {
        if (!visited[i]) {
            cnt++;
            comp.emplace_back();
            DFS(i);
        }
    }

    g << cnt + 1 << endl;
    for (int i = 0; i <= cnt; ++i) {
        for (const auto node : comp[i]) {
            g << node << " ";
        }
        g << endl;
    }

    f.close();
    g.close();
    return 0;
}