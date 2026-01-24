#include <fstream>
#include <vector>
using namespace std;
ifstream f("dfs.in");
ofstream g("dfs.out");

#define nil (-1)

vector<vector<int>> adiac;
vector<int> times;
int n, m, c;

void DFS(const int s, const int time) {
    // NU E CEL MAI SCURT TIMP MEREU!
    times[s] = time;
    for (const int neighbour : adiac[s]) {
        if (times[neighbour] == nil) {
            DFS(neighbour, times[s] + 1);
        }
    }
}

int main() {
    f >> n >> m;
    adiac.resize(n + 1);
    times.resize(n + 1, -1);
    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        adiac[x].push_back(y);
        adiac[y].push_back(x);
    }

    for (int i = 1; i <= n; ++i) {
        if (times[i] == nil) {
            DFS(i, 0);
            ++c;
        }
    }

    g << c;

    f.close();
    g.close();
    return 0;
}