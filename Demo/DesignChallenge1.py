import math
import numpy as np
import copy

file = input("Enter file name: ")
with open(file) as f:
    w, h = [int(x) for x in next(f).split()] # read first line
    array = []
    for line in f: # read rest of lines
        array.append([int(x) for x in line.split()])
numECC = math.log((w*h), 2) + 1
x = np.array(array)
x = x.flatten()
y = []
print("Original data: ", x) # data array
i = 0
j = 0

while i < (len(x)) + numECC:
    if (i + 1 & i) == 0:  # check if power of 2
        y.append(0)
        i += 1
    else:
        if j < len(x):
            a = copy.copy(x[j])
            y.append(a)
            j += 1
            i += 1

i = 0
j = 0
cnt = 0
while j < numECC: # we want to set numECC bits
    i = 0
    while i < len(y):
        if (i + 1 & i) != 0:
            if ((i + 1) & (2 ** j) != 0) & y[i]:
                cnt += 1
        i += 1
    y[(2 ** j) - 1] = cnt % 2  # parity
    j += 1
    cnt = 0
print("Data with ECC: ", y) # newly encoded array with data bits and redundancy bits
