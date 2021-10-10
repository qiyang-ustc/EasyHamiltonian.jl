# HamiltonianExpression is in fact an AutoMPO.
# But we implement some additional utils.

abstract type AbstractHamiltonianExpression end

export HamiltonianExpression

# ------------------------------------------------------
using ITensors:OpSum
struct HamiltonianExpression <: AbstractHamiltonianExpression
    ex :: OpSum
end

import Base.convert
convert(::Type{HamiltonianExpression},op::OpSum) = HamiltonianExpression(op)
HamiltonianExpression() = HamiltonianExpression(AutoMPO())


import Base.+
"""
    function +(a::HamiltonianExpression,b::HamiltonianExpression)
        Just add two hamiltonian expression together.
"""
function +(a::HamiltonianExpression,b::HamiltonianExpression)
    out = AutoMPO()
    out.data = append!(out.data,a.data,b.data)
    return out
end

"""
    function +(a::HamiltonianExpression,b)
        dispatch for AutoMPO native grammer support
"""
function +(a::HamiltonianExpression,b)
    return HamiltonianExpression(a.ex + b)
end