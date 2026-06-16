# Computational Verification Suite for 4-Strand Turk's Head Knots

[![arXiv](https://img.shields.io/badge/arXiv-2606.11301-b31b1b.svg)](https://arxiv.org/abs/2606.11301)

This repository contains the computational scripts used to generate the results, evaluate representations, and verify algebraic identities presented in the paper **[Spectral Factorization and Hypergeometric Representations of the Alexander Polynomials of $Th(4,2n+1)$](https://arxiv.org/abs/2606.11301)**.

The proofs in the manuscript hold analytically. These scripts provide exact-arithmetic validation for specific finite cases of the structural theorems, compute the polynomial expansions recorded in the appendices, and handle the matrix and combinatorial evaluations underlying the knot invariants.

## Related Work
For the application of this computational framework to prove Fox's Trapezoidal Conjecture for this knot family, see the follow-up manuscript **[Fox's Trapezoidal Conjecture for the Four-Strand Turk's Head Knots](https://arxiv.org/pdf/2606.15256)** and its associated [verification repository](https://github.com/saurabh-suman2/fox_conjecture_Th4q).

---

## Repository Contents

### I. Foundational Matrix Operations
* **`matrix_invriants.sage`**
  Computes the reduced Burau representation matrices for the standard braid generators of $Th(4,2n+1)$. Evaluates the characteristic polynomial, principal minors, and trace invariants of the fundamental matrix block $M(t)$ to establish the baseline determinant sequences prior to the shift operator reduction.

### II. Annihilating Operators and Generating Functions
* **`generating_function_denominator.sage`**
  Derives the exact denominator polynomial $D(x,t)$ for the rational generating function. It constructs the order-8 annihilating operator from the reduced Burau representation using the even-step reflection $R(E)=L(E)L(-E)$, confirming the coefficients recorded in Appendix A.

### III. Spectral Factorization and Chebyshev Structure
* **`resultant_expansion.sage`**
  Executes the multivariable resultant elimination over the reciprocal constraint $w^2-uw+1=0$. This script formally computes the algebraic expansion that verifies the polynomial identity $R(x,u)=-x^3(u-v)(u-v+2)^2$ utilized in the spectral factorization.
* **`verify_spectral_factorization.sage`**
  Symbolically and numerically verifies the Chebyshev spectral factorization. It constructs the explicit trigonometric product representation of $A_{2n+1}(z)$ and cross-verifies the expanded coefficients against the direct topological determinant expansions.

### IV. Combinatorics and Convolutions
* **`Cauchy_convolution`**
  Derives the explicit numerator polynomials $N(x,t)$ via discrete Cauchy convolution of the unnormalized sequence.
* **`recurrence_operator.sage`**
  Computes the exact even-step annihilator from the Burau matrix characteristic polynomial and its exterior square.

### V. Empirical Wronskian Bounds
* **`empirical_wronskian_check.py`**
  Evaluates the discrete Wronskian $\Delta_{n,k}$ utilizing the terminating ${}_4F_3$ hypergeometric binomial convolution. This script uses arbitrary-precision integer arithmetic to empirically confirm strict log-concavity across the finite computational gap up to $n=51$ (crossing length $q=103$), demonstrating discrete structural positivity where global continuous Taylor bounds are obstructed.

---

## Requirements
* **SageMath** (v10.0+ recommended) for symbolic matrix evaluations, resultant algebraic geometry, and Laurent polynomial structures.
* **Python 3** for executing the arbitrary-precision integer combinatorial sums.

## Citation
If you utilize this code or the associated mathematical framework in your work, please cite the paper:

```bibtex
@article{saurabh2026spectral,
  title={Spectral Factorization and Hypergeometric Representations of the Alexander Polynomials of $Th(4,2n+1)$},
  author={Saurabh, Suman},
  journal={arXiv preprint arXiv:2606.11301},
  year={2026}
}
