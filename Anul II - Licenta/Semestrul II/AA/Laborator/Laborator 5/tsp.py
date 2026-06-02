# https://cms.fmi.unibuc.ro/problem/l5pb4

from math import dist

def readPoint() -> tuple[int, int]:
    x, y = map(int, input().strip().split())
    return x, y


def detectOrientation(P, Q, R):
    return (Q[0] - P[0]) * (R[1] - P[1]) - (Q[1] - P[1]) * (R[0] - P[0])


def convexHull(points):
    unique = sorted(set(points))
    if len(unique) <= 2:
        return unique

    def half(pts):
        chain = []
        for point in pts:
            while len(chain) >= 2 and detectOrientation(chain[-2], chain[-1], point) <= 0:
                chain.pop()
            chain.append(point)
        return chain[:-1]

    lower = half(unique)
    upper = half(reversed(unique))
    return lower + upper


def convexHullInsertion(points):
    hull = convexHull(points)
    if len(hull) <= 2:
        return hull

    tour = hull[:]
    inside = set(tour)
    remaining = [p for p in points if p not in inside]

    while remaining:
        best_ratio = None
        best_point = None
        best_edge = None

        for r in remaining:
            min_increase = None
            edge = None
            for i in range(len(tour)):
                a = tour[i]
                b = tour[(i + 1) % len(tour)]
                increase = dist(a, r) + dist(r, b) - dist(a, b)
                if min_increase is None or increase < min_increase:
                    min_increase = increase
                    edge = i

            a = tour[edge]
            b = tour[(edge + 1) % len(tour)]
            ratio = (dist(a, r) + dist(r, b)) / dist(a, b)
            if best_ratio is None or ratio < best_ratio:
                best_ratio = ratio
                best_point = r
                best_edge = edge

        tour.insert(best_edge + 1, best_point)
        remaining.remove(best_point)

    start = min(range(len(tour)), key=lambda i: tour[i])
    return tour[start:] + tour[:start]


if __name__ == "__main__":
    points_count = int(input().strip())
    points = [readPoint() for _ in range(points_count)]

    tour = convexHullInsertion(points)
    if len(tour) > 1:
        tour.append(tour[0])
    for point in tour:
        print(f'{point[0]} {point[1]}')
