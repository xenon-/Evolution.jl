module Evolution

import Base: shuffle!, getindex

include("genotype.jl")
include("phenotype.jl")

export

    AbstractGenotype,

    ArraylikeGenotype,
    randmutate!,
    randswap,
    randswap!,
    randcrossover,

    AbstractPhenotype,
    genotype,
    fitness,
    best,
    worst

end # module
