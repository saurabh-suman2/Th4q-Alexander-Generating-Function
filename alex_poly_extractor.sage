R_t.<t> = QQ[]
F_t = FractionField(R_t)
R_E.<E> = PolynomialRing(F_t)

# --- USER INPUTS ---
TARGET_Q = 7

M = Matrix(F_t, [
    [1-1/t, 0, -1],
    [t,     0, -t],
    [0,     t, -t]
])

den_coeffs = [
    t^4,
    -2*t^7 + 7*t^6 - 10*t^5 + 7*t^4 - 2*t^3,
    -t^9 + 6*t^8 - 17*t^7 + 22*t^6 - 17*t^5 + 6*t^4 - t^3,
    -2*t^9 + 7*t^8 - 10*t^7 + 7*t^6 - 2*t^5,
    t^8
]
# -------------------

if TARGET_Q % 2 == 0 or TARGET_Q < 3:
    raise ValueError("Target q must be an odd integer >= 3")

k_target = (TARGET_Q - 3) // 2
order = len(den_coeffs) - 1

norm = 1 + t + t^2 + t^3
H = []

for k in range(order):
    q = 2*k + 3
    F_q = (M^q).charpoly(E).subs(E=1)
    H.append(F_q / norm)

if k_target < order:
    poly = H[k_target]
else:
    d0 = den_coeffs[0]
    for n in range(order, k_target + 1):
        H_next = -sum(den_coeffs[j] * H[n-j] for j in range(1, order + 1)) / d0
        H.append(H_next)
    poly = H[-1]

print(f"Alexander Polynomial for q={TARGET_Q}:\n")
print(poly)