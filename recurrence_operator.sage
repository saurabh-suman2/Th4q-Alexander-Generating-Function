# recurrence_operator.sage
# Author: Suman Saurabh
# Calculates the even-step annihilator L(E)L(-E) for the odd-q subsequence.

R_t.<t> = QQ[]
F_t = FractionField(R_t)
R_E.<E> = F_t[]

# Components of the minimal annihilator L(E)
P1 = t*E^3 + (2*t^2 - 2*t + 1)*E^2 + (t^3 - 2*t^2 + 2*t)*E + t^2
P2 = E^3 - (t^2 - 2*t + 2)*E^2 + (2*t^2 - 2*t + 1)*E - t^2

L = (E - 1) * (E + t) * P1 * P2

# Even-step transformation to filter for knots
L_even = L * L(-E)

print("Even-powered annihilator R(Y):")
print(L_even)