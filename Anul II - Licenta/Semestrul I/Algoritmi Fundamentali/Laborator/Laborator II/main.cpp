#include <iostream>
#include <fstream>
#include <utility>
#include <vector>
#include <algorithm>
#include <set>
#include <queue>

#define infile "apm.in"
#define outfile "apm.out"

class APM {
private:
    struct edge {
        int x, y, price;
    };

    std::string input_file, output_file;
    int n{}, m{};
    long result_sum{};
    std::vector<int> p, sz;
    std::vector<edge> e, result;

    static bool p_cond(const edge& a, const edge& b) {
        return a.price < b.price;
    }

    int Find(const int x) {
        if (x != p[x])
            p[x] = Find(p[x]);
        return p[x];
    }

    void Union(int x, int y) {
        if (x != y) {
            if (sz[x] < sz[y]) {
                std::swap(x, y);
            }

            sz[x] += sz[y];
            p[y] = x;
            sz[y] = 0;
        }
    }

    void getData() {
        std::ifstream f(input_file);
        int x, y, price;
        f >> n >> m;
        while (f >> x >> y >> price) {
            e.push_back(edge{x, y, price});
        };
        f.close();
    }

    void putData() {
        std::ofstream g(output_file);
        g << result_sum << std::endl << result.size() << std::endl;
        for (const auto& [x, y, price] : result) {
            g << x << " " << y << std::endl;
        }
        g.close();
    }

public:
    void Kruskal() {
        std::ranges::sort(e, p_cond);

        for (int i = 1; i <= n; ++i) {
            p[i] = i;
            sz[i] = 1;
        }

        for (const auto& [x, y, price] : e) {
            const int a = Find(x);
            const int b = Find(y);
            if ( a != b) {
                result_sum += price;
                Union(a, b);
                result.push_back({x, y, price});
            }
        }

        putData();
    }

    void Prim(int root = 0) {
        std::set<int> visited;
        std::priority_queue<int, std::vector<int>, std::greater<>> heap;

        visited.insert(root);

    }

    explicit APM(std::string  input_file, std::string  output_file)
        : input_file(std::move(input_file)),
          output_file(std::move(output_file)),
          p(200001),
          sz(200001)
    {
        getData();
    }

};

int main() {
    APM en(infile, outfile);
    en.Kruskal();
    // en.Prim();
    return 0;
}