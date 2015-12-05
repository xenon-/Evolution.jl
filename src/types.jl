immutable Random end


immutable RandomNormal
    mean::Float64
    std::Float64
end

function RandomNormal(; mean = 0, std = 1)
    RandomNormal(Float64(mean), Float64(std))
end


immutable Elitism{T}
    kind::T
    fraction::Float64

    function Elitism(kind::T, fraction::Float64)
        @assert 0 < fraction <= 1
        new(kind, fraction)
    end
end

function Elitism{T}(kind::T, fraction)
    Elitism{T}(kind, Float64(fraction))
end

function Elitism{T}(kind::T; fraction = .1)
    Elitism{T}(kind, Float64(fraction))
end
