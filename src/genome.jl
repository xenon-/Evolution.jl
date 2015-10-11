abstract AbstractGenome

abstract ArraylikeGenome <: AbstractGenome

randmutate!(gt::ArraylikeGenome) = error()
randswap(gt::ArraylikeGenome) = error()
randswap!(gt::ArraylikeGenome) = error()
shuffle!(gt::ArraylikeGenome) = error()
getindex(gt::ArraylikeGenome) = error()
randcrossover(gt1::ArraylikeGenome, gt2::ArraylikeGenome) = error()
