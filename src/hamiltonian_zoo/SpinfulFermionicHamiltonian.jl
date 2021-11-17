using ITensors
export KitaevFermionsModel
export SpinfulFermions
struct KitaevFermionsModel <: AbstractFermionicHamiltonian
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

@doc raw"
    spinful_fermions(γ::Real,λ::Real)

return a struct representing the free fermions model with paring strength `Delta`.
"
struct SpinfulFermions{T0<:Real,T1<:Real,T2<:Real} <: AbstractSpinfulFermionicHamiltonian
    t::T0
	Δ::T1
	μ::T2
end

"""
	hamiltonian(model::SpinfulFermions)
"""
function Hamiltonian(model::SpinfulFermions)
	t = model.t
	Δ = model.Δ
	μ = model.μ
		ampo = AutoMPO()
		sites = siteinds("Electron",2)
		ampo += -t ,"Cdagup",1,"Cup",2
        ampo += -t ,"Cdagup",2,"Cup",1
        ampo += -t ,"Cdagdn",1,"Cdn",2
        ampo += -t ,"Cdagdn",2,"Cdn",1
        
		ampo += Δ,"Cdagup",1,"Cdagdn",2
        ampo += conj(Δ),"Cdn",2,"Cup",1
        ampo += Δ,"Cdagup",2,"Cdagdn",1
        ampo += conj(Δ),"Cdn",1,"Cup",2

		ampo += 0.5*μ,"Cdagup",1,"Cup",1
		ampo += 0.5*μ,"Cdagup",2,"Cup",2
		ampo += 0.5*μ,"Cdagdn",1,"Cdn",1
		ampo += 0.5*μ,"Cdagdn",2,"Cdn",2


		H = MPO(ampo,sites)

		H1 = Array(H[1],inds(H[1])...)
		H2 = Array(H[2],inds(H[2])...)
		h = reshape(ein"aij,apq->ipjq"(H1,H2),16,16)

    return h
end