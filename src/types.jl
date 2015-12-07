immutable Random end

@defimmutable RandomNormal (
    mean::Float64 = 0,
    (std::Float64 = 1, std > 0),
)

@defimmutable Elitism{T} (
    kind::T,
    (fraction::Float64 = .1, 0 < fraction <= 1),
)
