def readPoint():
    x, y = map(int, input().strip().split())
    return x, y

def detectOrientation(P, Q, R):
    return (Q[0] - P[0]) * (R[1] - P[1]) - (Q[1] - P[1]) * (R[0] - P[0])

def onSegment(A, B, R):
    if detectOrientation(A, B, R) != 0:
        return False
    
    return (min(A[0], B[0]) <= R[0] <= max(A[0], B[0]) and \
            min(A[1], B[1]) <= R[1] <= max(A[1], B[1]))

def classify(poly, R):
    n = len(poly)
    py = R[1]
    inside = False

    for i in range(n):
        A = poly[i]
        B = poly[(i + 1) % n]

        if onSegment(A, B, R):
            return 'BOUNDARY'

        if (A[1] > py) != (B[1] > py):
            if (detectOrientation(A, B, R) > 0) == (B[1] > A[1]):
                inside = not inside

    return 'INSIDE' if inside else 'OUTSIDE'

if __name__ == "__main__":
    poly_points_count = int(input().strip())
    poly_points = [readPoint() for _ in range(poly_points_count)]

    test_points_count = int(input().strip())
    test_points = [readPoint() for _ in range(test_points_count)]

    out = [classify(poly_points, R) for R in test_points]
    print('\n'.join(out))
