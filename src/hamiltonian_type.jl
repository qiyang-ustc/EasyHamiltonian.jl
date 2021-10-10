# classification for different kinds of hamiltonian.
# algorithm designer will need these type to adopt/reject hamiltonian.

abstract type AbstractHamiltonian end
abstract type AbstractFermionicHamiltonian <: AbstractHamiltonian end
abstract type AbstractSpinlessFermionicHamiltonian <: AbstractFermionicHamiltonian end
abstract type AbstractSpinfulFermionicHamiltonian <: AbstractFermionicHamiltonian end
abstract type AbstractElectronHamiltonian <: AbstractSpinfulFermionicHamiltonian end

abstract type AbstractSpinHamiltonian <: AbstractHamiltonian end

abstract type AbstractBosonicHamiltonian <: AbstractHamiltonian end

export Hamiltonian
# Notice: Hamiltonian is a universal hamiltonian.
struct Hamiltonian{HType<:AbstractHamiltonian,N}
    ex :: HamiltonianExpression
end

const Electron = AbstractSpinfulFermionicHamiltonian
Hamiltonian(ex,htype,N::Int) = Hamiltonian{htype,N}(ex)
Hamiltonian(ex,htype::String,N::Int) = Hamiltonian{eval(Meta.parse(htype)),N}(ex)