#include <fstream>
#include <vector>
#include <queue>
using namespace std;
ifstream f("apm.in");
ofstream g("apm.out");

vector<pair<int, int>> result;
vector<int> tata, h;
int n, m, cost;
void init(const int size) {
    tata.resize(size);
    h.resize(size);
}

struct edge {
    int x, y, c;
};

struct comp {
    bool operator()(const edge a, const edge b) const {
        return a.c > b.c;
    }
};

priority_queue<edge, std::vector<edge>, comp> edges;

void kruskal_init(int i) {
    tata[i] = h[i] = 0;
}

int kruskal_rep(int i) {
    while (tata[i] != 0) {
        i = tata[i];
    }

    return i;
}

void kruskal_union(int x, int y) {
    const int rx(kruskal_rep(x)), ry(kruskal_rep(y));
    if (h[rx] > h[ry]) {
        tata[ry] = rx;
    } else {
        tata[rx] = ry;

        if (h[rx] == h[ry]) {
            h[rx] = h[ry] + 1;
        }
    }
}

int main() {
    f >> n >> m;
    init(n + 1);

    for (int i = 0; i < m; ++i) {
        int x, y, c;
        f >> x >> y >> c;
        edges.push(edge{x, y, c});
    }

    for (int i = 1; i <= n; ++i) {
        kruskal_init(i);
    }

    while (!edges.empty()){
        auto e = edges.top();
        edges.pop();

        int x = e.x, y = e.y;
        if (kruskal_rep(x) != kruskal_rep(y)) {
            cost += e.c;
            result.emplace_back(x, y);
            kruskal_union(x, y);
            if (result.size() == n - 1) {
                break;
            }
        }
    }

    g << cost << endl;
    g << result.size() << endl;
    for (const auto& [x, y] : result) {
        g << x << " " << y << endl;
    }

    f.close();
    g.close();
    return 0;
}