# Computational Verification Suite for 4-Strand Turk's Head Knots

This repository contains the SageMath and Python scripts used to computationally verify the algebraic identities, rational generating functions, and discrete sequence bounds presented in the manuscript *Rational Generating Functions and Hypergeometric Reduction of Alexander Polynomials for 4-Strand Turk's Head Knots*.

The proofs in the manuscript hold analytically. These scripts provide exact-arithmetic validation for specific finite cases of the structural theorems and explicitly compute the polynomial expansions recorded in the appendices.

## Repository Contents

### Section 2: Annihilating Operators and Generating Functions

* **`generating_function_denominator.sage`**
Derives the exact denominator polynomial $D(x,t)$ for the rational generating function. It constructs the order-8 annihilating operator from the reduced Burau representation using the even-step reflection $R(E) = L(E)L(-E)$, confirming the coefficients recorded in Appendix A.

### Section 3: Spectral Factorization and Chebyshev Structure

* **`resultant_expansion.sage`**
Executes the multivariable resultant elimination over the reciprocal constraint $w^2 - uw + 1 = 0$. This script formally computes the algebraic expansion that verifies the polynomial identity $R(x, u) = -x^3(u - v)(u - v + 2)^2$ utilized in Lemma 3.5 and Appendix B.
* **`verify_spectral_factorization.sage`**
Symbolically and numerically verifies Theorem 3.7. It constructs the explicit trigonometric product representation of $A_{2n+1}(z)$ and cross-verifies the expanded coefficients against the direct topological determinant expansions for $n \le 5$.

### Sections 4 & 5: Combinatorics and Wronskian Bounds

* **`empirical_wronskian_check.py`**
Evaluates the discrete Wronskian $\Delta_{n,k}$ utilizing the terminating ${}_4F_3$ hypergeometric binomial convolution (Theorem 4.3). This script uses arbitrary-precision integer arithmetic to empirically confirm strict log-concavity across the finite computational gap up to $n=51$ (crossing length $q=103$), demonstrating discrete structural positivity where global continuous Taylor bounds are obstructed.

## Requirements

* **SageMath** (v10.0+ recommended) for symbolic matrix evaluations, resultant algebraic geometry, and Laurent polynomial structures.
* **Python 3** for executing the arbitrary-precision integer combinatorial sums.
