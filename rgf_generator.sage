R_t.<t> = QQ[]
F_t = FractionField(R_t)
R_E.<E> = PolynomialRing(F_t)
R_x.<x> = PolynomialRing(F_t)

# Base matrix for (\sigma_1^{-1} \sigma_2 \sigma_3)^q
M = Matrix(F_t, [
    [1-1/t, 0, -1],
    [t,     0, -t],
    [0,     t, -t]
])

# Extract invariants
P1 = M.charpoly(E)
a = M.trace()
b = P1[1]
c = M.det()

# Exterior square charpoly and global annihilator
P2 = E^3 - b*E^2 + a*c*E - c^2
L_E = (E - 1) * (E - c) * P1 * P2

# Even-step transformation
R_E2 = L_E * L_E.subs(E == -E)
C = [R_E2[2*i] for i in range(9)]

# Denominator (reversed annihilator coefficients)
D_x = sum(C[8-j] * x^j for j in range(9))

# Initial sequence values H_0 to H_7
H = []
norm = 1 + t + t^2 + t^3
for k in range(8):
    q = 2*k + 3
    F_q = (M^q).charpoly(E).subs(E=1)
    H.append(F_q / norm)

# Cauchy convolution for numerator
N_x = sum(sum(C[8-j] * H[n-j] for j in range(n + 1)) * x^n for n in range(8))

print("Denominator D(x,t):")
print(D_x)
print("\nNumerator N(x,t):")
print(N_x)