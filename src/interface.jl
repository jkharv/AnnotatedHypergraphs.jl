function SpeciesInteractionNetworks.species(int::AnnotatedHyperedge) 

    return int.spp
end

function SpeciesInteractionNetworks.species(net::AnnotatedHypergraph)

    return species(net.species)
end

function SpeciesInteractionNetworks.richness(net::AnnotatedHypergraph) 

    return length(species(net))
end

function SpeciesInteractionNetworks.interactions(net::AnnotatedHypergraph)

    return [net.interactions[i] for i ∈ eachindex(net.interactions)]
end

function role(sp::T, int::AnnotatedHyperedge{T})::Symbol where T

    return roles(sp, int)[1] 
end

function roles(sp::T, int::AnnotatedHyperedge{T}) :: Vector{RoleType} where T

    indices = findall(x -> x == sp, int.spp)

    if isnothing(indices)

        throw(ArgumentError("Can't find $sp in this interaction: $int"))
    end

    return int.roles[indices]
end

function has_role(sp::T, int::AnnotatedHyperedge{T}, role::RoleType)::Bool where T

    return role ∈ roles(sp, int)
end

function subject(int::AnnotatedHyperedge{T})::T where T

    sbj = with_role(:subject, int)

    if length(sbj) ≠ 1

        error("`subject()` only works if an interaction has exactly one subject species")
    end

    return first(sbj)
end

function object(int::AnnotatedHyperedge{T})::T where T

    obj = with_role(:object, int)

    if length(obj) ≠ 1

        error("`object()` only works if an interaction has exactly one subject species")
    end

    return first(obj)
end

function isloop(int::AnnotatedHyperedge)

    return subject(int) == object(int)
end