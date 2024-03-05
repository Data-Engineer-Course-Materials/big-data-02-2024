import sys

for line in sys.stdin:
    inputData = line.strip().split('  ')
    year = inputData[0]
    data = inputData[1:-1]
    for idx in range(len(data)):
        value = data[idx]
        print(str(year) + '\t' + value + ',' + str(idx))
