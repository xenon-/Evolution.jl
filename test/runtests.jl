@everywhere using Evolution
using Base.Test
using ValueHistories
using UnicodePlots

@everywhere function rosenbrock(x::Vector)
    return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

history = VectorUnivalueHistory(Float64)

population = [MinimizerPhenotype(rand(2) * 30, rosenbrock) for i = 1:1000]
for i = 1:30
    map!(fitness!, population)
    mutate!(population, Elitism(RandomNormal(), 0.1))
    crossover!(population, Elitism(Random(), 0.2))

    push!(history, i, fitness(best(population)))
end

solution = best(population)
println(solution)
print(lineplot(get(history)..., height = 10, title = "Best Fitness over Generations"))
