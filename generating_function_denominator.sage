"""
generating_function_denominator.sage

Derives the exact denominator polynomial D(x,t) for the rational generating 
function of Th(4, 2n+1) via the even-step reflection of the Burau annihilator.
"""
"""
generating_function_denominator.sage
"""
from sage.all import *

def compute_generating_function_denominator():
    R_laurent.<t> = LaurentPolynomialRing(ZZ)
    S.<E> = PolynomialRing(R_laurent)

    # 1. Base Annihilators
    P1 = E^3 + (2*t + t^-1 - 2)*E^2 + (t^2 - 2*t + 2)*E + t
    P2 = E^3 - (t^2 - 2*t + 2)*E^2 + (2*t^2 - 2*t + 1)*E - t^2
    L = (E - 1) * (E + t) * P1 * P2

    # 2. Even-Step Transformation R(E) = L(E)L(-E)
    R_op = L * L(-E)

    # 3. Extract coeffs and shift by t^2 to match Appendix A normalization
    coeffs = R_op.coefficients(sparse=False)
    even_coeffs = [coeffs[2*i] * (t^2) for i in range(9)]
    
    # Normalize sign
    sign_correction = 1 if even_coeffs[-1] > 0 else -1
    
    print("Generating Function Denominator Coefficients D(x,t) [Appendix A]:\n")
    for i, c in enumerate(even_coeffs):
        index = 8 - i
        print(f"d_{index}(t) = {c * sign_correction}")

if __name__ == "__main__":
    compute_generating_function_denominator()