#include <fstream>
#include <vector>
#include <queue>
#include <bitset>
#include <set>
using namespace std;

ifstream cin("data.in");
ofstream cout("data.out");

constexpr int NMAX = 1e5;

vector<set<int>> a;
vector<int> deg, result;
bitset<NMAX> visited;

int n;
void init(const int size){
    a.resize(size);
    deg.resize(size);
}

int main(){
    int m;
    cin >> n >> m;
    init(n + 1);
    for (int i = 0; i < m; ++i){
        int x, y;
        cin >> x >> y;
        a[x].insert(y);
        deg[y]++;
    }

    priority_queue<int, vector<int>, greater<>> q;
    for (int i = 1; i <= n; ++i) {
        if (deg[i] == 0) {
            q.push(i);
        }
    }

    while (!q.empty()) {
        int current = q.top();
        q.pop();

        result.push_back(current);

        for (const int ngh : a[current]) {
            deg[ngh]--;
            if (deg[ngh] == 0) {
                q.push(ngh);
            }
        }
    }

    for (const int r : result) {
        visited[r] = true;
        cout << r << " ";
    }
    
    for (int i = 1; i <= n; ++i) {
        if (!visited[i]) {
            cout << i << " ";
        }
    }

    return 0;
}