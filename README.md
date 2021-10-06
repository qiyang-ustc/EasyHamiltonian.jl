# EasyHamiltonian.jl

The easiest way to construct a Hamiltonian(Matrix Form or MPO Form).

## This package is under development.

## Motivation

The module is just a packup for ITensor.AutoMPO. Though, this pack could be quite helpful when users want to simulate their own hamiltonian in an innovative algorithm package (such as DMRG, CTMRG, VUMPS).

Usually, an algorithm package should offer some basic hamiltonian to perform their tests. Each of these package should have a file named "hamiltonian.jl", and if others want to modify the hamiltonian, they may have to devlop these packages and modify the "hamiltonian.jl" by hands.

We want to use this package to unify all these "hamiltonian.jl" at all. Algorithm designer do not need to write their own "hamiltonian.jl". Instead, they only need to import this package.

Type *AbstractHamiltonian* should be accepted by all different algorithms. So package user could import this package and feed their *AbstractHamiltonian* into algorithm.

## Structure of EasyHamiltonian.jl

### API for users

Functions to construct *AbstractHamiltonian*. The API should looks like:

``` julia
    hamiltonian = HeisenbergXYZ(1.0,1.0,1.0)
```

### API for algorithm developers

Offer tools to construct a *AbstractHamiltonian* to Matrix or MPO to be used in algorithm.

``` julia
    h = Matrix(hamiltonian);
    @show eigen(h)
```

## Contribution

If you have realize some hamiltonian, it would be helpful(and very easy) to contribute your hamiltonian to this package.