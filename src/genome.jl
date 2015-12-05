abstract AbstractGenome

abstract IndexableGenome{T} <: AbstractGenome

function randnmutate!(g::IndexableGenome, mu = 0, sigma = 1)
    @inbounds for i in 1:length(g)
        eps = randn() * sigma + mu
        g[i] = g[i] + eps
    end
end

function randswap!(g::IndexableGenome)
    i1 = rand(1:length(g))
    i2 = rand(1:length(g))
    tmp = g[i1]
    g[i1] = g[i2]
    g[i2] = tmp
    g
end

shuffle!(g::IndexableGenome) = error()
getindex(g::IndexableGenome) = error()


type ArrayGenome{T,N} <: IndexableGenome{T}
    array::Array{T,N}
end

function ArrayGenome{T,N}(x0::Array{T,N})
    ArrayGenome{T,N}(x0)
end

Base.eltype(genome::ArrayGenome) = eltype(genome.array)
Base.size(genome::ArrayGenome) = size(genome.array)
Base.length(genome::ArrayGenome) = length(genome.array)
Base.getindex(genome::ArrayGenome, index) = genome.array[index]
Base.setindex!(genome::ArrayGenome, val, index) = genome.array[index] = val

function randcrossover{T,N}(g1::ArrayGenome{T,N}, g2::ArrayGenome{T,N})
    @assert length(g1) == length(g2)
    from_g1 = bitrand(length(g1))
    new_array = similar(g1.array)
    @inbounds @simd for i = 1:length(g1)
        if from_g1[i]
            new_array[i] = g1[i]
        else
            new_array[i] = g2[i]
        end
    end
    ArrayGenome(new_array)::ArrayGenome{T,N}
end
