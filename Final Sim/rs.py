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
        print("Generator Polynomial: ", self.genpoly)

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
        Lambda = [1] #Error Locator Polynomial
        old_loc = [1] #BM is an iterative algorithm, so we need to keep the value of the last used locator polynomial
        for i in range(0, rsym):
            
            #Compute delta
            delta = syndrome[i]
            for j in range(1, len(Lambda)):
                delta ^= self.field.multiply(Lambda[-(j+1)], syndrome[i-j])
            #print ("delta", i, delta, list(self.field.poly_multiply(Lambda[::-1], syndrome))) # debug line

            #Shift polynomials to compute next degree
            old_loc = old_loc + [0]

            # Iteratively estimate the errata locator and evaluator polynomials
            if delta != 0: # Update only if there's a discrepancy
                if len(old_loc) > len(Lambda): # Rule B (rule A is implicitly defined because rule A just says that we skip any modification for this iteration)
                    # Computing errata locator polynomial Sigma
                    new_loc = self.field.poly_scale(old_loc, delta)
                    old_loc = self.field.poly_scale(Lambda, self.field.inverse(delta)) # effectively we are doing Lambda * 1/delta = Lambda / delta
                    Lambda = new_loc
                
                # Update with the discrepancy
                Lambda = self.field.poly_add(Lambda, self.field.poly_scale(old_loc, delta))

        #drop any leading 0s if they exist
        while len(Lambda) and Lambda[0] == 0: del Lambda[0] # total number of errors in message is now len(Lambda) - 1
        print("Lambda: ", Lambda) #debug line
        #determine if too many errors exist to correct
        error_count = len(Lambda) - 1
        #if error_count * 2 > rsym:
        #    raise ReedSolomonError("Too many errors to correct")    # too many errors to correct      


        # STEP 4: Determine the location of the errors using the locator polynomial
        # Currently using a brute force approach, there is a faster algorithm called Chien search that exists if someone else wants to look into that
        X = [] # this list will contain the positions of the errors in the msg
        for i in range(len(msg)-1, -1, -1): #count down from 14 to 0
            #print("2^-i, i = ", i, self.field.poly_evaluate(Lambda, self.field.pow(2, i)))
            if self.field.poly_evaluate(Lambda, self.field.pow(2, -i)) == 0:
                X.append(len(msg)-1-i)
        
        print("X: ", X) # debug line

        # STEP 5: Calculate the magnitude of the errors (using Forney)
        # Note - this step currently only works and is optimized for symbols size 4 or 2, symbol size 8 or greater WILL NOT WORK
        # Also a very depressing algo

        # First calculate omega
        omega = self.field.poly_multiply(syndrome[::-1], Lambda) # syndrome polynomial * error location polynomial
        omega = omega[len(omega)-(error_count):] # truncate omega so it holds what we want
        print("Omega: ", omega)

        Y = [0] * len(msg) # list to hold the error magnitude at each position

        # Calculate Formal Derivative (this step is holding it back from scaling to symbol size >4)
        Lambda_prime = Lambda[1]    #Lambda prime for a linear or quadratic polynomial is simply the constant of the 1st degree term
                                    #Since symbol size 4 will have at most 3 terms in the error locator for a polynomial for a correctable error, this will work

        # Now find the error magnititudes -> Yi = Xi * Omega(Xi^-1)  / Lambda_prime
        for i in range(0, len(X)):
            degree = len(msg)-X[i]-1
            Xi_inverse = self.field.inverse(self.field.pow(2, degree))
            numerator = self.field.multiply(self.field.pow(2, degree), self.field.poly_evaluate(omega, Xi_inverse))
            Y[X[i]] = self.field.divide(numerator, Lambda_prime)
        print("Y: ", Y) #debug line

        # STEP 6: Fix those damn errors!
        # Final step thank god
        msg_out = self.field.poly_add(msg, Y)

        return msg_out[:self.K]

