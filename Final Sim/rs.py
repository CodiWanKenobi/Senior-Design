from gf import GF

class ReedSolomonError(Exception):
    pass

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

        #self.field.printLogT()

    # BMalgo()
    # takes syndrome polynomial as input and outputs locator polynomial, Lambda
    # NOTE: Unlike the rest of the code, Syndrome must be in REVERSE order (with lowest degree as first element) 
    def __BMalgo(self, syndrome):
        Lambda = [1] # Lambda(x) = 1
        Lambda_star = [1] # will hold Lambda*(x)
        Cx = [1, 0] # C(x) = x
        L = 0 #current number of assumed errors, init to 0
        N = len(syndrome) #total number of syndromes

        for K in range(0, N):
            #calculate delta: delta = S_n + Lambda_1 * S_n-1 + ... + Lambda_L * S_n-L
            delta = syndrome[K]
            for i in range(1, len(Lambda)):
                delta ^= self.field.multiply(Lambda[-(i+1)], syndrome[K-i])

            if delta !=0: #update only if there is a discrepancy
                Lambda_star = self.field.poly_add(Lambda, self.field.poly_scale(Cx, delta)) # Lambda*(x) = Lambda(x) + delta * C(x)
                if 2*L < (K+1):
                #if len(old_lambda) > len(Lambda):
                    Cx = self.field.poly_scale(Lambda, self.field.inverse(delta)) # C(x) = Lambda / e
                    L = (K+1)-L # update L

            Cx = Cx + [0] # C(x) = C(x) * x
            Lambda = Lambda_star
            #print(Lambda)

        return Lambda

    # NOTE: This algo has syndrome in normal order (with highest degree first) 
    def __BM_high_speed(self, syndrome):
        # variable_0 represents current iteration of variable
        # variable_1 represents next iteration of a variable
        
        #Initialization
        t = 2
        lambda_0 = [0]*t + [1] # lambda(x) = 1 with degree t
        b_0 = [0]*t + [1]      # b(x) = 1 with degree t, b(x) is basically C(x) from old bm algo
        k_0 = 0                # scaler k = 0
        gamma_0 = 1            # scaler gamma = 1

        delta_0 = syndrome[:] # delta(x) = syndrome(x)
        theta_0 = syndrome[:] # theta(x) = syndrome(x)

        s = len(syndrome)

        for _ in range(0, 2*t):
            # Step 1:
            # NOTE: in comments, "polynomial_n" represents the nth degree of that polynomial
            # next lambda = gamma * lambda(x) - delta_0 * b(x) * x (where we remove highest degree of b) 
            lambda_1 = self.field.poly_add(self.field.poly_scale(lambda_0, gamma_0), self.field.poly_scale(b_0[1:] + [0], delta_0[s-1]))

            # next delta = gamma * (delta(x) / x) - delta_0 * theta(x)
            delta_1 =self.field.poly_add(self.field.poly_scale([0] + delta_0[0:s-1], gamma_0), self.field.poly_scale(theta_0, delta_0[s-1]))

            # Step 2: 
            if (delta_0[s-1] != 0) and (k_0 >= 0):
                b_1 = lambda_0 # next b(x) = lambda(x)
                theta_1 = [0] + delta_0[0:s-1] # next theta(x) = delta(x) / x
                gamma_1 = delta_0[s-1] # next gamma = delta_0
                k_1 = -k_0 - 1 # next k = -(k+1)
            else:
                b_1 = b_0[1:] + [0] # next b(x) = b(x) * x
                theta_1 = theta_0 # next theta(x) = theta(x)
                gamma_1 = gamma_0 # next gamma = gamma
                k_1 = k_0 + 1 # next k = k+1

            # Set current iterations to next iterations
            #print(lambda_1)
            lambda_0 = lambda_1
            delta_0 = delta_1
            b_0 = b_1
            theta_0 = theta_1
            gamma_0 = gamma_1
            k_0 = k_1

        return [lambda_0, delta_0[s-2:]]


            


        




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
        syndrome = syndrome[::-1] #reverse syndrome so it's in correct order (highest degree first)
        print("Syndrome: ", syndrome) # debug line

        # STEP 2: Check if syndrome is all 0 (meaning message is undamaged)
        if max(syndrome) == 0:
            return msg[:self.K] #return the real message

        # STEP 3: Find Error Locator Polynomial using the Berlekamp–Massey algorithm
        # The BM algo needs the syndrome list to be in reverse order
        Lambda = self.__BMalgo(syndrome[::-1])
        print("Lambda:", Lambda)
        [newL, newO] = self.__BM_high_speed(syndrome)
        print("New Lambda and New Omega:", newL, newO)
        Lambda = newL
        
        error_count = len(Lambda) - 1
        #This is currently not working, sometimes 3 errors will not be detected
        if error_count * 2 > rsym:
            raise ReedSolomonError("Too many errors to correct")    # too many errors to correct      

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
        omega = self.field.poly_multiply(syndrome, Lambda) # syndrome polynomial * error location polynomial
        omega = omega[len(omega)-(error_count):] # truncate omega so it holds what we want
        print("Omega: ", omega)

        Y = [0] * len(msg) # list to hold the error magnitude at each position

        # Calculate Formal Derivative (this step is holding it back from scaling to symbol size >4)
        if(len(Lambda) == 3):
            Lambda_prime = Lambda[1]    #Lambda prime for a linear or quadratic polynomial is simply the constant of the 1st degree term
                                        #Since symbol size 4 will have at most 3 terms in the error locator for a polynomial for a correctable error, this will work
        elif (len(Lambda) == 2):
            Lambda_prime = Lambda[0]
        # Now find the error magnititudes -> Yi = Xi * Omega(Xi^-1)  / Lambda_prime
        for Xi in X:
            degree = len(msg)-Xi-1
            Xi_inverse = self.field.inverse(self.field.pow(2, degree))
            numerator = self.field.multiply(self.field.pow(2, degree), self.field.poly_evaluate(omega, Xi_inverse))
            Y[Xi] = self.field.divide(numerator, Lambda_prime)
        print("Y: ", Y) #debug line

        # STEP 6: Fix those damn errors!
        # Final step thank god
        msg_out = self.field.poly_add(msg, Y)

        return msg_out[:self.K]

