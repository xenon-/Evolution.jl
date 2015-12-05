type MinimizerPhenotype{G<:ArrayGenome} <: AbstractPhenotype{G}
    genome::G
    costfunction::Function
    fitness::Nullable{Float64}

    function MinimizerPhenotype(prototype::MinimizerPhenotype{G}, genome::G)
        new(genome, prototype.costfunction, Nullable{Float64}())
    end

    function MinimizerPhenotype(
            genome::G,
            costfunction::Function,
            fitness::Nullable{Float64} = Nullable{Float64}())
        new(genome, costfunction, fitness)
    end
end

function MinimizerPhenotype{G<:ArrayGenome}(genome::G, costfunction::Function)
    MinimizerPhenotype{G}(genome, costfunction)
end

function MinimizerPhenotype{TArray<:Array}(array::TArray, costfunction::Function)
    MinimizerPhenotype(ArrayGenome(array), costfunction)
end

function Base.show(io::IO, pt::MinimizerPhenotype)
    print(io, "MinimizerPhenotype(")
    if pt.fitness.isnull
        print(io, "null")
    else
        print(io, round(get(pt.fitness), 5))
    end
    print(io, ") with ", pt.genome)
end

for op = (:<, :>, :(==), :(!=), :(<=), :(>=), :isless)
    @eval Base.$op(pt1::MinimizerPhenotype, pt2::MinimizerPhenotype) = Base.$op(fitness(pt1), fitness(pt2))
end

genome(pt::MinimizerPhenotype) = pt.genome
fitness(pt::MinimizerPhenotype) = get(pt.fitness, typemin(eltype(pt.fitness)))
function fitness!(pt::MinimizerPhenotype)
    if pt.fitness.isnull
        pt.fitness = Nullable(Float64(-pt.costfunction(pt.genome.array)))
    end
    pt
end
