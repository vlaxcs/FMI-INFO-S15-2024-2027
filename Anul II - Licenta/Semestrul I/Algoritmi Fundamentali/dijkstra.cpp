#include <fstream>
#include <vector>
#include <queue>
#include <bitset>
using namespace std;
ifstream f("dijkstra.in");
ofstream g("dijkstra.out");

constexpr int NMAX = 5e5 + 5;
constexpr long long INF = 1e18;
int n, m;

struct edge {
    int to;
    long long cost;

    bool operator>(const edge& other) const {
        return cost > other.cost;
    }
};

vector<vector<edge>> a;
vector<long long> d;
vector<int> t;
bitset<NMAX> visited;
priority_queue<edge, vector<edge>, greater<>> pq;

void Dijkstra(const int s) {
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
                t[to] = current;
                pq.push({to, d[to]});
            }
        }
    }

    for (int i = 2; i <= n; ++i) {
        if (d[i] == INF) {
            g << 0 << " ";
        } else {
            g << d[i] <<" ";
        }
    }
}

void init(const int size) {
    a.resize(size);
    d.resize(size, INF);
    t.resize(size);
}

int main() {
    f >> n >> m;
    init(n + 1);
    for (int i = 0;i < m; ++i) {
        int x, y, c;
        f >> x >> y >> c;
        a[x].push_back({y, c});
    }

    Dijkstra(1);

    f.close();
    g.close();
    return 0;
}