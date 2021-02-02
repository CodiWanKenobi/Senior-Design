from gf import GF

class RS:
    # Init()
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

    # Decode()
    # Takes an encoded message as python list and returns decoded message as list
    # This a big boy, take caution when looking through it that you don't strain yourself
    # For OOP purposes, it may be benefial to break each step into its own private method, but that's not the full goal of this sim
    def decode(self, msg):
        if len(msg) != self.N:
            raise ValueError("Message is not equal to %d symbols" % self.N)
        rsym = self.N - self.K #number of redundant symbols
        
        # STEP 1: Calculate Syndrome of the message
        # This is a similar calculation to parity calculation. We substitue the roots of the generator polynomial (2^i) into the received encoded msg
        syndrome = [0] * rsym
        for i in range (0, rsym):
            syndrome[i] = self.field.poly_evaluate(msg, self.field.pow(2, i))
        print("Syndrome: ", syndrome) # debug line

        # STEP 2: Check if syndrome is all 0 (meaning message is undamaged)
        if max(syndrome) == 0:
            return msg[:self.K] #return the real message

        # STEP 3: Find Error Locator Polynomial using the Berlekamp–Massey algorithm
        # I still do not fully understand this algorithm but it works
        err_loc = [1] #Error Locator Polynomial
        old_loc = [1] #BM is an iterative algorithm, so we need to keep the value of the last used locator polynomial
        for i in range(0, rsym):
            
            #Compute delta
            delta = syndrome[i]
            for j in range(1, len(err_loc)):
                delta ^= self.field.multiply(err_loc[-(j+1)], syndrome[i-j])
            #print ("delta", i, delta, list(self.field.poly_multiply(err_loc[::-1], syndrome))) # debug line

            #Shift polynomials to compute next degree
            old_loc = old_loc + [0]

            # Iteratively estimate the errata locator and evaluator polynomials
            if delta != 0: # Update only if there's a discrepancy
                if len(old_loc) > len(err_loc): # Rule B (rule A is implicitly defined because rule A just says that we skip any modification for this iteration)
                    # Computing errata locator polynomial Sigma
                    new_loc = self.field.poly_scale(old_loc, delta)
                    old_loc = self.field.poly_scale(err_loc, self.field.inverse(delta)) # effectively we are doing err_loc * 1/delta = err_loc / delta
                    err_loc = new_loc
                
                # Update with the discrepancy
                err_loc = self.field.poly_add(err_loc, self.field.poly_scale(old_loc, delta))

        #drop any leading 0s if they exist
        while len(err_loc) and err_loc[0] == 0: del err_loc[0] # total number of errors in message is now len(err_loc) - 1
        #reverse the polynomial
        err_loc = err_loc[::-1]
        print("Err_loc: ", err_loc) #debug line
        #determine if too many errors exist to correct
        error_count = len(err_loc) - 1
        #if error_count * 2 > rsym:
        #    raise ReedSolomonError("Too many errors to correct")    # too many errors to correct      


        # STEP 4: Use locator polynomial to locate the errors
        # Currently using a brute force approach, there is a faster algorithm called Chien search that exists if someone else wants to look into that
        # OK READ HERE - for purposes of our project, our locator polynomial
        err_pos = [] # this list will contain the positions of the errors in the msg
        for i in range(len(msg)):
            #print("2^i, i = ", i, self.field.poly_evaluate(err_loc, self.field.pow(2, i)))
            if self.field.poly_evaluate(err_loc, self.field.pow(2, i)) == 0:
                err_pos.append(len(msg)-1-i)
        
        print("Err_Pos: ", err_pos) # debug line




        return syndrome

