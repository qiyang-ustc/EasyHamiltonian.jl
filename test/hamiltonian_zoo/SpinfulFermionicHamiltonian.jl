using Test,EasyHamiltonian,ITensors
using EasyHamiltonian:KitaevFermionsModel

@testset "KitaevFermionsModel" begin
    model = KitaevFermionsModel(1.0,1.0,1.0)
    hamiltonian = Hamiltonian(model)
    @test isa(hamiltonian,Hamiltonian)
    @test isa(Matrix(hamiltonian),Matrix)
    @test isa(MPO(hamiltonian),MPO)
end