MessageSize = 64 #message size in bits
RedunantSize = 16 #redudant ECC bits
SymbolSize = 4 #Size (in bits) of each symbol

n = (MessageSize + RedunantSize) / SymbolSize #Total number of symbols
k = MessageSize / SymbolSize #Length of real message (in symbols)

