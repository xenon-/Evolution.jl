@everywhere using Evolution
using Base.Test
using ValueHistories
using UnicodePlots

@everywhere function rosenbrock(x::Vector)
    return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

history = VectorUnivalueHistory(Float64)

population = [MinimizerPhenotype(rand(2) * 50, rosenbrock) for i = 1:1000]
for i = 1:20
    map!(fitness!, population)
    elitemutate!(population, percent = 10)
    elitecrossover!(population, percent = 20)

    push!(history, i, fitness(best(population)))
end

solution = best(population)
println(solution)
print(lineplot(get(history)..., title = "Fitness over generation"))
