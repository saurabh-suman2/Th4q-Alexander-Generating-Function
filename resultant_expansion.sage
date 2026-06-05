"""
resultant_expansion.sage

Executes the resultant computation to eliminate the Laurent parameter,
proving the spectral resultant identity R(x, u) = -x^3(u - v)(u - v + 2)^2.
"""

from sage.all import *

def verify_resultant_expansion():
    R_poly.<x, w, u> = PolynomialRing(QQ)

    # 1. Clear Laurent denominator: w * chi_M(x, -w)
    w_chi = w*x^3 - (2*w^2 + 2*w + 1)*x^2 + (w^3 + 2*w^2 + 2*w)*x - w^2
    constraint = w^2 - u*w + 1

    # 2. Compute resultant
    res = w_chi.resultant(constraint, w)
    
    print("Raw Resultant Expansion R(x, u):")
    print(res)

    # 3. Verify Identity: -x^3(u - v)(u - v + 2)^2 where v = x + 1/x
    # Substituting v = (x^2+1)/x yields the expanded polynomial ring equivalent:
    theoretical = -(u*x - x^2 - 1) * (u*x - x^2 + 2*x - 1)^2
    
    print(f"\nIdentity Match [R(x,u) == -x^3(u-v)(u-v+2)^2]: {res == theoretical}")

if __name__ == "__main__":
    verify_resultant_expansion()