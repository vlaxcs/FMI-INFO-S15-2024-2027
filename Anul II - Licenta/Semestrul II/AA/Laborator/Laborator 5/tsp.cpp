// https://cms.fmi.unibuc.ro/problem/l5pb4

#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <cmath>

using namespace std;

using Point = pair<int, int>;

long long detectOrientation(const Point& P, const Point& Q, const Point& R) {
    return 1LL * (Q.first - P.first) * (R.second - P.second) -
           1LL * (Q.second - P.second) * (R.first - P.first);
}

double distance(const Point& A, const Point& B) {
    return std::hypot(A.first - B.first, A.second - B.second);
}

vector<Point> convexHull(vector<Point> points) {
    sort(points.begin(), points.end());
    points.erase(unique(points.begin(), points.end()), points.end());

    if (points.size() <= 2) {
        return points;
    }

    auto half = [](const vector<Point>& pts) {
        vector<Point> chain;
        for (const Point& point : pts) {
            while (chain.size() >= 2 && detectOrientation(chain[chain.size() - 2], chain.back(), point) <= 0) {
                chain.pop_back();
            }

            chain.push_back(point);
        }

        chain.pop_back();
        return chain;
    };

    vector<Point> lower = half(vector<Point>(points.begin(), points.end()));
    vector<Point> upper = half(vector<Point>(points.rbegin(), points.rend()));
    lower.insert(lower.end(), upper.begin(), upper.end());
    return lower;
}

vector<Point> convexHullInsertion(const vector<Point>& points) {
    vector<Point> hull = convexHull(points);
    if (hull.size() <= 2) {
        return hull;
    }

    int n = points.size();
    map<Point, int> id;
    for (int i = 0; i < n; ++i) {
        id[points[i]] = i;
    }

    vector<int> nxt(n), prv(n);
    vector<char> inTour(n, 0);

    int h = (int) hull.size();
    int anchor = id[hull[0]];
    for (int k = 0; k < h; ++k) {
        int u = id[hull[k]];
        int v = id[hull[(k + 1) % h]];
        nxt[u] = v;
        prv[v] = u;
        inTour[u] = 1;
    }

    vector<int> rest;
    for (int i = 0; i < n; ++i) {
        if (!inTour[i]) {
            rest.push_back(i);
        }
    }

    vector<int> bestFrom(n, -1);
    vector<double> bestInc(n, 0), bestRatio(n, 0);

    auto recompute = [&](int r) {
        int from = -1;
        double inc = 0;
        int u = anchor;
        do {
            int v = nxt[u];
            double candidate = distance(points[u], points[r]) +
                               distance(points[r], points[v]) -
                               distance(points[u], points[v]);
            if (from == -1 || candidate < inc) {
                inc = candidate;
                from = u;
            }
            u = v;
        } while (u != anchor);

        int v = nxt[from];
        bestFrom[r] = from;
        bestInc[r] = inc;
        bestRatio[r] = (distance(points[from], points[r]) + distance(points[r], points[v])) /
                       distance(points[from], points[v]);
    };

    for (int r : rest) {
        recompute(r);
    }

    while (!rest.empty()) {
        int pick = 0;
        for (int k = 1; k < (int) rest.size(); ++k) {
            if (bestRatio[rest[k]] < bestRatio[rest[pick]]) {
                pick = k;
            }
        }

        int r = rest[pick];
        int a = bestFrom[r];
        int b = nxt[a];

        nxt[a] = r;
        prv[r] = a;
        nxt[r] = b;
        prv[b] = r;
        inTour[r] = 1;

        rest[pick] = rest.back();
        rest.pop_back();

        // Edge (a, b) is gone; edges (a, r) and (r, b) are new.
        for (int q : rest) {
            if (bestFrom[q] == a) {
                recompute(q);
                continue;
            }

            double inc1 = distance(points[a], points[q]) +
                          distance(points[q], points[r]) -
                          distance(points[a], points[r]);
            if (inc1 < bestInc[q]) {
                bestInc[q] = inc1;
                bestFrom[q] = a;
                bestRatio[q] = (distance(points[a], points[q]) + distance(points[q], points[r])) /
                               distance(points[a], points[r]);
            }

            double inc2 = distance(points[r], points[q]) +
                          distance(points[q], points[b]) -
                          distance(points[r], points[b]);
            if (inc2 < bestInc[q]) {
                bestInc[q] = inc2;
                bestFrom[q] = r;
                bestRatio[q] = (distance(points[r], points[q]) + distance(points[q], points[b])) /
                               distance(points[r], points[b]);
            }
        }
    }

    // The first vertex of the cycle must be the one with the minimum abscissa.
    int start = 0;
    for (int i = 1; i < n; ++i) {
        if (points[i] < points[start]) {
            start = i;
        }
    }

    vector<Point> tour;
    tour.reserve(n);
    int u = start;
    do {
        tour.push_back(points[u]);
        u = nxt[u];
    } while (u != start);
    return tour;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);

    int pointsCount;
    cin >> pointsCount;

    vector<Point> points(pointsCount);
    for (Point& point : points) {
        cin >> point.first >> point.second;
    }
        
    vector<Point> tour = convexHullInsertion(points);
    if (tour.size() > 1) {
        tour.push_back(tour.front());
    }
        
    for (const Point& point : tour) {
        cout << point.first << ' ' << point.second << '\n';
    }
        
    return 0;
}
