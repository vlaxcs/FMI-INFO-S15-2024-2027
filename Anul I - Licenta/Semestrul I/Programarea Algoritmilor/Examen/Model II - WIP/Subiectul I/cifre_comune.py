def cifre_comune(*numbers, x = 135579):
    x = str(x)
    ans = {int(c): [] for c in x}

    for number in numbers:
        nrs = set(str(number))
        for digit in nrs:
            if int(digit) in ans and number not in ans[int(digit)]:
                ans[int(digit)].append(number)
    
    for key in ans:
        ans[key] = tuple(sorted(ans[key]))

    return ans

rez = cifre_comune(54572, 9559, 2024, 75917)
print(rez)