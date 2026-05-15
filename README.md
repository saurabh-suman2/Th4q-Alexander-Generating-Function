# Th(4,q) Alexander Polynomial Generating Function

Computational supplement for the preprint: *"Rational Generating Functions and Trapezoidality for the Mixed-Sign Turk's Head Family Th(4,q)"*.

This repository contains the SageMath scripts used to algebraically derive the explicit generating function and computationally verify the structural theorems presented in the manuscript.

## Repository Contents

* `matrix_invariants.sage`: Generates initial empirical Alexander polynomials for the odd-$q$ subsequence and demonstrates the singularity/failure of low-order matrix solvers.
* `recurrence_operator.sage`: Computes the exact even-step annihilator from the Burau matrix characteristic polynomial and its exterior square.
* `cauchy_convolution.sage`: Derives the explicit numerator polynomials $N(x,t)$ via discrete Cauchy convolution of the unnormalized sequence.
* `reproduce_paper_results.sage`: The master test suite. It uses strict assertions to computationally verify the characteristic polynomials, the order-8 recurrence relation, and the exact topological match with standard knot databases for $q \le 35$.

## Verification

To run the master verification suite and computationally prove the core theorems, ensure SageMath is installed and execute:

```bash
sage reproduce_paper_results.sage
