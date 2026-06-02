def readPoint() -> tuple[int, int]:
    x, y = map(int, input().strip().split())
    return x, y


def detectOrientation(P, Q, R):
    poly = P[0] * (Q[1] - R[1]) + Q[0] * (R[1] - P[1]) + R[0] * (P[1] - Q[1])

    if poly > 0:
        return 1
    
    if poly < 0:
        return -1
    
    return 0


if __name__ == "__main__":
    points_count = int(input().strip())

    turns = {key: 0 for key in ['LEFT', 'RIGHT', 'TOUCH']}

    first_point = readPoint()

    if points_count > 2:
        p_prev = first_point
        p_current = readPoint()

        for _ in range(2, points_count):
            p_next = readPoint()
            orientation = detectOrientation(p_prev, p_current, p_next)

            key = 'LEFT' if orientation > 0 else 'RIGHT' if orientation < 0 else 'TOUCH'
            turns[key] += 1

            p_prev = p_current
            p_current = p_next

        orientation = detectOrientation(p_prev, p_current, first_point)

        key = 'LEFT' if orientation > 0 else 'RIGHT' if orientation < 0 else 'TOUCH'
        turns[key] += 1

    print(turns['LEFT'], turns['RIGHT'], turns['TOUCH'])