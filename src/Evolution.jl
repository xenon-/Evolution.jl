module Evolution

import Base: shuffle!, getindex

include("genome.jl")
include("phenotype.jl")

export

    AbstractGenome,

    ArraylikeGenome,
    randmutate!,
    randswap,
    randswap!,
    randcrossover,

    AbstractPhenotype,
    genome,
    fitness,
    best,
    worst

end # module
