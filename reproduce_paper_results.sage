# reproduce_paper_results.sage
# Author: Suman Saurabh
# Master verification script for the theorems in the Th(4,q) preprint.

from sage.groups.braid import BraidGroup
from sage.knots.link import Link

print("Starting Th(4,q) Verification Suite...\n")

R_t.<t> = QQ[]
F_t = FractionField(R_t)
R_E.<E> = PolynomialRing(F_t)

print("[1/4] Checking M(t) characteristic polynomial...")
M = Matrix(F_t, [
    [1-t, 1-1/t, -1],
    [1,   1-1/t, -1],
    [0,   t,     -t]
])
P1 = M.charpoly(E)
expected_P1 = E^3 + (2*t + 1/t - 2)*E^2 + (t^2 - 2*t + 2)*E + t
assert P1 == expected_P1, "Mismatch in P1(E)"
print("  -> P1(E) matched.")

print("[2/4] Checking Exterior Square roots (P2)...")
a, b, c = -P1[2], P1[1], -P1[0]
P2 = E^3 - b*E^2 + a*c*E - c^2
expected_P2 = E^3 - (t^2 - 2*t + 2)*E^2 + (2*t^2 - 2*t + 1)*E - t^2
assert P2 == expected_P2, "Mismatch in P2(E)"
print("  -> P2(E) matched.")

print("[3/4] Testing order-8 recurrence on unnormalized Burau sequence...")
L = (E - 1)*(E + t)*P1*P2
R_E2 = L * L.subs(E=-E)
C = [R_E2[2*i] for i in range(9)] 

H = []
for k in range(15):
    q = 2*k + 3
    F_q = (M^q).charpoly(E).subs(E=1)
    H.append(F_q / (1 + t + t^2 + t^3))

for m in range(len(H) - 8):
    assert sum(C[j] * H[m+j] for j in range(9)) == 0, f"Recurrence failed at m={m}"
print("  -> Recurrence holds identically for all computed terms.")

print("[4/4] Verifying matrix normalization against Sage knot database...")
B = BraidGroup(4)
L_knot = Link(B([1, -2, 3] * 3))
sage_poly = L_knot.alexander_polynomial()

ratio = F_t(H[0]) / F_t(sage_poly)
assert ratio.numerator().degree() == ratio.numerator().valuation(), "Topological mismatch"
assert ratio.denominator().degree() == ratio.denominator().valuation(), "Topological mismatch"
print("  -> Matrix-generated polynomial matches standard Alexander invariant.")

print("\nAll theorems computationally verified.")