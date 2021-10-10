export MPO,Matrix
using OMEinsum
using ITensors:siteinds
import Base.Matrix, ITensors.MPO

function MPO2Matrix(mpo::MPO)
    N = length(mpo)
    if N > 14
        @warn "N>14,construct Matrix may be very slow."
    end

    op = Array(mpo[1],inds(mpo[1])...)
    for j = 2:N-1
        opa = Array(mpo[j],inds(mpo[j])...)
        op = reshape(ein"aij,abpq->bipjq"(op,opa),:,2^j,2^j)
    end
    opn = Array(mpo[N],inds(mpo[N])...)
    op = ein"aij,apq->ipjq"(op,opn)
    n1,n2 = size(op)[[1;2]]
    return reshape(op,n1*n2,n1*n2)
end

Matrix(h::Hamiltonian) = MPO2Matrix(MPO(h))
MPO(h::Hamiltonian{Electron,N}) where N = MPO(h.ex.ex,siteinds("Electron",N))
