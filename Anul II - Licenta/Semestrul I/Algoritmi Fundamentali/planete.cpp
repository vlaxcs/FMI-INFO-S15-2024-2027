#include <fstream>
#include <queue>
#include <vector>
#include <bitset>
using namespace std;
ifstream cin("data.in");
ofstream cout("data.out");

constexpr int NMAX = 1e4 + 1;
constexpr long long INF = 1e18;
constexpr int INFCD = 1e9;
int n, p, k;
struct edge {
    int to;
    long long cost;
    bool operator>(const edge& other) const {
        return cost > other.cost;
    }
};
vector<vector<edge>> a, sa;
vector<long long> d;
bitset<NMAX> visited;

priority_queue<edge, vector<edge>, greater<>> pq;
long long Dijkstra(const int s) {
    d[s] = 0;
    pq.push({s, d[s]});

    while (!pq.empty()) {
        const auto [current, c_cost] = pq.top();
        pq.pop();

        if (visited[current]) {
            continue;
        }

        if (c_cost != d[current]) {
            continue;
        }

        visited[current] = true;

        for (const auto [to, cost] : a[current]) {
            if (!visited[to] && d[current] + cost < d[to]) {
                d[to] = d[current] + cost;
                pq.push({to, d[to]});
            }
        }
    }

    return d[n];
}

void init(const int size) {
    a.resize(size);
    sa.resize(size);
    d.resize(size, INF);
}

void BFS(const int s) {
    vector<int> c(n + 1, 0);
    queue<int> q;
    q.push(s);
    visited[s] = true;
    c[s] = 0;

    while (!q.empty()) {
        const int current = q.front();
        q.pop();

        if (current != s) {
            a[s].push_back({current, static_cast<long long>(c[current]) * p});
        }

        if (c[current] < k) {
            for (const auto& [ngh, _] : sa[current]) {
                if (!visited[ngh]) {
                    c[ngh] = c[current] + 1;
                    visited[ngh] = true;
                    q.push(ngh);
                }
            }
        }
    }
}

int main() {
    int m;
    cin >> n >> m >> p >> k;
    init(n + 1);
    while (m) {
        int x, y, c;
        cin >> x >> y >> c;
        sa[x].push_back({y, c});
        sa[y].push_back({x, c});
        a[x].push_back({y, c});
        a[y].push_back({x, c});
        --m;
    }

    for (int i = 1; i <= n; ++i) {
        BFS(i);
        visited &= 0;
    }

    cout << Dijkstra(1);

    return 0;
}