```@meta
CurrentModule = EasyHamiltonian
```

# EasyHamiltonian.jl

## Introduction

### Motivation

The module is just a packup for ITensor.AutoMPO. Though, this pack could be quite helpful when users want to simulate their own hamiltonian in an innovative algorithm package (such as DMRG, CTMRG, VUMPS).

Usually, an algorithm package should offer some basic hamiltonian to perform their tests. Each of these package should have a file named "hamiltonian.jl", and if others want to modify the hamiltonian, they may have to devlop these packages and modify the "hamiltonian.jl" by hands.

We want to use this package to unify all these "hamiltonian.jl" at all. Algorithm designer do not need to write their own "hamiltonian.jl". Instead, they only need to import this package.

Type *AbstractHamiltonian* should be accepted by all different algorithms. So package user could import this package and feed their *AbstractHamiltonian* into algorithm.

### Structure of EasyHamiltonian.jl

#### API for users

Functions to construct *AbstractHamiltonian*. The API should looks like:

``` julia
    # Kitaev model (BCS theory)
    using EasyHamiltonian:KitaevFermionsModel
    model = KitaevFermionsModel(1.0,1.0,1.0)
    hamiltonian = Hamiltonian(model)
```

If users want to define there own hamiltonian which is not defined in this package, a simple implementation will looks like this:

``` julia
    # Free electrons model for 2 site
    expression = HamiltonianExpression()
    expression += -1.0 ,"Cdagup",1,"Cup",2
    expression += -1.0 ,"Cdagdn",1,"Cdn",2
    hamiltonian = Hamiltonian(expression,"Electron",2)
```

Then users only need to feed this hamiltonian into the following algorithm package.

#### API for algorithm developers

Offer tools to construct a *AbstractHamiltonian* to Matrix or MPO to be used in algorithm.

``` julia
    h_matrix = Matrix(hamiltonian);
    @show eigen(h_matrix)
    h_mpo = MPO(hamiltonian);
    @show eigen(h_mpo)
```

### Contribution

If you have realize some hamiltonian, it would be helpful(and very easy) to contribute your hamiltonian to this package.

A wonderful template is in "/src/hamiltonian_zoo/SpinfulFermionicHamiltonian.jl".

You only need to implement mathematical **Formula** instead of **Array**.

```julia
using ITensors
struct KitaevFermionsModel
    t::Real
    Δ::Real
    μ::Real
end

function Hamiltonian(model::KitaevFermionsModel)
    ampo = AutoMPO()
    
    ampo += -model.t ,"Cdagup",1,"Cup",2
    ampo += -model.t ,"Cdagup",2,"Cup",1
    ampo += -model.t ,"Cdagdn",1,"Cdn",2
    ampo += -model.t ,"Cdagdn",2,"Cdn",1
    
    ampo += model.Δ,"Cdagup",1,"Cdagdn",2
    ampo += conj(model.Δ),"Cdn",2,"Cup",1
    ampo += model.Δ,"Cdagup",2,"Cdagdn",1
    ampo += conj(model.Δ),"Cdn",1,"Cup",2

    ampo += 0.5*model.μ,"Cdagup",1,"Cup",1
    ampo += 0.5*model.μ,"Cdagup",2,"Cup",2
    ampo += 0.5*model.μ,"Cdagdn",1,"Cdn",1
    ampo += 0.5*model.μ,"Cdagdn",2,"Cdn",2

    return Hamiltonian(ampo,"Electron",2)
end
```

Then for users or developer:

```julia
    using EasyHamiltonian:KitaevFermionsModel
    model = KitaevFermionsModel(1.0,1.0,1.0)
    hamiltonian = Hamiltonian(model)
    h_matrix = Matrix(hamiltonian)
    h_mpo = MPO(hamiltonian)
```
