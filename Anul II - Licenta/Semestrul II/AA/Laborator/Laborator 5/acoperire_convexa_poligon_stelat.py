from collections import deque

def readPoint() -> tuple[int, int]:
    x, y = map(int, input().strip().split())
    return x, y


def detectOrientation(P, Q, R):
    return (Q[0] - P[0]) * (R[1] - P[1]) - (Q[1] - P[1]) * (R[0] - P[0])


def hullMelkman(points):
    points_count = len(points)

    if points_count <= 1:
        return points

    if points_count == 2:
        return points if points[0] != points[1] else [points[0]]

    second = 1

    while second < points_count and points[second] == points[0]:
        second += 1

    if second == points_count:
        return [points[0]]

    third = second + 1
    while third < points_count and detectOrientation(points[0], points[second], points[third]) == 0:
        third += 1

    if third == points_count:
        return [points[0], points[second]]

    P, Q, R = points[0], points[second], points[third]
    deq = deque()
    if detectOrientation(P, Q, R) > 0:
        deq.append(P), deq.append(Q)
    else:
        deq.append(Q), deq.append(P)

    deq.append(R), deq.appendleft(R)

    for point in points[third + 1:]:
        if detectOrientation(deq[0], deq[1], point) > 0 and detectOrientation(deq[-2], deq[-1], point) > 0:
            continue

        while len(deq) >= 3 and detectOrientation(deq[0], deq[1], point) <= 0:
            deq.popleft()
        deq.appendleft(point)

        while len(deq) >= 3 and detectOrientation(deq[-2], deq[-1], point) <= 0:
            deq.pop()
        deq.append(point)

    if deq and deq[0] == deq[-1]:
        deq.pop()

    hull = list(deq)

    if len(hull) > 2:
        changed = True
        while changed and len(hull) > 2:
            changed = False
            n = len(hull)

            for i in range(n):
                prev_point = hull[(i - 1) % n]
                current_point = hull[i]
                next_point = hull[(i + 1) % n]

                if detectOrientation(prev_point, current_point, next_point) == 0 and \
                   min(prev_point[0], next_point[0]) <= current_point[0] <= max(prev_point[0], next_point[0]) and \
                   min(prev_point[1], next_point[1]) <= current_point[1] <= max(prev_point[1], next_point[1]):
                    del hull[i]
                    changed = True
                    break

    return hull


if __name__ == "__main__":
    points_count = int(input().strip())
    points = [readPoint() for _ in range(points_count)]

    cover = hullMelkman(points)
    print(len(cover))
    for point in cover:
        print(f'{point[0]} {point[1]}')
