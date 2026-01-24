#include <fstream>
#include <iostream>
#include <vector>
#include <set>
#include <queue>
using namespace std;
ifstream f("berarii2.in");
ofstream g("berarii2.out");

int n, m, p;
vector<set<int>> a;
set<int> beers;
vector<bool> visited;
vector<int> result;

void BFS(const int p) {
    queue<int> q;
    q.push(p);
    visited[p] = true;

    while (!q.empty()) {
        const int current = q.front();
        q.pop();

        for (const int ngh : a[current]) {
            if (!visited[ngh]) {
                visited[ngh] = true;
                q.push(ngh);
            }
        }
    }
}

int main() {
    f >> n >> m >> p;
    a.resize(n + 1);
    visited.resize(n + 1);
    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        a[x].insert(y);
    }
    for (int i = 0; i < p; ++i) {
        int x;
        f >> x;
        beers.insert(x);
    }

    for (int i = 1; i <= n; ++i) {
        BFS(i);

        bool reachable(false);
        for (const int b : beers) {
            if (visited[b]) {
                reachable = true;
                break;
            }
        }
        if (!reachable) {
            result.push_back(i);
        }
        fill(visited.begin(), visited.end(), false);
    }

    g << result.size() << endl;
    for (const int r : result) {
        g << r << endl;
    }

    f.close();
    g.close();
    return 0;
}