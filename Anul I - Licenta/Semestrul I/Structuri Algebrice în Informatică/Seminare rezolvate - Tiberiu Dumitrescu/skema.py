def convertToBase(x, b):
    new = 0
    for i, x in enumerate(x):
        new += int(x) * (b ** i)
    return new

def reconvert(x, b):
    return 6 * b

with open("file.out", "w") as g:
    for b in range(2, 60):
        g.write(f"Baza {b}\n")
        for i in range(2, b):
            for j in range(2, 60):
                new = "".join(str(i - 1) for _ in range(3))
                ssn = convertToBase(new, i)
                ss = reconvert(60, j)
                if (int(ss) == ssn):
                    g.write("Baza {}: 60 ? {} = {} ? {} Baza {}\n".format(j, ss, new, ssn, i))
            g.write("\n")
        g.write("\n")