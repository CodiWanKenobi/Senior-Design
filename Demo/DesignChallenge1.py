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
numECC = math.floor(math.log((w*h), 2)) + 1
x = np.array(array)
x = x.flatten()
print("Original data: ", x)  # data array

y = [0]
j = 0
for i in range(1, (len(x)) + numECC + 1):
    if (i & (i - 1)) == 0:  # check if power of 2
        y.append(0)
    else:
        if j < len(x):
            a = copy.copy(x[j])
            y.append(a)
            j += 1

# Calculate parity bit values for original data
parityIndices = []
for i in range(numECC):  # we want to set numECC bits
    parityIndex = (1 << i)
    parityIndices.append(parityIndex)
    for j in range(1, len(y)):
        if (j & (j-1)) == 0:
            continue
        if (j & parityIndex) == parityIndex:
            y[parityIndex] ^= y[j]

print("Data with ECC (parity bits in bold): [", end='')
for i in range(len(y)):
    if parityIndices.__contains__(i):
        print((Colors.BOLD + '%d' + Colors.END + ', ') % y[i], end='')  # print parity bits in bold
    else:
        delimiter = ", "
        if i == len(y) - 1:
            delimiter = ''
        print("%d" % y[i], end=delimiter)
print("]")

errorPos = input("Enter index of bit to flip: ")
errorPos = int(errorPos)
y[errorPos] ^= 1

# Calculate parity bit values for modified data
parityValues = [0] * numECC
for i in range(numECC):
    parityIndex = (1 << i)
    for j in range(1, len(y)):
        if j == 8:
            j = 8
        if (j & (j - 1)) == 0:
            continue
        elif (j & parityIndex) == parityIndex:
            parityValues[i] ^= y[j]

# Determine error position
errorIndex = 0
for i in range(numECC):
    if parityValues[i] != y[1 << i]:
        errorIndex += (1 << i)

if (errorIndex & (errorIndex - 1)) != 0:
    print("Error detected at position %d" % errorIndex)
elif errorIndex != 0:
    print("Error detected in parity bit at position %d" % errorIndex)
else:
    print("No errors detected")

print("Received ECC data:  [", end='')
for i in range(len(y)):
    if errorPos == i:
        print((Colors.RED + '%d' + Colors.END + ', ') % y[i], end='')
    elif parityIndices.__contains__(i):
        print((Colors.BOLD + '%d' + Colors.END + ', ') % y[i], end='')  # print parity bits in bold
    else:
        delimiter = ", "
        if i == len(y) - 1:
            delimiter = ''
        print("%d" % y[i], end=delimiter)
print("]")

print("Corrected ECC data: [", end='')
for i in range(len(y)):
    if errorPos == i:
        print((Colors.GREEN + '%d' + Colors.END + ', ') % (y[i] ^ 1), end='')  # print corrected bit in green
    elif parityIndices.__contains__(i):
        print((Colors.BOLD + '%d' + Colors.END + ', ') % y[i], end='')  # print parity bits in bold
    else:
        delimiter = ", "
        if i == len(y) - 1:
            delimiter = ''
        print("%d" % y[i], end=delimiter)
print("]")

print("Corrected data: [", end='')
for i in range(len(y)):
    if (i & (i - 1)) == 0:
        continue
    else:
        delimiter = ", "
        if i == len(y) - 1:
            delimiter = ''
        print("%d" % y[i], end=delimiter)
print("]")

print("Original data:  [", end='')
for i in range(len(x)):
    delimiter = ", "
    if i == len(x) - 1:
        delimiter = ''
    print("%d" % x[i], end=delimiter)
print("]")