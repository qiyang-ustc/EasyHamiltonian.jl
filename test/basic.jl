using EasyHamiltonian

kitaev_hamiltonian = HamiltonianExpression()
hamiltonian += -1.0 ,"Cdagup",1,"Cup",2
hamiltonian += -1.0 ,"Cdagup",2,"Cup",1
hamiltonian += -1.0 ,"Cdagdn",1,"Cdn",2
hamiltonian += -1.0 ,"Cdagdn",2,"Cdn",1
