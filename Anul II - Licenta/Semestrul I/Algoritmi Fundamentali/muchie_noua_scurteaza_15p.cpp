#include <fstream>
#include <vector>
#include <queue>
#include <set>
#include <bitset>
using namespace std;
ifstream cin("data.in");
ofstream cout("data.out");

constexpr long long INF = 1e9;
constexpr int NMAX = 1e5 + 1;
bitset<NMAX> visited;
vector<set<int>> a;
vector<int> c, d, result;
int n;

void BFS(const int s, const bool retry = false) {
    queue<int> q;
    q.push(s);
    d[s] = 0;
    visited[s] = true;

    while (!q.empty()) {
        const int current = q.front();
        q.pop();

        for (const int ngh : a[current]) {
            if (!visited[ngh]) {
                if (retry) {
                    d[ngh] = d[current] + 1;
                } else {
                    c[ngh] = c[current] + 1;
                }
                visited[ngh] = true;
                q.push(ngh);
            }
        }
    }
}

void init(const int size) {
    a.resize(size);
    c.resize(size);
    d.resize(size);
}

int main() {
    int m;
    cin >> n >> m;
    init(n + 1);
    while (m) {
        int x, y;
        cin >> x >> y;
        a[x].insert(y);
        a[y].insert(x);
        --m;
    }

    BFS(1);
    visited = false;

    int q;
    cin >> q;
    for (int i = 1; i <= q; ++i) {
        int x, y;
        cin >> x >> y;
        if (a[x].find(y) != a[x].end()) {
            continue;
        }

        a[x].insert(y);
        a[y].insert(x);
        BFS(1, true);
        visited = false;
        if (d[n] < c[n]) {
            result.push_back(i);
        }
        a[x].erase(y);
        a[y].erase(x);
    }

    cout << result.size() << endl;
    for (const int qi : result) {
        cout << qi << " ";
    }

    return 0;
}