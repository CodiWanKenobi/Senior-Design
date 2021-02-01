from gf import GF

class RS:
    # Init
    # Input messageSize is total number off bits of real message
    # Input redudantSize is total number of bits of redudant information
    # Input symbolSize is number of bits in each symbol
    def __init__(self, messageSize, redudantSize, symbolSize):
        self.SymSize = symbolSize
        self.N = int((messageSize + redudantSize) / symbolSize)
        self.K = int(messageSize / symbolSize)
        self.field = GF(symbolSize)
        #Code below creates the generator polynomial (can be hardcoded in final schematic)
        self.genpoly = [1]
        for i in range(0, self.N-self.K):
            self.genpoly = self.field.poly_multiply(self.genpoly, [1, self.field.pow(2, i)])

    # Encode()
    # Takes a python list containing the message already split into its symbols
    # Returns the encoded message with ECC symbols appended as a list
    def encode(self, msg_in):
        if len(msg_in) != self.K:
            raise ValueError("Message is not equal to %d symbols" % self.K)
        msg_out = [0] * self.N
        msg_out[:len(msg_in)] = msg_in

        #Synthetic Division Main Loop
        for i in range(len(msg_in)):
            coef = msg_out[i]
            if coef != 0:
                for j in range(1, len(self.genpoly)):
                    msg_out[i+j] ^= self.field.multiply(self.genpoly[j], coef)

        # At this point, the Extended Synthetic Divison is done, msg_out contains the quotient in msg_out[:len(msg_in)]
        # and the remainder in msg_out[len(msg_in):]. Here for RS encoding, we don't need the quotient but only the remainder
        # (which represents the RS code), so we can just overwrite the quotient with the input message, so that we get
        # our complete codeword composed of the message + code.
        msg_out[:len(msg_in)] = msg_in
        return msg_out