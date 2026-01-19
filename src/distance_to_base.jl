function SpeciesInteractionNetworks.distancetobase(
    ::Type{SPM}, 
    N::AnnotatedHypergraph, 
    sp::T, f) where {T, SPM <: ShortestPathMethod}

    paths = shortestpath(SPM, N, sp)
    basal_species = filter(s -> iszero(generality(N, s)), species(N))
    connected_basal_species = filter(s -> s in keys(paths), basal_species)

    if isempty(connected_basal_species)

        return 1.0
    end

    distances = [paths[s] for s in connected_basal_species]

    return f(distances) + 1.0
end

function SpeciesInteractionNetworks.distancetobase(
    N::AnnotatedHypergraph, 
    sp::T) where {T}

    return distancetobase(BellmanFord, N, sp, maximum)
end

function SpeciesInteractionNetworks.distancetobase(
    N::AnnotatedHypergraph, sp::T, f) where {T} 

    return distancetobase(BellmanFord, N, sp, f)
end