# matrix_invariants.sage
# Author: Suman Saurabh
# Extracts empirical Alexander polynomials for Th(4,q) and solves for the recurrence.

from sage.groups.braid import BraidGroup
from sage.knots.link import Link

B = BraidGroup(4)
block = [1, -2, 3]

print("Generating empirical polynomials for odd q...")
polys = []
for q in range(3, 20, 2):
    L = Link(B(block * q))
    if L.number_of_components() == 1:
        polys.append(L.alexander_polynomial())

print(f"Generated {len(polys)} polynomials.")

# Setup system M * C = -V to solve for recurrence coefficients
R.<t> = FunctionField(QQ)

matrix_entries = [
    [polys[0], polys[1], polys[2], polys[3]],
    [polys[1], polys[2], polys[3], polys[4]],
    [polys[2], polys[3], polys[4], polys[5]],
    [polys[3], polys[4], polys[5], polys[6]]
]
vector_entries = [-polys[4], -polys[5], -polys[6], -polys[7]]

M = Matrix(R, matrix_entries)
V = vector(R, vector_entries)

try:
    C = M.solve_right(V)
    print("\nEmpirical Recurrence Coefficients:")
    for i, coeff in enumerate(C):
        print(f"c_{i}(t) = {coeff.factor()}")
except ValueError:
    print("System is singular; higher-order recurrence required.")