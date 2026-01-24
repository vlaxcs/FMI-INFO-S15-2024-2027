#include <fstream>
using namespace std;

ifstream cin("data.in");
ofstream cout("data.out");

constexpr int NMAX = 301;
constexpr unsigned long long INF = 1e18;
int n;

unsigned long long d[NMAX][NMAX];

void RAW() {
    for (int k = 1; k <= n; ++k) {
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (d[i][j] > d[i][k] + d[k][j]) {
                    d[i][j] = d[i][k] + d[k][j];
                }
            }
        }
    }
}

void init() {
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= n; ++j) {
            d[i][j] = (i == j) ? 0 : INF;
        }
    }
}

int main() {
    int m;
    cin >> n >> m;
    init();
    while (m) {
        int x, y, c;
        cin >> x >> y >> c;
        d[x][y] = d[y][x] = c;
        m--;
    }

    RAW();

    int q;
    cin >> q;
    while (q) {
        int x, y, k;
        cin >> x >> y >> k;
        cout << (d[x][y] == INF || (d[x][y] != INF && d[x][y] != d[x][k] + d[k][y]));
        q--;
    }

    return 0;
}