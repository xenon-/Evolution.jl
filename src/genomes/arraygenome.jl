type ArrayGenome{T,N} <: IndexableGenome{T}
    array::Array{T,N}
end

function ArrayGenome{T,N}(x0::Array{T,N})
    ArrayGenome{T,N}(x0)
end

function Base.show{T,N}(io::IO, genome::ArrayGenome{T,N})
    print(io, "ArrayGenome(", genome.array, ")")
end

Base.eltype(genome::ArrayGenome) = eltype(genome.array)
Base.size(genome::ArrayGenome) = size(genome.array)
Base.size(genome::ArrayGenome, i) = size(genome.array, i)
Base.length(genome::ArrayGenome) = length(genome.array)
Base.getindex(genome::ArrayGenome, i) = genome.array[i]
Base.setindex!(genome::ArrayGenome, v, i) = genome.array[i] = v

function crossover{T,N}(g1::ArrayGenome{T,N}, g2::ArrayGenome{T,N}, ::Random = Random())
    @assert length(g1) == length(g2)
    new_array = similar(g1.array)
    @inbounds @simd for i = 1:length(g1)
        new_array[i] = rand(Bool) ? g1[i] : g2[i]
    end
    ArrayGenome(new_array)::ArrayGenome{T,N}
end
