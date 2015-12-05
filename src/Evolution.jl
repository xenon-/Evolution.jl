module Evolution

import Base: shuffle!, getindex

include("common.jl")
include("types.jl")
include("genome.jl")
include("phenotype.jl")
include("genomes/arraygenome.jl")
include("phenotypes/minimizer.jl")

export

    Random,
    RandomNormal,
    Elitism,

    pmap!,

    AbstractGenome,
    IndexableGenome,
    randswap!,

    AbstractPhenotype,
    genome,
    fitness!,
    fitness,
    best,
    worst,

    crossover,
    crossover!,
    mutate!,

    ArrayGenome,
    MinimizerPhenotype

end # module
