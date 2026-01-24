#include <fstream>
#include <bitset>
#include <vector>
#include <queue>
#include <set>
using namespace std;

ifstream f("apm.in");
ofstream g("apm.out");

constexpr int NMAX = 2e6;
constexpr int inf = 2e9;
#define nil (-1)

struct edge {
    int to, cost;
    bool operator>(const edge& other) const {
        return cost > other.cost;
    }
};

vector<vector<edge>> a;
bitset<NMAX> visited;
vector<int> d, t;
int n, m;

void res(int size) {
    a.resize(size);
    d.resize(size, inf);
    t.resize(size);
}

void reset(int size) {
    fill(d.begin(), d.end(), inf);
}

void Prim(const int source) {
    int total_count = 0;
    priority_queue<edge, vector<edge>, greater<edge>> pq;
    d[source] = 0;
    pq.push({source, 0});

    while (!pq.empty()) {
        auto [to, cost] = pq.top();
        pq.pop();

        if (visited[to]) {
            continue;
        }

        total_count += cost;
        visited[to] = true;

        for (const auto& [ngh, cost] : a[to]) {
            if (!visited[ngh] && cost < d[ngh]) {
                d[ngh] = cost;
                t[ngh] = to;
                pq.push({ngh, d[ngh]});
            }
        }
    }

    g << total_count << endl;
    g << n - 1 << endl;
    for (int i = 1; i <= n; ++i) {
        if (t[i] != 0) {
            g << t[i] << " " << i << endl;
        }
    }
}

int main() {
    f >> n >> m;
    res(n + 1);
    for (int i = 0; i < m; ++i) {
        int x, y, c;
        f >> x >> y >> c;
        a[x].push_back({y, c});
        a[y].push_back({x, c});
    }

    Prim(1);

    f.close();
    g.close();
    return 0;
}