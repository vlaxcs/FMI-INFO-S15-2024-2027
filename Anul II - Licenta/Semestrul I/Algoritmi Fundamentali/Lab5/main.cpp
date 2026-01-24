#include <bits/stdc++.h>

#define NMAX 500

int flow[NMAX + 1][NMAX + 1];
int c[NMAX + 1][NMAX + 1];
int visited[NMAX + 1], p[NMAX + 1];

std::vector<int> G[NMAX + 1];

int BFS(const int s, const int d, const int n_flow) {
    std::queue<int> q;
    for (int i = 1; i <= n_flow; ++i) {
        visited[i] = 0;
        p[i] = 0;
    }

    q.push(s);
    visited[s] = 1;
    while (!q.empty()) {
        const int x = q.front();
        q.pop();

        for (auto y : G[x]) {
            if (!visited[y] && c[x][y] - flow[x][y] > 0) {
                visited[y] = 1;
                q.push(y);
                p[y] = x;
            }
        }
    }

    if (visited[d] == 0) {
        return 0;
    }

    std::vector<int> path;
    int x = d;
    while (x != 0) {
        path.push_back(x);
        x = p[x];
    }

    std::ranges::reverse(path);

    int mn = 1e9;
    for (int i = 0; i + 1 < path.size(); ++i) {
        int x = path[i];
        int y = path[i + 1];
        mn = std::min(mn, c[x][y] - flow[x][y]);
    }
    for (int i = 0; i + 1 < path.size(); ++i) {
        int x = path[i];
        int y = path[i + 1];
        flow[x][y] += mn;
        flow[y][x] -= mn;
    }

    return mn;
}

int main() {
    int n, m, e;
    std::ifstream cin("cuplaj.in");
    std::ofstream cout("cuplaj.out");

    cin >> n >> m >> e;
    int n_flow(n + m + 2), src(1), dest(n_flow);

    for (int u = 1; u <= n; ++u) {
        int u_flow = u + 1;
        c[src][u_flow] = 1;
        G[src].push_back(u_flow);
        G[u_flow].push_back(src);
    }

    for (int v = 1; v <= m; ++v) {
        int v_flow = n + 1 + v;
        c[v_flow][dest] = 1;
        G[v_flow].push_back(dest);
        G[dest].push_back(v_flow);
    }

    for (int i = 1; i <= e; ++i) {
        int u, v;
        cin >> u >> v;

        int u_flow = u + 1;
        int v_flow = n + 1 + v;

        c[u_flow][v_flow] = 1;
        G[u_flow].push_back(v_flow);
        G[v_flow].push_back(u_flow);
    }

    int sum = 0;
    while (true) {
        int f = BFS(src, dest, n_flow);
        sum += f;

        if (f == 0) {
            break;
        }
    }

    cout << sum << std::endl;
    for (int u_flow = 2; u_flow <= n + 1; ++u_flow) {
        for (int v_flow : G[u_flow]) {
            if (v_flow >= n + 2
                && v_flow <= n + m + 1
                && flow[u_flow][v_flow] == 1) {
                    cout << u_flow - 1 << " " << v_flow - (n + 1) << std::endl;
                }
        }
    }
    return 0;
}