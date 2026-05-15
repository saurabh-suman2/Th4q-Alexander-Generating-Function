# cauchy_convolution.sage
# Author: Suman Saurabh
# Derives the rational generating function numerator via discrete convolution.

R_t.<t> = QQ[]
F_t = FractionField(R_t)
R_x.<x> = PolynomialRing(F_t)
R_E.<E> = PolynomialRing(F_t)

# Denominator coefficients extracted from R(Y) (Properly reversed!)
C = [
    t^2,
    -t^6 + 4*t^5 - 7*t^4 + 8*t^3 - 7*t^2 + 4*t - 1,
    3*t^8 - 16*t^7 + 38*t^6 - 64*t^5 + 74*t^4 - 64*t^3 + 38*t^2 - 16*t + 3,
    -3*t^10 + 20*t^9 - 62*t^8 + 124*t^7 - 183*t^6 + 208*t^5 - 183*t^4 + 124*t^3 - 62*t^2 + 20*t - 3,
    t^12 - 8*t^11 + 33*t^10 - 88*t^9 + 175*t^8 - 256*t^7 + 292*t^6 - 256*t^5 + 175*t^4 - 88*t^3 + 33*t^2 - 8*t + 1,
    -3*t^12 + 20*t^11 - 62*t^10 + 124*t^9 - 183*t^8 + 208*t^7 - 183*t^6 + 124*t^5 - 62*t^4 + 20*t^3 - 3*t^2,
    3*t^12 - 16*t^11 + 38*t^10 - 64*t^9 + 74*t^8 - 64*t^7 + 38*t^6 - 16*t^5 + 3*t^4,
    -t^12 + 4*t^11 - 7*t^10 + 8*t^9 - 7*t^8 + 4*t^7 - t^6,
    t^10
]

D = sum(C[i] * x^i for i in range(9))

# Generate unnormalized initial sequence terms from the Burau matrix
print("Generating initial unnormalized polynomials...")
M = Matrix(F_t, [
    [1-t, 1-1/t, -1],
    [1,   1-1/t, -1],
    [0,   t,     -t]
])

H = []
for k in range(8): 
    q = 2*k + 3
    F_q = (M^q).charpoly(E).subs(E=1)
    H.append(F_q / (1 + t + t^2 + t^3))

G_series = sum(H[i] * x^i for i in range(8))

# N(x) = G(x) * D(x) mod x^8
N_full = G_series * D
N_truncated = sum(N_full[i] * x^i for i in range(8))

print("\nExplicit Numerator N(x,t):")
print(N_truncated)