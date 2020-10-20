import math
import numpy as np
import copy


class Colors:
    BOLD = '\033[1m'
    GREEN = '\033[92m'
    RED = '\033[91m'
    END = '\033[0m'


file = input("Enter file name: ")
with open(file) as f:
    w, h = [int(x) for x in next(f).split()] # read first line
    array = []
    for line in f:  # read rest of lines
        array.append([int(x) for x in line.split()])
numECC = math.ceil(math.log((w*h), 2)) + 1
x = np.array(array)
x = x.flatten()
print("Original data: ", x)  # data array

y = []
j = 0
for i in range((len(x)) + numECC):
    if (i + 1 & i) == 0:  # check if power of 2
        y.append(0)
    else:
        if j < len(x):
            a = copy.copy(x[j])
            y.append(a)
            j += 1

cnt = 0
parityIndices = []
for i in range(numECC):  # we want to set numECC bits
    for j in range(len(y)):
        if (j + 1 & j) != 0:
            if ((j + 1) & (2 ** i) != 0) & y[j]:
                cnt += 1
    parityIndex = (2 ** i) - 1
    parityIndices.append(parityIndex)
    y[parityIndex] = cnt % 2  # parity
    cnt = 0

print("Data with ECC (parity bits highlighted): [", end='')
for i in range(len(y)):
    if parityIndices.__contains__(i):
        print((Colors.BOLD + '%d' + Colors.END + ', ') % y[i], end='')  # print parity bits in bold
    else:
        delimiter = ", "
        if i == len(y) - 1:
            delimiter = ''
        print("%d" % y[i], end=delimiter)
print("]")
