class GF:
    # PrimChoices - Primitive polynomials for degrees 1-8
    # Higher degrees have multiple primative polynomials - to see them all go here -> http://www.ee.unb.ca/cgi-bin/tervo/calc2.pl
    PrimChoices = [0, 0b11, 0b111, 0b1101, 0b11001, 0b111101, 0b100011, 0b11001011, 0b100011101]

    # Private Methods (neither will need to be recreated in the schematic)
    def __gf_mult_noLUT(self, x, y, prim=0, field_charac_full=256, carryless=True):
        '''Galois Field integer multiplication using Russian Peasant Multiplication algorithm (faster than the standard multiplication + modular reduction).
        If prim is 0 and carryless=False, then the function produces the result for a standard integers multiplication (no carry-less arithmetics nor modular reduction).'''
        # Note: This function DOES NOT have to be recreated in the shcematic - we will just hardcode the log and anti-log tables in ROM
        r = 0
        while y: # while y is above 0
            if y & 1: r = r ^ x if carryless else r + x # y is odd, then add the corresponding x to r (the sum of all x's corresponding to odd y's will give the final product). Note that since we're in GF(2), the addition is in fact an XOR (very important because in GF(2) the multiplication and additions are carry-less, thus it changes the result!).
            y = y >> 1 # equivalent to y // 2
            x = x << 1 # equivalent to x*2
            if prim > 0 and x & field_charac_full: x = x ^ prim # GF modulo: if x >= maxSize+1 then apply modular reduction using the primitive polynomial (we just subtract, but since the primitive number can be above maxSize then we directly XOR).

        return r

    def __initLogTables(self, prim):
        '''Precompute the logarithm and anti-log tables for faster computation later, using the provided primitive polynomial.'''
        # Note: This function DOES NOT have to be recreated in the shcematic - we will just hardcode the log and anti-log tables in ROM
        # prim is the primitive (binary) polynomial. Since it's a polynomial in the binary sense,
        # it's only in fact a single galois field value between 0 and maxSize, and not a list of gf values.
        self.gf_exp = [0] * 2 * (self.maxSize+1) # anti-log (exponential) table
        self.gf_log = [0] * (self.maxSize+1) # log table
        # For each possible value in the galois field 2^8, we will pre-compute the logarithm and anti-logarithm (exponential) of this value
        x = 1
        for i in range(0, 255):
            self.gf_exp[i] = x # compute anti-log for this value and store it in a table
            self.gf_log[x] = i # compute log at the same time
            x = self.__gf_mult_noLUT(x, 2, self.prim, self.maxSize+1)
        
        # Optimization: double the size of the anti-log table so that we don't need to mod 255 to
        # stay inside the bounds (because we will mainly use this table for the multiplication of two GF numbers, no more).
        for i in range(self.maxSize, 2*(self.maxSize+1)):
            self.gf_exp[i] = self.gf_exp[i - self.maxSize]
    
    # Init Method
    # Initialize GF Field of GF(2^n) where n is a positive integer and is the number of binary digits
    def __init__(self, n):
        self.n = n
        self.prim = self.PrimChoices[n] # Set an n-th degree primitive polynomial
        self.maxSize = 2 ** n - 1 # 2^n - 1 is the max size of each element
        self.__initLogTables(self.prim)       


    # Below are the scalar operators of Galois Fields, all run in O(1)

    def add(self, a, b):
        return a ^ b

    def subtract(self, a, b):
        return a ^ b            # Subtraction is the same as addition in Galois Fields

    def multiply(self, a, b):
        if a==0 or b==0:
            return 0
        return self.gf_exp[self.gf_log[a] + self.gf_log[b]] # Since exp(log(a)+log(b)) = a*b, this is O(1) multiplication

    def divide(self, a, b):
        if b==0:
            raise ZeroDivisionError()
        if a==0:
            return 0
        return self.gf_exp[(self.gf_log[a] - self.gf_log[b]) % 255] # Since exp(log(a)-log(b)) = a/b, this is O(1) division

    
    # Below are the polynomial operators of Galois Fields
    # Polynomials in Python are represented as lists, where the leftmost item in the list is the coefficient of the highest degree
    # e.g. 5x^2 - 3x + 12 would be represented as [5, -3, 12]
    
    # poly_scale - multiplies a polynomial (p) whose coefficients are GF elements by a GF scalar element (x)
    # Runs in O(n) where where n is the degree of polynomial p
    # Returns polynomial r
    def poly_scale(self, p, x):
        r = [0] * len(p)
        for i in range(0, len(p)):
            r[i] = self.multiply(p[i], x)
        return r

    # poly_add - adds two polynomials whose coefficients are GF elements using the usual XOR
    # Runs in O(n+k) where n is degree of polynomial p and k is degree of polynomial q
    # Returns polynomial r
    def poly_add(self, p, q):
        r = [0] * max(len(p),len(q))
        for i in range(0,len(p)):
            r[i+len(r)-len(p)] = p[i]
        for i in range(0,len(q)):
            r[i+len(r)-len(q)] ^= q[i]
        return r

    # poly_multiply - multiply two polynomials (p and q)
    # Runs in O(n*k) where n is degree of polynomial p and k is degree of polynomial q (assuming O(1) multiplication)
    # Returns polynomial r
    def poly_multiply(self, p, q):
        r = [0] * (len(p)+len(q)-1)
        # Compute the polynomial multiplication (just like the outer product of two vectors,
        # we multiply each coefficients of p with all coefficients of q)
        for j in range(0, len(q)):
            for i in range(0, len(p)):
                r[i+j] ^= self.multiply(p[i], q[j]) # equivalent to: r[i + j] = gf_add(r[i+j], gf_mul(p[i], q[j]))
                                                            # -- you can see it's your usual polynomial multiplication
        return r

    # poly_evalute - Evaluates a polynomial (p), whose coefficients are GF elements, at a particular GF element (x)
    # Horner's Method for polynomial evaluation is used to avoid calculating powers of x - runs in O(n) where n is the degree of the polynomial
    # Returns scalar y
    def poly_evaluate(self, p, x):
        y = p[0]
        for i in range(1, len(p)):
            y = self.multiply(y, x) ^ p[i]
        return y

    # poly_divide - divides two polynomials (p / q) whose coefficients are GF elements 
    # This is the most complex operation - implements extended synthetic division https://en.wikipedia.org/wiki/Synthetic_division#Expanded_synthetic_division
    # Runs in O(n*k) where n is degree of polynomial p and k is degree of polynomial q
    # Returns the polynomial quotient and remainder
    def poly_divide(self, p, q):
        out = list(p) # copy the dividend
        for i in range(0, len(p) - (len(q)-1)):
            coef = out[i] #prechaching
            if coef != 0:
                for j in range(1, len(q)): # in synthetic division we always skip the 1st coefficient of the divisor because its only used to normalize the divident effect
                    if q[j] != 0: # log(0) is undefined
                        out[i+j] ^= self.multiply(q[j], coef)

        # The resulting msg_out contains both the quotient and the remainder, the remainder being the size of the divisor
        # (the remainder has necessarily the same degree as the divisor -- not length but degree == length-1 -- since it's
        # what we couldn't divide from the dividend), so we compute the index where this separation is, and return the quotient and remainder.
        seperator = -(len(q)-1)
        return out[:seperator], out[seperator:] # return quotient, remainder
