# Frecvente de aparitie = Dictionar cu cheia frecventa: Lista de cuvinte
# Lista ordonata pentru fiecare cheie: sorted cu lambda

import os
path = os.path.dirname(__file__)
inputFileName = path + "/frecvente.in"


def getInput():
    words = []
    with open(inputFileName, "r") as f:
        for line in f.readlines():

            import string
            for symbol in string.punctuation:
                line = line.replace(symbol, "")

            for word in line.split():
                words += [word.lower()]
        
    return words

def computeFrequencies(words):
    frequencies = {}
    d = {}

    for word in words:
        if word not in frequencies:
            frequencies[word] = 1
        else:
            frequencies[word] += 1

    for word in frequencies:
        if frequencies[word] not in d:
            d[frequencies[word]] = [word]
        else:
            d[frequencies[word]].append(word)

    # Sortam dictionarul descendent dupa cheie, apoi ascendent lexicografic
    d = dict(sorted(d.items(), key=lambda item: -item[0]))
    return d

def writeOutput(frequencies):
    for key in frequencies:
        print("Frecventa {}: {}".format(key, ", ".join(frequencies[key])))

def main():
    words = sorted(getInput())
    frequencies = computeFrequencies(words)
    writeOutput(frequencies)
    return

if __name__ == "__main__":
    main()
    exit()