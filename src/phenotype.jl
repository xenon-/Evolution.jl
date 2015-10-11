abstract AbstractPhenotype{G<:AbstractGenotype}

genotype(pt::AbstractPhenotype) = error()
fitness(pt::AbstractPhenotype) = error()
randcrossover{T<:AbstractPhenotype}(gt1::T, gt2::T) = T(randcrossover(genotype(gt1), genotype(gt2)))

best(pop::Vector{AbstractPhenotype}) = error()
worst(pop::Vector{AbstractPhenotype}) = error()
