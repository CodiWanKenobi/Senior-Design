from rs import RS
import random

MessageSize = 44 #message size in bits
RedunantSize = 16 #redudant ECC bits
SymbolSize = 4 #Size (in bits) of each symbol

rs = RS(MessageSize, RedunantSize, SymbolSize)

msg = random.choices(range(0, 16), k=11) # Use this for random choices

msg = [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb]
print('Msg_in:  [{}]'.format(', '.join(hex(x) for x in msg)))
encoded = rs.encode(msg)
print('Encoded: [{}]'.format(', '.join(hex(x) for x in encoded)))

# Put your own errors here
#encoded[random.randint(0, 14)] ^= random.randint(0,16)
#encoded[random.randint(0, 14)] ^= random.randint(0,16)
encoded[5] = 11
encoded[12] = 1
#encoded[0] = 15

print('Errors:  [{}]'.format(', '.join(hex(x) for x in encoded)))
decoded = rs.decode(encoded)
print("Decoded: [{}]".format(', '.join(hex(x) for x in decoded)))

