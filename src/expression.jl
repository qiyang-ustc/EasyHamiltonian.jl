# HamiltonianExpression is in fact an AutoMPO.

abstract type AbstractHamiltonianExpression end

using ITensors:Opsum
struct HamiltonianExpression <: AbstractHamiltonianExpression
    ex :: OpSum
end


