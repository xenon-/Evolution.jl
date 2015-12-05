abstract AbstractPhenotype{G <: AbstractGenome}

genome(pt::AbstractPhenotype) = error()
fitness(pt::AbstractPhenotype) = error()
crossover{T<:AbstractPhenotype}(gt1::T, gt2::T, o) = T(gt1, crossover(genome(gt1), genome(gt2), o))

function mutate!{T<:AbstractPhenotype}(
        pop::AbstractVector{T},
        o::Elitism)
    sort!(pop, rev = true)
    n_top = floor(Int, o.fraction * length(pop))
    @inbounds for i = (n_top+1):length(pop)
        gt = genome(pop[i])
        mutate!(gt, o.kind)
    end
    pop
end

function crossover!{T<:AbstractPhenotype}(
        pop::AbstractVector{T},
        o::Elitism)
    sort!(pop, rev = true)
    n_top = floor(Int, o.fraction * length(pop))
    @inbounds for i = (n_top+1):length(pop)
        i1 = rand(1:n_top)
        i2 = rand(1:n_top)
        pop[i] = crossover(pop[i1], pop[i2], o.kind)
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
