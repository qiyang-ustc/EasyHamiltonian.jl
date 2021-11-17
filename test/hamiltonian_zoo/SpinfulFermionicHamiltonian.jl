using EasyHamiltonian
using ITensors
using Test

@testset "KitaevFermionsModel" begin
    model = KitaevFermionsModel(1.0,1.0,1.0)
    @test isa(model,AbstractFermionicHamiltonian)

    hamiltonian = Hamiltonian(model)
    @test isa(hamiltonian,Hamiltonian)
    @test isa(Matrix(hamiltonian),Matrix)
    @test isa(MPO(hamiltonian),MPO)
end

@testset "SpinfulFermions" begin
    model = SpinfulFermions(1.0,1.0,1.0)
    @test isa(model,AbstractSpinfulFermionicHamiltonian)

    hamiltonian = Hamiltonian(model)
    @test isa(hamiltonian,Hamiltonian)
    @test isa(Matrix(hamiltonian),Matrix)
    @test isa(MPO(hamiltonian),MPO)
end