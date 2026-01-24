
#include <vector>
#include <fstream>
#include <queue>
#include <bitset>
using namespace std;
ifstream f("catun.in");
ofstream g("catun.out");

constexpr int NMAX = 4e5;
constexpr long long INF = 1e18;

struct edge {
    int to;
    long long cost;

    bool operator>(const edge& other) const {
        return cost > other.cost;
    }
};

int n, m, k;
vector<vector<edge>> a;
priority_queue<edge, vector<edge>, greater<>> pq;
vector<long long> d;
vector<int> t, sol;
bitset<NMAX> visited; 
void init(int size) {
    a.resize(n + 1);
    d.resize(n + 1, INF);
    t.resize(n + 1);
    sol.resize(n + 1);
}

int find_rep(int k) {
    while (t[k] != 0) {
        k = t[k];
    }
    return k;
}

void Dijkstra() {
    while (!pq.empty()) {
        const auto [current, cost] = pq.top();
        pq.pop();

        if (visited[current]) {
            continue;
        }

        if (cost != d[current]) {
            continue;
        }

        for (const auto& [to, cost] : a[current]) {
            if (!visited[to] && d[current] + cost < d[to]) {
                d[to] = d[current] + cost;
                t[to] = current;
                sol[to] = sol[current];
                pq.push({to, d[to]});
            } 
            // Daca un catun este la distanta egala 
            // de doua fortarete, se va considera ca 
            // apartine fortaretei cu numarul de 
            // identificare minim.
            else {
                if (d[current] + cost == d[to]){
                    sol[to] = min(sol[to], sol[current]);
                }
            }
        }
    }
}

int main() {
    f >> n >> m >> k;
    init(n + 1);
    for (int i = 0; i < k; ++i) {
        int x;
        f >> x;
        sol[x] = x;
        d[x] = 0;
        pq.push({x, 0});
    }

    for (int i = 0; i < m; ++i) {
        int x, y, c;
        f >> x >> y >> c;
        a[x].push_back({y, c});
        a[y].push_back({x, c});
    }

    Dijkstra();
    
    for (int i = 1; i <= n; ++i) {
        if (sol[i] == i) {
            g << 0 << " ";
        } else {
            g << sol[i] << " ";
        }
    }

    f.close();
    g.close();
    return 0;
}