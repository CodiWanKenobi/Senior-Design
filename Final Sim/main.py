from rs import RS
import random

MessageSize = 44 #message size in bits
RedunantSize = 16 #redudant ECC bits
SymbolSize = 4 #Size (in bits) of each symbol


rs = RS(MessageSize, RedunantSize, SymbolSize)

#msg = random.choices(range(0, 16), k=16)
msg = [0x5, 0x4, 0xb, 0xe, 0x9, 0xe, 0x2, 0xf, 0xc, 0x9, 0x0]
#print(msg)
print('Msg_in:  [{}]'.format(', '.join(hex(x) for x in msg)))
encoded = rs.encode(msg)
print('Encoded: [{}]'.format(', '.join(hex(x) for x in encoded)))
encoded[0] = 6
encoded[1] = 0xf
print('Errors:  [{}]'.format(', '.join(hex(x) for x in encoded)))
syndrome = rs.decode(encoded)

