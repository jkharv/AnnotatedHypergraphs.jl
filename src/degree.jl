function SpeciesInteractionNetworks.generality(
    web::AnnotatedHypergraph, 
    sp::T) where {T}

    d = filter(x -> (subject(x) == sp) & (object(x) ≠ sp), interactions(web))

    return length(d)
end

function SpeciesInteractionNetworks.vulnerability(
    web::AnnotatedHypergraph, sp::T) where {T}

    d = filter(x -> (object(x) == sp) & (subject(x) ≠ sp), interactions(web))

    return length(d)
end

function SpeciesInteractionNetworks.degree(
    N::AnnotatedHyperedge, sp::T) where {T}

    d = generality(N, sp) + vulnerability(N, sp)
    correction = iszero(N[sp,sp]) ? zero(eltype(d)) : one(eltype(d))

    return d - correction
end

function SpeciesInteractionNetworks.degree(
    web::AnnotatedHypergraph, sp::T) where {T}

    return generality(web, sp) + vulnerability(web, sp)
end

function SpeciesInteractionNetworks.generality(N::AnnotatedHypergraph)

    Dict([sp => generality(N, sp) for sp in species(N)])
end

function SpeciesInteractionNetworks.vulnerability(N::AnnotatedHypergraph)
    
    Dict([sp => vulnerability(N, sp) for sp in species(N)])
end

function SpeciesInteractionNetworks.degree(N::AnnotatedHypergraph)

    Dict([sp => degree(N, sp) for sp in species(N)])
end
