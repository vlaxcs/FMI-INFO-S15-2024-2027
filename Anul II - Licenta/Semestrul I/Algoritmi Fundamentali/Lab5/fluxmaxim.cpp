#include <bits/stdc++.h>

using namespace std;

constexpr int NMAX = 1000;
int flux[NMAX + 1][NMAX + 1];
int capacitate[NMAX + 1][NMAX + 1];

vector<int> G[NMAX + 1];
int viz[NMAX + 1], p[NMAX + 1];
int n, m;

int BFS(const int s, const int d) {
    queue<int> q;
    for (int i = 1; i <= n; ++i) {
        viz[i] = 0;
        p[i] = 0;
    }

    q.push(s);
    viz[s] = 1;
    while (!q.empty()) {
        int x = q.front();
        q.pop();

        for (auto y : G[x]) {
            if (!viz[y] && capacitate[x][y] - flux[x][y] > 0) {
                viz[y] = 1;
                q.push(y);
                p[y] = x;
            }
        }
    }

    if (viz[d] == 0) {
        return 0;
    }

    vector<int> path;
    int x = d;
    while (x != 0) {
        path.push_back(x);
        x = p[x];
    }

    reverse(path.begin(), path.end());

    int mn = 1e9;
    for (int i = 0; i < path.size(); ++i) {
        int x = path[i];
        int y = path[i + 1];
        mn = min(mn, capacitate[x][y] - flux[x][y]);
    }
    for (int i = 0; i< path.size(); ++i) {
        int x = path[i];
        int y = path[i + 1];
        flux[x][y] += mn;
        flux[y][x] -= mn;
    }

    return mn;
}

int main() {
    ifstream cin("maxflow.in");
    ofstream cout("maxflow.out");

    cin >> n >> m;
    for (int i = 1; i <= m; ++i) {
        int x, y, c;
        cin >> x >> y >> c;
        capacitate[x][y] = c;
        G[x].push_back(y);
        G[y].push_back(x);
    }

    int sum = 0;
    while (true) {
        int flux = BFS(1, n);
        sum += flux;

        if (flux == 0) {
            break;
        }
    }

    cout << sum;
    return 0;
}