# https://cms.fmi.unibuc.ro/problem/l7pb5

def readSegment():
    x1, y1, x2, y2 = map(int, input().strip().split())
    return x1, y1, x2, y2


def update(tree, i, delta):
    while i < len(tree):
        tree[i] += delta
        i += i & (-i)


def prefix(tree, i):
    total = 0
    while i > 0:
        total += tree[i]
        i -= i & (-i)

    return total

def countBelow(ys, value):
    low, high = 0, len(ys)
    while low < high:
        mid = (low + high) // 2
        if ys[mid] <= value:
            low = mid + 1
        else:
            high = mid

    return low


if __name__ == "__main__":
    n = int(input().strip())

    verticals, horizontals, ys = [], [], []
    for _ in range(n):
        x1, y1, x2, y2 = readSegment()
        if x1 == x2:
            verticals.append((x1, min(y1, y2), max(y1, y2)))
        else:
            horizontals.append((y1, min(x1, x2), max(x1, x2)))
            ys.append(y1)

    ys = sorted(set(ys))
    rank = {y: i + 1 for i, y in enumerate(ys)}

    events = []
    for y, low_x, high_x in horizontals:
        events.append((low_x, 0, y, y))
        events.append((high_x, 2, y, y))
        
    for x, low_y, high_y in verticals:
        events.append((x, 1, low_y, high_y))
    events.sort(key=lambda e: (e[0], e[1]))

    tree = [0] * (len(ys) + 1)

    count = 0
    for x, kind, low_y, high_y in events:
        if kind == 0:
            update(tree, rank[low_y], 1)
        elif kind == 2:
            update(tree, rank[low_y], -1)
        else:
            count += prefix(tree, countBelow(ys, high_y)) - prefix(tree, countBelow(ys, low_y - 1))

    print(count)
