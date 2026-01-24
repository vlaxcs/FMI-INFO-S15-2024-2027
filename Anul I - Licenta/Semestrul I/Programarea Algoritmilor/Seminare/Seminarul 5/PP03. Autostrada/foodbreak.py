import os
path = os.path.dirname(__file__)
inputFileName = path + "/foodbreak.in"
outputFileName = path + "/foodbreak.out"

def getInput():
    reports = []
    with open(inputFileName, "r") as f:
        for line in f.readlines():
            x, y = line.split()
            reports.append((int(x), int(y)))

        roadLength = len(reports)

    return roadLength, reports

def computeRoadStats(roadLength, reports):
    safeAreas = []
    damagedAreas = []

    lastSafeArea = 0
    maxLeft = reports[0][0]
    maxRight = reports[0][1]
    damageLength = maxRight - maxLeft

    for report in reports[1:]:
        if report[1] <= maxRight:
            continue
        elif report[0] < maxRight:
            damageLength += report[1] - maxRight
            maxRight = report[1]
        else:
            if lastSafeArea < maxLeft:
                safeAreas.append((lastSafeArea, maxLeft))
            damagedAreas.append([maxLeft, maxRight])

            lastSafeArea = maxRight
            maxLeft = report[0]
            maxRight = report[1]
            damageLength += maxRight - maxLeft

    damagedAreas.append([maxLeft, maxRight])
    if lastSafeArea < maxLeft:
        safeAreas.append((lastSafeArea, maxLeft))
    if maxRight < roadLength:
        safeAreas.append((maxRight, roadLength))

    return safeAreas

def writeOutput(roadLength, safeAreas):
    with open(outputFileName, "w") as g:
        for area in safeAreas:
            g.write("{}\n".format(area))

def sortKey(item):
    return item[0], -item[1]

def main():
    roadLength, reports = getInput()
    reports = sorted(reports, key=sortKey)
    safeAreas = computeRoadStats(roadLength, reports)
    writeOutput(roadLength, safeAreas)
    return

if __name__ == "__main__":
    main()
    exit()