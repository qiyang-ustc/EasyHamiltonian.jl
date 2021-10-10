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