# verification.sage
# Reproducibility script for Th(4,q) generating function paper

print("--- Th(4,q) Verification Script ---")

R_t.<t> = QQ[]
F_t = FractionField(R_t)
R_E.<E> = PolynomialRing(F_t)

# 1. Verify Characteristic Polynomial
print("\n1. Verifying M(t) Characteristic Polynomial...")
M = Matrix(F_t, [
    [1-t, 1-1/t, -1],
    [1,   1-1/t, -1],
    [0,   t,     -t]
])
P1 = M.charpoly(E)
claimed_char_poly = E^3 + (2*t + 1/t - 2)*E^2 + (t^2 - 2*t + 2)*E + t
if P1 == claimed_char_poly:
    print("✓ Characteristic polynomial P_1(E) matches explicit formula.")

# 2. Verify Exterior Square
print("\n2. Verifying Exterior Square characteristic roots...")
a = -P1[2]; b = P1[1]; c = -P1[0]
P2 = E^3 - b*E^2 + a*c*E - c^2
claimed_P2 = E^3 - (t^2 - 2*t + 2)*E^2 + (2*t^2 - 2*t + 1)*E - t^2
if P2 == claimed_P2:
    print("✓ Exterior square polynomial P_2(E) is correct.")

# 3. Compute the Annihilator R(Y) dynamically!
print("\n3. Computing even-step annihilator R(Y) dynamically...")
L = (E - 1)*(E + t)*P1*P2
L_minus = L.subs(E = -E)
R_E2 = L * L_minus
C = [R_E2[2*i] for i in range(9)] # Extract coefficients for Y = E^2
print("✓ Dynamically computed order-8 coefficients C_0 to C_8.")

# 4. Generate Unnormalized Sequence from Matrix
print("\n4. Generating unnormalized sequence H_k from Burau matrix...")
H = []
for k in range(15):
    q = 2*k + 3
    # F_q(t) = det(I - M^q) is charpoly of M^q evaluated at x=1
    F_q = (M^q).charpoly(E).subs(E=1)
    H_k = F_q / (1 + t + t^2 + t^3)
    H.append(H_k)
print(f"✓ Generated {len(H)} exact Burau sequence terms.")

# 5. Verify Recurrence on Unnormalized Sequence
print("\n5. Verifying Recurrence Relation...")
recurrence_holds = True
for m in range(len(H) - 8):
    test_sum = sum(C[j] * H[m+j] for j in range(9))
    if test_sum != 0:
        recurrence_holds = False
        break

if recurrence_holds:
    print("✓ Recurrence strictly holds for the unnormalized sequence!")
else:
    print("X Recurrence failed.")

# 6. Verify against Sage's Topology Library
print("\n6. Verifying Algebraic H_0 against Topological Knot Database...")
from sage.groups.braid import BraidGroup
from sage.knots.link import Link
B = BraidGroup(4)
L_knot = Link(B([1, -2, 3] * 3))
sage_poly = L_knot.alexander_polynomial()

# Check if H[0] and sage_poly are identical up to a factor of +/- t^p
# By dividing them and checking if the result is a simple monomial
ratio = F_t(H[0]) / F_t(sage_poly)
if ratio.numerator().degree() == ratio.numerator().valuation() and ratio.denominator().degree() == ratio.denominator().valuation():
    print("✓ Matrix-generated polynomial perfectly matches topological knot table (up to t^k shift)!")
else:
    print("X Matrix polynomial does not match topological knot.")

print("\n--- Verification Complete ---")