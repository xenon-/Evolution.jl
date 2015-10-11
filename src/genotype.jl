abstract AbstractGenotype

abstract ArraylikeGenotype <: AbstractGenotype

randmutate!(gt::ArraylikeGenotype) = error()
randswap(gt::ArraylikeGenotype) = error()
randswap!(gt::ArraylikeGenotype) = error()
shuffle!(gt::ArraylikeGenotype) = error()
getindex(gt::ArraylikeGenotype) = error()
randcrossover(gt1::ArraylikeGenotype, gt2::ArraylikeGenotype) = error()
