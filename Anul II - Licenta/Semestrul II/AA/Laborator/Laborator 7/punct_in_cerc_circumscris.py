# https://cms.fmi.unibuc.ro/problem/l7pb1

def readPoint():
    x, y = map(int, input().strip().split())
    return x, y

def determineOrientation(A, B, C, D):
    X, Y = [list(map(lambda P: P[i] - D[i], (A, B, C))) for i in range(2)]

    return (
        (X[0] * X[0] + Y[0] * Y[0]) * (X[1] * Y[2] - X[2] * Y[1]) \
      - (X[1] * X[1] + Y[1] * Y[1]) * (X[0] * Y[2] - X[2] * Y[0]) \
      + (X[2] * X[2] + Y[2] * Y[2]) * (X[0] * Y[1] - X[1] * Y[0])
    )

def orientate(A, B, C):
    return (B[0] - A[0]) * (C[1] - A[1]) - (B[1] - A[1]) * (C[0] - A[0])

if __name__ == "__main__":
    A, B, C = [readPoint() for _ in range(3)]    
    o = orientate(A, B, C)

    test_points_count = int(input().strip())
    for _ in range(test_points_count):
        D = readPoint()
        orientation = determineOrientation(A, B, C, D)

        if o < 0:
            orientation *= -1

        if orientation > 0:
            print('INSIDE')
        elif orientation == 0:
            print('BOUNDARY')
        else:
            print('OUTSIDE')