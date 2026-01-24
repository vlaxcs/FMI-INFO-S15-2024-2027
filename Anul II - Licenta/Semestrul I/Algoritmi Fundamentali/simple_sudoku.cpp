#include <fstream>
using namespace std;

constexpr int NMAX = 19;
int m[NMAX][NMAX];

ifstream cin("data.in");
ofstream cout("data.out");
int n;
bool solved;

void print_solution() {
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= n; ++j) {
            cout << m[i][j] << " ";
        }
        cout << endl;
    }
}

bool condition(const int i, const int j, const int val) {
    for (int a = 1; a <= n; ++a) {
        if (m[a][j] == val) {
            return false;
        }
        if (m[i][a] == val) {
            return false;
        }
    }

    return true;
}

void bkt(const int i, const int j) {
    if (solved) {
        return;
    }

    if (i > n) {
        print_solution();
        solved = true;
        return;
    }

    int ni = i, nj = j + 1;
    if (nj > n) {
        ni++;
        nj = 1;
    }

    if (m[i][j] != 0) {
        bkt(ni, nj);
        return;
    }

    for (int num = 1; num <= n; ++num) {
        if (condition(i, j, num)) {
            m[i][j] = num;
            bkt(ni, nj);
            m[i][j] = 0;
        }
    }
}

int main() {
    cin >> n;
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= n; ++j) {
            cin >> m[i][j];
        }
    }

    bkt(1, 1);
    return 0;
}