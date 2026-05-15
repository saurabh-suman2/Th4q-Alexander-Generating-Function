# 1. Define t as a rational function
R_t.<t> = QQ[]
F_t = FractionField(R_t)

# 2. Define E as a polynomial variable with coefficients in t
R_E.<E> = F_t[]

# 3. Define the components of the annihilator L(E)
P1 = t*E^3 + (2*t^2 - 2*t + 1)*E^2 + (t^3 - 2*t^2 + 2*t)*E + t^2
P2 = E^3 - (t^2 - 2*t + 2)*E^2 + (2*t^2 - 2*t + 1)*E - t^2

L = (E - 1) * (E + t) * P1 * P2

# 4. Calculate L(E) * L(-E)
# In a univariate ring, we can just evaluate the polynomial at -E
L_neg = L(-E)

# 5. Multiply them together
L_even = L * L_neg

print("The even-powered annihilator L(E) * L(-E) is:")
print("-" * 60)
print(L_even)