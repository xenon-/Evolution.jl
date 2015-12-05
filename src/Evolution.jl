module Evolution

import Base: shuffle!, getindex

include("types.jl")
include("genome.jl")
include("phenotype.jl")
include("genomes/arraygenome.jl")
include("phenotypes/minimizer.jl")

function pmap!(func, array)
    buffer = pmap(func, array)
    copy!(array, buffer)
end

export

    Random,
    RandomNormal,
    Elitism,

    pmap!,

    AbstractGenome,

    IndexableGenome,
    ArrayGenome,
    mutate!,
    randswap!,
    crossover,

    AbstractPhenotype,
    genome,
    fitness!,
    fitness,
    best,
    worst,

    crossover!,
    mutate!,

    MinimizerPhenotype

end # module
