n = int(input())

lmax = 0
aux = n
while aux != 0:
    print("bin(n): {}\nbin(n << 1): {}\nbin(n & (n << 1)): {}\n".format(bin(aux), bin(aux << 1), bin(aux & (aux << 1))))
    lmax += 1
    aux = aux & (aux << 1)

print("Cea mai lunga secventa de biti nenuli din scrierea binara a numarului {} are {} biti".format(n, lmax))
