#include <fstream>
#include <iostream>
#include <vector>
#include <set>
#include <queue>
using namespace std;
ifstream f("berarii2.in");
ofstream g("berarii2.out");

int n, m, p;
vector<vector<int>> a;
vector<bool> visited;
vector<int> result;
queue<int> q;

void BFS() {
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
    visited.resize(n + 1, false);
    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        
        if (x == y){
            continue;
        }

        // Plec de la berărie la intersecție, logic
        // Deci construiesc GT
        a[y].push_back(x);
    }

    for (int i = 0; i < p; ++i) {
        int beer;
        f >> beer;
        if (!visited[beer]){
            visited[beer] = true;
            q.push(beer);
        }
    }

    BFS();

    for (int i = 1; i <= n; ++i) {
        // Intersecții în care n-am ajuns din niciun target
        if (!visited[i]) {
            result.push_back(i);
        }
    }

    g << result.size() << endl;
    for (const int r : result) {
        g << r << endl;
    }

    f.close();
    g.close();
    return 0;
}
