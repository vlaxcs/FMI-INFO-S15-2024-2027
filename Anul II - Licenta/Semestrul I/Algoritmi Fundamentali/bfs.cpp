#include <fstream>
#include <vector>
#include <queue>

using namespace std;

ifstream f("bfs.in");
ofstream g("bfs.out");

#define nil (-1)

int n, m, s;
// Folosim liste de adiacență
vector<vector<int>> adiac;
vector<int> times;

// Începe BFS-ul din nodul sursă s
void BFS(const int s) {
    // Adăugăm sursa în coadă
    queue<int> q;
    q.push(s);

    // Timpul de vizitare a sursei devine 0
    times[s] = 0;

    // Câtă vreme se poate parcurge componenta conexă
    while (!q.empty()) {
        // Setăm nodul curent vârful cozii
        const int current = q.front();
        q.pop();

        // Vizităm vecinii și verificăm dacă este primul cioc-cioc
        for (const int neighbour : adiac[current]) {
            // Îi deranjăm
            if (times[neighbour] == nil) {
                // Bineînțeles că ne ia o secundă să ajungem la un vecin din nodul curent, altfel nu era vecin
                times[neighbour] = times[current] + 1;
                q.push(neighbour);  // îl vecinim
            }
        }
    }
}

int main(){
    f >> n >> m >> s;
    adiac.resize(n + 1);
    times.resize(n + 1, nil);
    for (int i = 0; i < m; ++i) {
        int x, y;
        f >> x >> y;
        adiac[x].push_back(y);
        // ATENȚIE! Doar dacă e neorientat / dezorientat...
        // adiac[y].push_back(x);
    }

    BFS(s);

    for (int i = 1; i <= n; ++i) {
        g << times[i] << " ";
    }

    f.close();
    g.close();
    return 0;
}