"""
empirical_wronskian_check.sage

Uses the terminating 4F3 hypergeometric summation (binomial convolution)
to empirically verify the discrete Wronskian positivity \Delta_{n,k} > 0.
"""

from sage.all import *

def B_coeff(n, k):
    """Computes the hypergeometric summation B_k^(n) using strict integer arithmetic."""
    if k < 0 or n < 0:
        return 0
    total = 0
    for j in range(floor(k/2) + 1):
        term1 = binomial(k - j, j)
        term2 = 2^(k - 2*j)
        term3 = binomial(n - j, k - 2*j)
        total += term1 * term2 * term3
    return total

def a_coeff(n, k):
    """Computes the final coefficient a_k^(n) via binomial convolution."""
    if k < 0 or k > 2*n:
        return 0
    return B_coeff(n, k) + B_coeff(n - 1, k - 1)

def verify_discrete_log_concavity(n_max):
    print(f"--- Running Wronskian Positivity Check up to n = {n_max} ---")
    
    all_positive = True
    
    for n in range(1, n_max + 1):
        for k in range(1, 2*n):
            ak = a_coeff(n, k)
            ak_minus = a_coeff(n, k - 1)
            ak_plus = a_coeff(n, k + 1)
            
            wronskian = ak^2 - (ak_minus * ak_plus)
            
            if wronskian <= 0:
                print(f"Log-concavity FAILED at n={n}, k={k}. Wronskian = {wronskian}")
                all_positive = False
                
    if all_positive:
        print(f"Discrete Wronskian is strictly positive for all valid k up to n = {n_max}.")
        
if __name__ == "__main__":
    # Verifies the Wronskian up to q = 51
    verify_discrete_log_concavity(25)