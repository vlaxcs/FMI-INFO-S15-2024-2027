# https://cms.fmi.unibuc.ro/problem/l7pb4

def readSemiplane():
    a, b, c = map(int, input().strip().split())
    return a, b, c

def readPoint():
    x, y = map(float, input().strip().split())
    return x, y

def format(area):
    return f"{area:.6f}".rstrip('0').rstrip('.')

if __name__ == "__main__":
    n = int(input().strip())

    lefts, rights, bottoms, tops = [], [], [], []
    for _ in range(n):
        a, b, c = readSemiplane()

        if b == 0:
            bound = -c / a
            (lefts if a < 0 else rights).append(bound)
        else:
            bound = -c / b
            (bottoms if b < 0 else tops).append(bound)

    m = int(input().strip())
    for _ in range(m):
        x, y = readPoint()

        xL = max((l for l in lefts if l < x), default=None)
        xR = min((r for r in rights if r > x), default=None)
        yB = max((b for b in bottoms if b < y), default=None)
        yT = min((t for t in tops if t > y), default=None)

        if None not in (xL, xR, yB, yT):
            print('YES')
            print(format((xR - xL) * (yT - yB)))
        else:
            print('NO')
