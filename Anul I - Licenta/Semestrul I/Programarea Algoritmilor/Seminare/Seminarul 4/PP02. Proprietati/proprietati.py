import os
path = os.path.dirname(__file__)
outputFileName = path + '/proprieati.out'

def getInput():
    inputFileName = path + "/proprietatea1.in"
    with open(inputFileName, "r") as f:

    inputFileName = path + "/proprietatea2.in"
    with open(inputFileName, "r") as f:

    inputFileName = path + "/proprietatea3.in"
    with open(inputFileName, "r") as f:

    inputFileName = path + "/proprietatea4.in"
    with open(inputFileName, "r") as f:

def main():

    tasks = getInput()
    return

if __name__ == "__main__":
    main()
    exit()