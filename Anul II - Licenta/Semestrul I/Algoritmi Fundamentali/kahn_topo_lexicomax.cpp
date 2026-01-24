#include <fstream>
#include <queue>
#include <vector>
#include <bitset>
using namespace std;

constexpr int NMAX = 1e5 + 1;

ifstream cin("data.in");
ofstream cout("data.out");

vector<vector<int>> a;
vector<int> deg, result;
bitset<NMAX> visited;
int n;

void init(const int size) {
    a.resize(size);
    deg.resize(size);
}

int main() {
    int m;
    cin >> n >> m;
    init(n + 1);
    while (m) {
        int x, y;
        cin >> x >> y;
        a[x].push_back(y);
        deg[y]++;
        --m;
    }

    priority_queue<int> pq;
    for (int i = 1; i <= n; ++i) {
        if (deg[i] == 0) {
            pq.push(i);
        }
    }

    while (!pq.empty()) {
        int current = pq.top();
        pq.pop();

        result.push_back(current);

        for (const int ngh : a[current]) {
            deg[ngh]--;
            if (deg[ngh] == 0) {
                pq.push(ngh);
            }
        }
    }

    for (const int r : result) {
        visited[r] = true;
        cout << r << " ";
    }

    for (int i = 1; i <= n; ++i) {
        if (visited[i] == false) {
            cout << i << " ";
        }
    }

    return 0;
}