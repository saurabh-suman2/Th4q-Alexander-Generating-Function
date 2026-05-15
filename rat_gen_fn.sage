# 1. Setup the rings
R_t.<t> = QQ[]
R_x.<x> = PolynomialRing(R_t)

# 2. Input the coefficients from the L_even output (c_8 down to c_0)
c8 = t^2
c7 = -t^6 + 4*t^5 - 7*t^4 + 8*t^3 - 7*t^2 + 4*t - 1
c6 = 3*t^8 - 16*t^7 + 38*t^6 - 64*t^5 + 74*t^4 - 64*t^3 + 38*t^2 - 16*t + 3
c5 = -3*t^10 + 20*t^9 - 62*t^8 + 124*t^7 - 183*t^6 + 208*t^5 - 183*t^4 + 124*t^3 - 62*t^2 + 20*t - 3
c4 = t^12 - 8*t^11 + 33*t^10 - 88*t^9 + 175*t^8 - 256*t^7 + 292*t^6 - 256*t^5 + 175*t^4 - 88*t^3 + 33*t^2 - 8*t + 1
c3 = -3*t^12 + 20*t^11 - 62*t^10 + 124*t^9 - 183*t^8 + 208*t^7 - 183*t^6 + 124*t^5 - 62*t^4 + 20*t^3 - 3*t^2
c2 = 3*t^12 - 16*t^11 + 38*t^10 - 64*t^9 + 74*t^8 - 64*t^7 + 38*t^6 - 16*t^5 + 3*t^4
c1 = -t^12 + 4*t^11 - 7*t^10 + 8*t^9 - 7*t^8 + 4*t^7 - t^6
c0 = t^10

# 3. Construct the Denominator D(x,t)
D = c8 + c7*x + c6*x^2 + c5*x^3 + c4*x^4 + c3*x^5 + c2*x^6 + c1*x^7 + c0*x^8

# 4. Input the first 8 actual Alexander polynomials (q=3 to q=17)
polys = []
for q in range(3, 19, 2):  
    word = [1, -2, 3] * q
    L = Link(BraidGroup(4)(word))
    polys.append(L.alexander_polynomial())

# 5. Construct the truncated series G(x)
G_series = sum(polys[i] * x^i for i in range(8))

# 6. Calculate Numerator N(x) = G(x) * D(x) mod x^8
N_full = G_series * D

# Truncate to degree 7 in x using the correct polynomial indexing [i]
N_truncated = sum(N_full[i] * x^i for i in range(8))

print("The Exact Numerator N(x,t) is:")
print("-" * 60)
print(N_truncated)