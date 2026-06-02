def readPoint():
    x, y = map(int, input().strip().split())
    return x, y

def detectOrientation(P, Q, R):
    return (Q[0] - P[0]) * (R[1] - P[1]) - (Q[1] - P[1]) * (R[0] - P[0])

def removeCollinear(poly):
    n = len(poly)
    res = []
    for i in range(n):
        a, b, c = poly[i - 1], poly[i], poly[(i + 1) % n]
        if detectOrientation(a, b, c) != 0:
            res.append(b)
    return res

def binarySearch(poly, R):
    lo, hi = 1, len(poly) - 1
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if detectOrientation(poly[0], poly[mid], R) >= 0:
            lo = mid
        else:
            hi = mid
    return lo

def classify(poly, R):
    n = len(poly)
    P = poly[0]
    Q1 = poly[1]
    QN = poly[n - 1]

    c1 = detectOrientation(P, Q1, R)
    cn = detectOrientation(P, QN, R)
    if c1 < 0 or cn > 0:
        return 'OUTSIDE'

    lo = binarySearch(poly, R)

    cfar = detectOrientation(poly[lo], poly[lo + 1], R)
    if cfar < 0:
        return 'OUTSIDE'
    if cfar == 0:
        return 'BOUNDARY'
    if (lo == 1 and c1 == 0) or (lo + 1 == n - 1 and cn == 0):
        return 'BOUNDARY'
    return 'INSIDE'

if __name__ == "__main__":
    poly_points_count = int(input().strip())
    poly_points = [readPoint() for _ in range(poly_points_count)]
    poly_points = removeCollinear(poly_points)

    test_points_count = int(input().strip())
    test_points = [readPoint() for _ in range(test_points_count)]

    out = [classify(poly_points, R) for R in test_points]
    print('\n'.join(out))