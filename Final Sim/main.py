from rs import RS
import random

MessageSize = 64 #message size in bits
RedunantSize = 16 #redudant ECC bits
SymbolSize = 4 #Size (in bits) of each symbol


rs = RS(MessageSize, RedunantSize, SymbolSize)

msg = random.choices(range(0, 16), k=16)
print(msg)
encoded = rs.encode(msg)
print(encoded)

