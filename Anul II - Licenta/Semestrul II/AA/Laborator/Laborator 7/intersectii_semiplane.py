# https://cms.fmi.unibuc.ro/problem/l7pb3

INF = float('inf')

def readSemiplane():
    a, b, c = map(int, input().strip().split())
    return a, b, c

if __name__ == "__main__":
    n = int(input().strip())
    low_x, low_y, high_x, high_y = -INF, -INF, INF, INF

    for _ in range(n):
        a, b, c = readSemiplane()
        
        if b == 0:
            bound = -c / a
            if a > 0:
                high_x = min(high_x, bound)
            else:
                low_x = max(low_x, bound)
        else:
            bound = -c / b
            if b > 0:
                high_y = min(high_y, bound)
            else:
                low_y = max(low_y, bound)

    if low_x > high_x or low_y > high_y:
        print('VOID')
    elif low_x != -INF and high_x != INF and low_y != -INF and high_y != INF:
        print('BOUNDED')
    else:
        print('UNBOUNDED')
