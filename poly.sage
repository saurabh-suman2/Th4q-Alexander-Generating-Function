# 1. Initialize the Braid Group on 4 strands
B = BraidGroup(4)

# 2. Define the fundamental braid word block: sigma_1 * sigma_2^-1 * sigma_3
# In Sage, negative numbers denote inverses.
block = [1, -2, 3]

print("Alexander Polynomials for Th(4,q) with mixed-sign word:")
print("-" * 60)

# 3. Loop through odd values of q to ensure we get knots, not links
for q in range(3, 14, 2):
    # Repeat the block q times using Python list multiplication
    word = block * q
    
    # Create the braid and convert it to a Link closure
    braid = B(word)
    L = Link(braid)
    
    # Verify it forms a single-component knot
    if L.number_of_components() == 1:
        poly = L.alexander_polynomial()
        print(f"q = {q:2} | poly = {poly}")
    else:
        print(f"q = {q:2} | Forms a link with {L.number_of_components()} components.")

print("-" * 60)
print("Extracting Exact Polynomial Recurrence:")

# We need the first 8 polynomials to build a full matrix equation for 4 unknowns
# The previous loop generated up to q=13 (which is 6 polynomials: k=1 to 6)
# Let's generate two more just to be safe
polys = []
for q in range(3, 20, 2):  # Generates 9 polynomials
    word = block * q
    L = Link(B(word))
    polys.append(L.alexander_polynomial())

# Set up the rational function field
R.<t> = FunctionField(QQ)

# Build the matrix of shifted polynomials
# We want to solve M * C = -V, where C = [c_0, c_1, c_2, c_3]^T
# Row 0: [ P_0, P_1, P_2, P_3 ] * C = -P_4
# Row 1: [ P_1, P_2, P_3, P_4 ] * C = -P_5
# Row 2: [ P_2, P_3, P_4, P_5 ] * C = -P_6
# Row 3: [ P_3, P_4, P_5, P_6 ] * C = -P_7

matrix_entries = [
    [polys[0], polys[1], polys[2], polys[3]],
    [polys[1], polys[2], polys[3], polys[4]],
    [polys[2], polys[3], polys[4], polys[5]],
    [polys[3], polys[4], polys[5], polys[6]]
]

vector_entries = [-polys[4], -polys[5], -polys[6], -polys[7]]

M = Matrix(R, matrix_entries)
V = vector(R, vector_entries)

# Solve the system
try:
    C = M.solve_right(V)
    print("Success! The exact polynomial coefficients are:")
    print(f"c_0(t) = {C[0].factor()}")
    print(f"c_1(t) = {C[1].factor()}")
    print(f"c_2(t) = {C[2].factor()}")
    print(f"c_3(t) = {C[3].factor()}")
except ValueError:
    print("The system is singular or requires a higher-order recurrence.")