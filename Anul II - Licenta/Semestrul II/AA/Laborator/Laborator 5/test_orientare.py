# Memory Limit Exceeded
def readTestInput():
    tests = dict()
    test_count = int(input().strip())

    for test_id in range(test_count):
        buf = str(input().strip())
        
        if buf.count(' ') != 5:
            raise Exception('Invalid data format, expected: xp yp xq yq xr yr')
        xp, yp, xq, yq, xr, yr = [int(value) for value in buf.split()]
        
        tests[test_id] = {
            'P': {
                'x': xp,
                'y': yp
            },
            'Q': {
                'x': xq,
                'y': yq
            },
            'R': {
                'x': xr,
                'y': yr
            }
        }

    return tests

def detectOrientation(P, Q, R):
    s = 3
    matrix = [
        1, 1, 1,
        P['x'], Q['x'], R['x'],
        P['y'], Q['y'], R['y']      
    ]

    poly = P['x'] * (Q['y'] - R['y']) + Q['x'] * (R['y'] - P['y']) + R['x'] * (P['y'] - Q['y'])

    if poly < 0:
        return 'RIGHT'
    elif poly > 0:
        return 'LEFT'
    else:
        return 'TOUCH'

if __name__ == '__main__':
    tests = readTestInput()
    for test_id, points in tests.items():
        try:
            P, Q, R = points['P'], points['Q'], points['R']

        except Exception as e:
            print(f'Error in {test_id}: {e}')

        print(detectOrientation(P, Q, R))
        
    exit(0)    