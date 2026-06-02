if __name__ == "__main__":
    test_count = int(input().strip())
    for _ in range(test_count):
        buf = str(input().strip())
        xp, yp, xq, yq, xr, yr = [int(value) for value in buf.split()]

        # matrix = [
        #     1, 1, 1,
        #     xp, xq, xr,
        #     yp, yq, yr      
        # ]

        poly = xp * (yq - yr) + xq * (yr - yp) + xr * (yp - yq)
        if poly < 0:
            print('RIGHT')
        elif poly > 0:
            print('LEFT')
        else:
            print('TOUCH')