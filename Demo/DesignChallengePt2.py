import math
import random
import copy


class Colors:
    BOLD = '\033[1m'
    GREEN = '\033[92m'
    RED = '\033[91m'
    END = '\033[0m'


numBits = 128
bitsPerBlock = numBits >> 2
numECC = math.floor(math.log(numBits, 2)) + 1
generalParityBits = [0] * numECC
blockParityBits = [0] * 4

x = []
for i in range(numBits):
    x.append(random.randint(0, 1))

blocks = [x[:32], x[32:64], x[64:96], x[96:128]]

# Binary representation of the ECC bits that each group counts for (see Excel sheet on Google Drive).
# For example, group 0 (groups[0]) counts for ECC bits 0, 1, 2, and 3.
groups = [
    0b00001111, 0b00010111, 0b00100111, 0b01000111, 0b10000111, 0b00011011, 0b00101011, 0b01001011,
    0b10001011, 0b00011101, 0b00101101, 0b01001101, 0b10001101, 0b00011110, 0b00101110, 0b01001110,
    0b10001110, 0b01111000, 0b10111000, 0b00111001, 0b00111010, 0b11100001, 0b11100010, 0b11100100,
    0b11101000, 0b11000011, 0b11000110, 0b11001100, 0b11011000, 0b11001010, 0b11010100, 0b11110000
]


# Generate ECC bits based on current data.
def gen_parity_bits():
    for block_index in range(len(blocks)):
        for blockBit in blocks[block_index]:
            blockParityBits[block_index] ^= blockBit
    for groupNum in range(len(groups)):
        group = groups[groupNum]
        for bitNum in range(0, 8, 1):
            bit = (group >> bitNum) & 1
            if bit:
                for blockNum in range(len(blocks)):
                    block = blocks[blockNum]
                    block_bit = block[groupNum]
                    generalParityBits[bitNum] ^= block_bit


# Generate syndrome based on parity bits for old and new data.
# Each argument is a tuple of the form (general_parity_bits, block_parity_bits)
def gen_syndrome(orig_parity, new_parity):
    orig_general, orig_block = orig_parity
    new_general, new_block = new_parity
    syndrome_general = [0] * len(orig_general)
    syndrome_block = [0] * len(orig_block)
    for i in range(len(syndrome_general)):
        syndrome_general[i] = orig_general[i] ^ new_general[i]
    for i in range(len(syndrome_block)):
        syndrome_block[i] = orig_block[i] ^ new_block[i]
    return syndrome_general, syndrome_block


gen_parity_bits()
originalGenParity = copy.copy(generalParityBits)
originalBlockParity = copy.copy(blockParityBits)

old_x = copy.copy(x)  # Keep old data to show changes

# Reset parity bits
generalParityBits = [0] * numECC
blockParityBits = [0] * 4

ecIndices = []
errorPos = input("\nEnter index of bit(s) to flip, separated by a space: ")
if len(errorPos) > 0:
    errorIndices = errorPos.split(' ')
    for i in range(len(errorIndices)):
        errorIndex = int(errorIndices[i])
        blockIndex = errorIndex // 32
        bitIndex = errorIndex % 32
        blocks[blockIndex][bitIndex] ^= 1
# choice to flip EC bits
ecErrs = input("\nEnter index of parity bit(s) to flip (0-11), separated by a space: ")
if len(ecErrs) > 0:
    ecIndices = [int(x) for x in ecErrs.split(' ')]



gen_parity_bits()
if len(ecIndices) > 0:
    for bit in ecIndices:
        if bit < 8:
            generalParityBits[bit] ^= 1
        else:
            blockParityBits[bit - 8] ^= 1

oldParityBits = (originalGenParity, originalBlockParity)
newParityBits = (generalParityBits, blockParityBits)
general_syndrome, block_syndrome = gen_syndrome(oldParityBits, newParityBits)

print('Old data:')
for i in range(len(blocks)):
    for j in range(len(blocks[i])):
        if i == 3 and j == 31:
            print(old_x[(i * 32 + j)], end='')
        else:
            print(old_x[(i * 32 + j)], end=', ')
    print()

print("Old parity:", oldParityBits)
print()
print('New data:')
for i in range(len(blocks)):
    for j in range(len(blocks[i])):
        if blocks[i][j] != old_x[(i * 32 + j)]:
            print(Colors.RED, end='')
            print(blocks[i][j], end='')
            print(Colors.END, end=', ')
        else:
            if i == 3 and j == 31:
                print(blocks[i][j], end='')
            else:
                print(blocks[i][j], end=', ')
    print()

print("New parity: ", end='')
#print EC bits
if len(ecIndices) == 0:
    print(newParityBits)
else:
    print("([", end='')
    for i in range(12):
        if i in [7, 11]:
            endl = ']'
        else:
            endl = ','
        if i in ecIndices:
            print(Colors.RED, end='')
            if i < 8:
                print(newParityBits[0][i], end='')
            else:
                print(newParityBits[1][8-i], end = '')
            print(Colors.END, end=endl)
        else:
            if i < 8:
                print(newParityBits[0][i], end=endl)
            else:
                print(newParityBits[1][8-i], end = endl)
        if i == 7:
            print(',', end=' [')
        elif i == 11:
            print(')')

print()
print("General Syndrome:", general_syndrome)
print("Group Syndrome:", block_syndrome)
print()


# Find a group whose binary literal corresponds to the bits set in the syndrome.
def find_error_group(syndrome):
    # Treat syndrome as binary representation of integer for easier comparison
    syndrome_literal = 0
    for i in range(len(syndrome)):
        syndrome_literal += syndrome[i] << i
    if syndrome_literal == 0:  # No error
        return -1
    for group_index in range(len(groups)):
        if syndrome_literal == groups[group_index]:
            return group_index
    return -1


# Find the first block where an error occurred (only need SEC, so don't worry about the rest).
def find_error_block(syndrome):
    sum = 0
    index = 0
    for i in range(len(syndrome)):
        sum += syndrome[i]
    if sum != 0 and sum % 2 == 0:
        return 0
    for i in range(len(syndrome)):
        if syndrome[i]:
            return i
    return -1


groupVal = find_error_group(general_syndrome)
blockVal = find_error_block(block_syndrome)

if groupVal == -1:
    print("No error detected in data block.")
    if blockVal != -1:
        print("Error Detected in ECC Bits")
elif (groupVal != 0 and blockVal == -1) or (groupVal == -1 and blockVal != -1):
    print("Double-error detected - skipping correction.", end='\n\n')
    print('Final data:')
    for i in range(len(blocks)):
        for j in range(len(blocks[i])):
            if blocks[i][j] != old_x[(i * 32 + j)]:
                print(Colors.RED, end='')
                print(blocks[i][j], end='')
                print(Colors.END, end=', ')
            else:
                if i == 3 and j == 31:
                    print(blocks[i][j], end='')
                else:
                    print(blocks[i][j], end=', ')
        print()
else:
    print("Error detected in group %d, block %c" % (groupVal, ['A', 'B', 'C', 'D'][blockVal]), end='\n\n')
    blocks[blockVal][groupVal] ^= 1
    print('Corrected data:')
    for i in range(len(blocks)):
        for j in range(len(blocks[i])):
            if i == blockVal and j == groupVal:
                print(Colors.GREEN, end='')
                print(blocks[i][j], end='')
                print(Colors.END, end=', ')
            else:
                if i == 3 and j == 31:
                    print(blocks[i][j], end='')
                else:
                    print(blocks[i][j], end=', ')
        print()
