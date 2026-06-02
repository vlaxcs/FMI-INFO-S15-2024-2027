def readPoint():
    x, y = map(int, input().strip().split())
    return x, y

def countTurns(vals):
    n = len(vals)
    signs = []

    for i in range(n):
        d = vals[(i + 1) % n] - vals[i]
        if d > 0:
            signs.append(1)
        elif d < 0:
            signs.append(-1)

    m = len(signs)
    if m == 0:
        return 0

    changes = 0
    for i in range(m):
        if signs[i] != signs[(i + 1) % m]:
            changes += 1

    return changes

def isMonotone(coords):
    return countTurns(coords) == 2

if __name__ == "__main__":
    poly_points_count = int(input().strip())
    poly_points = [readPoint() for _ in range(poly_points_count)]

    xs = [point[0] for point in poly_points]
    ys = [point[1] for point in poly_points]
    monoton_x, monoton_y  = isMonotone(xs), isMonotone(ys)

    print("YES" if monoton_x else "NO")
    print("YES" if monoton_y else "NO")