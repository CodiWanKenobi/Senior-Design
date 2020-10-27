import math
import random
import copy


class Colors:
    BOLD = '\033[1m'
    GREEN = '\033[92m'
    RED = '\033[91m'
    END = '\033[0m'


def print_array(arr, description):
    print(description, end='[')
    for i in range(len(arr)):
        delimiter = ', '
        if i == len(arr) - 1:
            delimiter = ''
        print("%d" % arr[i], end=delimiter)
    print(']')


def print_ecc_array(arr, parity_bits, description, diff_index=0, data_only=False,
                    highlight_parity=True, highlight_diff=True, error=True):
    print(description, end='[')
    diff_color = Colors.GREEN
    if highlight_diff and error:
        diff_color = Colors.RED
    for i in range(len(arr)):
        if data_only and (i & (i - 1)) == 0:
            continue
        delimiter = ', '
        if i == len(arr) - 1:
            delimiter = ''
        if highlight_diff and diff_index == i:
            diff_val = arr[i]
            if not error:
                diff_val ^= 1
            print((diff_color + '%d' + Colors.END) % diff_val, end=delimiter)
        elif highlight_parity and (parity_bits.__contains__(i) or i == 0):
            print((Colors.BOLD + '%d' + Colors.END) % arr[i], end=delimiter)  # print parity bits in bold
        else:
            print("%d" % arr[i], end=delimiter)
    print(']')


numBits = input("Enter the number of data bits (64, 128, or 256): ")
numBits = int(numBits)
numECC = math.floor(math.log(numBits, 2)) + 1

x = []
for i in range(numBits):
    x.append(random.randint(0, 1))

print_array(x, "Original data:\t\t\t\t\t       ")  # data array

y = []
x_index = 0
for i in range(len(x) + numECC + 1):
    if (i & (i - 1)) == 0:  # check if power of 2
        y.append(0)
    else:
        if x_index < len(x):
            a = copy.copy(x[x_index])
            y.append(a)
            x_index += 1

# Calculate parity bit values for original data
parityIndices = []
parityZeroVal = 0
for i in range(numECC):  # we want to set numECC bits
    parityIndex = (1 << i)
    parityIndices.append(parityIndex)
    for j in range(1, len(y)):
        if (j & (j-1)) == 0:
            continue
        if i == 0:
            parityZeroVal ^= y[j]  # Need to use all of the data bits for y[0], just do it on the first pass
        if (j & parityIndex) == parityIndex:
            y[parityIndex] ^= y[j]
    parityZeroVal ^= y[parityIndex]
y[0] = parityZeroVal

print_ecc_array(y, parityIndices, 'Data with ECC (%d parity bits in bold): ' % (numECC + 1), highlight_diff=False)

errorPos = input("Enter index of bit(s) to flip, separated by a space: ")
errorIndices = errorPos.split(' ')
for i in range(len(errorIndices)):
    errorIndex = int(errorIndices[i])
    y[errorIndex] ^= 1

# Calculate parity bit values for modified data
parityZeroVal = 0
parityValues = [0] * numECC
for i in range(numECC):
    parityIndex = (1 << i)
    for j in range(1, len(y)):
        if i == 0:
            parityZeroVal ^= y[j]
        if (j & (j - 1)) == 0:
            continue
        if (j & parityIndex) == parityIndex:
            parityValues[i] ^= y[j]

# Determine error position
errorIndex = 0
for i in range(numECC):
    if parityValues[i] != y[1 << i]:
        errorIndex += (1 << i)

multipleErrors = False
multiErrorString = 'At least two errors detected - correction not possible'
if (errorIndex & (errorIndex - 1)) != 0:
    if parityZeroVal == y[0]:
        multipleErrors = True
        print(multiErrorString)
    else:
        print("Error detected at position %d" % errorIndex)
elif errorIndex != 0:
    if parityZeroVal == y[0]:
        multipleErrors = True
        print(multiErrorString)
    else:
        print("Error detected in parity bit at position %d" % errorIndex)
else:
    print("No errors detected")

if not multipleErrors:
    print_ecc_array(y, parityIndices, 'Received ECC data:  ', diff_index=errorIndex)

    print_ecc_array(y, parityIndices, 'Corrected ECC data: ', diff_index=errorIndex, error=False)
    print()
    print_ecc_array(y, None, 'Corrected data: ', highlight_parity=False, data_only=True)

    print_array(x, 'Original data:  ')
