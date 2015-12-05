abstract AbstractGenome

abstract IndexableGenome{T} <: AbstractGenome

function mutate!{T<:Real}(g::IndexableGenome{T}, o::RandomNormal)
    @inbounds for i in 1:length(g)
        ɛ = T(randn() * o.std + o.mean)
        g[i] = g[i] + ɛ
    end
end

function randswap!(g::IndexableGenome)
    i1 = rand(1:length(g))
    i2 = rand(1:length(g))
    @inbounds tmp = g[i1]
    @inbounds g[i1] = g[i2]
    @inbounds g[i2] = tmp
    g
end

shuffle!(g::IndexableGenome) = error()
