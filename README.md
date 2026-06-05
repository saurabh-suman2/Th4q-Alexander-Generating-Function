# Computational Verification Suite for 4-Strand Turk's Head Knots

This repository contains the computational scripts used to evaluate representations, verify algebraic identities, and empirically test discrete bounds presented in the manuscript *Rational Generating Functions and Hypergeometric Reduction of Alexander Polynomials for 4-Strand Turk's Head Knots*. 

The proofs in the manuscript hold analytically. These scripts provide exact-arithmetic validation for specific finite cases of the structural theorems, compute the polynomial expansions recorded in the appendices, and handle the matrix and combinatorial evaluations underlying the knot invariants.

## Repository Contents

### I. Foundational Matrix Operations
* **`matrix_inv`** (and related matrix scripts)
  Computes the reduced Burau representation matrices for the standard braid generators of $Th(4, 2n+1)$. Evaluates the characteristic polynomial, principal minors, and trace invariants of the fundamental matrix block $M(t)$ to establish the baseline determinant sequences prior to the shift operator reduction.

### II. Annihilating Operators and Generating Functions
* **`generating_function_denominator.sage`**
  Derives the exact denominator polynomial $D(x,t)$ for the rational generating function. It constructs the order-8 annihilating operator from the reduced Burau representation using the even-step reflection $R(E) = L(E)L(-E)$, confirming the coefficients recorded in Appendix A.

### III. Spectral Factorization and Chebyshev Structure
* **`resultant_expansion.sage`**
  Executes the multivariable resultant elimination over the reciprocal constraint $w^2 - uw + 1 = 0$. This script formally computes the algebraic expansion that verifies the polynomial identity $R(x, u) = -x^3(u - v)(u - v + 2)^2$ utilized in the spectral factorization.
* **`verify_spectral_factorization.sage`**
  Symbolically and numerically verifies the Chebyshev spectral factorization. It constructs the explicit trigonometric product representation of $A_{2n+1}(z)$ and cross-verifies the expanded coefficients against the direct topological determinant expansions.

### IV. Combinatorics and Convolutions
* **`Cauchy_conv`** (and related sequence scripts)
  Implements the discrete Cauchy convolution of the extracted polynomial sequences. Used to analyze the initial sequence interactions, isolate the algebraic cross-terms, and test structural properties of the coefficients prior to the hypergeometric formulation.

### V. Empirical Wronskian Bounds
* **`empirical_wronskian_check.py`**
  Evaluates the discrete Wronskian $\Delta_{n,k}$ utilizing the terminating ${}_4F_3$ hypergeometric binomial convolution. This script uses arbitrary-precision integer arithmetic to empirically confirm strict log-concavity across the finite computational gap up to $n=51$ (crossing length $q=103$), demonstrating discrete structural positivity where global continuous Taylor bounds are obstructed.

## Requirements
* **SageMath** (v10.0+ recommended) for symbolic matrix evaluations, resultant algebraic geometry, and Laurent polynomial structures.
* **Python 3** for executing the arbitrary-precision integer combinatorial sums.
