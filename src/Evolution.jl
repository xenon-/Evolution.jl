module Evolution

import Base: shuffle!, getindex

include("genome.jl")
include("phenotype.jl")

function pmap!(func, array)
    buffer = pmap(func, array)
    copy!(array, buffer)
end

export

    pmap!,

    AbstractGenome,

    IndexableGenome,
    ArrayGenome,
    randnmutate!,
    randswap!,
    randcrossover,

    AbstractPhenotype,
    genome,
    fitness!,
    fitness,
    best,
    worst,
    
    elitecrossover!,
    elitemutate!,

    MinimizerPhenotype

end # module
