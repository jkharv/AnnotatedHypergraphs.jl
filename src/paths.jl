function SpeciesInteractionNetworks._path_distance(
    N::AnnotatedHypergraph, 
    E::AnnotatedHyperedge
) 
    return 1.0
end

function SpeciesInteractionNetworks.shortestpath(
    N::AnnotatedHypergraph, 
    sp::T; kwargs...) where {T}
    
    shortestpath(BellmanFord, N, sp; kwargs...)
end

function pathbetween(
    ::Type{SPM}, 
    N::AnnotatedHypergraph, 
    source::T, 
    target::T
    ) where {SPM <: ShortestPathMethod, T}

    @assert source in species(N)
    @assert target in species(N)

    _, pred = shortestpath(SPM, N, source; include_paths=true)

    if !(target in keys(pred))
        return Vector{eltype(N)}()
    end

    path = eltype(N)[]

    reached = target
    while reached != source
        through = pred[reached]
        push!(path, (through, reached, N[through, reached]))
        pop!(pred, reached)
        reached = through
    end

    return reverse(path)
end

function pathbetween(
    N::AnnotatedHypergraph, 
    source::T, 
    target::T
    ) where {T}

    return pathbetween(BellmanFord, N, source, target)
end

function shortestpath(
    ::Type{BellmanFord},
    N::AnnotatedHypergraph,
    sp::T;
    include_paths::Bool = false
    ) where {T}

    @assert sp in species(N)

    dist = Dict([s => Inf for s in species(N)])
    pred = Dict{T, Union{T, Nothing}}([s => nothing for s in species(N)])
    dist[sp] = 0.0

    for _ ∈ 1:length(interactions(N)) - 1

        for int ∈ interactions(N)

            if (dist[subject(int)] + 1.0) < dist[object(int)]

                dist[object(int)] = dist[subject(int)] + 1
                pred[object(int)] = subject(int)
            end
        end
    end

    for s in species(N)

        if (isinf(dist[s])) | (isnothing(pred[s]))
            pop!(dist, s, nothing)
        end
    end

    return include_paths ? (dist, pred) : dist
end