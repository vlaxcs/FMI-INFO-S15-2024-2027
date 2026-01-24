#include <fstream>
using namespace std;
ifstream f("data.in");
ofstream g("data.out");

#define NMAX 301
constexpr unsigned long long INF = 1e18;
unsigned long long d[NMAX][NMAX], s;
int p[NMAX][NMAX];
int n;

void RFW(){
    for (int k = 1; k <= n; ++k){
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= n; ++j){
                if (d[i][j] > d[i][k] + d[k][j]){
                    d[i][j] = d[i][k] + d[k][j];
                }
            }
        }
    }
}

void init(){
    for (int i = 1; i <= n; ++i){
        for (int j = 1; j <= n; ++j){
            d[i][j] = (i == j) ? 0 : INF;
        }
    }
}

int main(){
    int m, q;
    f >> n >> m;
    init();
    for (int i = 0; i < m; ++i){
        int x, y, c;
        f >> x >> y >> c;
        d[x][y] = d[y][x] = c;
        p[x][y] = x;
        p[y][x] = y;
    }

    RFW();

    f >> q;
    for (int i = 0; i < q; ++i){
        int x, y, k;
        f >> x >> y >> k;

        bool found(false);

        if (d[x][y] != INF && d[x][y] == d[x][k] + d[y][k]){
            found = true;
        }

        g << found;
    }

    f.close();
    g.close();
    return 0;
}