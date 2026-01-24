#include <cmath>
#include <fstream>
#include <iostream>
#include <vector>
#include <queue>
using namespace std;
ifstream f("amici2.in");
ofstream g("amici2.out");

#define nil (-1)

int t;

int BFS(const vector<vector<int>>& a, vector<int>& d) {
    queue<int> q;
    q.push(1);
    int dmax = d[1] = 1;

    while (!q.empty()) {
        const int current = q.front();
        q.pop();

        for (const int ngh : a[current]) {
            if (d[ngh] == nil) {
                d[ngh] = d[current] + 1;
                dmax = max(dmax, d[ngh]);
                q.push(ngh);
            }
        }
    }

    return dmax;
}

int solve() {
    int n, m;
    f >> n >> m;

    vector<vector<int>> a(n + 1);
    vector<int> d(n + 1, nil);

    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        a[x].push_back(y);
        a[y].push_back(x);
    }

   return ceil(log2(BFS(a, d)));
}

int main() {
    f >> t;
    for (int i = 0; i < t; ++i) {
        g << solve() << endl;
    }
    return 0;
}