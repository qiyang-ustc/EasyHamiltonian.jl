using EasyHamiltonian,Test

@testset "Basic Usage" begin
    kitaev_hamiltonian = HamiltonianExpression()
    kitaev_hamiltonian += -1.0 ,"Cdagup",1,"Cup",2
    kitaev_hamiltonian += -1.0 ,"Cdagup",2,"Cup",1
    kitaev_hamiltonian += -1.0 ,"Cdagdn",1,"Cdn",2
    kitaev_hamiltonian += -1.0 ,"Cdagdn",2,"Cdn",1

    N = 2
    site_type = "Electron"
    hamiltonian = Hamiltonian(kitaev_hamiltonian,site_type,N)

    @test isa(Matrix(hamiltonian),Matrix)
    @test isa(MPO(hamiltonian),MPO)
end
