# classification for different kinds of hamiltonian.
# algorithm designer will need these type to adopt/reject hamiltonian.

abstract type AbstractHamiltonian end
abstract type AbstractFermionicHamiltonian <: AbstractHamiltonian end
abstract type AbstractSpinlessFermionicHamiltonian <: AbstractFermionicHamiltonian end
abstract type AbstractSpinfulFermionicHamiltonian <: AbstractFermionicHamiltonian end
abstract type AbstractElectronHamiltonian <: AbstractSpinfulFermionicHamiltonian end

abstract type AbstractSpinHamiltonian <: AbstractHamiltonian end

abstract type AbstractBosonicHamiltonian <: AbstractHamiltonian end
