using Evolution
using Base.Test

function rosenbrock(x::Vector)
    return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

genome = ArrayGenome([2., 3])
