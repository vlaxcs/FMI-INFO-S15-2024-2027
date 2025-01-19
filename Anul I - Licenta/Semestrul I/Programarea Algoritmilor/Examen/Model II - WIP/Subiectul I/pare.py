M = [[2, 3, 5]]
pare = [M[i][j] for i in ([-1, 0] if len(M) > 1 else [0]) for j in range(0, len(M)) if M[i][j] % 2 == 0]

print(pare)