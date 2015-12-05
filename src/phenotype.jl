abstract AbstractPhenotype{G <: AbstractGenome}

genome(pt::AbstractPhenotype) = error()
fitness(pt::AbstractPhenotype) = error()
randcrossover{T<:AbstractPhenotype}(gt1::T, gt2::T) = T(randcrossover(genome(gt1), genome(gt2)))

function elitemutate!{T<:AbstractPhenotype}(
        pop::AbstractVector{T};
        percent = 10,
        fun! = randnmutate!)
    sort!(pop, rev = true)
    n_top = floor(Int, percent/100 * length(pop))
    @inbounds for i = (n_top+1):length(pop)
        gt = genome(pop[i])
        fun!(gt)
    end
    pop
end

function elitecrossover!{T<:AbstractPhenotype}(
        pop::AbstractVector{T};
        percent = 10,
        fun = randcrossover)
    sort!(pop, rev = true)
    n_top = floor(Int, percent/100 * length(pop))
    @inbounds for i = (n_top+1):length(pop)
        i1 = rand(1:n_top)
        i2 = rand(1:n_top)
        pop[i] = T(pop[i], fun(genome(pop[i1]), genome(pop[i2])))
    end
    pop
end

function worst{T<:AbstractPhenotype}(pop::AbstractVector{T})
    worst_pt = pop[1]
    worst_val = fitness(worst_pt)
    @inbounds for i in 2:length(pop)
        cur_val = fitness(pop[i])
        if cur_val < worst_val
            worst_val = cur_val
            worst_pt = pop[i]
        end
    end
    worst_pt
end

function best{T<:AbstractPhenotype}(pop::AbstractVector{T})
    best_pt = pop[1]
    best_val = fitness(best_pt)
    @inbounds for i in 2:length(pop)
        cur_val = fitness(pop[i])
        if cur_val > best_val
            best_val = cur_val
            best_pt = pop[i]
        end
    end
    best_pt
end


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
