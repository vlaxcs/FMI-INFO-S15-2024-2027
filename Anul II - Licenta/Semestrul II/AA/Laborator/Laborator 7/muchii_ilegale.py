# https://cms.fmi.unibuc.ro/problem/l7pb2

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

if __name__ == "__main__":
    A, B, C, D = [readPoint() for _ in range(4)]    
    D_o = determineOrientation(A, B, C, D)
    A_o = determineOrientation(B, C, D, A)

    print(f"AC: {'ILLEGAL' if D_o > 0 else 'LEGAL'}")
    print(f"BD: {'ILLEGAL' if A_o > 0 else 'LEGAL'}")